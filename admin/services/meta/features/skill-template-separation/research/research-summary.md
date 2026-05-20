# Research Summary — Skill-Template Separation

**Status:** ✅ Consolidated
**Created:** 2026-05-06
**Last Updated:** 2026-05-19

---

## Overview

11 research topics investigating how to separate skills/commands/agents from templates, what templates become after separation, what substrate enables the transition, how artifacts are managed, and the installation/distribution mechanism.

| Priority | Topics | Status |
|----------|--------|--------|
| High | 2 (Topics 1, 2) | ✅ Both Complete |
| Medium | 5 (Topics 3, 4, 6, 8, 9) | 3 Complete, 2 Deferred |
| Low | 4 (Topics 5, 7, 11) + Topic 10 (Medium) | 2 Complete (10, 11), 2 Deferred (5, 7) |

---

## Key Findings

*(Populated after research-conduct completes each topic)*

### Topic 1: Minimum Viable Project Contract

The current 89-file standard template is 91% removable: 47% is skills/commands (migrated to global installs), 27% is docs infrastructure (created on demand by skills), 8% is structural empties. The minimal template converges on **7-9 files**: AGENTS.md (AI agent contract), `.dev-infra.yml` (proj-cli state), `.gitignore` (scratch hygiene), README.md (human identity), and optionally CI config + entry point. Key insight: skills create their own structure on demand — pre-building it is wasted scaffolding that becomes stale. AGENTS.md is the highest-leverage file (Linux Foundation standard, 28.6% agent runtime reduction per Princeton research).

### Topic 2: Per-Repo Profile Location and Schema

The unified per-repo profile lives at `~/.cursor/repos/<slug>.yaml` (slug = repo basename from git remote). Schema starts at v1 with three sections: `ticket:` (existing ticket-intake conventions), `paths:` (artifact/plan/scratch roots), and `artifacts:` (location strategy from Topic 9). Lookup convention: invocation flag → AGENTS.md → external profile → skill defaults. AGENTS.md and the profile are complementary (repo's shared opinion vs. user's personal preferences). XDG-compliant path (`~/.config/ai-workflow/repos/`) documented as migration target if multi-editor support becomes needed. Controller state (setup status, last-seen) separated from user-editable config.

### Topic 3: Skill Corpus Ownership Model

The corpus should be its own repo (Model B: separate). 76% of the corpus already exists only globally — dev-infra's template copies are a stale 24% subset. The corpus and templates are different products with different lifecycles. The canonical XDG location (`~/.config/ai-workflow/`) becomes the repo root. Zero coordination cost because symlink dev-mode means editing never involves dev-infra's git flow. Dev-infra retains only a manifest of expected skills, not copies. The hybrid model (some skills in dev-infra, some outside) is explicitly rejected — it creates ambiguity.

### Topic 4: Template Skill Bundling Strategy

Model B confirmed: templates carry NO skill/command/agent copies. They include only an `expected_skills` manifest in `.dev-infra.yml` (machine-readable for proj-cli validation) and a note in AGENTS.md. No "package manager" is needed — the symlink installer (Topic 10) IS the install mechanism. `template-sync-manifest.txt` should be retired. Generated projects function without skills installed (degraded but functional via AGENTS.md). The `workflow-decoupling` exploration's "package manager question" is answered: manifest + existing install mechanism, not a new tool.

### Topic 5: Migration Path for Existing Projects

*(Not yet researched)*

### Topic 6: `global-command-distribution` Requirements Audit

The December 2025 feature is **superseded**. FR-1 (install globally) is already done. FR-2 (project installs) and FR-5 (check updates) are superseded by the no-bundling model. FR-3 (version tracking) evolves into corpus versioning (deferred until distribution mode needed). FR-4 (update) is replaced by symlinks (always current). Two platform constraints survive: C-1 (rules NOT global — only skills/commands/agents work globally) and C-2 (project commands override global). The old feature's core assumption (dev-infra as authority) is explicitly rejected.

### Topic 7: Meta Work-Unit Naming

*(Not yet researched)*

### Topic 8: Process Artifact Storage — Branch-Local vs. Merged

*(Not yet researched)*

### Topic 9: Artifact Management Configuration Schema

*(Not yet researched)*

### Topic 10: Symlink-Based Installation

GNU Stow pattern (25+ years proven) works for bridging canonical XDG package location to editor-specific paths. The installer is a thin adapter with a mapping table (editor → paths). Cursor has known symlink bugs for plugins (`Dirent.isDirectory()` returns false), but skills are markdown files read via standard `fs.readFile()` which follows symlinks transparently — different code path. Recommendation: start with directory-level symlinks, fall back to hybrid (real dirs, symlinked children) if needed. A 5-minute spike (symlink one skill dir, invoke it) would fully de-risk.

### Topic 11: Dev Mode vs. Distribution Mode

Two permanent coexisting modes: dev (symlinks, zero-friction edit-test cycle for the author) and distribution (plugin publish for external consumers). Not a maturity progression — both serve different audiences permanently. AI skill testing is impractical at this scale: prompt testing appears in only ~1% of agent framework tests, proper frameworks (AgentAssay) require 5-10 multi-trial runs per test. Usage-as-testing is the correct methodology, not laziness. Cursor's plugin system (`~/.cursor/plugins/local/`) is the ready-made distribution mechanism — add a manifest when there's a second consumer, not before. The npm link analogy holds but is *simpler* for skills (no dependency resolution, no version conflicts).

---

## Cross-Topic Patterns

*(Populated during research-consolidate — patterns that emerge across multiple topics)*

---

## Requirements Summary

See [requirements.md](requirements.md) for the full requirements document.

**Status:** Final (consolidated 2026-05-19)
**Counts:** 25 FR, 10 NFR, 9 Constraints, 0 Assumptions = 44 total requirements

**Consolidation actions:** Merged 4 redundancies (FR-MVPC-6→BNDL-1, FR-DEV-2→INST-1, FR-OWN-3→INST-4, NFR-DEV-1→FR-DEV-1), added 2 gap fills (FR-INST-5 self-contained installer, FR-INST-6 config-driven mapping), modified 2 stale requirements (FR-PROF-1 and C-PROF-1 to reflect XDG-primary framing).

---

## Next Steps

1. Proceed to `/decision` phase — recommended ADRs: separation model, installation architecture, profile schema v1
2. Deferred topics (5, 7, 8, 9) can be researched later and may append requirements, but do not block decisions
3. Template minimalism spike (MEDIUM-HIGH) recommended before implementation to validate the 7-9 file template on a real project
