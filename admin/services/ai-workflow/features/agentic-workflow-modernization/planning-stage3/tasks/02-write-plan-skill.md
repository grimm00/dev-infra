# Write-Plan Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Write-Plan Skill
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/write-plan agentic-workflow-modernization --expand --group 2` to add detailed implementation notes.

- [ ] Task 4: Audit transition-plan command modes and classify behavioral instructions
  - Read `.cursor/commands/transition-plan.md` (820 lines — largest Stage 3 command)
  - Map setup mode vs expand mode: identify shared logic, mode-specific logic, mode boundaries
  - Classify instructions against precision tiers; note which are mode-specific
  - **Identify template-extractable content:** directory scaffolding structures, file templates (implementation-plan.md, status-and-next-steps.md, task file skeletons) — these become `assets/`
  - Produce audit artifact at `planning-stage3/artifacts/transition-plan-command-audit.md`

- [ ] Task 5: Resolve decomposition — single skill vs family
  - design.md Section 6 open question: "may decompose into write-plan-setup and write-plan-expand, or stay single if modes are thin enough"
  - Use audit data: if modes share <30% behavioral instructions, family pattern (like research); if >70% shared, single skill with mode sections
  - Document decision with rationale in task file

- [ ] Task 6: Convert transition-plan command to write-plan SKILL.md(s) per decomposition decision
  - **Skill directory structure (new convention):**
    ```
    skills/write-plan/
    ├── SKILL.md                          # behavioral contract + workflow
    ├── assets/
    │   ├── implementation-plan.md        # copyable template
    │   ├── status-and-next-steps.md      # copyable template
    │   └── task-group-skeleton.md        # copyable template for task files
    └── references/
        └── structure.yaml               # declares expected output structure
    ```
  - If family: parent SKILL.md + `write-plan-setup/SKILL.md` + `write-plan-expand/SKILL.md` (assets live in parent, shared by children)
  - `references/structure.yaml` must declare: output directories, singleton files, collection files (task groups), and input modes (`--from-artifacts`, `--from-design`, etc.)
  - Apply five-property rubric; populate gotchas
  - Consider `--from-design` as a natural input mode addition (this stage used design.md as input)

- [ ] Task 7: Validate write-plan skill against Stage 3's own scaffolding
  - Meta-test: this stage's planning was created using the command; validate the skill can produce equivalent output
  - Verify `assets/` templates match what the command would generate
  - Verify `references/structure.yaml` accurately describes the output shape
  - Document verdict in task file's Validation Log

---

## 🎯 Goals

1. Resolve the write-plan decomposition open question with evidence
2. Convert the largest Stage 3 command without quality loss
3. **Establish the `assets/` + `references/` skill directory convention** — write-plan is the ideal first adopter because it's the most template-heavy skill
4. Meta-validate: the skill should be able to produce what the command produced for this stage

---

## ✅ Completion Criteria

- [ ] Audit artifact with mode mapping, tier classification, and template inventory
- [ ] Decomposition decision documented with rationale
- [ ] SKILL.md(s) in templates with rubric pass and gotchas
- [ ] `assets/` directory with copyable templates
- [ ] `references/structure.yaml` with output schema
- [ ] Validation log with meta-test verdict

---

## 🔗 Dependencies

- No hard dependency on Group 1 (decision), but shared audit patterns apply
- Decomposition decision (Task 5) gates Task 6
- **Group 1 follow-up:** decision skill needs template extraction into `assets/` (can happen during this group or cutover)

---

**Last Updated:** 2026-05-02
