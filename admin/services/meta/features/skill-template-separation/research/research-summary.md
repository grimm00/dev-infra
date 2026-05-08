# Research Summary — Skill-Template Separation

**Status:** 🔴 Not Started
**Created:** 2026-05-06
**Last Updated:** 2026-05-06

---

## Overview

11 research topics investigating how to separate skills/commands/agents from templates, what templates become after separation, what substrate enables the transition, how artifacts are managed, and the installation/distribution mechanism.

| Priority | Topics | Status |
|----------|--------|--------|
| High | 2 (Topics 1, 2) | ✅ Both Complete |
| Medium | 5 (Topics 3, 4, 6, 8, 9) | 🔴 Not Started |
| Low | 2 (Topics 5, 7) | 🔴 Not Started |

---

## Key Findings

*(Populated after research-conduct completes each topic)*

### Topic 1: Minimum Viable Project Contract

The current 89-file standard template is 91% removable: 47% is skills/commands (migrated to global installs), 27% is docs infrastructure (created on demand by skills), 8% is structural empties. The minimal template converges on **7-9 files**: AGENTS.md (AI agent contract), `.dev-infra.yml` (proj-cli state), `.gitignore` (scratch hygiene), README.md (human identity), and optionally CI config + entry point. Key insight: skills create their own structure on demand — pre-building it is wasted scaffolding that becomes stale. AGENTS.md is the highest-leverage file (Linux Foundation standard, 28.6% agent runtime reduction per Princeton research).

### Topic 2: Per-Repo Profile Location and Schema

The unified per-repo profile lives at `~/.cursor/repos/<slug>.yaml` (slug = repo basename from git remote). Schema starts at v1 with three sections: `ticket:` (existing ticket-intake conventions), `paths:` (artifact/plan/scratch roots), and `artifacts:` (location strategy from Topic 9). Lookup convention: invocation flag → AGENTS.md → external profile → skill defaults. AGENTS.md and the profile are complementary (repo's shared opinion vs. user's personal preferences). XDG-compliant path (`~/.config/ai-workflow/repos/`) documented as migration target if multi-editor support becomes needed. Controller state (setup status, last-seen) separated from user-editable config.

### Topic 3: Skill Corpus Ownership Model

*(Not yet researched)*

### Topic 4: Template Skill Bundling Strategy

*(Not yet researched)*

### Topic 5: Migration Path for Existing Projects

*(Not yet researched)*

### Topic 6: `global-command-distribution` Requirements Audit

*(Not yet researched)*

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

*(Requirements extracted from each topic's findings during research-conduct, consolidated and deduped during research-consolidate)*

---

## Next Steps

1. Begin research-conduct on Topics 1 and 2 (highest priority, unblock others)
2. Topic 6 can proceed in parallel (pure audit of existing docs)
3. After all topics complete → research-consolidate → decision phase
