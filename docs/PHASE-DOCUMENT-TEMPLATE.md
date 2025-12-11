# Phase Document Template

**Purpose:** Template for creating detailed phase documents following work-prod structure  
**Status:** ✅ Active Template  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 📋 How to Use This Template

1. Copy this template when creating a new phase document
2. Replace all `[PLACEHOLDER]` sections with actual values
3. Expand tasks with detailed TDD flow (RED → GREEN → REFACTOR)
4. Add project-specific implementation notes
5. Include code examples and testing commands where applicable

**Template Location:** `docs/PHASE-DOCUMENT-TEMPLATE.md`  
**Usage:** Copy and customize for each phase

---

# [Feature Name] - Phase [N]: [Phase Name]

**Phase:** [N] - [Phase Name]  
**Duration:** [X] days (Actual: [Y] days)  
**Status:** 🔴 Not Started  
**Prerequisites:** [Previous phase or requirements]  
**Completed:** YYYY-MM-DD (if complete)

---

## 📋 Overview

[What this phase delivers. Brief description of the phase's purpose and outcomes.]

**Success Definition:** [Clear, measurable definition of phase success. What can you do/verify when this phase is complete?]

---

## 🎯 Goals

1. **[Goal 1]** - [Brief description]
2. **[Goal 2]** - [Brief description]
3. **[Goal 3]** - [Brief description]
4. **[Goal 4]** - [Brief description]
5. **[Goal 5]** - [Brief description]

---

## 📝 Tasks

### TDD Flow ([Component Type] - Backend/CLI/Frontend/etc.)

#### 1. [Task Name] (TDD - RED)

- [ ] Create `[file-path]`
- [ ] Test [specific functionality]
- [ ] Test [validation/error cases]
- [ ] Test [edge cases]
- [ ] Run test: **FAILS** ❌ ([component] doesn't exist yet)

**Test Example:**
```[language]
[Code example of test to write]
```

#### 2. [Task Name] (TDD - GREEN)

- [ ] Create `[file-path]`
- [ ] Implement [specific functionality]
- [ ] Add [validation/error handling]
- [ ] Add [edge case handling]
- [ ] Run test: **PASSES** ✅

**Implementation Example:**
```[language]
[Code example of implementation]
```

#### 3. [Task Name] (TDD - RED)

- [ ] Create `[file-path]`
- [ ] Test [specific functionality]
- [ ] Test [validation/error cases]
- [ ] Run test: **FAILS** ❌

#### 4. [Task Name] (TDD - GREEN)

- [ ] Implement [specific functionality]
- [ ] Add [validation/error handling]
- [ ] Run test: **PASSES** ✅
- [ ] Verify test coverage: `[coverage-command]`

#### 5. Manual Testing

- [ ] Start [service/component]: `[start-command]`
- [ ] Test [functionality] with [tool]:
  ```bash
  [testing-command]
  # Expected: [expected-output]
  ```
- [ ] Test [error case]:
  ```bash
  [testing-command]
  # Expected: [expected-error]
  ```
- [ ] Verify [specific behavior]

#### 6. [Additional Task]

- [ ] [Task detail 1]
- [ ] [Task detail 2]
- [ ] [Task detail 3]

---

## ✅ Completion Criteria

- [ ] [Criterion 1 - specific and measurable]
- [ ] [Criterion 2 - specific and measurable]
- [ ] [Criterion 3 - specific and measurable]
- [ ] [Criterion 4 - specific and measurable]
- [ ] [Criterion 5 - specific and measurable]
- [ ] [Criterion 6 - specific and measurable]
- [ ] [Criterion 7 - specific and measurable]
- [ ] [Criterion 8 - specific and measurable]
- [ ] [Criterion 9 - specific and measurable]
- [ ] Coverage > [X]% for new code

---

## 📦 Deliverables

1. **[Component Type]**
   - `[file-path]` - [Description]
   - `[file-path]` - [Description]
   - [Database migration file] (if applicable)

2. **Tests**
   - `[test-file-path]` - [Test description]
   - `[test-file-path]` - [Test description]
   - Coverage report (HTML)

3. **[Component Type]**
   - `[file-path]` - [Description]
   - `[file-path]` - [Description]

4. **Documentation**
   - [API documentation] (if applicable)
   - [Usage examples] (if applicable)
   - [README updates] (if applicable)

---

## 🔗 Dependencies

### Prerequisites

- ✅ [Previous Phase]: [Phase Name] complete
- ✅ [Dependency]: [Description]
- ✅ [Dependency]: [Description]

### External Dependencies

- [Dependency 1] - [Description]
- [Dependency 2] - [Description]
- None (uses existing [framework/setup])

### Blocks

- [Phase N+1]: [Phase Name] - [Description of what it blocks]

---

## ⚠️ Risks

**Risk: [Risk Name]**  
**Probability:** [Low/Medium/High]  
**Impact:** [Low/Medium/High]  
**Mitigation:** [How to mitigate this risk]  
**Contingency:** [Fallback plan if risk materializes]

**Risk: [Risk Name]**  
**Probability:** [Low/Medium/High]  
**Impact:** [Low/Medium/High]  
**Mitigation:** [How to mitigate this risk]  
**Contingency:** [Fallback plan if risk materializes]

---

## 📊 Progress Tracking

**Phase Status:** 🔴 Not Started

**[Category 1] (0/X complete)**
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

**[Category 2] (0/X complete)**
- [ ] [Task 1]
- [ ] [Task 2]

**[Category 3] (0/X complete)**
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

---

## 💡 Implementation Notes

### TDD Workflow

**For [Component Type]:**
1. Write test for [functionality] → Run → FAIL
2. Create [component] with [minimal implementation] → Run → PASS
3. Write test for [additional functionality] → Run → FAIL
4. Implement [additional functionality] → Run → PASS
5. Refactor if needed

**For [Component Type]:**
1. Write test for [functionality] → Run → FAIL
2. Create [component] with [minimal implementation] → Run → PASS
3. Refactor if needed

### [Component] Pattern

**[Pattern Name]:**
```[language]
[Code example showing the pattern]
```

**[Pattern Name]:**
```[language]
[Code example showing the pattern]
```

### Testing Pattern

**[Test Type] Example:**
```[language]
[Code example of test]
```

**[Test Type] Example:**
```[language]
[Code example of test]
```

### [Tool/Command] Setup

**[Setup Step]:**
```bash
[command]
[command]
```

**[Setup Step]:**
```bash
[command]
[command]
```

### [Tool] Testing Commands

```bash
# [Test description]
[command]

# [Test description]
[command]

# [Test description]
[command]
```

---

## 🔗 Related Documents

- [Phase [N-1]: [Phase Name]](phase-[N-1].md)
- [Phase [N+1]: [Phase Name]](phase-[N+1].md)
- [Feature Plan](feature-plan.md)
- [Feature Hub](README.md)
- [ADR-XXXX: [Decision Name]](../../decisions/ADR-XXXX-[decision-name].md) (if applicable)

---

**Last Updated:** YYYY-MM-DD  
**Status:** 🔴 Not Started  
**Approach:** [Development approach, e.g., "Backend-First API Development"]  
**Next:** Begin after prerequisites met


