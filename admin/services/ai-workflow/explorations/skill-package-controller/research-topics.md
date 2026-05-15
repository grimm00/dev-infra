# Research Topics — Skill Package Controller

**Created:** 2026-05-06

---

## 📋 Topics Identified

### Topic 1: Controller Trigger Mechanism

**Question:** What's the right invocation point for the controller — Cursor session hook, shared skill preamble, or something else — and how does it generalize across editors?
**Priority:** High
**Context:** The controller must fire *before* any skill-specific logic. The `using-superpowers` hook proves session hooks work in Cursor, but Claude Code and CLI agents have different entry points. The mechanism chosen determines portability.
**Parallel-safe:** Yes — this is mechanical/platform research, independent of meta decisions.

### Topic 2: Registry Storage Convention (XDG vs Cursor-local)

**Question:** Should the package's persistent state use XDG Base Directory conventions (`~/.config/ai-workflow/`, `~/.local/state/ai-workflow/`) or remain under `~/.cursor/` with a future migration path?
**Priority:** High
**Context:** The current `~/.cursor/repos/` location couples the package to Cursor. XDG is the POSIX standard for application config/state separation. The choice affects every path the controller reads/writes and determines whether the package is editor-portable by default.
**Parallel-safe:** Yes — storage convention is independent of what the registry *contains*.

### Topic 3: Repo Identity and Slug Derivation

**Question:** How should the controller uniquely identify a repo — `basename` of remote URL, full `org/repo` from remote, hash, or cwd-based? How does it handle repos with no remote or monorepo subdirectories?
**Priority:** Medium
**Context:** The `ticket-intake` precedent uses `basename $(git remote get-url origin) .git`. This fails for repos with the same name under different orgs, local-only repos, and monorepo sub-paths. The slug is the registry's primary key — getting it wrong means collisions or orphaned entries.
**Parallel-safe:** Yes — slug derivation is a utility concern, not blocked on meta decisions.

### Topic 4: Setup Flow UX — What Does Onboarding Actually Need?

**Question:** When the controller encounters an unknown repo, what questions does it need to ask, what can it infer, and what's the minimal viable interaction?
**Priority:** High
**Context:** The bootstrapping flow should feel helpful, not interrogative. It needs to balance "derive understanding without asking" (scan for structure, read existing config files) with "confirm assumptions before acting." The UX determines whether users accept or skip setup.
**Parallel-safe:** Partially — the *what to ask* depends on what the registry stores, which partially depends on meta decisions about template minimalism. The *how to ask* (interaction pattern, trigger, opt-out) is independent.

### Topic 5: AGENTS.md as Tier 1 — Detection and Derivation

**Question:** What should the controller look for when checking Tier 1 (in-repo authority)? Just `AGENTS.md` at root, or also `CLAUDE.md`, `.cursor/rules/`, and other namespace variants? If deriving one, what does a useful generated AGENTS.md contain?
**Priority:** Medium
**Context:** The agentskills.io emerging standard converges on AGENTS.md, but real repos have CLAUDE.md, .cursorrules, etc. The controller needs to know what counts as "repo has declared its own context." If setup *generates* one, it should produce something the repo maintainer would keep.
**Parallel-safe:** Yes — detection heuristics are independent of meta decisions.

### Topic 6: Package-Level vs Skill-Level Config Separation

**Question:** Where's the boundary between what the controller manages (package-level: workspace root, setup state, AGENTS.md cache) and what individual skills manage (skill-level: specific artifact paths, formatting preferences)?
**Priority:** Medium
**Context:** The unified profile int-opp proposes one file with sections per concern. But the controller/skill boundary question is: does the controller *resolve* skill-specific paths (centralizing all resolution), or does it provide the *inputs* (workspace root, repo slug) and let skills resolve their own paths from there? The former is simpler for skills; the latter is more extensible.
**Parallel-safe:** Partially — the boundary depends on how many concerns the controller takes on, which depends on how minimal templates become (meta Theme 2).

### Topic 7: Prior Art — Existing Package Managers and Dev Tool Controllers

**Question:** How do comparable tools (direnv, asdf/mise, devcontainers, nix flakes) handle per-project config discovery, bootstrapping, and resolution chains? What patterns are proven?
**Priority:** Low
**Context:** Avoids reinventing known patterns. `direnv` does "detect `.envrc`, resolve hierarchically." `mise` does "detect `.tool-versions` or `mise.toml`, support global fallback." These are the same problem: per-project config with a global default. Their UX decisions (opt-in vs opt-out, file-in-repo vs external) are directly relevant.
**Parallel-safe:** Yes — pure research, no dependencies.

### Topic 8: Stateless Dispatch — Write Timing and Post-Hooks

**Question:** If dispatch is a pure read-resolve-handoff, when and how do registry writes happen? Should writes be post-skill-execution hooks, explicit setup commands, or opportunistic (write-if-changed)?
**Priority:** Medium
**Context:** The stateless dispatch model means the fast path (read config, resolve, hand off) never blocks on writes. But the registry still needs to be updated — last-seen timestamps, newly observed repo structure, setup state changes. The write timing affects whether skills need to be aware of the registry at all or whether the controller handles all persistence transparently.
**Parallel-safe:** Yes — write timing is a design decision independent of meta exploration outcomes.

### Topic 9: Relationship Between Controller and Issue #102 Unified Dispatch

**Question:** Is the controller the same component as issue #102's "unified dispatch," or is it a lower-level substrate that the dispatcher consumes? If they're the same, how does the controller avoid becoming the "god object" #102 warns about?
**Priority:** Medium
**Context:** Issue #102 proposes unified dispatch (routing to agents by category/name/intent) and warns about god-object risk. The controller explored here resolves context and passes it downstream. These might be the same thing (dispatch = resolve context + route to agent) or two layers (controller = resolve context; dispatcher = route to agent using that context). Clarifying the boundary determines whether this exploration subsumes #102's dispatch thread or feeds into it.
**Parallel-safe:** Yes — conceptual alignment work, no implementation dependencies.

---

## 🚀 Next Steps

Use `/research --from-explore skill-package-controller` to investigate these questions.

**Recommended parallel tracks:**
- Topics 1, 2, 3, 7 can proceed immediately (no meta dependencies)
- Topic 4 can proceed on the "how to ask" dimension; "what to ask" is partially blocked
- Topics 5, 6 can proceed with current assumptions and update when meta Themes 1–2 land
