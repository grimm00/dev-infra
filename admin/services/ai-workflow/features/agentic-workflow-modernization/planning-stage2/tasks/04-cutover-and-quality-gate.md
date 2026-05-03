# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)
**Group:** Cutover and Quality Gate
**Status:** ✅ Expanded
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 12: Install skills + archive commands
  - **Purpose:** Cut over from commands to skills — same pattern as Stage 1 (discuss/explore/int-opp)
  - **Steps:**
    1. Copy research family tree from `templates/standard-project/.claude/skills/research/` to root `.claude/skills/research/` (parent + 3 children + templates if any)
    2. Copy spike from `templates/standard-project/.claude/skills/spike/` to root `.claude/skills/spike/`
    3. Copy reflect from `templates/standard-project/.claude/skills/reflect/` to root `.claude/skills/reflect/`
    4. Archive root `.cursor/commands/research.md` → `.cursor/commands/archived/research.md`
    5. Archive root `.cursor/commands/spike.md` → `.cursor/commands/archived/spike.md`
    6. Archive root `.cursor/commands/reflect.md` → `.cursor/commands/archived/reflect.md`
    7. Archive `templates/standard-project/.cursor/commands/research.md` → `archived/`, same for spike, reflect
    8. Archive `templates/learning-project/.cursor/commands/research.md` → `archived/`, same for spike, reflect
    9. Update `scripts/template-sync-manifest.txt` — move command entries to archived, add skill entries
  - **Files:** `.claude/skills/research/`, `.claude/skills/spike/`, `.claude/skills/reflect/`, `.cursor/commands/archived/`, template archived dirs, `scripts/template-sync-manifest.txt`
  - **Acceptance:** root `.claude/skills/` has all 6 new skill dirs; 3 commands archived at root + 2 template dirs; manifest updated

- [ ] Task 13: Regression test research-conduct against recent topic research
  - **Purpose:** Go/no-go gate — same quality bar as discuss (Stage 1 C5-3)
  - **Steps:**
    1. Identify a recent research artifact produced under the command era (before Group 1)
    2. Read the original command (`archived/research.md`) and the new skill (`research/research-conduct/SKILL.md`)
    3. Perform static comparison: behavioral coverage, source evaluation steps, finding quality, requirement discovery
    4. Note any gaps or regressions; note any improvements
    5. Record verdict: go (no regression) or flag (regression or gap identified)
    6. Document in this task file's Validation Log section
  - **Files:** `planning-stage2/artifacts/research-command-audit.md` (reference), skill files, this task file
  - **Acceptance:** Validation log populated with explicit go/no-go verdict backed by behavioral diff

- [ ] Task 14: Verify all Stage 2 skills pass five-property rubric
  - **Purpose:** Quality gate before Stage 2 exit
  - **Rubric properties:** observable, bounded, outcome-framed, delta-only, failure-aware
  - **Steps:**
    1. Read each skill file: research/SKILL.md, research-setup/SKILL.md, research-conduct/SKILL.md, research-consolidate/SKILL.md, spike/SKILL.md, reflect/SKILL.md
    2. For each behavioral instruction, verify all 5 properties present
    3. Verify Gotchas section populated in each
    4. Verify self-containment (FR-8): each skill readable standalone, no cross-skill load required
    5. Document results per skill — pass/fail with notes
  - **Files:** all 6 skill files, this task file
  - **Acceptance:** Each skill explicitly assessed; any failures documented with remediation needed

- [ ] Task 15: Final quality gate sweep + Stage 2 exit criteria
  - **Purpose:** Verify Stage 2 is done and make Stage 2 → Stage 3 decision
  - **Steps:**
    1. Verify all Stage 2 exit criteria from design.md Section 5
    2. Run `bats tests/` from repo root (or note if not available)
    3. Check CI status once PR created (GitHub Actions)
    4. Mark Stage 2 complete in `status-and-next-steps.md` and `implementation-plan.md`
    5. Log Stage 2 → Stage 3 decision in status notes with evidence
  - **Files:** status-and-next-steps.md, implementation-plan.md, task file
  - **Acceptance:** Status docs updated; decision logged with explicit evidence

---

## 📋 Validation Log

*(populated during task execution)*

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
