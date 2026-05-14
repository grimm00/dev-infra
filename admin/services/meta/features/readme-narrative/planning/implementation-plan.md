---
task_count: 9
groups:
  - name: "Origin Narrative Content"
    file: "tasks/01-origin-narrative-content.md"
    tasks: [1, 2, 3]
  - name: "README Restructure"
    file: "tasks/02-readme-restructure.md"
    tasks: [4, 5, 6, 7]
  - name: "Start.txt Reconciliation"
    file: "tasks/03-start-txt-reconciliation.md"
    tasks: [8, 9]
tasks_files:
  - "tasks/01-origin-narrative-content.md"
  - "tasks/02-readme-restructure.md"
  - "tasks/03-start-txt-reconciliation.md"
---
# Implementation Plan — README Narrative

**Status:** 🟠 In Progress
**Created:** 2026-05-14
**Last Updated:** 2026-05-14
**Source:** Discussion artifacts + research on narrative-driven READMEs + ADR-001 (project identity) + existing README.md + start.txt

---

## 📋 Overview

Dev-infra's README currently reads as a product spec sheet — it describes what the project does and how to use it, but provides no context for why it exists, how it evolved, or what it has produced. Research on 2026 narrative-driven README conventions (Finding 1) and self-assessment identified that the README lacks an origin section (Finding 2), underselling a 7-month, 1,100+ commit project with 14 ADRs and multiple downstream production projects (pi-hole DNS, proj-cli, OurFileServer). This plan adds narrative context, restructures the README to lead with purpose over mechanics, and reconciles the untouched start.txt.

**Key Changes:**
- Add origin/narrative section communicating why dev-infra exists, the identity pivot, and downstream lineage
- Restructure README to follow 2026 conventions: origin story first, technical details secondary
- Address staleness (dates, version references, broken link placeholders)
- Fill in start.txt with actual project initialization context

---

## 🎯 Goals

1. **Communicate the project's nature** — A reader should understand that dev-infra is a living system that produces other systems, not a weekend scaffold generator
2. **Surface the origin and identity pivot** — The lab-to-factory decision (ADR-001) shows project maturity that the current README hides
3. **Document downstream lineage** — Real projects running on dev-infra patterns are the proof that the templates work
4. **Follow 2026 README conventions** — Origin story first, technical details collapsible/secondary, research methodology over marketing claims
5. **Eliminate staleness** — Version refs, dates, and placeholder links should reflect current state

---

## 📝 Implementation Plan

### Origin Narrative Content
- [x] Task 1: Draft origin section — the problem that motivated dev-infra
- [x] Task 2: Write identity pivot narrative — lab/factory/reference tension and ADR-001 resolution
- [ ] Task 3: Write downstream lineage section — projects produced by dev-infra patterns

### README Restructure
- [ ] Task 4: Reorder README sections — origin/narrative before Quick Start
- [ ] Task 5: Consolidate redundant sections and reduce emoji-header noise
- [ ] Task 6: Update stale references — version numbers, dates, placeholder links
- [ ] Task 7: Make technical details secondary — collapsible or lower-priority positioning

### Start.txt Reconciliation
- [ ] Task 8: Fill in start.txt with actual dev-infra project context
- [ ] Task 9: Review start.txt against README origin section for consistency

---

## ✅ Definition of Done

- [ ] README has an origin/narrative section before Quick Start
- [ ] A reader can understand why this project exists without scrolling to technical details
- [ ] Downstream projects are named and their relationship to dev-infra is clear
- [ ] No stale version numbers, dates, or broken placeholder links
- [ ] start.txt reflects actual project context, not template placeholders
- [ ] Commit history shows clean `docs(readme-narrative):` scoping

---

## 🔗 Related

- [ADR-001: Project Identity](../../dev-infra-identity-and-focus/decisions/adr-001-project-identity.md) — the identity pivot from lab+factory+reference to template factory
- [Discussion artifacts](.) — this plan sourced from `/discuss` session on narrative-driven READMEs
- Research Finding 1: Narrative-driven READMEs as 2026 convention (Grinta-Agent, Clarté, BlackRoad, Lumen)
- Research Finding 2: dev-infra README currently has no origin section

---

**Last Updated:** 2026-05-14
