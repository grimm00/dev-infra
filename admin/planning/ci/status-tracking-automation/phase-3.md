# Status Tracking Automation - Phase 3: Integrate with PR Workflow

**Phase:** 3 - Integrate with PR Workflow  
**Duration:** 1-2 hours (Actual: TBD)  
**Status:** ✅ Complete  
**Prerequisites:** Phase 2 complete  
**Completed:** (if complete)

---

## 📋 Overview

Integrate status checks into PR validation workflow and ensure `/post-pr` consistently updates status after PR merges. This phase focuses on making status updates part of the PR process and ensuring status validation happens automatically.

**Success Definition:** Status checks integrated into PR validation, `/post-pr` consistently updates status, status updates verified in PR review, and status updates are mandatory part of PR process. PR workflow includes automatic status validation.

---

## 🎯 Goals

1. **Include Status Checks in PR Validation** - Add status validation to `/pr-validation` command
2. **Use `/post-pr` Consistently** - Ensure `/post-pr` updates phase and feature status after merges
3. **Verify Status Updates in PR Review** - Add status check to PR review checklist
4. **Make Status Updates Part of PR Process** - Integrate status updates into PR workflow

---

## 📝 Tasks

### PR Workflow Integration (Process Workflow)

#### 1. Include Status Checks in PR Validation

- [x] Add status validation to `/pr-validation` command
  - [x] Read current `/pr-validation` command documentation
  - [x] Add status validation section
  - [x] Implement status check logic
  - [x] Add status validation to validation checklist
- [x] Check phase status before PR creation
  - [x] Verify phase status is current
  - [x] Verify phase status matches actual progress
  - [x] Require status update if outdated (lenient: warnings, not blockers)
- [x] Verify feature status is current
  - [x] Check feature status document
  - [x] Verify feature status matches phase progress
  - [x] Require status update if outdated (lenient: warnings, not blockers)

**PR Validation Updates:**
- Status validation added to `/pr-validation` command
- Phase status check before PR creation
- Feature status verification
- Status update requirements

#### 2. Use `/post-pr` Consistently After PR Merges

- [x] Ensure `/post-pr` updates phase status
  - [x] Review current `/post-pr` command behavior
  - [x] Verify phase status updates work correctly
  - [x] Test phase status updates after PR merge (documented behavior)
- [x] Ensure `/post-pr` updates feature status
  - [x] Review current `/post-pr` command behavior
  - [x] Verify feature status updates work correctly
  - [x] Test feature status updates after PR merge (documented behavior)
- [x] Document `/post-pr` status update behavior
  - [x] Document what `/post-pr` updates
  - [x] Document when `/post-pr` updates status
  - [x] Include examples of `/post-pr` usage

**`/post-pr` Updates:**
- Phase status updates verified
- Feature status updates verified
- `/post-pr` behavior documented
- Usage examples included

#### 3. Verify Status Updates in PR Review

- [x] Add status check to PR review checklist
  - [x] Update PR review checklist
  - [x] Add status verification items
  - [x] Include status check in review process
- [x] Verify status updates are included in PR
  - [x] Check if status updates are in PR description (documented)
  - [x] Verify status updates are in PR commits (documented)
  - [x] Require status updates for PR approval (mandatory, lenient)
- [x] Require status updates for PR approval
  - [x] Make status updates mandatory
  - [x] Block PR approval without status updates (lenient: warnings, not blockers)
  - [x] Document status update requirements

**PR Review Updates:**
- Status check added to PR review checklist
- Status update verification process
- Status update requirements for approval

#### 4. Make Status Updates Part of PR Process

- [x] Integrate status updates into PR workflow
  - [x] Add status updates to PR creation process (per /pr command)
  - [x] Add status updates to PR review process (per PR Review Workflow)
  - [x] Add status updates to PR merge process (per /post-pr command)
- [x] Make status updates mandatory
  - [x] Require status updates for PR creation (mandatory, lenient)
  - [x] Require status updates for PR approval (mandatory, lenient)
  - [x] Document mandatory status update requirements
- [x] Document PR status update requirements
  - [x] Document when status updates are required
  - [x] Document what status updates are required
  - [x] Include examples of PR status updates

