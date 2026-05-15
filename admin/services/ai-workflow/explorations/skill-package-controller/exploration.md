# Exploration: Skill Package Controller

**Created:** 2026-05-06
**Amended:** 2026-05-06 — discussion surfaced stateless dispatch model and issue #102 connection

---

## 🎯 What We're Exploring

The ai-workflow skills, agents, and commands currently operate as independent units with no shared runtime. Each skill re-derives repo context, detects paths, and makes assumptions about structure in isolation. What's missing is a **controller** — the component that fires before any skill, identifies the repo, consults persistent state, and hands resolved context downstream. This exploration maps out what that controller is, what it manages, and how it interacts with the registry (per-repo profile), the bootstrapping flow (setup), and the authority model (AGENTS.md vs external config vs inference).

---

## 🔍 Themes

### Theme 1: The Controller as Shared Entry Point

- Skills today have no shared dispatcher — each does its own detection, leading to repeated path-resolution logic across `pre-commit-review`, `commit`, `write-plan`, etc.
- The superpowers `using-superpowers` hook is proto-controller: it fires at session start, checks for applicable skills, and sets behavioral context — but it doesn't manage state or pass resolved config
- The controller's job: (1) identify current repo, (2) consult registry for relationship state, (3) decide if setup is needed, (4) pass resolved workspace root and paths to the invoked skill
- This eliminates the DRY violation where each skill independently implements "flag → config → fallback" resolution — the controller resolves once, skills consume
- The controller is what makes "package-level" behavior possible: install the package, get a runtime that coordinates across all its constituent skills
- Implementation form is likely a session hook (Cursor) or preamble include — something that fires before skill-specific logic regardless of which skill was invoked

### Theme 2: The Registry as Persistent State (Model Layer)

- Every skill invocation in a repo is a potential registry write: "I ran here, here's what I observed"
- Registry entries track relationship status between the package and each repo: AGENTS.md presence/location, setup state, workspace root, resolved paths
- The `ticket-intake/repos/<slug>.yaml` precedent is the first instance of this registry — it stores per-repo conventions externally without touching the repo
- The unified profile proposal (`per-repo-skill-profile-unified.md`) sketches the shape: `schema_version`, `ticket`, `paths` sections — but it doesn't yet account for the controller's metadata (setup state, AGENTS.md detection, last-seen timestamp)
- The registry makes the package stateful across sessions: a new conversation doesn't start from zero but picks up where the last one left off
- Write authority should belong to the controller (single writer), not to individual skills (many writers, conflict risk)
- Open shape question: does the registry entry grow a `controller:` section for its own metadata, or does controller metadata live separately from skill-consumed config?

### Theme 3: The Bootstrapping Flow (Setup / Onboarding)

- When the controller runs in a repo it hasn't seen before (no registry entry), it should offer setup rather than silently proceeding with degraded detection
- Setup flow: "I don't see an AGENTS.md or a config for this repo. Want me to learn about your repo and store that so I can help better?"
- The user can choose: (a) generate an AGENTS.md in-repo, (b) generate understanding externally in the package's config directory, (c) decline — the package operates in degraded/fallback mode
- "Completely leave the user's repo alone" is a first-class option — the package functions as a guest, never requiring write access to the repo it operates in
- The derived AGENTS.md is not a template fill-in-the-blanks but an observed understanding: "I looked at your repo, here's what I see, here's where I'll put artifacts"
- Setup should be idempotent: re-running it updates the registry without clobbering user customizations
- The setup trigger could be: first skill invocation in unknown repo, explicit user command (`/setup`), or a session hook detecting a new `pwd`

### Theme 4: The Three-Tier Authority Model

- Tier 1: AGENTS.md in repo root — authoritative, the repo's own opinion about itself
- Tier 2: Package's external registry for this repo — package-managed understanding, user-customizable
- Tier 3: Runtime inference / detection heuristics — degraded mode, triggers setup offer
- The controller's resolution chain: check Tier 1, then Tier 2, then Tier 3. Skills never need to know which tier the answer came from — they get a resolved value
- AGENTS.md presence doesn't eliminate the registry — the registry may store derived/cached values and controller metadata even when AGENTS.md exists
- The meta exploration's Theme 2 (template minimalism) decision affects whether Tier 1 is common or rare: if templates become minimal, most repos won't *have* an AGENTS.md on day one, making Tier 2 (the registry) the primary path for most users
- This is the same "flag → config → fallback" pattern from the skill-path-roots int-opp, but elevated to the package level

