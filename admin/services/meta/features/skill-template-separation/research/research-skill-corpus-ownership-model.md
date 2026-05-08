# Research: Skill Corpus Ownership Model

**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-05-06
**Completed:** 2026-05-08

---

## Research Question

Does dev-infra continue to own the skill corpus (global installs as primary, dev-infra as the repo), or do skills become a separate project?

---

## Research Goals

- [x] Assess current state: which skills live only globally vs. which have dev-infra copies
- [x] Evaluate single-repo model: skills stay in dev-infra with a different release cadence (internal separation)
- [x] Evaluate split-repo model: skills get their own repo with independent versioning
- [x] Evaluate hybrid: dev-infra owns "core" skills, other skills are personal/per-project
- [x] Determine audience impact: if skills stay personal (never consumed by others), does repo separation matter?
- [x] Assess coordination cost of each model (release process, cross-repo PRs, testing)

---

## Methodology

**Queries executed:**
1. "monorepo vs multi-repo personal developer tools dotfiles packages ownership model 2025 2026 chezmoi yadm"
2. "single developer personal tool repository organization skills plugins separate repo vs monorepo tradeoffs 2025 2026"

**Internal sources consulted:**
- `~/.cursor/skills/` listing (18 skills globally installed)
- `~/.cursor/skills-cursor/` listing (13 Cursor-specific skills)
- `~/.cursor/commands/` listing (20 commands)
- `~/.cursor/agents/` listing (3 agents)
- `templates/standard-project/.claude/skills/` listing (13 skills in template)
- Topic 10 findings (canonical XDG location)
- Topic 11 findings (dev mode via symlinks)

---

## Sources

- [x] Current `~/.cursor/skills/` — 18 skills installed globally
- [x] `~/.cursor/skills-cursor/` — 13 additional Cursor-specific skills (not in template)
- [x] `templates/standard-project/.claude/skills/` — 13 skills (subset of global)
- [x] `~/.cursor/commands/` — 20 commands (no template copies remain)
- [x] `~/.cursor/agents/` — 3 agents (global only)
- [x] Web search: monorepo vs. polyrepo for personal tools, chezmoi multi-source patterns

---

## Findings

### Finding 1: The Corpus Has Already Diverged from Dev-Infra

**Source:** Internal: directory listings comparison
**Relevance:** Comparing what's globally installed vs. what's in the template:

| Category | Global | In Template | Global-Only |
|----------|--------|-------------|-------------|
| Core skills (`~/.cursor/skills/`) | 18 | 13 | 5 (`apprentice-eod`, `apprentice-standup`, `ticket-create`, `ticket-intake`, `update-pr-description`) |
| Cursor skills (`~/.cursor/skills-cursor/`) | 13 | 0 | All 13 |
| Commands (`~/.cursor/commands/`) | 20 | 0 (mass-deleted from working tree) | All 20 |
| Agents (`~/.cursor/agents/`) | 3 | 0 | All 3 |

**Total corpus:** 54 artifacts globally. Template contains 13 (24%). The de facto state is already "global-first, template is a stale subset." Dev-infra doesn't *own* the corpus in any meaningful operational sense — it just has copies of some of it.

### Finding 2: The Canonical Location Changes Everything

**Source:** Topics 10 and 11 — symlink-based installation, XDG canonical path
**Relevance:** If the canonical package lives at `~/.config/ai-workflow/` (per Topic 10) and dev-infra is a *template factory* (per AGENTS.md/ADR-001), then the corpus and the templates are different products:

- **The corpus** is operational tooling — it runs in any repo, evolves continuously, is tested through usage
- **Dev-infra** is a project factory — it produces templates, scripts, and documentation on a release cadence

These are different products with different lifecycles. The question is whether they share a repo.

### Finding 3: Solo Developer Monorepos Are Viable but Not Required

**Source:** Web search: monorepo vs. polyrepo decision frameworks
**Relevance:** For a single developer:
- Monorepos excel when there's shared code between packages and you want atomic cross-cutting changes
- Polyrepos win for isolation and independent deployment
- The recommendation: "start single-repo for simplicity, evolve to monorepo only when code-sharing friction actually exists"

For skills vs. dev-infra specifically: there is minimal shared code between them. Skills are self-contained markdown+YAML; dev-infra has shell scripts, templates, and documentation. They don't import from each other. The only connection is that templates *used to* bundle skills — but Topic 1 research says they shouldn't.

### Finding 4: Chezmoi's Multi-Source Limitation Is Instructive

**Source:** chezmoi GitHub issue #3817
**Relevance:** When a user asked chezmoi about managing files from multiple repos (personal + employer), the maintainers said "there's really no good answer" and recommended aliases to separate repos. The pattern that *doesn't* work: trying to merge multiple authoring concerns into one directory structure.

