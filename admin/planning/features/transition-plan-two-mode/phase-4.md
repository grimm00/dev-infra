# Transition-Plan Two-Mode - Phase 4: Supporting Content

**Phase:** 4 - Supporting Content  
**Duration:** ~1 hour  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 3 complete

---

## 📋 Overview

Update Usage, Scenarios, and Tips sections for two-mode workflow.

**Success Definition:** Command documentation has complete mode-specific examples and guidance.

**Target File:** `.cursor/commands/transition-plan.md`  
**Target Sections:** Usage (~line 52), Common Issues (~line 1005), Tips (~line 1033)

---

## 🎯 Goals

1. **Update Usage** - Add expand mode examples
2. **Add Scenarios** - Mode-specific usage scenarios
3. **Update Tips** - "When to Use Each Mode" guidance
4. **Update Common Issues** - Two-mode troubleshooting

---

## 📝 Tasks

### Task 1: Update Usage Section - Add Expand Mode Examples

**Purpose:** Add examples showing how to use `--expand` flag.

- [x] Read current Usage section (lines 52-76)
- [x] Add expand mode examples after existing examples
- [x] Add new options documentation

**Current Examples (lines 56-65):**
```markdown
**Examples:**

- `/transition-plan --from-reflection ...` - Create transition plan
- `/transition-plan --from-artifacts ...` - From specific artifact
- `/transition-plan --from-adr ...` - From ADR document
...
```

**Content to Add:**
```markdown
**Setup Mode Examples (default):**

- `/transition-plan --from-adr decisions/auth-system/` - Create scaffolding from ADRs
- `/transition-plan --from-artifacts releases/v0.1.0/checklist.md` - Create scaffolding from artifact
- `/transition-plan --dry-run` - Preview scaffolding without creating files

**Expand Mode Examples:**

- `/transition-plan auth-system --expand --phase 1` - Expand specific phase
- `/transition-plan auth-system --expand --phase 2` - Expand phase 2
- `/transition-plan auth-system --expand --all` - Expand all phases at once
```

**Options to Add:**
```markdown
**Expand Mode Options:**

- `--expand` - Enter expand mode (fill scaffolding with detail)
- `--phase N` - Expand specific phase number (use with --expand)
- `--all` - Expand all scaffolding phases (use with --expand)
```

---

### Task 2: Add Common Scenarios Section

**Purpose:** Add a new section with mode-specific usage scenarios.

- [x] Create new "## Common Scenarios" section
- [x] Add Scenario 1: Setup Scaffolding Only
- [x] Add Scenario 2: Expand Single Phase
- [x] Add Scenario 3: Expand All Phases
- [x] Add Scenario 4: Full Workflow

**Location:** After Tips section (before Reference)

**Content to Add:**
```markdown
## Common Scenarios

### Scenario 1: Setup Scaffolding Only

**Use case:** Create scaffolding for human review before expanding.

```bash
# From ADRs
/transition-plan --from-adr decisions/auth-system/

# Output:
# - transition-plan.md
# - phase-1.md (🔴 Scaffolding)
# - phase-2.md (🔴 Scaffolding)
# - phase-3.md (🔴 Scaffolding)
```

**Next:** Review scaffolding, then use `--expand` when ready.

---

### Scenario 2: Expand Single Phase

**Use case:** Incrementally expand one phase at a time.

```bash
# Review scaffolding first
cat docs/maintainers/planning/features/auth-system/phase-1.md

# Expand Phase 1 only
/transition-plan auth-system --expand --phase 1

# Output:
# - phase-1.md updated (✅ Expanded, ~200-300 lines)
```

**Next:** Implement Phase 1 with `/task-phase`, then expand Phase 2.

---

### Scenario 3: Expand All Phases

**Use case:** Expand all scaffolding at once after review.

```bash
# After reviewing all scaffolding
/transition-plan auth-system --expand --all

# Output:
# - phase-1.md (✅ Expanded)
# - phase-2.md (✅ Expanded)
# - phase-3.md (✅ Expanded)
```

**Next:** Begin implementation with `/task-phase phase-1`.

---

### Scenario 4: Full Workflow (End-to-End)

**Use case:** Complete workflow from ADRs to expanded phases.

```bash
# Step 1: Create scaffolding
/transition-plan --from-adr decisions/auth-system/

# Step 2: Review scaffolding (human review)
# - Check phase breakdown
# - Verify goals and criteria
# - Confirm dependencies

# Step 3: Expand all phases
/transition-plan auth-system --expand --all

# Step 4: Implement
/task-phase phase-1
/task-phase phase-2
...
```

**Timeline:**
- Setup: ~5-10 min
- Human review: Variable
- Expand: ~5-10 min per phase
- Implement: Per phase estimate
```

---

### Task 3: Update Tips Section - Add "When to Use Each Mode"

**Purpose:** Help users understand when to use Setup vs Expand mode.

- [ ] Read current Tips section (lines 1033-1052)
- [ ] Add new "### When to Use Each Mode" subsection
- [ ] Update existing tips for two-mode workflow

**Current Tips Structure:**
```markdown
## Tips

### Before Running
### During Planning
### After Planning
```

