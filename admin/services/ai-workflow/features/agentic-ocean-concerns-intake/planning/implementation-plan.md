---
task_count: 25
groups:
  - name: "Concerns channel shape in agentic-ocean"
    file: "tasks/01-concerns-channel-shape.md"
    tasks: [1, 2, 3, 4]
  - name: "Dev-infra source-side prep"
    file: "tasks/02-source-side-prep.md"
    tasks: [5, 6, 7]
  - name: "Migrate skill-bug issues"
    file: "tasks/03-migrate-skill-bug-issues.md"
    tasks: [8, 9]
  - name: "Migrate skill-architecture issues"
    file: "tasks/04-migrate-skill-architecture-issues.md"
    tasks: [10, 11]
  - name: "Migrate corpus mechanics int-opps"
    file: "tasks/05-migrate-corpus-mechanics-intopps.md"
    tasks: [12, 13]
  - name: "Migrate pipeline/design int-opps (batch A)"
    file: "tasks/06-migrate-pipeline-design-intopps-a.md"
    tasks: [14, 15]
  - name: "Migrate pipeline/design int-opps (batch B)"
    file: "tasks/07-migrate-pipeline-design-intopps-b.md"
    tasks: [16, 17]
  - name: "Learnings-as-concerns + BOTH cases"
    file: "tasks/08-learnings-and-both-cases.md"
    tasks: [18, 19, 20, 21]
  - name: "Hubs + verification + status doc"
    file: "tasks/09-hubs-and-verification.md"
    tasks: [22, 23, 24, 25]
tasks_files:
  - "tasks/01-concerns-channel-shape.md"
  - "tasks/02-source-side-prep.md"
  - "tasks/03-migrate-skill-bug-issues.md"
  - "tasks/04-migrate-skill-architecture-issues.md"
  - "tasks/05-migrate-corpus-mechanics-intopps.md"
  - "tasks/06-migrate-pipeline-design-intopps-a.md"
  - "tasks/07-migrate-pipeline-design-intopps-b.md"
  - "tasks/08-learnings-and-both-cases.md"
  - "tasks/09-hubs-and-verification.md"
---
# Implementation Plan — agentic-ocean-concerns-intake

