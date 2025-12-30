# Template Sync Drift Fix - Phase 2: Implementation

**Phase:** 2 - Implementation  
**Duration:** ~10-15 minutes  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete (drift source identified, source of truth decided)

---

## 📋 Overview

Sync the drifted `status.md` file and verify the fix locally before pushing.

**Success Definition:** Template sync validation passes locally, changes committed with descriptive message.

---

## 🎯 Goals

1. **Sync Files** - Copy correct version to target template
2. **Verify Locally** - Run template sync validation to confirm fix
3. **Commit Changes** - Create commit with descriptive message

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan template-sync-drift-fix --expand --phase 2` to add detailed tasks.

### Task Categories

- [ ] **File Sync** - Copy file from source to target template
- [ ] **Local Validation** - Run validation script
- [ ] **Git Operations** - Stage and commit changes

---

## ✅ Completion Criteria

- [ ] File synced between templates
- [ ] `./scripts/validate-template-sync.sh` passes
- [ ] Changes committed with descriptive message
- [ ] Ready for Phase 3 (push and CI verification)

---

## 📦 Deliverables

- Synced `status.md` file in both templates
- Passing local validation
- Git commit ready for push

---

## 🔗 Dependencies

### Prerequisites

- Phase 1 complete
- Decision on source of truth

### Blocks

- Phase 3: Verification (cannot push without commit)

---

## 🔗 Related Documents

- [Transition Plan](transition-plan.md)
- [Phase 1: Analysis](phase-1.md)
- [Phase 3: Verification](phase-3.md)

---

**Last Updated:** 2025-12-30  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan template-sync-drift-fix --expand --phase 2`

