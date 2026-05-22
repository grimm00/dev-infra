---
task_count: 25
groups:
  - name: "Branch Setup & Doc Curation"
    file: "tasks/01-branch-setup-and-doc-curation.md"
    tasks: [1, 2, 3, 4, 5]
  - name: "Template Cleanup"
    file: "tasks/02-template-cleanup.md"
    tasks: [6, 7, 8, 9, 10]
  - name: "Template-Sync-Manifest Retirement"
    file: "tasks/03-template-sync-manifest-retirement.md"
    tasks: [11, 12, 13, 14]
  - name: "expected_skills Manifest in Templates"
    file: "tasks/04-expected-skills-manifest.md"
    tasks: [15, 16, 17, 18]
  - name: "proj-cli Validation"
    file: "tasks/05-proj-cli-validation.md"
    tasks: [19, 20, 21, 22]
  - name: "Documentation & Supersession"
    file: "tasks/06-documentation-and-supersession.md"
    tasks: [23, 24, 25]
tasks_files:
  - "tasks/01-branch-setup-and-doc-curation.md"
  - "tasks/02-template-cleanup.md"
  - "tasks/03-template-sync-manifest-retirement.md"
  - "tasks/04-expected-skills-manifest.md"
  - "tasks/05-proj-cli-validation.md"
  - "tasks/06-documentation-and-supersession.md"
---
# Implementation Plan — Skill-Template Separation (ADR-001)

**Status:** 🔴 Not Started
**Created:** 2026-05-22
**Last Updated:** 2026-05-22
**Source:** [decisions/adr-001-separation-model.md](../decisions/adr-001-separation-model.md)

---

## 📋 Overview

Implements ADR-001 — formalizes the skill corpus as a separate product from dev-infra templates. Removes any remaining bundled skills/commands/agents from templates, retires the now-obsolete `template-sync-manifest.txt`, introduces an `expected_skills` manifest in `.dev-infra.yml` for `proj-cli` validation, and curates which artifacts merge to develop (Theme 6: branch-as-workspace, only hard artifacts merge).

This plan covers ADR-001 only. ADR-002 (installation architecture / symlinks) and ADR-003 (per-repo profile schema) will get their own implementation plans.

**Key Changes:**
- New feature branch off `develop` carries only ADR-001 + this planning tree (small doc surface)
- Template trees lose any remaining `.claude/skills/`, `.cursor/commands/`, agent files
- `scripts/template-sync-manifest.txt` and its validation script retired
- `.dev-infra.yml` gains an `expected_skills` field
- `proj-cli` setup gains a warn-not-error validation step
- The December 2025 `global-command-distribution` feature is marked superseded

---

## 🎯 Goals

1. **Curated Doc Surface on Develop** — Only ADR-001 and the planning tree merge to `develop`; research, exploration, and other ADRs stay on the research branch.
2. **Templates Free of Bundled Tooling** — No skill/command/agent copies remain in `templates/`. The corpus is sourced externally per ADR-001.
3. **Manifest-Based Skill Expectations** — `.dev-infra.yml` declares `expected_skills`; `proj-cli` validates with a warning when missing.
4. **Manifest Sync Retired** — `template-sync-manifest.txt` and `validate-template-sync.sh` are removed; CI no longer enforces sync that no longer exists.
5. **Graceful Degradation Verified** — A generated project works (CI passes, AGENTS.md orients agents) even with no skills installed.
6. **Cross-References Updated** — `global-command-distribution` superseded; four-arm-architecture extended; dev-infra AGENTS.md reflects template minimalism.

---

## 📝 Implementation Plan

### Branch Setup & Doc Curation
- [ ] Task 1: Create new feature branch from develop
- [ ] Task 2: Selectively transfer ADR-001 to the new branch
- [ ] Task 3: Selectively transfer planning tree to the new branch
- [ ] Task 4: Decide how ADR-001's research references are handled on develop
- [ ] Task 5: Verify the new branch contains only curated hard artifacts

### Template Cleanup
- [ ] Task 6: Audit current template tree for skill/command/agent residue
- [ ] Task 7: Remove `templates/standard-project/.claude/skills/` if present
- [ ] Task 8: Remove `templates/standard-project/.cursor/commands/` if present
- [ ] Task 9: Remove any agent files from `templates/`
- [ ] Task 10: Update template validation tests to confirm absence

### Template-Sync-Manifest Retirement
- [ ] Task 11: Audit `scripts/template-sync-manifest.txt` for remaining valid entries
- [ ] Task 12: Remove or repurpose the manifest file
- [ ] Task 13: Remove or update `scripts/validate-template-sync.sh`
- [ ] Task 14: Remove related CI workflow steps that consume the manifest

### expected_skills Manifest in Templates
- [ ] Task 15: Define `expected_skills` field schema in `.dev-infra.yml`
- [ ] Task 16: Populate `expected_skills` in `templates/standard-project/.dev-infra.yml`
- [ ] Task 17: Populate `expected_skills` in `templates/learning-project/.dev-infra.yml`
- [ ] Task 18: Document the field in template README and `.dev-infra.yml` reference docs

### proj-cli Validation
- [ ] Task 19: Design `proj-cli` `expected_skills` validation step (warn-not-error)
- [ ] Task 20: Implement validation logic in `proj-cli` setup flow
- [ ] Task 21: Add install-guidance message text pointing to the corpus
- [ ] Task 22: Test graceful degradation (generated project works without skills installed)

### Documentation & Supersession
- [ ] Task 23: Mark `global-command-distribution` feature README as superseded by ADR-001
- [ ] Task 24: Update dev-infra AGENTS.md / docs to reflect template minimalism + manifest pattern
- [ ] Task 25: Cross-link ADR-001 from four-arm-architecture and skill-template-separation hubs

---

## ✅ Definition of Done

- [ ] All 25 tasks complete
- [ ] CI passes on the new feature branch
- [ ] Generated project (via `./scripts/new-project.sh`) contains no bundled skills/commands/agents
- [ ] `proj-cli` setup warns (not errors) when expected skills are missing
- [ ] `template-sync-manifest.txt` and validator removed; CI green without them
- [ ] ADR-001 status moved from 🔴 Proposed → ✅ Accepted (acceptance recorded in the ADR file)
- [ ] PR to `develop` carries only ADR-001 + planning tree (no research, no exploration, no other ADRs)

---

## 🔗 Related

- **Source ADR:** [decisions/adr-001-separation-model.md](../decisions/adr-001-separation-model.md)
- **Sibling ADRs (separate plans):** [adr-002-installation-architecture.md](../decisions/adr-002-installation-architecture.md), [adr-003-per-repo-profile-schema.md](../decisions/adr-003-per-repo-profile-schema.md)
- **Theme 6 (branch-as-workspace):** [../../../explorations/skill-template-separation/exploration.md](../../../explorations/skill-template-separation/exploration.md) — Why only ADR-001 + planning merge to develop
- **Superseded:** [admin/services/meta/features/global-command-distribution/](../../global-command-distribution/) — December 2025 feature replaced by this work

---

**Last Updated:** 2026-05-22
