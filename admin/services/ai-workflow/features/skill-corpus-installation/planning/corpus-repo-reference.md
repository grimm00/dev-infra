# Corpus Repository — Reference

**Feature:** Skill Corpus Installation (ADR-002)
**Type:** Reference (not a plan or decision) — anchors Group 2 (Corpus Repository Structure)
**Status:** 📋 Reference
**Last Updated:** 2026-06-09

---

## Purpose

The corpus repo does not exist yet, but Groups 3–5 (installer mapping, `install.sh`,
multi-machine) have no home until it does. ADR-002 assumes "the corpus lives at a
normal project directory" — this doc pins down **what that repo is, what it contains,
and what it explicitly excludes**, so establishing it (Group 2) starts from a concrete
inventory rather than guesswork.

This is cross-project work by design: the corpus repo will be **born from this feature**,
then live independently (per ADR-001, the corpus is its own product). This reference
stays in dev-infra as the origin record; the repo itself ships elsewhere.

---

## What the corpus IS

The **user-authored** AI-workflow tooling currently installed (untracked) under
`~/.cursor/`. Inventory as of 2026-06-09:

| Kind | Location | Count | Contents |
|------|----------|-------|----------|
| Skills | `~/.cursor/skills/` | 19 | apprentice-eod, apprentice-standup, capture-discussion, commit, decision, discuss, explore, handoff, int-opp, narrative, plan-review, pre-commit-review, reflect, research, spike, ticket-create, ticket-intake, update-pr-description, write-plan |
| Commands | `~/.cursor/commands/` | 22 | (agent-dispatch, task, pr-validation, post-pr, release-prep, transition-plan, …) |
| Agents | `~/.cursor/agents/` | 3 entries | group-cycle.agent.md, group-cycle-work.agent.md, research-orchestrator/ |

(The transient `spike-probe` symlink from the C-INST-1 spike is excluded — it's
teardown-pending, not corpus.)

---

## What the corpus is NOT (exclusions)

These live alongside the corpus but must **not** be pulled into the repo:

- **Cursor built-in skills** — `~/.cursor/skills-cursor/` (18 dirs: automate, babysit, canvas, create-hook, …). These ship with Cursor; they are product, not personal corpus.
- **Third-party Claude plugins** — `~/.claude/plugins/cache/` (hex, superpowers marketplaces). Vendored external packages, not authored here.
- **`~/.claude/skills/`** — currently empty. Claude-side corpus is out of v1 scope (see the [Claude path int-opp](../../../../planning/opportunities/internal/dev-infra/improvements/claude-path-symlink-verification.md)).

This boundary matters: the installer maps **only** the authored corpus into editor paths; built-ins and plugins are already where they belong.

---

## Proposed repo shape (from ADR-002)

- **Name:** `agentic-ocean` (the **core** repo; renamed from ADR-002's `ai-workflow` working name, 2026-06-09)
- **Location:** a normal project dir, e.g. `~/Projects/agentic-ocean/` (ADR-002 §Decision)
- **Layout:**
  ```
  agentic-ocean/
  ├── corpus/             # installable payload — the SINGLE mapping root
  │   ├── skills/         #   14 core skills
  │   ├── commands/       #   20 core commands
  │   └── agents/         #   2 core agents
  ├── install.sh          # self-contained installer (Group 4)
  ├── docs/ scripts/ .github/   # repo scaffolding (NOT installed)
  └── README.md           # corpus product doc + versioning
  ```
  **Payload nesting (2026-06-09 chore):** skills/commands/agents moved under
  `corpus/` so the installer maps one payload root and the repo root cleanly
  separates installable content from repo meta. Applied to both repos via `git mv`.
- **Config (separate, XDG):** `~/.config/agentic-ocean/` holds `installer.yaml` (the
  editor-path → corpus-subdir mapping) and later `repos/` profiles (ADR-003). Config is
  config; corpus is a project (ADR-002 Theme 10). The config/family namespace was renamed
  from `ai-workflow` → `agentic-ocean` (2026-06-09) so `agentic-ocean` serves as both the
  core repo name and the shared family namespace for *both* repos.
- **Versioning:** independent of dev-infra (ADR-001) — the corpus releases on its own
  cadence.
- **Install mode:** symlink farm (C-INST-1 resolved GO); copy-mode is the documented
  contingency only.

---

## Relationship to this feature

| Group | Produces |
|-------|----------|
| 2 — Corpus Repository Structure | Establishes the repo + migrates the inventory above into it |
| 3 — Installer Mapping & XDG Config | `installer.yaml` schema + `~/.config/agentic-ocean/` |
| 4 — Installer Script | `install.sh` (lives in the corpus repo) |
| 5 — Source Install & Multi-Machine | `clone → install` flow; retires proj-cli placeholder |
| 6 — Documentation & ADR Acceptance | Guide, cross-links, ADR-002 → Accepted |

Most Group 2–5 artifacts land in the **corpus repo**, not dev-infra — like proj-cli #31
did for skill-template-separation Group 5. dev-infra holds the plan + this reference;
the code ships in the corpus repo.

---

## Open questions for Group 2

1. ~~**Personal vs shared skills:** all authored skills vs core/personal split?~~
   **RESOLVED** by [ADR-001: Corpus Repository Split Model](../decisions/adr-001-corpus-repo-split-model.md)
   — **two repos**: core (`agentic-ocean`, shareable) + personal (`agentic-ocean-personal`,
   private). A skill is core if general-purpose/durable **or** depended-on by a core
   artifact; otherwise personal. `update-pr-description` is **core** (dependency-forced
   via `group-cycle.agent`); `apprentice-*` / `ticket-*` / `capture-discussion` are
   personal. Invariant: no core→personal dependencies.
2. ~~**Repo + family naming**~~ **RESOLVED** (2026-06-09) → core repo `agentic-ocean`,
   personal `agentic-ocean-personal`, and the shared family/config namespace
   `~/.config/agentic-ocean/`. `agentic-ocean` is both the core repo name and the family
   namespace. (Name is still "for now" — but everything is consistent now, so a future
   rename is a single sweep.)
3. **`research-orchestrator/`** is a directory under `agents/` (not a single `.agent.md`)
   — confirm the agents layout handles both forms.
4. **Migration mechanics:** move (git mv from nowhere — they're untracked) vs copy then
   symlink-back. Likely: copy into repo, then the installer symlinks editor paths → repo,
   then remove the originals.

---

## References

- [ADR-002: Installation & Distribution Architecture](../../../../meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md)
- [ADR-001: Skill-Template Separation Model](../../../../meta/features/skill-template-separation/decisions/adr-001-separation-model.md) — corpus as separate product
- [Implementation plan](implementation-plan.md) · [Group 2](tasks/02-corpus-repository-structure.md)
- [skill-package-controller exploration](../../../explorations/skill-package-controller/exploration.md)

---

**Last Updated:** 2026-06-09