### Theme 5: Prior Art and Platform Convergence

- The `using-superpowers` hook already fires at session start in Cursor — it's the closest thing to a controller today
- Cursor hooks (`~/.cursor/hooks/`) provide the mechanical seam for triggering the controller on session start
- The emerging agentskills.io standard suggests convergence on AGENTS.md as the agent instruction file — the controller's Tier 1 aligns with this
- Claude Code's CLAUDE.md, Cursor's `.cursor/rules/`, and the agentskills.io AGENTS.md are all the same concept in different namespaces — the controller should be namespace-agnostic in its Tier 1 detection
- XDG Base Directory Specification provides the model for package-level config storage: `~/.config/ai-workflow/repos/<slug>.yaml` (config), `~/.local/state/ai-workflow/` (state) — separating config the user edits from state the controller manages
- The Cursor-specific installation (`~/.cursor/skills/`, `~/.cursor/repos/`) was pragmatic for single-user single-editor use, but doesn't generalize; XDG or a similar convention makes the package editor-agnostic even if only one editor is supported initially

### Theme 6: Meta Prerequisites and Parallel Work

- The skill-template-separation exploration (meta service) makes decisions that constrain controller scope — specifically Theme 1 (skills as their own concern) and Theme 2 (template minimalism)
- If templates become minimal, the controller's setup flow becomes *mandatory infrastructure* not optional enhancement — most repos won't have pre-built structure
- If skills are their own concern (not template products), the controller's authority is skill-authored, not template-imposed
- **What can proceed in parallel to meta decisions:** the controller's mechanical implementation (hook, registry read/write, resolution chain), the registry schema for currently-known fields, the setup flow UX, and the `pre-commit-review`/`commit` path-root fixes
- **What's blocked on meta decisions:** the full registry schema (what sections exist depends on what templates stop providing), whether AGENTS.md generation is part of setup or separate, the naming/location of the package's config directory (depends on whether the package is "ai-workflow" or something else)
- The handoff (`handoff-ai-skill-improvements.md`) explicitly advises "hold on the unified profile schema until meta research on Themes 1–2 lands" — this exploration's parallel-work items respect that boundary

### Theme 7: Stateless Dispatch, Filesystem-Backed Statefulness

- The controller/dispatch is stateless at invocation time — it reads filesystem state, resolves, and hands off. No daemon, no in-memory persistence, no session carryover required
- The *system* is stateful (registry files accumulate over time) but any individual invocation is a pure read-resolve-handoff — same model as `git config`, `direnv`, `mise`
- This means dispatch can't become a god object (issue #102's concern about unified dispatch complexity) — it doesn't accumulate runtime state, it just knows where to look
- Registry writes don't need to happen during dispatch. They can be post-hooks ("update last-seen, record observations") or explicit setup commands. The dispatch path stays fast and predictable — never blocks on a write
- A stateful server or daemon is a possible future layer but not a prerequisite — file-based config/state is sufficient and proven at this scale
- This is the architectural answer to "how does the package remember things across sessions without becoming complex": it doesn't remember anything in-process; it reads files that persist

### Theme 8: Connection to Issue #102 — Agent Architecture and Unified Dispatch

