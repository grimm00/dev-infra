# Status Decoupling Plan

**Purpose:** Decouple status tracking from implementation commands  
**Created:** 2025-12-09  
**Status:** 🟠 In Progress

---

## 📋 Overview

Currently, status tracking is embedded in multiple commands (`/task-phase`, `/pr`, `/post-pr`). This leads to:
- Inconsistent updates
- Forgotten status changes
- Duplicated logic
- Hard to maintain

**Solution:** Centralize all status operations in the new `/status` command.

---

## 🎯 Goal

| Before | After |
|--------|-------|
| Commands inline status updates | Commands delegate to `/status` |
| Status logic duplicated | Single source of truth |
| Easy to forget updates | Explicit status operations |
| Hard to validate | `/status --validate` catches issues |

---

## 📝 Commands to Update

### 1. `/task-phase` (HIGH Priority)

**Current Behavior:**
- Section "Status Update (Start of Phase)" - inline updates phase document
- Section "Status Update (Phase Completion)" - inline updates status document
- Manual checkbox updates during task completion

**Changes Needed:**

| Section | Current | New |
|---------|---------|-----|
| Start of Phase | Inline status update logic | `Delegate: /status --phase-start N` |
| Task Complete | "Mark task items as complete" | `Delegate: /status --task-complete N M` |
| Phase Complete | Inline status update logic | `Delegate: /status --phase-complete N` |

**Specific Edits:**

1. **Remove** the "Status Update (Start of Phase)" section's inline logic
2. **Replace** with: "Run `/status --phase-start [N] --commit` to update status"
3. **Remove** the "Status Update (Phase Completion)" section's inline logic
4. **Replace** with: "Run `/status --phase-complete [N] --commit` to update status"
5. **Add** after task completion: "Run `/status --task-complete [N] [M] --commit`"

**Lines to modify:** ~150 lines of status logic can be replaced with ~10 lines of delegation

---

### 2. `/pr` (MEDIUM Priority)

**Current Behavior:**
- Section "Status Validation" - validates status before PR
- If status not current, instructs to update manually

**Changes Needed:**

| Section | Current | New |
|---------|---------|-----|
| Status Validation | Manual checklist | `Delegate: /status --validate` |
| Status Fix | Manual instructions | `Delegate: /status --sync` |

**Specific Edits:**

1. **Replace** Status Validation checklist with:
   ```markdown
   **Status Validation:**
   Run `/status --validate --feature [feature-name]` to verify status is current.
   
   If validation fails:
   - Run `/status --sync --feature [feature-name] --commit` to fix
   - Or manually update and commit status documents
   ```

2. **Simplify** the "If status is not current" section

---

### 3. `/post-pr` (MEDIUM Priority)

**Current Behavior:**
- Complex logic for updating status-and-next-steps.md
- Updates phase status, progress, milestones
- Duplicates much of status update logic

**Changes Needed:**

| Section | Current | New |
|---------|---------|-----|
| Update Status Document | 50+ lines of update logic | `Delegate: /status --phase-complete N --pr PR#` |

**Specific Edits:**

1. **Replace** "Update Status Document" section with:
   ```markdown
   **Update Status:**
   Run `/status --phase-complete [N] --pr [PR#] --commit`
   
   This will:
   - Mark phase as complete in phase document
   - Update status-and-next-steps.md with completion info
   - Add PR reference to milestone
   - Recalculate overall progress
   ```

2. **Keep** PR-specific logic (like cleaning up branches) - that's not status-related

---

### 4. `/fix-implement` (LOW Priority)

**Current Behavior:**
- Updates fix batch status (not phase status)
- Different tracking structure

**Changes Needed:**

Fix batches use a different structure than phase tracking. Consider:
- Keep fix batch status updates in `/fix-implement` (different domain)
- OR create `/status --fix-batch` variant

**Recommendation:** Keep separate for now. Fix batches are not the same as feature phases.

---

### 5. `/task-improvement` (LOW Priority)

**Current Behavior:**
- Similar to `/task-phase` but for CI/CD improvements
- CI improvements don't have `status-and-next-steps.md`

**Changes Needed:**

- Less urgent since CI improvements use simpler tracking
- Could add `/status --ci-improvement` variant later

**Recommendation:** Defer until `/task-phase` decoupling is proven.

---

## 📊 Impact Summary

| Command | Lines Affected | Priority | Complexity |
|---------|----------------|----------|------------|
| `/task-phase` | ~150 lines | HIGH | Medium |
| `/pr` | ~30 lines | MEDIUM | Low |
| `/post-pr` | ~80 lines | MEDIUM | Medium |
| `/fix-implement` | ~20 lines | LOW | Low |
| `/task-improvement` | ~100 lines | LOW | Medium |

**Total:** ~380 lines of duplicated logic → ~50 lines of delegation

---

## 🔄 Migration Strategy

### Phase 1: Add `/status` Command ✅
- Create `/status` command with full functionality
- Document all operations

### Phase 2: Update `/task-phase` 
- Remove inline status logic
- Add delegation to `/status`
- Test with real phase work

### Phase 3: Update `/pr` and `/post-pr`
- Simplify status validation
- Delegate status updates
- Test with real PRs

### Phase 4: Document & Verify
- Update command README
- Verify all integrations work
- Remove any remaining duplication

---

## ✅ Checklist

- [x] Create `/status` command
- [ ] Update `/task-phase` to delegate status
- [ ] Update `/pr` to use `/status --validate`
- [ ] Update `/post-pr` to delegate status
- [ ] Test full workflow end-to-end
- [ ] Update command documentation
- [ ] Remove duplicated status logic

---

## 🔗 Related

- [/status command](.cursor/commands/status.md)
- [/task-phase command](.cursor/commands/task-phase.md)
- [/pr command](.cursor/commands/pr.md)
- [/post-pr command](.cursor/commands/post-pr.md)

---

**Last Updated:** 2025-12-09  
**Next:** Implement Phase 2 - Update `/task-phase`

