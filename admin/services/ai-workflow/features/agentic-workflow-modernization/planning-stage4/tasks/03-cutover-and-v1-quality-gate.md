# Cutover and v1 Final Quality Gate

**Feature:** Agentic Workflow Modernization — Stage 4
**Group:** Cutover and v1 Final Quality Gate
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [ ] Task 9: Install skills + archive commands (review, commit, handoff)
  - Install skills: copy from `templates/standard-project/.claude/skills/` to root `.claude/skills/`
  - **Archive commands to `admin/archived/commands/stage4-reviewer/`** (follows Stage 3 convention)
  - Archive in both template directories (standard-project, learning-project) — move `.cursor/commands/{review,commit,handoff}.md`
  - Update `scripts/template-sync-manifest.txt` to track new skill files

- [ ] Task 10: Final quality sweep across ALL v1 skills (~16 skills)
  - Enumerate all skills in `templates/standard-project/.claude/skills/`
  - Verify each passes five-property rubric
  - Verify each has `references/structure.yaml` (where applicable — Stage 1 skills may predate convention)
  - Cross-check family patterns (explore, research, write-plan) for parent↔child consistency
  - Run Bats test suite (full)

- [ ] Task 11: v1 exit criteria verification + completion
  - Verify design.md Section 5 Stage 4 exit criteria: all thinking pipeline commands removed, ~16 skills operational, full quality gate pass
  - Log Stage 4 → Post-v1 decision (GO / NO-GO)
  - Update implementation-plan.md and status-and-next-steps.md to ✅ Complete
  - Record post-v1 options from design.md Section 5: template sync activation, learning-project skills, implementation command evaluation

---

## 🎯 Goals

1. Clean cutover: install skills, archive commands, no coexistence
2. v1 completion gate: every skill passes rubric, every family is consistent, CI green
3. Document the v1 → post-v1 boundary for future work

---

## ✅ Completion Criteria

- [ ] 3 commands archived to `admin/archived/commands/stage4-reviewer/`
- [ ] All ~16 skills present in template and repo root
- [ ] Final rubric sweep passes for all skills
- [ ] Bats test suite passes
- [ ] CI green on cutover PR
- [ ] Stage 4 exit criteria verified against design.md
- [ ] v1 completion logged

---

## 🔗 Dependencies

- Group 1 (Review Skill) and Group 2 (Commit + Handoff) must be complete
- Depends on all prior stages being merged to develop

---

**Last Updated:** 2026-05-03
