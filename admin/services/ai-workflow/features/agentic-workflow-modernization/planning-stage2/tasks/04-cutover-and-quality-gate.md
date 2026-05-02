# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)
**Group:** Cutover and Quality Gate
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [ ] Task 12: Install skills + archive commands
  - Copy production skills from `templates/standard-project/.claude/skills/` to root `.claude/skills/`:
    - `research/SKILL.md` (parent)
    - `research/research-setup/SKILL.md`
    - `research/research-conduct/SKILL.md`
    - `research/research-consolidate/SKILL.md`
    - `spike/SKILL.md`
    - `reflect/SKILL.md`
  - Archive commands to `.cursor/commands/archived/`:
    - `research.md` → `archived/research.md`
    - `spike.md` → `archived/spike.md`
    - `reflect.md` → `archived/reflect.md`
  - Archive template commands:
    - `templates/standard-project/.cursor/commands/{research,spike,reflect}.md` → `archived/`
    - `templates/learning-project/.cursor/commands/{research,spike,reflect}.md` → `archived/`
  - Update `scripts/template-sync-manifest.txt`

- [ ] Task 13: Regression test research-conduct against recent topic research
  - Same pattern as discuss regression (Task 16 in Stage 1)
  - Use a real research topic — compare skill output vs command-era output
  - Test specific behaviors: source evaluation quality, finding structure, requirement discovery
  - Document observed quality: better, worse, or neutral
  - This is the Stage 2 go/no-go signal

- [ ] Task 14: Verify all Stage 2 skills pass five-property rubric
  - Sweep all 6 skill files (parent + 3 children + spike + reflect)
  - Verify each behavioral instruction is: observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify gotchas sections are populated
  - Verify self-containment (FR-8)

- [ ] Task 15: Final quality gate sweep + Stage 2 exit criteria
  - Verify Stage 2 exit criteria (from design.md Section 5):
    - [ ] Research family pattern validated (parent + 3 children)
    - [ ] research-conduct regression test passes
    - [ ] All skills pass quality gate
  - Run CI locally (`bats tests/`) and verify GitHub Actions pass
  - Update status documents: mark Stage 2 complete
  - Log Stage 2 → Stage 3 decision

---

## 🎯 Goals

1. Complete the clean cutover (same pattern as Stage 1)
2. Validate the go/no-go signal: research-conduct quality
3. Make the Stage 2 → Stage 3 decision with evidence

---

## ✅ Completion Criteria

- [ ] Skills installed at root `.claude/skills/`
- [ ] 3 commands archived
- [ ] Template commands archived
- [ ] CI passes after cutover
- [ ] research-conduct regression test documented
- [ ] Stage 2 exit criteria verified
- [ ] Stage 2 → Stage 3 decision logged

---

## 🔗 Dependencies

- Groups 1-3 must all be complete
- Final group; gates the Stage 2 → Stage 3 transition

---

**Last Updated:** 2026-05-02