**Content to Add (new subsection at start):**
```markdown
## Tips

### When to Use Each Mode

**Setup Mode (default):**
- First time creating transition plan from new source
- When you want to review phase structure before detail
- When working with unfamiliar ADRs or artifacts
- When multiple stakeholders need to approve structure

**Expand Mode (`--expand`):**
- After scaffolding has been reviewed and approved
- When ready to add implementation detail
- Before starting `/task-phase` implementation
- When TDD task ordering is needed

**Incremental vs Batch:**

| Approach | Flag | When to Use |
|----------|------|-------------|
| **Incremental** | `--phase N` | Complex phases, want to review each |
| **Batch** | `--all` | Simple phases, already reviewed scaffolding |

**Rule of Thumb:**
- If unsure → Use Setup Mode first, review, then expand
- If familiar with source → Can use `--expand --all` directly
```

**Update "Before Running" to:**
```markdown
### Before Running

- **For Setup Mode:**
  - Ensure source exists (ADRs, artifacts, or reflection)
  - Review source content for completeness
  - Determine desired transition type

- **For Expand Mode:**
  - Ensure scaffolding exists (run setup first)
  - Review scaffolding for correct phase breakdown
  - Decide on incremental (`--phase N`) vs batch (`--all`)
```

---

### Task 4: Update Common Issues Section

**Purpose:** Add two-mode specific troubleshooting.

- [ ] Read current Common Issues section (lines 1005-1030)
- [ ] Add new issues for expand mode
- [ ] Update existing issues for two-mode context

**Current Issues:**
```markdown
## Common Issues

### Issue: No Artifacts Found
### Issue: Transition Type Ambiguous
### Issue: Artifact Content Incomplete
```

**Content to Add:**
```markdown
### Issue: Phase Already Expanded

**Symptom:** Error when trying to expand a phase that's already expanded.

**Solution:**
- Check phase status: `grep "Status:" phase-N.md`
- If `✅ Expanded`, phase is already done
- Use `--force` to re-expand (overwrites existing content)
- Or edit phase document directly

---

### Issue: No Scaffolding Found

**Symptom:** `--expand` fails because no scaffolding exists.

**Solution:**
- Run setup mode first: `/transition-plan --from-adr [path]`
- Check phase files exist: `ls docs/maintainers/planning/features/[feature]/phase-*.md`
- Verify status is `🔴 Scaffolding`

---

### Issue: Scaffolding Structure Incorrect

**Symptom:** After setup, phase breakdown doesn't match expectations.

**Solution:**
- Edit scaffolding files directly before expanding
- Adjust phase boundaries in `transition-plan.md`
- Re-run setup with different source if needed
- Scaffolding is meant for human review - modify as needed

---

### Issue: TDD Ordering Wrong After Expand

**Symptom:** Tasks not in test-first order after expansion.

**Solution:**
- Edit phase document to reorder tasks
- Ensure test tasks come before implementation tasks
- Check "Determine TDD vs Non-TDD" logic in expansion
- For documentation phases, TDD ordering may not apply
```

---

### Task 5: Verify All Changes Against Criteria

**Purpose:** Confirm all completion criteria met.

- [ ] Usage section has expand mode examples
- [ ] Scenario 1: Setup Scaffolding Only ✓
- [ ] Scenario 2: Expand Single Phase ✓
- [ ] Scenario 3: Expand All Phases ✓
- [ ] Scenario 4: Full Workflow ✓
- [ ] Tips includes "When to Use Each Mode" ✓
- [ ] Common Issues updated for two modes ✓

---

## ✅ Completion Criteria

- [ ] Usage section has expand mode examples
- [ ] Scenario 1: Setup Scaffolding Only
- [ ] Scenario 2: Expand Single Phase
- [ ] Scenario 3: Expand All Phases
- [ ] Scenario 4: Full Workflow
- [ ] Tips includes "When to Use Each Mode"
- [ ] Common Issues updated for two modes

---

## 📦 Deliverables

- Updated Usage section (~20 lines added)
- 4 mode-specific scenarios (~80 lines)
- Updated Tips section (~40 lines added)
- Updated Common Issues (~40 lines added)

**Total:** ~180 lines of new content

---

## 🔗 Dependencies

### Prerequisites

- [x] Phase 3: Expand Mode Workflow complete

### Blocks

- None (final phase)

---

## 📊 Progress Tracking

| Task                                | Status         | Notes |
| ----------------------------------- | -------------- | ----- |
| Task 1: Update Usage Section        | ✅ Complete    |       |
| Task 2: Add Common Scenarios        | ✅ Complete    |       |
| Task 3: Update Tips Section         | 🔴 Not Started |       |
| Task 4: Update Common Issues        | 🔴 Not Started |       |
| Task 5: Verify All Changes          | 🔴 Not Started |       |

---

## 💡 Implementation Notes

### Section Locations in Current Command

| Section | Current Line | Content |
|---------|--------------|---------|
| Usage | ~52-76 | Examples and options |
| Common Issues | ~1005-1030 | 3 issues |
| Tips | ~1033-1052 | Before/During/After |
| Reference | ~1055-1096 | File paths, related commands |

### Insertion Points

1. **Usage:** Add expand examples after line 65
2. **Common Scenarios:** New section before Reference (~line 1053)
3. **Tips:** Add "When to Use Each Mode" at start of Tips section
4. **Common Issues:** Add 4 new issues after existing 3

### Pattern Reference: /research Command

The `/research` command Tips section provides a pattern for mode guidance:

```markdown
## Tips

### When to Use Setup vs Conduct Mode
...

### Common Workflow Patterns
...
```

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Previous Phase: Phase 3](phase-3.md)
- [ADR-003: Command Structure](../../../decisions/transition-plan-two-mode/adr-003-command-structure-refactoring.md)
- [/research Command](../../../../.cursor/commands/research.md) - Tips pattern

---

**Last Updated:** 2025-12-29  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
