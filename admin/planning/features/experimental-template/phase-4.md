# Phase 4: Add Stability Indicators

**Phase:** 4 of 4  
**Duration:** 1-2 hours  
**Status:** ✅ Complete  
**Completed:** 2025-12-15  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Implement clear stability communication for experimental commands using visual indicators, documentation, and graduation checklists.

**Success Definition:** Users can easily identify command stability levels and understand the graduation path.

---

## 🎯 Goals

1. Add stability badges to command documentation
2. Create stability levels documentation
3. Create graduation checklist
4. Document feedback mechanism

---

## 📝 Tasks

### Task 1: Define Stability Levels

**Objective:** Establish clear stability level definitions

**Stability Levels:**

| Level            | Indicator | Meaning                                         |
| ---------------- | --------- | ----------------------------------------------- |
| **Stable**       | 🟢        | Production-ready, API stable, fully documented  |
| **Experimental** | 🟠        | May change, actively evolving, feedback welcome |
| **Deprecated**   | 🔴        | Will be removed, migration path provided        |

---

### Task 2: Add Stability Badges to Commands

**Objective:** Update Evolving tier commands with stability indicators

**Note:** The `/status` command already has a stability header from Phase 1. This task focuses on:

- Verifying existing header matches template format
- Adding the **feedback link** (currently missing)
- Ensuring consistency across all Evolving commands

**Process:**

1. [ ] Identify all Evolving tier commands in experimental template (currently: `/status`)
2. [ ] Verify existing headers match template format
3. [ ] Add feedback link to command headers

**Stability Header Template:**

```markdown
# Command Name

**Status:** 🟠 Experimental  
**Stability:** Evolving - may change without notice  
**Feedback:** [Create issue](link-to-issues)

> ⚠️ **Experimental Command**: This command is under active development
> and may change significantly between releases. Use in production with
> caution and please provide feedback!
```

---

### Task 3: Create Stability Levels Documentation

**Objective:** Create comprehensive stability documentation

**File:** `templates/experimental-project/docs/STABILITY-LEVELS.md`

**Note:** This goes in the experimental template so generated projects have it. Dev-infra already has ADR-003/ADR-004 for internal reference.

**Contents:**

```markdown
# Stability Levels

## Overview

Dev-infra uses stability levels to communicate the maturity of features
and commands. This helps users make informed decisions about adoption.

## Stability Indicators

| Indicator | Level        | Meaning          |
| --------- | ------------ | ---------------- |
| 🟢        | Stable       | Production-ready |
| 🟠        | Experimental | May change       |
| 🔴        | Deprecated   | Being removed    |

## Stable (🟢)

Features marked as Stable:

- Have been tested in production
- Have complete documentation
- Follow semantic versioning for changes
- Are included in the standard template

## Experimental (🟠)

Features marked as Experimental:

- Are under active development
- May change without notice
- May have incomplete documentation
- Are included only in the experimental template
- Welcome feedback and bug reports

## Deprecated (🔴)

Features marked as Deprecated:

- Will be removed in a future release
- Have migration guides available
- Should be replaced with alternatives

## Graduation Process

Experimental features graduate to Stable when they meet the
[graduation criteria](link-to-graduation-checklist).
```

---

### Task 4: Create Graduation Checklist

**Objective:** Document process for promoting commands from experimental to stable

**File:** `templates/experimental-project/docs/GRADUATION-CHECKLIST.md`

**Note:** Based on ADR-004 graduation criteria. Goes in template for generated projects.

**Contents (based on ADR-004):**

```markdown
# Command Graduation Checklist

## Overview

This checklist defines the criteria for graduating commands from
Experimental (🟠) to Stable (🟢).

## Required Criteria (ALL must be met)

- [ ] **Time in dev-infra:** ≥1 release cycle in dev-infra
- [ ] **Stability:** No major changes in 2+ weeks
- [ ] **Documentation:** 100% complete
- [ ] **Usage:** Demonstrated use in dev-infra
- [ ] **No critical bugs:** No open critical issues

## Recommended Criteria (majority should be met)

- [ ] Positive user feedback received
- [ ] Clear use cases documented
- [ ] Error handling comprehensive
- [ ] Tests cover main scenarios

## Graduation Process

1. **Identify Candidate**

   - Command meets required criteria
   - Maintainer proposes graduation

2. **Review Period** (1 week)

   - Document any final changes
   - Ensure tests pass
   - Update documentation

3. **Graduation PR**

   - Move command to standard template
   - Update stability indicator to 🟢
   - Add to release notes

4. **Communication**
   - CHANGELOG entry
   - Release notes highlight
   - Update experimental template docs

## Template for Graduation PR

Title: `feat(templates): graduate [command-name] to stable`

Body:

- Command being graduated
- Link to graduation criteria checklist
- Summary of time in experimental
- User feedback received
```

