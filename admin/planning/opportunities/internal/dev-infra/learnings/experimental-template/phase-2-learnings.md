# Experimental Template Learnings - Phase 2

**Project:** dev-infra  
**Feature:** Experimental Template  
**Phase:** Phase 2 - Update Generator Script  
**Date:** 2025-12-15  
**PR:** #48  
**Status:** ✅ Complete

---

## 📋 Overview

Phase 2 focused on updating the `new-project.sh` generator script to support the new `experimental-project` template type. This included validation updates, interactive menu changes, stability warnings, documentation updates, and comprehensive testing.

---

## ✅ What Worked Exceptionally Well

### 1. Comprehensive Test-First Approach

**Why it worked:**
Writing tests before implementation (TDD) ensured that all generator functionality was properly covered and edge cases were handled.

**What made it successful:**
- 8 new tests added covering various scenarios
- Tests caught issues early (validation logic, edge cases)
- Clear test names documented expected behavior

**Key examples:**
```bash
@test "new-project: validates experimental-project type"
@test "new-project: experimental-project includes evolving command"
@test "new-project: experimental-project README includes stability disclaimer"
```

**Benefits:**
- Confidence in generator changes
- Regression prevention
- Documentation through tests

---

### 2. Stability Warning with Confirmation

**Why it worked:**
Adding an explicit stability warning with `[y/N]` confirmation ensures users consciously opt-in to experimental features.

**What made it successful:**
- Clear communication of risks (may change, incomplete docs)
- Default to "No" prevents accidental selection
- Non-interactive mode skips warning for CI/automation

**Template implications:**
This pattern should be used whenever introducing experimental/unstable features that require user acknowledgment.

**Benefits:**
- User awareness before opting in
- No accidental experimental usage
- CI/automation still works seamlessly

---

### 3. Documentation-Alongside-Code Pattern

**Why it worked:**
Updating `docs/PROJECT-TYPES.md` and `docs/TEMPLATE-USAGE.md` alongside the code changes kept documentation in sync.

**What made it successful:**
- All changes in a single PR
- Documentation reflects actual behavior
- Decision matrices help users choose templates

**Key examples:**
- Added "Experimental Project" section to PROJECT-TYPES.md
- Added decision checklist for when to use experimental

**Benefits:**
- Users can immediately understand new template
- Documentation never out of sync with code
- Clear guidance on template selection

---

## 🟡 What Needs Improvement

### 1. Test Assertion Specificity

**What the problem was:**
Sourcery review identified that some test assertions were too weak (e.g., checking for "experimental" anywhere in README instead of specific disclaimer text).

**Why it occurred:**
Focused on test coverage first, less on assertion quality.

**Impact:**
Tests could pass even if disclaimer content changed or was incomplete.

**How to prevent:**
- Use more specific assertions (exact phrases, not just keywords)
- Review test assertions for false-positive risk
- Consider what changes would break the test vs. slip through

**Template changes needed:**
Update test template examples to emphasize specific assertions over general pattern matching.

---

### 2. Template Type Centralization

**What the problem was:**
Template type handling is spread across help text, validation, and interactive menu in `new-project.sh`.

**Why it occurred:**
Script evolved organically; each section handles types independently.

**Impact:**
Adding a new template type requires changes in multiple places, risking inconsistency.

**How to prevent:**
- Create single `VALID_TEMPLATE_TYPES` array at top of script
- Reference this array in validation, help text, and menu
- Consider template type metadata (description, emoji) in structured format

**Template changes needed:**
Consider centralizing template type definitions in future refactoring.

---

## 💡 Unexpected Discoveries

### 1. Interactive Menu Expansion is Straightforward

**Finding:**
Adding a third template option to the interactive menu required minimal changes - just adding one `case` option and updating the numbered display.

**Why it's valuable:**
Validates that the menu design scales well for additional template types.

**How to leverage:**
Can confidently plan for additional template types (e.g., `cli-project`, `library-project`) in future without major refactoring.

---

### 2. Non-Interactive Mode Already Well-Supported

**Finding:**
The existing `--non-interactive` flag handling made CI/automation support trivial - just skip the warning confirmation.

**Why it's valuable:**
No need to design new CLI patterns for automation support.

**How to leverage:**
Continue using `--non-interactive` pattern for any future interactive features that need CI support.

---

## ⏱️ Time Investment Analysis

**Breakdown:**
- Task 1 (Validation): ~10 minutes
- Task 2 (Interactive Menu): ~15 minutes
- Task 3 (Stability Warning): ~15 minutes
- Task 4 (Help Text): ~10 minutes
- Task 5 (Documentation): ~20 minutes
- Task 6 (Tests): ~30 minutes
- PR Review & Fixes: ~15 minutes

**Total:** ~2 hours (within 1-2 hour estimate)

**What took longer:**
- Tests: Writing comprehensive tests took longest, but was valuable
- Documentation: Ensuring all docs were updated thoroughly

**What was faster:**
- Interactive menu: Existing patterns made this quick
- Validation: Simple array check addition

**Estimation lessons:**
- Documentation updates often match or exceed code time
- Test writing time scales with feature complexity
- Well-structured existing code accelerates changes

---

## 📊 Metrics & Impact

**Code metrics:**
- Lines added to `new-project.sh`: ~50
- Tests added: 8 new tests
- Documentation files updated: 2 (PROJECT-TYPES.md, TEMPLATE-USAGE.md)

**Quality metrics:**
- All CI checks passing
- Sourcery review: 4 comments (1 fixed, 3 deferred)
- No CRITICAL/HIGH issues

**Developer experience:**
- Clear stability warning prevents surprises
- Help text documents new option immediately
- Decision matrices guide template selection

---

## 🔗 Related

- **Phase Plan:** [phase-2.md](../../../../features/experimental-template/phase-2.md)
- **Feature Hub:** [experimental-template/README.md](../../../../features/experimental-template/README.md)
- **PR:** #48
- **Sourcery Review:** [pr48.md](../../../../feedback/sourcery/pr48.md)

---

**Last Updated:** 2025-12-15

