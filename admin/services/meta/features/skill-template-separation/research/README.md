# Research — Skill-Template Separation

**Purpose:** Investigate 9 topics to determine how skills/commands/agents separate from templates, what templates become after separation, and what substrate enables both
**Status:** 🔴 Research
**Created:** 2026-05-06
**Last Updated:** 2026-05-07

---

## Quick Links

- [Research Summary](research-summary.md) — cross-topic rollup (populated after conduct)
- [Requirements](requirements.md) — FR / NFR / constraints extracted from findings
- **Exploration source:** [../../explorations/skill-template-separation/](../../explorations/skill-template-separation/)

---

## Research Status

| # | Topic | File | Priority | Status |
|---|-------|------|----------|--------|
| 1 | Minimum Viable Project Contract | [research-minimum-viable-project-contract.md](research-minimum-viable-project-contract.md) | High | ✅ Complete |
| 2 | Per-Repo Profile Location and Schema | [research-per-repo-profile-location-and-schema.md](research-per-repo-profile-location-and-schema.md) | High | ✅ Complete |
| 3 | Skill Corpus Ownership Model | [research-skill-corpus-ownership-model.md](research-skill-corpus-ownership-model.md) | Medium | 🔴 Not Started |
| 4 | Template Skill Bundling Strategy | [research-template-skill-bundling-strategy.md](research-template-skill-bundling-strategy.md) | Medium | 🔴 Not Started |
| 5 | Migration Path for Existing Projects | [research-migration-path-for-existing-projects.md](research-migration-path-for-existing-projects.md) | Low | 🔴 Not Started |
| 6 | `global-command-distribution` Requirements Audit | [research-global-command-distribution-requirements-audit.md](research-global-command-distribution-requirements-audit.md) | Medium | 🔴 Not Started |
| 7 | Meta Work-Unit Naming | [research-meta-work-unit-naming.md](research-meta-work-unit-naming.md) | Low | 🔴 Not Started |
| 8 | Process Artifact Storage — Branch-Local vs. Merged | [topic-8-process-artifact-storage.md](topic-8-process-artifact-storage.md) | Medium | 🔴 Not Started |
| 9 | Artifact Management Configuration Schema | [topic-9-artifact-management-configuration-schema.md](topic-9-artifact-management-configuration-schema.md) | Medium | 🔴 Not Started |

---

## Research Overview

This research spans four interconnected concerns:

1. **What do templates become?** (Topics 1, 4, 5) — Define the minimal template, decide bundling strategy, plan migration
2. **What enables skills to work anywhere?** (Topic 2) — Per-repo profile location and schema (ai-workflow substrate, consumed by meta decisions)
3. **What's the organizational model?** (Topics 3, 6, 7) — Skill ownership, requirements reuse, naming conventions
4. **How are artifacts managed?** (Topics 8, 9) — Where process artifacts live, what survives feature completion, configurable location and retention

**Recommended conduct order:** Topics 1 and 2 first (they constrain the others), then Topic 6 (reuse existing research), then Topics 3–4 (depend on 1+2 findings), then Topics 5 and 7 (lowest priority, least dependent).

---

## Next Steps

1. Use `research-conduct` to investigate Topics 1 and 2 (highest priority, unblock all other topics)
2. Topic 6 is housekeeping — audit the existing `global-command-distribution` requirements early to avoid duplicating work
3. After all topics complete, use `research-consolidate` to reconcile findings and finalize requirements
