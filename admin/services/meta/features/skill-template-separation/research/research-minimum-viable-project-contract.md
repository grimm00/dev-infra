# Research: Minimum Viable Project Contract

**Status:** 🔴 Not Started
**Priority:** High
**Created:** 2026-05-06

---

## Research Question

What's the minimum set of files/structure that `proj-cli`/`work-prod` and AI agents need to manage a project's lifecycle — i.e., what must be in the minimal template?

---

## Research Goals

- [ ] Identify what `proj-cli` requires to detect and manage a project (state file, manifest, etc.)
- [ ] Identify what AI agents (skills, commands, agents) require to operate in a repo (scratch path, AGENTS.md, profile pointer)
- [ ] Identify what `work-prod` requires to register and track a project (registry entry, metadata)
- [ ] Determine the boundary between "template provides" and "on-demand creation by skills/tools"
- [ ] Produce a candidate list of "day-one files" that constitute the minimal template
- [ ] Compare against what the current comprehensive template provides to understand what would be removed

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] Current `templates/standard-project/` file listing (what exists today)
- [ ] Current `templates/learning-project/` file listing (what exists today)
- [ ] `proj-cli` source — what files does it read/write?
- [ ] `work-prod` API — what project metadata does it require?
- [ ] Existing skills that create files on first run (evidence of "on-demand" pattern)
- [ ] `skill-package-controller` exploration — AGENTS.md as project contract candidate
- [ ] Web search: minimal project scaffolds in other ecosystems (cookiecutter, yeoman, cargo init)

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

Begin research-conduct for this topic. Pair with Topic 2 (per-repo profile) as findings are mutually constraining.
