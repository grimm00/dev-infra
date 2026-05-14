# Research: Template Skill Bundling Strategy

**Status:** 🔴 Not Started
**Priority:** Medium
**Created:** 2026-05-06

---

## Research Question

After separation, do templates still bundle a subset of skills (as release snapshots), or do they rely entirely on global installs and just document which skills they expect?

---

## Research Goals

- [ ] Define "bundling" precisely: full skill copy in template vs. manifest/lockfile referencing skills
- [ ] Evaluate Model A (snapshot at release): templates include skills at release time, generated projects start with them
- [ ] Evaluate Model B (no bundling): templates carry no skills, document expected global installs instead
- [ ] Evaluate Model C (manifest only): templates include a skill manifest that a setup command resolves
- [ ] Assess self-containment tradeoff: can a generated project work without global installs?
- [ ] Determine what the `workflow-decoupling` exploration's "package manager question" means for each model
- [ ] Assess version drift: if templates snapshot skills, how quickly do they go stale?

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] Current `template-sync-manifest.txt` — what's synced today and why
- [ ] `workflow-decoupling` exploration (template-generation) — Themes 4 and 5 (package manager, versioning)
- [ ] Four-arm architecture ADR-001 — command distribution ownership decision
- [ ] Issue #73 — template drift documentation
- [ ] Web search: package bundling vs. dependency declaration patterns (npm bundledDependencies, pip freeze vs requirements, cargo vendor)

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

Depends on Topics 1 and 3 (what the minimal template contains and who owns skills). Begin after those topics produce findings.
