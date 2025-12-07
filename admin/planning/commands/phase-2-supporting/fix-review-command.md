# Fix Review Command - Implementation Plan

**Command:** `/fix-review`  
**Status:** 🟠 In Progress  
**Priority:** 🟠 HIGH  
**Estimated Effort:** 4 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/fix-review.md)** - Original work-prod command
- **[Fix Plan Command](../phase-1-core/fix-plan-command.md)** - Related command (creates batches)
- **[Phase 2 Plan](PLAN.md)** - Overall Phase 2 planning

---

## 🎯 Overview

The `/fix-review` command reviews old deferred issues to identify candidates for addressing. It completes the fix management workflow by enabling cross-PR fix batching and deferred issue management.

**Key Features:**
- Scans all deferred issues from multiple PRs
- Identifies accumulated issues (similar issues across PRs)
- Finds quick wins (LOW effort fixes)
- Generates review reports
- Creates fix batch recommendations

---

## 🔄 Adaptations Required

### 1. Generic Fix Tracking Paths

**Current (work-prod specific):**
```
docs/maintainers/planning/features/projects/fix/
```

**Target (generic):**
```
docs/maintainers/planning/features/[feature-name]/fix/
OR
docs/maintainers/planning/fix/  (project-wide)
```

**Implementation:**
- Auto-detect feature name from context
- Support project-wide fix structure
- Match `/fix-plan` and `/fix-implement` paths
- Allow configuration override

---

### 2. Configurable Review Report Paths

**Current:** Hardcoded report location

**Target:** Configurable report paths

**Implementation:**
- Feature-specific: `docs/maintainers/planning/features/[feature-name]/fix/fix-review-report-YYYY-MM-DD.md`
- Project-wide: `docs/maintainers/planning/fix/fix-review-report-YYYY-MM-DD.md`
- Support both patterns

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [x] Read complete source command from work-prod
- [x] Understand deferred issue scanning logic
- [x] Identify filtering and grouping logic
- [x] Document review report structure
- [x] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/fix-review.md`

---

### Step 2: Create Adapted Command File

- [x] Create `.cursor/commands/fix-review.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Match `/fix-plan` and `/fix-implement` paths
- [x] Add feature detection logic
- [x] Make review report paths configurable

**Target Location:**
- `.cursor/commands/fix-review.md` (for dev-infra project)
- `templates/.cursor/commands/fix-review.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test with existing fix structure
- [ ] Test deferred issue scanning
- [ ] Test filtering and grouping
- [ ] Test review report generation
- [ ] Test integration with `/fix-plan --from-review-report`

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example review report
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document review report format
- [ ] Document integration with `/fix-plan`

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic fix tracking paths implemented
- [x] Review report paths configurable
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/fix-plan` command (must be implemented first)
- `/fix-implement` command (for understanding fix structure)

**Enables:**
- Cross-PR fix batching
- Deferred issue management
- Technical debt reduction

---

## 📚 Related Documentation

**Source:**
- [Work-Prod Fix Review Command](../../../../work-prod/.cursor/commands/fix-review.md)

**Related Commands:**
- [Fix Plan Command](../phase-1-core/fix-plan-command.md) - Creates fix plans
- [Fix Implement Command](../phase-1-core/fix-implement-command.md) - Implements fixes

**Planning:**
- [Phase 2 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

