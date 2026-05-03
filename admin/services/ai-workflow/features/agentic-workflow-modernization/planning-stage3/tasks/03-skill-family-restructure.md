# Skill Family Restructure

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Skill Family Restructure
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/write-plan agentic-workflow-modernization --expand --group 3` to add detailed implementation notes.

- [ ] Task 8: Restructure write-plan into family (parent + setup + expand)
  - Split the single `write-plan/SKILL.md` into:
    ```
    skills/write-plan/
    ├── SKILL.md                      # thin parent: orientation hub, when-to-use routing, shared conventions
    ├── write-plan-setup/
    │   └── SKILL.md                  # setup workflow only (scaffold planning tree)
    ├── write-plan-expand/
    │   └── SKILL.md                  # expand workflow only (deepen one group file)
    ├── assets/
    │   ├── implementation-plan.md    # copyable template (shared by both children)
    │   ├── status-and-next-steps.md  # copyable template
    │   └── task-group-skeleton.md    # copyable template
    └── references/
        └── structure.yaml           # updated: declares per-child output shapes
    ```
  - Parent SKILL.md: orientation + routing (like `explore/SKILL.md`, `research/SKILL.md`)
  - `write-plan-setup/SKILL.md`: path detection, input modes, scaffolding workflow, behavioral contract for setup
  - `write-plan-expand/SKILL.md`: group location, classify-and-rewrite workflow, behavioral contract for expand
  - `assets/` stays in parent dir, shared by both children
  - `references/structure.yaml` updated: separate `setup_output` and `expand_output` sections

- [ ] Task 9: Restructure decision skill with assets/ + references/
  - Extract inline templates from `decision/SKILL.md` into `assets/`:
    ```
    skills/decision/
    ├── SKILL.md                      # behavioral contract + workflow (reduced — no inline templates)
    ├── assets/
    │   ├── adr-template.md           # ADR section structure
    │   ├── hub-readme-template.md    # decisions hub README scaffold
    │   └── decision-interview.md     # interview scaffold template
    └── references/
        └── structure.yaml           # declares decision output shape (hub, ADRs, summary)
    ```
  - SKILL.md references `assets/` for file creation instead of embedding templates inline
  - `references/structure.yaml` declares: singleton files (hub README, summary), collection files (ADRs), interview artifact
  - Decision stays a single skill (no family split — one workflow mode), but gains the `assets/` + `references/` convention

- [ ] Task 10: Validate restructured skills
  - Verify write-plan family: parent routes correctly, setup produces expected scaffolding, expand deepens correctly
  - Verify decision: SKILL.md references assets instead of inline templates, structure.yaml is accurate
  - Cross-check: `references/structure.yaml` for each skill accurately describes what the skill produces
  - Run five-property rubric on all new/modified SKILL.md files

---

## 🎯 Goals

1. **Align write-plan with the family pattern** — consistent with explore and research families; cleaner per-invocation context
2. **Complete the `assets/` + `references/` convention** for decision (deferred from Group 1)
3. **Validate that `structure.yaml` is accurate** for both restructured skills before plan-review conversion

---

## ✅ Completion Criteria

- [ ] write-plan is a family: parent + write-plan-setup + write-plan-expand
- [ ] write-plan parent is a thin orientation hub (like explore, research parents)
- [ ] decision has `assets/` with extracted templates + `references/structure.yaml`
- [ ] All modified SKILL.md files pass five-property rubric
- [ ] `references/structure.yaml` files are accurate for both skills

---

## 🔗 Dependencies

- **Depends on Group 2:** write-plan single skill must exist before restructuring into family
- **Depends on Group 1:** decision skill must exist before adding assets/references
- Restructuring here informs plan-review (Group 4) — plan-review can reference the family pattern and structure.yaml convention as established

---

**Last Updated:** 2026-05-02