- Issue #102 ("Agent architecture: directory-based agents with skill manifests and unified dispatch") works the same problem from the agent-orchestration angle
- Thread 5 ("Agents Hired by Projects") is the bootstrapping/registry concept as metaphor: agents come with a toolbox (skills manifest) and a resume; a project "hires" them by dispatching. The controller mediates between project needs (AGENTS.md / registry) and package capabilities (manifest)
- Thread 4 ("Unified Dispatch") is the controller by another name — and the concern about it becoming a god object is resolved by Theme 7's stateless-dispatch model
- Thread 3 ("Skill Concerns vs Agent Concerns") gives the layer boundary: skills = atomic contracts, agents = orchestration, controller = neither. The controller is runtime substrate both consume
- Thread 2 ("Agents as Skill Collections / Directory Pattern") connects to the package framing: if agents become directories with manifests, the manifest is what the controller reads to know "what does this agent need from the registry?"
- The statefulness dimension (Theme 2, Theme 7) is what issue #102 doesn't yet have — it frames dispatch as stateless matching, but the registry adds cross-session memory. This is an extension, not a contradiction
- Source: `/discuss` session reviewing issue #102 against the exploration

---

## ❓ Key Questions

1. What's the minimal controller implementation that provides value now — is it just "resolve workspace root and pass it to skills" or does it need the full registry/setup flow?
2. Should the controller's config/state use XDG conventions (`~/.config/ai-workflow/`, `~/.local/state/ai-workflow/`) or stay under `~/.cursor/` for now with a migration path later?
3. How does the controller detect "new repo" vs "known repo" — repo slug from `git remote`, basename of cwd, or something more robust?
4. What's the trigger mechanism — Cursor session hook, skill preamble include, or something else? Does it need to work across Cursor, Claude Code, and raw CLI?
5. Should the setup flow produce AGENTS.md by default (in-repo) or external-only by default (guest mode)? What heuristic determines the default offer?
6. How does the registry handle repos with no git remote (local-only projects, monorepo subdirectories)?
7. Can the controller's resolution chain be implemented as a standalone utility (shell script, yq helper) that skills call, or does it need to be a hook that runs *before* skills?
8. If dispatch is stateless (read-resolve-handoff), where and when do registry writes happen — post-hook after skill execution, explicit setup command, or both?
9. How does this controller concept unify with issue #102's "unified dispatch" — are they the same component, or is the controller a substrate that the dispatcher consumes?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Controller as session hook | MEDIUM | No | The `using-superpowers` hook proves the mechanical approach works. Research on trigger mechanisms is sufficient — no hard-to-reverse decisions. |
| Registry schema | MEDIUM | No | The unified profile int-opp already sketches the shape. Extending it with controller metadata is additive. Research on XDG vs Cursor-local is sufficient. |
| Bootstrapping/setup flow | MEDIUM-HIGH | Consider | The UX of "detect unknown repo, offer setup, derive understanding" is genuinely unclear. A spike building a minimal setup command and testing it on 2–3 repos would surface what the flow actually needs to ask/observe. |
| Three-tier authority resolution | LOW | No | The resolution chain is a well-understood pattern (flag → config → fallback). Implementation is straightforward once the registry location is decided. |
| XDG vs Cursor-local storage | LOW | No | This is a decision about naming/location, not a technical risk. Can be made after a brief research pass on conventions. |
| Platform convergence (multi-editor) | LOW | No | Only Cursor is supported now. The abstraction is worth having, but building for multiple editors is YAGNI until a second editor is actually used. Research the emerging standards; don't implement multi-editor support. |
| Stateless dispatch model | LOW | No | Well-understood pattern (git config, direnv, mise). No hard-to-reverse decisions — it's a design constraint, not a technical risk. |
| Issue #102 unification | MEDIUM | No | Conceptual alignment work — determining whether the controller IS the unified dispatch or feeds into it. Research and discussion are sufficient; no code risk. |

**Risk framework:** HIGH = spike first (hard to pivot), MEDIUM-HIGH = consider spike, MEDIUM/LOW = research only.

---

## 🚀 Next Steps

Review this exploration, then:
- `/explore-amend` to add new themes from downstream discovery
- `/research --from-explore skill-package-controller` to investigate open questions
- The setup/bootstrapping theme (MEDIUM-HIGH risk) may benefit from a `/spike` — build a minimal `setup` command and test it against 2–3 real repos to see what it needs to observe
- Items that can proceed **in parallel to meta exploration research**: controller hook mechanism (Question 4), registry slug derivation (Question 3), XDG convention research (Question 2), and the immediate `pre-commit-review`/`commit` path-root fixes from the handoff
