# proj-cli Learnings - Refactor Planning Category

**Project:** proj-cli  
**Topic:** Refactor Planning Category - New Planning Structure  
**Date:** 2026-01-07  
**Status:** ✅ Complete  
**Last Updated:** 2026-01-07

---

## 📋 Overview

During the code-structure-refactoring work in proj-cli, we discovered the need for a new planning category: `refactor/`. This category sits alongside `features/` and `ci/` but has a simpler workflow suited for internal code quality improvements that don't add user-facing functionality.

---

## ✅ What Worked Exceptionally Well

### Clear Category Separation

**Why it worked:**
The three-category model (features, refactor, ci) provides clear guidance on where work belongs and what workflow to follow.

**What made it successful:**
- Each category has distinct characteristics
- Workflow complexity matches the work type
- Prevents over-engineering simple refactors with full research/ADR workflow

**Template implications:**
Add `refactor/` directory to standard-project template with README explaining the category.

**Key examples:**

| Category | Purpose | Workflow |
|----------|---------|----------|
| **Feature** | New user functionality | Research → Decision → Plan → Implement |
| **Refactor** | Code quality, restructuring | Explore → Plan → Implement |
| **CI/CD** | Pipeline, automation | Improvement plan → Implement |

**Benefits:**
- Simpler workflow for internal improvements
- Clear decision criteria for categorization
- Reduced documentation overhead for refactors

### Reusing Feature Templates for Refactors

**Why it worked:**
Refactors can reuse the same `feature-plan.md`, `status-and-next-steps.md`, and `phase-N.md` templates - they just don't need the research/decision phase.

**What made it successful:**
- Consistent structure across planning types
- No need to create new templates
- Phase-based implementation works for both

**Template implications:**
Document that feature templates are reusable for refactors.

---

## 🟡 What Needs Improvement

### Template Missing Refactor Category

**What the problem was:**
The dev-infra standard-project template doesn't have a `refactor/` directory, so projects must create it manually.

**Why it occurred:**
The refactor category emerged from real project needs, not initial template design.

**Impact:**
Projects need to manually create the structure and may not follow consistent patterns.

**How to prevent:**
Add `refactor/` directory to standard-project template with proper README.

**Template changes needed:**
1. Add `docs/maintainers/planning/refactor/` directory
2. Add `docs/maintainers/planning/refactor/README.md` hub file
3. Update `docs/maintainers/planning/README.md` to include refactor category
4. Document workflow differences in README

---

## 💡 Unexpected Discoveries

### Exploration Can Feed Refactor (Not Just Features)

**Finding:**
The `/explore` → `/transition-plan --type refactor` workflow works well for refactors that need some investigation before planning.

**Why it's valuable:**
Refactors sometimes need exploration (e.g., analyzing code structure, evaluating options) but don't need full research/ADR workflow.

**How to leverage:**
Document that explorations can transition to refactors, not just features.

### Refactor Workflow is Simpler but Still Structured

**Finding:**
Refactors benefit from phase-based planning even though they're simpler than features.

**Why it's valuable:**
- Breaking work into phases helps track progress
- Phase documents provide clear scope boundaries
- PR workflow still applies for code changes

**How to leverage:**
Emphasize that refactors use the same phase-based implementation, just with simpler planning.

---

## ⏱️ Time Investment Analysis

**Breakdown:**
- Creating refactor directory structure: ~15 min
- Writing refactor README with workflow: ~20 min
- Updating planning hub: ~5 min
- Total setup: ~40 min

**What took longer:**
- Defining the workflow differences between refactor/feature/ci: Required thought about when each applies

**What was faster:**
- Reusing feature templates: No new templates needed

**Estimation lessons:**
- Refactor setup is quick once the pattern is understood
- The main value is in the clear categorization, not complex documentation

---

## 📊 Metrics & Impact

**Code metrics:**
- New files: 2 (refactor/README.md, refactor/code-structure-refactoring/*)
- Lines of documentation: ~130 lines for refactor hub

**Quality metrics:**
- Clear workflow guidance
- Consistent with existing patterns

**Developer experience:**
- Easier to decide where work belongs
- Simpler workflow for internal improvements
- Less documentation overhead for refactors

---

## 🎯 Template Improvement Checklist

### For dev-infra Standard Project Template

- [ ] **Add `docs/maintainers/planning/refactor/` directory**
  - **Location:** `templates/standard-project/docs/maintainers/planning/refactor/`
  - **Action:** Create directory with README.md
  - **Priority:** MEDIUM
  - **Effort:** LOW

- [ ] **Create refactor hub README**
  - **Location:** `templates/standard-project/docs/maintainers/planning/refactor/README.md`
  - **Action:** Copy pattern from proj-cli refactor README
  - **Content:** Include workflow comparison table, directory structure, quick start
  - **Priority:** MEDIUM
  - **Effort:** LOW

- [ ] **Update planning hub README**
  - **Location:** `templates/standard-project/docs/maintainers/planning/README.md`
  - **Action:** Add refactor category to quick links and directory structure
  - **Priority:** MEDIUM
  - **Effort:** LOW

- [ ] **Document workflow differences**
  - **Location:** Refactor README and possibly WORKFLOW-OVERVIEW.md
  - **Action:** Explain when to use refactor vs feature vs ci
  - **Priority:** MEDIUM
  - **Effort:** LOW

---

## 📚 Reference Files

**Source files (proj-cli):**
- `docs/maintainers/planning/refactor/README.md` - Refactor hub
- `docs/maintainers/planning/README.md` - Planning hub with refactor category

**Target files (dev-infra template):**
- `templates/standard-project/docs/maintainers/planning/refactor/README.md` (to create)
- `templates/standard-project/docs/maintainers/planning/README.md` (to update)

---

**Last Updated:** 2026-01-07
