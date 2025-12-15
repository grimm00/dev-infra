# Command Documentation Update: `/pr-validation` - Manual Testing Guide Enforcement

**Command:** `/pr-validation`  
**Date:** 2025-12-15  
**Source:** User feedback during PR #49 validation  
**Status:** ✅ Complete

---

## 📋 Overview

This update enhances the `/pr-validation` command to ensure manual testing guides exist and are properly understood as documentation for **human users**, not AI agent checklists.

---

## 🤔 Problem Discovered

During PR #49 (Phase 3 of Experimental Template) validation, the following issue was identified:

1. **Unclear Purpose:** The command treated manual testing as something the AI runs locally, rather than documentation for human testers.

2. **Missing Guide Check:** The command assumed a manual testing guide already existed, without checking or providing guidance to create one.

3. **No Template:** When a guide didn't exist, there was no template or guidance for creating one.

**User Feedback:**
> "There needs to be clarity on the manual testing guide: The manual testing guide must be done so the user can use it and not just the AI agent running tests locally."

---

## 🎯 Solution

Enhanced Step 2 (Update Manual Testing Guide) with three sub-sections:

### 2a. Check if Manual Testing Guide Exists
- Check if guide exists at expected location
- **STOP** if missing - must create guide first
- Provide clear file path patterns for different project structures

### 2b. Create Manual Testing Guide (If Missing)
- Complete template for creating a new guide
- Key principles for writing human-readable guides
- Emphasis on covering ALL completed phases (not just current)

### 2c. Add Scenarios for Current Phase
- Original functionality preserved
- Only reached if guide exists

---

## 🔑 Key Changes

### Added: Purpose Statement

```markdown
#### ⚠️ IMPORTANT: Manual Testing Guides Are for HUMAN Users

**Manual testing guides are written for HUMAN team members to follow, NOT for the AI agent to run tests locally.**

**Purpose of manual testing guides:**
- 📖 **Documentation for humans** - Step-by-step instructions any team member can follow
- 🔍 **User verification** - Allows humans to manually verify features work as expected
- 📝 **Reference material** - Persists in the repo as a testing reference for the feature
- 🎓 **Knowledge transfer** - New team members can understand how to test the feature

**Manual testing guides are NOT:**
- ❌ Tests the AI agent runs during PR validation
- ❌ A checklist only the AI uses internally
- ❌ Automated test scripts (those go in `tests/`)
```

### Added: Guide Existence Check

```markdown
**If guide does NOT exist:**

1. **STOP and create the guide first** - A feature PR with user-facing changes MUST have a manual testing guide
2. **Create the guide using the template below** (Section 2b)
3. **Add scenarios for ALL phases completed so far** (not just current phase)
4. **Commit the guide to the feature branch** before proceeding
```

### Added: Guide Template

Complete markdown template with:
- Overview section explaining purpose
- Prerequisites section
- Phase-based scenario structure
- Cleanup instructions
- Acceptance criteria checklist
- Notes for testers
- Related documents section

### Added: Key Principles

```markdown
**Key principles for the guide:**

1. **Write for humans** - Clear, step-by-step instructions anyone can follow
2. **Include context** - Explain what each scenario verifies and why
3. **Provide cleanup** - Show how to reset after testing
4. **Cover all phases** - Include scenarios for ALL completed phases, not just current
5. **Be specific** - Include exact commands, expected outputs, and success criteria
```

---

## 🚀 Impact

- **Clarity:** Manual testing guides are now clearly documented as human-facing documentation
- **Enforcement:** Command will STOP if guide is missing for feature PRs
- **Template:** New guides can be created from a complete template
- **Comprehensiveness:** Guides must cover ALL phases, not just current

---

## 🔗 Related

- **PR #49:** Phase 3 - CI Drift Detection (where issue was discovered)
- **Example Guide Created:** `admin/planning/features/experimental-template/manual-testing.md`
- **Command File:** `.cursor/commands/pr-validation.md`

---

**Last Updated:** 2025-12-15