**PR Process Integration:**
- Status updates in PR creation
- Status updates in PR review
- Status updates in PR merge
- Mandatory status update requirements

---

## ✅ Completion Criteria

- [x] Status checks integrated into PR validation ✅ (2025-12-07)
- [x] `/post-pr` consistently updates status after merges ✅ (2025-12-07)
- [x] Status updates verified in PR review ✅ (2025-12-07)
- [x] Status updates mandatory part of PR process ✅ (2025-12-07)
- [ ] All PR workflow documentation updated
- [ ] Status validation tested and working
- [ ] Ready for Phase 4

---

## 📦 Deliverables

1. **PR Validation Updates**
   - Updated `/pr-validation` command with status checks
   - Phase status validation logic
   - Feature status validation logic

2. **`/post-pr` Documentation**
   - `/post-pr` status update behavior documented
   - `/post-pr` usage examples
   - `/post-pr` testing results

3. **PR Review Updates**
   - Updated PR review checklist with status checks
   - Status update verification process
   - Status update requirements documentation

4. **PR Process Integration**
   - Updated PR workflow documentation
   - Mandatory status update requirements
   - PR status update examples

---

## 🔗 Dependencies

### Prerequisites

- ✅ Phase 2 complete
- ✅ Status update process documented
- ✅ Status update guide created

### External Dependencies

- `/pr-validation` command exists
- `/post-pr` command exists
- PR workflow documentation exists

### Blocks

- Phase 4: Consider Automation - Requires Phase 3 complete

---

## ⚠️ Risks

**Risk: Status validation may be too strict or too lenient**  
**Probability:** Medium  
**Impact:** Medium  
**Mitigation:** Test validation logic thoroughly, gather feedback, adjust as needed  
**Contingency:** Iterate on validation logic based on usage feedback

---

## 📊 Progress Tracking

**Phase Status:** 🔴 Not Started

**PR Validation Integration (0/3 complete)**
- [ ] Status validation added to `/pr-validation`
- [ ] Phase status check implemented
- [ ] Feature status verification implemented

**`/post-pr` Updates (0/3 complete)**
- [ ] `/post-pr` phase status updates verified
- [ ] `/post-pr` feature status updates verified
- [ ] `/post-pr` behavior documented

**PR Review Updates (0/3 complete)**
- [ ] Status check added to PR review checklist
- [ ] Status update verification process created
- [ ] Status update requirements documented

**PR Process Integration (0/3 complete)**
- [ ] Status updates integrated into PR workflow
- [ ] Status updates made mandatory
- [ ] PR status update requirements documented

---

## 💡 Implementation Notes

### PR Workflow Integration

**For PR Validation:**
1. Review current `/pr-validation` command
2. Add status validation section
3. Implement status check logic
4. Test status validation
5. Update command documentation

**For `/post-pr` Updates:**
1. Review current `/post-pr` command behavior
2. Verify status updates work correctly
3. Test status updates after PR merge
4. Document status update behavior
5. Add usage examples

**For PR Review:**
1. Update PR review checklist
2. Add status verification items
3. Create status update verification process
4. Document status update requirements
5. Test PR review process

### Integration Pattern

**PR Validation Status Check:**
```markdown
## Status Validation

**Before PR creation:**
- [ ] Phase status is current
- [ ] Feature status is current
- [ ] Progress tracking is accurate

**Status check:**
- Verify phase document status matches actual progress
- Verify feature status document is current
- Require status update if outdated
```

**`/post-pr` Status Updates:**
```markdown
## Status Updates After PR Merge

**Automatic updates:**
- Phase status updated to "Complete"
- Feature status updated (if applicable)
- Progress tracking updated

**Manual verification:**
- Review updated status documents
- Verify status updates are correct
- Update if needed
```

---

## 🔗 Related Documents

- [Phase 2: Document Status Update Process](phase-2.md)
- [Phase 4: Consider Automation](phase-4.md)
- [Improvement Plan](improvement-plan.md)
- [Transition Plan](transition-plan.md)
- [CI/CD Hub](../../README.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🔴 Not Started  
**Approach:** Process Integration Workflow  
**Next:** Begin after Phase 2 complete

