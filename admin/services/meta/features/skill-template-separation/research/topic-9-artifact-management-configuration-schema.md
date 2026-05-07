# Research: Artifact Management Configuration Schema — Location and Retention Axes

**Status:** 🔴 Not Started
**Priority:** Medium
**Created:** 2026-05-06

---

## Research Question

What should the per-repo profile schema look like for artifact location (on-disk / worktree / in-repo), and how should the handoff/merge skill prompt for retention strategy (full / condensed / minimal) at feature completion?

---

## Research Goals

- [ ] Define the location axis options and their implications: on-disk (outside repo), worktree/branch (in working tree, gitignored or branch-local), in-repo (committed, merges)
- [ ] Determine profile schema fields for location: key name, allowed values, default, per-service override support
- [ ] Define the retention axis options: full (keep all process artifacts), condensed (produce summary, archive raw), minimal (only decisions/deliverables survive)
- [ ] Determine where and when retention is prompted: handoff skill, merge skill, or a dedicated archive/close skill
- [ ] Evaluate whether retention choice affects what merges vs. what gets tagged/archived on the branch
- [ ] Assess interaction between location and retention: e.g., if location=worktree but retention=full, does the branch just never get deleted?
- [ ] Determine whether "features" on develop become thin registry entries (name, status, links to ADRs) regardless of location/retention choice

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] Topic 2 research (per-repo profile schema) — location config is a field in this schema
- [ ] `artifact-emission-strategy.md` int-opp — L0-L3 spectrum maps to retention axis
- [ ] `handoff` skill — current completion workflow, where retention prompt would live
- [ ] `finishing-a-development-branch` skill — merge/archive decision point
- [ ] Web search: project artifact lifecycle management, configurable documentation retention

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

Begin research-conduct for this topic. Depends on Topic 2 findings (profile schema) and Topic 8 findings (branch-local model). Together with Topic 8, determines the full artifact management story.
