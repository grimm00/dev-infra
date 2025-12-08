# PR Status Update Requirements

**Purpose:** Define mandatory status update requirements for PR creation, review, and merge  
**Status:** ✅ Active  
**Last Updated:** 2025-12-07

---

## 📋 Overview

This document defines the mandatory status update requirements for pull requests. Status updates ensure that phase documents and feature status accurately reflect work completed, making project progress visible and accurate.

**Key Principle:** Status updates are mandatory throughout the PR lifecycle, from creation through review to merge.

**Note:** This document serves as the **single source of truth** for status update requirements. Other documents (command docs, workflow rules) reference this document for authoritative requirements. Examples in this document use placeholder dates (e.g., `2025-12-07`) and phase numbers (e.g., `Phase 3`) for illustration purposes.

---

## ✅ Status Update Requirements

### Mandatory Requirements

**Status updates are required at these points:**

1. **During Work** - Update status as work progresses (per `/task-phase` workflow)
2. **Before PR Creation** - Status must be current before creating PR (per `/pr` command validation)
3. **During PR Review** - Status updates verified as part of PR review (per PR Review Workflow)
4. **After PR Merge** - Status automatically updated by `/post-pr` command

**Validation Approach:**

- **Mandatory:** Status updates are required for PR approval
- **Lenient:** Validation uses warnings, not blockers (to start)
- **Iterative:** Validation strictness can be tightened based on feedback

---

## 📝 When Status Updates Are Required

### 1. During Work (Per `/task-phase` Workflow)

**When:** As tasks are completed during phase implementation

**What to Update:**
- Task checkboxes: Mark completed tasks `- [x]`
- Progress tracking: Update percentages as milestones reached
- Phase status: Update to "🟠 In Progress" at phase start

**Location:**
- Phase document: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
- Feature status: `docs/maintainers/planning/features/[feature-name]/status-and-next-steps.md`

**See:** [Status Update Workflow](STATUS-UPDATE-WORKFLOW.md) for complete guide

---

### 2. Before PR Creation (Per `/pr` Command Validation)

**When:** Before creating PR for completed phase

**What to Update:**
- Phase document status: Update to "✅ Complete"
- Feature status document: Update with phase completion
- Progress tracking: Update to reflect completion
- All task checkboxes: Mark all tasks complete

**Location:**
- Phase document: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
- Feature status: `docs/maintainers/planning/features/[feature-name]/status-and-next-steps.md`

**Validation:**
- `/pr` command validates status before PR creation
- Status must be current (warnings if not, but PR can proceed)