**Implication:** Dev-infra and the skill corpus are two authoring concerns. Forcing them into one repo creates the same tension chezmoi users experience — changes to skills pollute the template release history, and template releases gate skill iterations.

### Finding 5: The Symlink Dev-Mode Eliminates the Cross-Repo Coordination Cost

**Source:** Topic 11 findings (FR-DEV-1: zero-friction edit-test)
**Relevance:** The traditional argument against splitting repos for a solo dev is coordination cost: cross-repo PRs, version pinning, release synchronization. But with the symlink dev-mode:

- The skill corpus lives at `~/.config/ai-workflow/` (canonical)
- Editing is direct (no build, no publish, no cross-repo PR)
- The dev-infra repo references the corpus only at *template release time* (snapshots a manifest of which skills the template expects, per Topic 4)

The coordination cost of a split is near-zero because the authoring workflow (symlinks, direct editing) doesn't involve either repo's git flow. The repo is just the backing store for version history and distribution.

---

## Analysis

### Three Models Evaluated

| Model | Description | Pros | Cons |
|-------|-------------|------|------|
| **A: Skills stay in dev-infra** | Same repo, different release cadence | Atomic changes, one clone | Polluted git history, gated releases, already de facto wrong |
| **B: Skills get own repo** | Separate repo at `~/.config/ai-workflow/` backed by its own git repo | Clean separation, independent versioning, matches XDG canonical location | One more repo to manage |
| **C: Hybrid** | "Core" skills in dev-infra, personal/work skills elsewhere | Preserves template bundling for core | Unclear boundary, two places to look, worst of both |

### Recommendation: Model B (Separate Repo)

The corpus should be its own repo for these reasons:

1. **It already is** — 76% of the corpus exists only globally, never in dev-infra. The template copies are a stale subset.
2. **Different products** — dev-infra produces templates; the corpus is operational tooling. Different audiences, lifecycles, and evolution pressures (Theme 1 of the exploration).
3. **The canonical location is XDG, not a dev-infra subtree** — Topics 10-11 established that the package lives at `~/.config/ai-workflow/`. That's the repo root.
4. **Zero coordination cost** — the symlink dev-mode means editing skills never involves dev-infra's git flow. The repos are independent in daily practice.
5. **Template bundling is dead** — Topic 1 (FR-MVPC-6) says templates MUST NOT bundle skills. The only connection between dev-infra and the corpus is a manifest saying "these skills should be available."

### What This Means for Dev-Infra

Dev-infra's role becomes:
- **Template products** — the minimal template (7-9 files per Topic 1)
- **Release automation** — `proj-cli`, `new-project.sh`, template validation
- **Meta documentation** — explorations, decisions, planning for dev-infra itself

The skill corpus is a separate product that happens to be authored by the same person. It has its own git history, its own versioning, and its own distribution (Cursor plugin when consumers appear, per Topic 11).

---

## Recommendations

- [x] Separate the skill corpus into its own repo (Model B) — the de facto state already reflects this
- [ ] The corpus repo should be rooted at the canonical XDG location (`~/.config/ai-workflow/`) or a source directory that symlinks from there
- [ ] Dev-infra retains only a *manifest* of expected skills (for `proj-cli` validation and template documentation), not copies
- [ ] The hybrid model (Model C) should be explicitly rejected — it creates ambiguity about where skills are authored and maintained
- [ ] Commands, agents, and Cursor-specific skills all go with the corpus (same product, same lifecycle)
- [ ] No immediate migration required — the current global installs already work. The "separation" is formalizing what's already true and giving the corpus its own git history

---

## Requirements Discovered

**FR-OWN-1:** The skill corpus (skills, commands, agents) MUST be a separate product from dev-infra templates, with its own repository and independent versioning.

**FR-OWN-2:** Dev-infra MUST NOT contain authoritative copies of skills. It MAY contain a manifest listing expected skills for template validation purposes.

**FR-OWN-3:** The corpus repo MUST be rooted at or symlinked from the canonical XDG location defined in Topic 2/10 (currently `~/.config/ai-workflow/`).

**NFR-OWN-1:** The separation MUST NOT introduce coordination overhead for daily skill development. The symlink dev-mode (Topic 11) ensures this.

**NFR-OWN-2:** The corpus repo SHOULD be browsable and searchable as a single unit (all skills, commands, agents in one tree for discoverability).

**C-OWN-1:** No migration deadline. The current global installs work. Formalization (creating the repo, moving git history) happens when convenient, not urgently.

---

## Next Steps

- Findings directly inform Topic 4 (bundling strategy): templates don't bundle skills; they reference a manifest
- Feeds into the `global-command-distribution` audit (Topic 6): the old feature's assumptions (dev-infra as authority) are explicitly superseded
- The corpus repo creation is a future task — not blocked on remaining research
