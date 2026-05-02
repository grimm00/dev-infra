# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Cutover and Quality Gate
**Status:** 🟠 In Progress
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 15: Install skills + archive commands
  - **Purpose:** Complete the clean cutover (C2-1) — skills replace commands, no coexistence
  - **Steps:**
    1. **Clean up spike artifacts** at root `.claude/skills/`:
       - Remove `explore-test/`, `explore-test-b/`, `foo/` (spike leftovers)
       - Remove existing `explore/` (spike version, not production)
    2. **Copy production skills** from `templates/standard-project/.claude/skills/` to root `.claude/skills/`:
       - `discuss/SKILL.md`
       - `explore/SKILL.md`, `explore/explore-start/SKILL.md`, `explore/explore-amend/SKILL.md`
       - `int-opp/SKILL.md`, `int-opp/templates/` (3 template files)
       - `narrative/SKILL.md`, `narrative/templates/` (2 template files)
    3. **Archive dev-infra commands** — move to `.cursor/commands/archived/`:
       - `discuss.md` → `.cursor/commands/archived/discuss.md`
       - `explore.md` → `.cursor/commands/archived/explore.md`
       - `int-opp.md` → `.cursor/commands/archived/int-opp.md`
       - `narrative.md` → `.cursor/commands/archived/narrative.md`
    4. **Archive template commands** — move to `archived/` in each template:
       - `templates/standard-project/.cursor/commands/{discuss,explore,int-opp}.md` → `archived/`
       - `templates/learning-project/.cursor/commands/{discuss,explore,int-opp}.md` → `archived/`
       - Note: `narrative.md` is not in templates (dev-infra only)
    5. **Update template-sync-manifest** (`scripts/template-sync-manifest.txt`):
       - Remove archived command entries (discuss, explore, int-opp)
       - Add skill entries if skills should be synced between templates
    6. **Verify** `.gitignore` doesn't exclude `.claude/` directory
  - **Files:** `.claude/skills/`, `.cursor/commands/archived/`, `templates/*/`, `scripts/template-sync-manifest.txt`
  - **Acceptance:**
    - Production skills installed at root `.claude/skills/`
    - Spike artifacts cleaned up
    - 4 commands archived (not deleted — preserved for reference)
    - Template commands archived (3 per template)
    - Template-sync-manifest updated
    - `git status` shows clean state after commit

---

- [ ] Task 16: Regression test discuss skill
  - **Purpose:** Validate C5-3 quality benchmark — discuss skill must perform at least as well as the command
  - **Steps:**
    1. Copy latest skills to ai-test workspace (or verify they're current)
    2. Invoke `/discuss` in ai-test with a real topic — compare against the command-era `/discuss` interactions from this session
    3. Test the specific behaviors that matter:
       - Does it hold the read-only contract? (no file creation)
       - Does it engage substantively with the user's thought?
       - Does it resist treating thoughts as directives?
       - Does the `--summary` format match the spec?
    4. Document observed quality: better, worse, or neutral vs command-era
  - **Files:** No new files in dev-infra — this is a validation task
  - **Acceptance:**
    - Discuss skill tested in ai-test with real content
    - Read-only contract held (no files created)
    - Quality assessed vs command-era baseline
    - Result documented in chat (pass/fail with observations)
    - If FAIL: stop and reassess before proceeding to Task 17

---

- [ ] Task 17: Final quality gate sweep + Stage 1 exit criteria
  - **Purpose:** Verify all Stage 1 exit criteria are met before declaring completion
  - **Steps:**
    1. **Verify Stage 1 exit criteria** (from design.md Section 5):
       - [ ] All 5 skills pass five-property rubric (verified in Task 14)
       - [ ] Discuss regression test passes (verified in Task 16)
       - [ ] Explore family pattern validated (verified in Task 11)
       - [ ] AGENTS.md + CLAUDE.md in place (verified in Tasks 2-3)
       - [ ] `.mdc` rules slimmed (verified in Task 4)
       - [ ] Templates-as-assets pattern established (Tasks 12-13)
    2. **Verify CI passes** after cutover:
       - Run `bats tests/` locally
       - Push and verify GitHub Actions pass
    3. **Update status documents:**
       - `status-and-next-steps.md`: mark Stage 1 complete, 17/17 tasks
       - `implementation-plan.md`: all checkboxes marked `[x]`
    4. **Log Stage 1 → Stage 2 decision:**
       - Document in status file: proceed to Stage 2, pause, or adjust
       - Note any design changes discovered during Stage 1 that affect Stage 2 planning
  - **Files:** Planning docs, status docs
  - **Acceptance:**
    - All exit criteria verified with evidence
    - CI passes
    - Status documents reflect Stage 1 completion
    - Stage 2 decision logged

---

## 🎯 Goals

1. Complete the clean cutover (C2-1): commands archived, skills installed at project root
2. Validate the C5-3 quality benchmark: discuss skill ≥ discuss command quality
3. Make the Stage 1 → Stage 2 go/no-go decision with evidence

---

## ✅ Completion Criteria

- [ ] Production skills installed at root `.claude/skills/` (dev-infra is a consumer of its own templates)
- [ ] Spike artifacts cleaned up from `.claude/skills/`
- [ ] 4 command files archived to `.cursor/commands/archived/`
- [ ] Template commands archived (3 per template × 2 templates)
- [ ] Template-sync-manifest updated
- [ ] CI passes after cutover
- [ ] Discuss regression test documented (observed quality vs command-era baseline)
- [ ] Stage 1 exit criteria from design.md Section 5 verified
- [ ] Decision logged: proceed to Stage 2, or pause for adjustment
- [ ] Status document updated to reflect Stage 1 completion

---

## 🔗 Dependencies

- Groups 1-4 must all be complete
- Final group; gates the Stage 1 → Stage 2 transition

---

**Last Updated:** 2026-05-02