**See:** [Status Validation](../.cursor/commands/pr.md#status-validation) in `/pr` command

---

### 3. During PR Review (Per PR Review Workflow)

**When:** As part of PR review process (step 7 in PR Review Workflow)

**What to Verify:**
- Phase document status is current
- Feature status document is current
- Status updates are included in PR commits
- Progress tracking is accurate

**Location:**
- PR Review Workflow: `.cursor/rules/workflow.mdc`
- Status Check Checklist: See PR Review Workflow section

**Validation:**
- Status Check Checklist verifies status updates
- Warnings if status outdated (not blockers)
- Recommendation to update status before approval

**See:** [Status Check Checklist](../.cursor/rules/workflow.mdc#status-check-checklist) in PR Review Workflow

---

### 4. After PR Merge (Per `/post-pr` Command)

**When:** After PR is merged to `develop`

**What Updates Automatically:**
- Phase document status: Updated to "✅ Complete" (if not already)
- Feature status document: Updated with phase completion
- Progress tracking: Updated to reflect completion
- Completion date: Added to phase document

**Location:**
- `/post-pr` command automatically updates status documents

**Process:**
- Run `/post-pr [pr-number] --phase [N]` after PR merge
- Command automatically updates phase and feature status
- Creates docs branch, commits updates, merges to develop

**See:** [Status Update Behavior](../.cursor/commands/post-pr.md#status-update-behavior) in `/post-pr` command

---

## 📋 What Status Updates Are Required

### Phase Document Updates

**Required Fields:**

1. **Status Field**
   - Start: `**Status:** 🟠 In Progress`
   - Complete: `**Status:** ✅ Complete`

2. **Completion Date** (at completion)
   - Format: `**Completed:** YYYY-MM-DD`

3. **Task Checkboxes**
   - Mark all tasks complete: `- [x]`

4. **Last Updated**
   - Format: `**Last Updated:** YYYY-MM-DD`

**Example:**
```markdown
# My Feature - Phase 3: Documentation & Examples

**Phase:** 3 - Documentation & Examples
**Status:** ✅ Complete
**Completed:** 2025-12-07
**Last Updated:** 2025-12-07

## 📅 Tasks

### 1. Add Dependency Sections

- [x] Review all commands for dependencies
- [x] Add "Dependencies" section to each command
```

---

### Feature Status Document Updates

**Required Fields:**

1. **Current Phase**
   - Update to reflect completed phase

2. **Overall Progress**
   - Calculate and update percentage
   - Format: `X/[total] phases complete (XX%)`

3. **Completed Milestones**
   - Add entry for completed phase
   - Include PR number and completion date

4. **Progress Tracking Table**
   - Update phase row status to "✅ Complete"
   - Add end date and duration

**Example (using placeholder dates, phase numbers, and PR numbers for illustration):**
```markdown
# My Feature - Status & Next Steps

**Current Phase:** Phase 3 Complete  # Example phase number - use actual phase
**Progress:** 75% (3 of 4 phases complete)  # Example progress - calculate actual

## Completed Milestones

- **Phase 3:** Documentation & Examples ✅ (PR #10, 2025-12-07)  # Example PR number and date - use actual values

## Progress Tracking

| Phase | Status | Start Date | End Date | Duration |
|-------|--------|------------|----------|----------|
| Phase 3 | ✅ Complete | 2025-12-06 | 2025-12-07 | 1 day |
```

---

## 🔄 PR Workflow Integration

### PR Creation Process

**Step 1: Create PR**
- Use `/pr --phase [N]` command
- Command validates status before PR creation
- Status must be current (warnings if not)

**Step 2: Status Validation**
- `/pr` command checks phase document status
- `/pr` command checks feature status document
- Warnings if status outdated (not blockers)

**See:** [Status Validation](../.cursor/commands/pr.md#status-validation) in `/pr` command

---

### PR Review Process

**Step 7: Status Validation**
- Verify status updates are included in PR
- Check phase document status is current
- Check feature status document is current
- Verify progress tracking is accurate

**Status Check Checklist:**
- [ ] Phase document status is current
- [ ] Feature status document is current
- [ ] Status updates are included in PR commits
- [ ] Progress tracking is accurate

**See:** [Status Check Checklist](../.cursor/rules/workflow.mdc#status-check-checklist) in PR Review Workflow

---

### PR Merge Process

**Step 9: Post-Merge**
- Run `/post-pr [pr-number] --phase [N]` after PR merge
- Command automatically updates phase and feature status
- Creates docs branch, commits updates, merges to develop

**Automatic Updates:**
- Phase document status: "✅ Complete"
- Feature status document: Phase completion entry
- Progress tracking: Updated percentages

**See:** [Status Update Behavior](../.cursor/commands/post-pr.md#status-update-behavior) in `/post-pr` command

---

## 💡 Examples

### Example 1: PR Creation with Status Updates

**Before PR Creation:**
```markdown
# Phase document
**Status:** ✅ Complete  # Updated before PR creation

# Feature status document
**Phase 3:** ✅ Complete (2025-12-07)  # Updated before PR creation
```

**PR Commits Include:**
```bash
docs(phase-3): update phase status to complete
docs(feature): update feature status with phase 3 completion
```

**PR Description Includes:**
```markdown
## Status Updates

- Phase document status updated to "✅ Complete"
- Feature status document updated with Phase 3 completion
- Progress tracking updated to 75%
```

---

### Example 2: PR Review Status Check

**Status Check Checklist:**
- [x] Phase document status is current (`**Status:** ✅ Complete`)
- [x] Feature status document is current (Phase 3 marked complete)
- [x] Status updates are included in PR commits (verified)
- [x] Progress tracking is accurate (75% matches 3 of 4 phases)

**Result:** ✅ Status updates verified, PR ready for approval

---

### Example 3: Post-Merge Status Updates

**After PR Merge:**
```bash
/post-pr 10 --phase 3
```

**Automatic Updates:**
- Phase document: Status confirmed "✅ Complete", completion date added
- Feature status document: Phase 3 milestone entry added, progress updated
- Progress tracking: Updated to reflect completion

**Result:** ✅ Status documents automatically updated, ready for next phase

---

## ⚠️ Validation Approach

### Lenient Approach (Current)

**Warnings, Not Blockers:**
- Status validation uses warnings if status outdated
- PR can proceed with warnings
- Recommendation to update status before approval
- Validation strictness can be tightened based on feedback

**Rationale:**
- Start with lenient approach to avoid blocking workflow
- Gather feedback from real PR usage
- Tighten validation based on feedback
- Iterative improvement approach

### Future Tightening

**Based on Feedback:**
- Evaluate validation strictness after first few PRs
- Tighten validation if warnings are ignored
- Make status updates blockers if needed
- Document changes and rationale

---

## 📚 Related Documentation

- **[Status Update Workflow](STATUS-UPDATE-WORKFLOW.md)** - Complete workflow guide
- **[Status Update Checklist](STATUS-UPDATE-CHECKLIST.md)** - Checklist for status updates
- **[Status Update Timing](STATUS-UPDATE-TIMING.md)** - Timing and frequency guide
- **[Status Update Templates](STATUS-UPDATE-TEMPLATES.md)** - Templates for status updates
- **[Status Validation](../.cursor/commands/pr.md#status-validation)** - Status validation in `/pr` command
- **[Status Check Checklist](../.cursor/rules/workflow.mdc#status-check-checklist)** - Status check in PR Review Workflow
- **[Status Update Behavior](../.cursor/commands/post-pr.md#status-update-behavior)** - Status updates in `/post-pr` command

---

## ✅ Summary

**Status updates are mandatory throughout the PR lifecycle:**

1. **During Work:** Update status as tasks complete (per `/task-phase` workflow)
2. **Before PR:** Status must be current (validated by `/pr` command)
3. **During Review:** Status updates verified (per PR Review Workflow)
4. **After Merge:** Status automatically updated (per `/post-pr` command)

**Validation Approach:**
- Mandatory but lenient (warnings, not blockers) to start
- Can be tightened based on feedback
- Iterative improvement approach

**Key Commands:**
- `/task-phase` - Updates status during work
- `/pr --phase [N]` - Validates status before PR creation
- `/pr-validation` - Validates status during PR review
- `/post-pr --phase [N]` - Updates status after PR merge

---

**Last Updated:** 2025-12-07  
**Status:** ✅ Active  
**Next:** Use this guide to ensure status updates throughout PR lifecycle

