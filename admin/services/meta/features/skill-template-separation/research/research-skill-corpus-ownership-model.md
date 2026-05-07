# Research: Skill Corpus Ownership Model

**Status:** 🔴 Not Started
**Priority:** Medium
**Created:** 2026-05-06

---

## Research Question

Does dev-infra continue to own the skill corpus (global installs as primary, dev-infra as the repo), or do skills become a separate project?

---

## Research Goals

- [ ] Assess current state: which skills live only globally vs. which have dev-infra copies
- [ ] Evaluate single-repo model: skills stay in dev-infra with a different release cadence (internal separation)
- [ ] Evaluate split-repo model: skills get their own repo with independent versioning
- [ ] Evaluate hybrid: dev-infra owns "core" skills, other skills are personal/per-project
- [ ] Determine audience impact: if skills stay personal (never consumed by others), does repo separation matter?
- [ ] Assess coordination cost of each model (release process, cross-repo PRs, testing)

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] Current `git status` — mass deletions of `.claude/skills/` indicate de facto global-first
- [ ] `~/.cursor/skills/` listing — what's installed globally now
- [ ] `templates/standard-project/.claude/skills/` — what was in the template
- [ ] Existing research from `global-command-distribution` feature (FR-3: version tracking)
- [ ] Web search: dotfile management patterns (chezmoi, yadm, stow) for personal tool distribution

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

Depends on Topics 1 and 2 findings (if templates are minimal, the ownership question simplifies). Can begin in parallel with prior art survey.