**Status:** 🟡 Planned (Track α ✅ merged via [PR #115](https://github.com/grimm00/dev-infra/pull/115); execution pending on Tracks β and γ)
**Created:** 2026-06-22
**Last Updated:** 2026-07-02 (post-PR #115 merge)
**Source:** `planning/inputs/triage-table.md` (from `/discuss` session 2026-06-22, updated 2026-07-02)
**Design decisions:** [`design-decisions.md`](design-decisions.md) — channel shape (flat-root markdown), 3-track execution split, `migrate-concern` subagent scope, 88f83db8 folded in as new triage row. **All 6 decisions (D1–D6) resolved.**

---

## 📋 Overview

Migrate the open agentic-workflow concerns currently held in `grimm00/dev-infra`
(12 remote issues + ~40 int-opp documents + 1 discuss-derived concern) into the
right home now that the core corpus lives in `grimm00/agentic-ocean`. The triage
table classifies every item as MIGRATE, STAY, BOTH, MOOT, or HISTORICAL using a
"concern follows the artifact" rule. This plan executes that classification:
**authoring ~30 fresh corpus-side concern docs** (25 pure MIGRATE + 5 BOTH
corpus-halves) at flat-root markdown paths
(`agentic-ocean/concerns/<subdir>/<slug>.md`), cross-linking the 5 BOTH cases
back to their dev-infra records, closing 2 MOOT cases in dev-infra, and
resolving the prerequisite question of *where* concerns live in agentic-ocean
(Group 1).

**Key Changes:**
- New flat-root concerns channel scaffolded in `agentic-ocean/concerns/` (shape resolved 2026-07-02 per design-decisions.md D1; Group 1 authors the ADR)
- **~30 new concern docs authored + committed in `grimm00/agentic-ocean`** (25 MIGRATE + 5 BOTH corpus-halves)
- 2 dev-infra issues closed as superseded by the corpus split
- 2 dev-infra issues split into corpus / template halves before migrating
- Source int-opps annotated with migrated-to markers pointing at concern-doc paths; hub READMEs updated
- `agentic-workflow-modernization` status doc records the migration as a milestone

---

## 🎯 Goals

1. **Single source of truth per concern** — every open agentic-workflow concern
   has exactly one canonical home (corpus issues for skill/agent/installer
   surface; dev-infra for template/repo-process surface).
2. **Discoverability from the corpus side** — a contributor opening
   `agentic-ocean` can find the open concern surface without spelunking
   dev-infra's `admin/` tree.
3. **No silent context loss** — int-opps that don't squash into issue shape are
   either preserved with link-backs or kept on the dev-infra side; the
   "What Worked Well / What Needs Improvement" structure is never stripped to
   fit an issue template.
4. **MOOT closes carry forward** — the corpus-split-as-answer reasoning is
   captured in the close comments so future readers don't re-litigate.

---

## 📝 Implementation Plan

### Concerns channel shape in agentic-ocean
- [ ] Task 1: Survey agentic-ocean structure and draft 3 channel-shape options
- [ ] Task 2: Pick option via `/decision` in agentic-ocean
- [ ] Task 3: Scaffold the chosen channel (dirs + hub README) in agentic-ocean
- [ ] Task 4: Commit channel scaffolding to agentic-ocean

### Dev-infra source-side prep
- [ ] Task 5: Split dev-infra issue #78 into corpus-half + dev-infra-half
- [ ] Task 6: Split dev-infra issue #113 into patterns-hub + thin-launchpad halves
- [ ] Task 7: Close MOOT issues #73 and #76 with pointers to agentic-ocean

### Migrate skill-bug concerns
- [ ] Task 8: Author 4 concern docs in agentic-ocean from dev-infra #74, #79, #101, #105
- [ ] Task 9: Cross-link and close dev-infra originals

### Migrate skill-architecture concerns
- [ ] Task 10: Author 4 concern docs in agentic-ocean — 3 from dev-infra #71, #102, #114 (rewrite #102's "Recommended Approach" section) + 1 from chat 88f83db8 ("skills describe shape, not location")
- [ ] Task 11: Cross-link and close dev-infra originals (the 3 issue-sourced)

### Migrate corpus mechanics int-opps
- [ ] Task 12: Author 5 concern docs in agentic-ocean for installer/corpus/skill-mechanics int-opps
- [ ] Task 13: Add migrated-to markers + agentic-ocean concern-doc paths in source int-opps

### Migrate pipeline/design int-opps (batch A)
- [ ] Task 14: Author 4 concern docs in agentic-ocean for pipeline/design int-opps (batch A — emission, design-step, phase-signals, QA catalog)
- [ ] Task 15: Add migrated-to markers in source int-opps

### Migrate pipeline/design int-opps (batch B)
- [ ] Task 16: Author 4 concern docs in agentic-ocean for pipeline/design int-opps (batch B — /decision, /research, /pr, /post-pr)
- [ ] Task 17: Add migrated-to markers in source int-opps

### Learnings-as-concerns + BOTH cases
- [ ] Task 18: Skim `worktree-feature-workflow/` learnings to confirm BOTH vs STAY
- [ ] Task 19: Author 3+ concern docs in agentic-ocean from learnings docs
- [ ] Task 20: Author 2–3 BOTH corpus-side concern docs in agentic-ocean (and `worktree-feature-workflow/` if resolved BOTH)
- [ ] Task 21: Add cross-link markers in all dev-infra-side BOTH records

### Hubs + verification + status doc
- [ ] Task 22: Update int-opp hub READMEs in dev-infra (improvements + learnings) with migrated-to-agentic-ocean section
- [ ] Task 23: Update `agentic-workflow-modernization` status doc to record the migration
- [ ] Task 24: Enumerate authored agentic-ocean concern docs vs triage; confirm every MIGRATE/BOTH/discuss-derived row has a destination path
- [ ] Task 25: Final commit pass + cleanup orphaned references

---

## ✅ Definition of Done

- [ ] All 25 tasks complete
- [ ] Concerns channel exists at `agentic-ocean/concerns/` with at least one committed concern doc
- [ ] All MIGRATE rows in `planning/inputs/triage-table.md` have a corresponding agentic-ocean concern-doc path recorded
- [ ] All BOTH rows have both an agentic-ocean concern doc and a dev-infra-side cross-link
- [ ] MOOT closes (#73, #76) reference the agentic-ocean installer
- [ ] Hub READMEs in dev-infra surface the migration so future readers route new concerns correctly
- [ ] `agentic-workflow-modernization` status doc updated

---

## 🔗 Related

- Source artifact: [`planning/inputs/triage-table.md`](inputs/triage-table.md)
- Design decisions (2026-07-02, all D1–D6 resolved): [`planning/design-decisions.md`](design-decisions.md)
- Parent context: [`admin/services/ai-workflow/explorations/agentic-workflow-modernization/exploration.md`](../../../explorations/agentic-workflow-modernization/exploration.md) (esp. Themes 5, 7, 9, 10)
- Corpus repo: `grimm00/agentic-ocean` (local at `~/Projects/agentic-ocean`)
- Corpus split ADR: [`adr-001-corpus-repo-split-model.md`](../../skill-corpus-installation/decisions/adr-001-corpus-repo-split-model.md)
- Discussions that produced this plan:
  - `/discuss` session 2026-06-22 (original triage)
  - `/discuss` session 2026-07-02 (design decisions D1–D6; halted `/agent-dispatch` pre-flight)
  - Chat [88f83db8](88f83db8-f63e-4959-ad2f-50544fa87cce) (source of the 88f83db8 concern folded into Group 4)
- **Merged PRs (this feature):** see [`status-and-next-steps.md`](status-and-next-steps.md#-merged-prs-this-feature) — currently [PR #115](https://github.com/grimm00/dev-infra/pull/115) (Track α landing).

---

**Last Updated:** 2026-07-02 (post-PR #115 merge)
