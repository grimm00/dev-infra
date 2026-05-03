# Skill Family Restructure

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Skill Family Restructure
**Status:** ✅ Expanded
**Last Updated:** 2026-05-02

---

## 📝 Tasks

### Pre-phase review pulse (prior group)

`/pre-phase-review` is superseded by `/plan-review`; for this iteration the operator
validated **Group 2** via merged PR **#93** narrative + Stage 3 doc notes (**Write-plan decomposition
override** documented in status file). Carry-forward implication: decomposition **now** adopts the explicit
explore/research family pattern regardless of interim single-skill decision text in Task 5 historical log.

---

- [x] Task 8: Restructure write-plan into family (parent + setup + expand)
  - **Purpose:** Reduce per-invocation context by mirroring `explore/` + `research/` thin-parent ergonomics without losing shared YAML + asset contracts.
  - **Steps:**
    1. Relocate substantive Setup prose into `templates/standard-project/.claude/skills/write-plan/write-plan-setup/SKILL.md` with **`read ../SKILL.md`** gate (family conventions identical pattern to research children).
    2. Move Expand procedural detail into sibling `write-plan-expand/SKILL.md` with analogous gate + classify matrix.
    3. Replace legacy monolith `write-plan/SKILL.md` with **orientation-only** hub: diagrams, routing table to children, condensed path table, pointers to **`assets/`** + **`references/structure.yaml`**.
    4. Enhance `references/structure.yaml`: add **`setup_output`** vs **`expand_output`** blocks describing mutability surfaces (singletons vs lone group markdown).
    5. Sanity scan template consumers (e.g., **explore**/ **research**/ diagrams) referencing `/transition-plan` → modern **write-plan-*** naming.
    6. Ensure FR-8: **no uncompensated reliance** on `.cursor/commands/*.md`; templates stay self-explaining (`write-plan-setup` Step 1 now references heuristic extraction only — no dangling command cites).
  - **Files:** `templates/standard-project/.claude/skills/write-plan/**`; optional dependent skill parents (`explore/SKILL.md`, `research/SKILL.md`) for pipeline breadcrumb renaming only.
  - **Acceptance:** Directory tree matches task diagram; YAML validates logically; parental hub matches explore/research tone; children independently deployable prose blocks.

---

- [ ] Task 9: Restructure decision skill with assets/ + references/
  - **Purpose:** Finish deferred template extraction from Group 1 — align decision with **`assets/` + `references/`** convention already proven on write-plan.
  - **Steps:**
    1. Create **`decision/assets/adr-template.md`**, **`hub-readme-template.md`**, **`decision-interview.md`** mirroring headings previously enumerated inline inside `SKILL.md`.
    2. Slim `decision/SKILL.md`: retain workflow sequencing + behavioral contract/gotchas — replace embedded template literals with anchored references (`assets/…`, **`references/structure.yaml`** summaries).
    3. Author **`decision/references/structure.yaml`** enumerating singletons (interview artifact, README hub, rollup summary), collections (`adr-NNN-*`), optional parent aggregator touch policy.
    4. Confirm relative asset paths ergonomic from skill root (`assets/foo.md` wording).
    5. Maintain five-property readability (Observables + failure branches still explicit despite slimmer SKILL).
  - **Files:** `templates/standard-project/.claude/skills/decision/**`
  - **Acceptance:** SKILL does not duplicate full scaffold fences; newcomers can generate artifacts solely by reading SKILL + copying assets/YAML cues.

---

- [ ] Task 10: Validate restructured skills
  - **Purpose:** Guard cutover regressions ahead of Plan-Review (Group 4) + eventual command archival.
  - **Steps:**
    1. **Routing sanity:** Confirm parent forbids mistaken direct invocation wording consistent with explore/research parents (`disable-model-invocation`, explicit child routing).
    2. **`structure.yaml` accuracy:** Tables in write-plan YAML must reflect filesystem behavior post-split; decision YAML mirrors actual workflow stages (interview-before-clustering invariant).
    3. **Cross-pattern audit:** Explore/research parent diagrams reference **write-plan-setup** successor labels (not retired command names).
    4. **Five-property rubric (FR-19) pass:** For each touched SKILL (`write-plan` parent + two children + `decision`), verify headings still encode *observable, bounded, outcome-framed, delta-only, failure-aware* obligations either in Behavioral Contract bullets or fused Gotchas (note gaps inline below if discovered).
    5. Capture outcomes in **Validation notes** appended under this Task.
  - **Files:** This task markdown (logging), enumerated skill + YAML artifacts above (read-only verification).
  - **Acceptance:** Validation notes show GO with concrete references OR NO-GO with blocking defects listed (none expected if merge proceeds).

---

## 🎯 Goals

1. **Align write-plan with the family pattern** — parity with explore & research ergonomics while preserving deterministic planning artifacts.
2. **Finish template externalization on decision** — eliminate monolithic scaffold duplication.
3. **Prove YAML truth tables** precede downstream plan-review conversions.

---

## ✅ Completion Criteria

- [x] write-plan is a family: parent + write-plan-setup + write-plan-expand
- [x] write-plan parent is a thin orientation hub (like explore, research parents)
- [ ] decision has `assets/` with extracted templates + `references/structure.yaml`
- [ ] All modified SKILL.md files pass five-property rubric
- [ ] `references/structure.yaml` files are accurate for both skills

---

## 🔗 Dependencies

- **Depends on Group 2:** canonical single-pass write-plan SKILL existed before family split (**PR #93** landed baseline assets + YAML).
- **Depends on Group 1:** authoritative behavioral decision workflow precedes templating refactor (**PR #92**).
- Informs Group 4 (plan-review modernization) referencing updated family choreography.

---

## 📋 Validation notes (Task 10)

_Add GO/NO-GO narrative after onsite verification._

| Artifact | Spot-check | Verdict |
|----------|-------------|---------|
| `write-plan/SKILL.md` | Parent routing + duplication vs explore parent | Pending |
| `write-plan-setup`, `write-plan-expand` | `read ../SKILL.md`; contracts + gotchas breadth | Pending |
| `write-plan/references/structure.yaml` | `setup_output` vs `expand_output` coherence | Pending |
| `decision/SKILL.md` | Asset pointers replace inline scaffolds | Pending |
| `decision/references/structure.yaml` | Mirrors interview→hub→ADR→summary flow | Pending |
| `explore` / `research` parents | Mention **write-plan-setup** not `/transition-plan` | Pending |

**Rubric rollup:** Pending explicit tick-box commentary after reviewer pass.
