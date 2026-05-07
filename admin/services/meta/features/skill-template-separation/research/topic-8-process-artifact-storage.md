# Research: Process Artifact Storage — Branch-Local vs. Merged

**Status:** 🔴 Not Started
**Priority:** Medium
**Created:** 2026-05-06

---

## Research Question

Should process artifacts (explorations, research, planning docs) remain branch-local and never merge to develop, with only hard artifacts (ADRs, summaries) reaching the main line? What branch preservation or recovery mechanism is needed?

---

## Research Goals

- [ ] Catalog which artifact types are "process" (explorations, research, plans, spikes) vs. "archival" (ADRs, decision summaries, requirements, narratives)
- [ ] Evaluate branch preservation strategies: never delete branches, tag before delete, squash with rich summary, merge commit preserves full history
- [ ] Determine what `develop` looks like under branch-local model: only `features/[name]/decisions/` and summary artifacts?
- [ ] Assess impact on discoverability: can future-you or collaborators find process work when needed?
- [ ] Evaluate whether the explorations/ → features/ directory pattern is eliminated or simplified
- [ ] Determine how skills know whether to emit to "branch workspace" vs. "merge-back set" (is this the location config from Topic 9?)
- [ ] Identify risks: orphaned knowledge, broken cross-references, loss of context for ADRs

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] AGENTS.md worktree workflow section — "all feature content stays on the feature branch"
- [ ] Current service directory structure — `explorations/` + `features/` duplication pattern
- [ ] Git branch preservation patterns in other projects (monorepo strategies, RFC repos)
- [ ] `group-cycle-work.agent.md` — `.scratch/` as precedent for non-committed workspace artifacts
- [ ] Web search: branch-based documentation strategies, feature branch archival patterns

---

## Findings

*(To be filled during research-conduct)*

---

## Analysis

*(To be filled during research-conduct)*

---

## Recommendations

*(To be filled during research-conduct)*

---

## Requirements Discovered

*(To be extracted during research-conduct and consolidated in requirements.md)*

---

## Next Steps

Begin research-conduct for this topic. Findings directly inform Topic 9 (configuration schema) and connect to Theme 6 of the exploration. Also informs the worktree-feature-workflow exploration.