---

### Task 5: Document Feedback Mechanism

**Objective:** Create clear path for users to provide feedback

**Note:** The `.github/ISSUE_TEMPLATE/` directory does not exist yet in the experimental template. Create it as part of this task.

**Process:**

1. [ ] Create `.github/ISSUE_TEMPLATE/` directory in experimental template
2. [ ] Create GitHub issue template for experimental feedback
3. [ ] Document feedback process in template README
4. [ ] Link feedback mechanism in command headers (via Task 2)

**Issue Template:** `templates/experimental-project/.github/ISSUE_TEMPLATE/experimental-feedback.yml`

```yaml
name: Experimental Feature Feedback
description: Provide feedback on experimental/evolving commands
labels: ["feedback", "experimental"]
body:
  - type: dropdown
    id: command
    attributes:
      label: Which experimental command?
      options:
        - [List of evolving commands]
  - type: textarea
    id: feedback
    attributes:
      label: Your feedback
      description: What worked well? What needs improvement?
```

---

### Task 6: Update Template README

**Objective:** Add stability section to experimental template README

**Process:**

1. [ ] Add "Stability Levels" section
2. [ ] Link to stability documentation
3. [ ] List Evolving commands with indicators
4. [ ] Add feedback call-to-action

---

## ✅ Completion Criteria

- [ ] All Evolving commands have 🟠 badge
- [ ] `docs/STABILITY-LEVELS.md` created
- [ ] `docs/GRADUATION-CHECKLIST.md` created
- [ ] Feedback issue template created
- [ ] Template README updated
- [ ] Links verified working

---

## 📦 Deliverables

1. Updated Evolving command headers
2. `docs/STABILITY-LEVELS.md`
3. `docs/GRADUATION-CHECKLIST.md`
4. `.github/ISSUE_TEMPLATE/experimental-feedback.yml`
5. Updated template README

---

## 🔗 Dependencies

**Prerequisites:**

- Phase 1 complete (commands exist)
- ADR-004 for graduation criteria

**Blocks:**

- None (final phase)

---

## 💡 Implementation Notes

### Recommended Task Order

Based on pre-phase review, recommended implementation order:

1. **Task 1** (Define levels) - Foundation for all other tasks
2. **Task 3** (STABILITY-LEVELS.md) - Create main documentation
3. **Task 4** (GRADUATION-CHECKLIST.md) - Create checklist based on ADR-004
4. **Task 5** (Issue template) - Create feedback mechanism
5. **Task 2** (Update commands) - Add feedback links to existing headers
6. **Task 6** (Update README) - Final integration with links

### Consistency

All Evolving commands should use identical stability header format for consistency.

### Existing Work

The `/status` command already has a stability header from Phase 1:

- ✅ Has `**Status:** 🟠 Evolving`
- ✅ Has `**Stability:** Experimental - may change without notice`
- ✅ Has warning block
- ❌ Missing feedback link (add in Task 2)

### Automation Opportunity

Future enhancement: script to validate all commands have appropriate stability indicators.

### Living Documentation

Graduation checklist should be updated as process is refined based on actual graduations.

---

## 🔗 Related Documents

- **Previous:** [Phase 3: CI Drift Detection](phase-3.md)
- **Next:** None (final phase)
- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Hub:** [README.md](README.md)
- **ADR-004:** Graduation Process

---

**Last Updated:** 2025-12-15  
**Status:** ✅ Complete  
**Completed:** 2025-12-15  
**Review:** [phase-4-review.md](phase-4-review.md) - ✅ Ready
