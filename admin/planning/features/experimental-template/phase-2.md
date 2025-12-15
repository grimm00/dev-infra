# Phase 2: Update Generator Script

**Phase:** 2 of 4  
**Duration:** 1-2 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Update `scripts/new-project.sh` to support `experimental-project` as a template type option, including stability warnings and updated documentation.

**Success Definition:** Users can generate projects using the experimental template with clear stability communication.

---

## 🎯 Goals

1. Add experimental-project to template type validation
2. Update interactive menu with experimental option
3. Add stability warning when selecting experimental
4. Update help text and documentation
5. Add tests for new template type

---

## 📝 Tasks

### Task 1: Update Template Type Validation

**Objective:** Accept experimental-project as valid template type

**Process:**

1. [x] Find template type validation in `new-project.sh`
2. [x] Add `experimental-project` to valid types
3. [x] Verify validation accepts new type

**Expected Code Change:**

```bash
# Find validation like:
VALID_TYPES=("standard-project" "learning-project")

# Update to:
VALID_TYPES=("standard-project" "learning-project" "experimental-project")
```

---

### Task 2: Update Interactive Menu

**Objective:** Add experimental option to template selection menu

**Process:**

1. [x] Find interactive menu in `new-project.sh`
2. [x] Add experimental-project option
3. [x] Include description indicating experimental nature

**Expected Menu:**

```
Select a template type:
1) standard-project  - Full-featured stable template
2) learning-project  - Educational/tutorial focused template
3) experimental-project - Includes experimental/evolving commands ⚠️
```

---

### Task 3: Add Stability Warning

**Objective:** Display warning when user selects experimental template

**Process:**

1. [x] Detect when experimental-project selected
2. [x] Display clear stability warning
3. [x] Require confirmation before proceeding

**Expected Warning:**

```
⚠️  EXPERIMENTAL TEMPLATE SELECTED

This template includes experimental/evolving commands that:
- May change without notice
- May have incomplete documentation
- Provide early access to new features

Are you sure you want to use the experimental template? [y/N]
```

---

### Task 4: Update Help Text

**Objective:** Document experimental option in help output

**Process:**

1. [x] Find help text in `new-project.sh`
2. [x] Add experimental-project to usage examples
3. [x] Describe experimental template purpose

**Expected Help:**

```
Usage: ./scripts/new-project.sh [project-name] [template-type]

Template Types:
  standard-project     Full-featured stable template (default)
  learning-project     Educational/tutorial focused template
  experimental-project Includes experimental/evolving commands

Examples:
  ./scripts/new-project.sh my-app
  ./scripts/new-project.sh my-app standard-project
  ./scripts/new-project.sh my-app experimental-project
```

---

### Task 5: Update User Documentation

**Objective:** Document experimental template in user docs

**Process:**

1. [x] Update `docs/TEMPLATE-USAGE.md`
2. [x] Add experimental template section
3. [x] Document when to use experimental vs standard
4. [x] Update `docs/PROJECT-TYPES.md` if exists

---

### Task 6: Add Generator Tests

**Objective:** Test generator with experimental template

**Process:**

1. [x] Add test for experimental template generation
2. [x] Test template type validation
3. [x] Test stability warning (if interactive tests possible)
4. [x] Verify generated project structure

**Test Cases:**

```bash
# Test: Generate experimental project
@test "new-project.sh generates experimental-project" {
  run "$SCRIPT" test-project experimental-project --non-interactive
  [ "$status" -eq 0 ]
  [ -d "$TEST_DIR/test-project" ]
}

# Test: Validation accepts experimental
@test "new-project.sh validates experimental-project type" {
  run "$SCRIPT" test-project experimental-project --non-interactive
  [ "$status" -eq 0 ]
}
```

---

## ✅ Completion Criteria

- [ ] Generator accepts `experimental-project` type
- [ ] Interactive menu shows experimental option
- [ ] Stability warning displays for experimental
- [ ] Help text updated
- [ ] User documentation updated
- [ ] Tests pass for new template type

---

## 📦 Deliverables

1. Updated `scripts/new-project.sh`
2. Tests in `tests/unit/new-project.bats`
3. Updated `docs/TEMPLATE-USAGE.md`
4. Updated `docs/PROJECT-TYPES.md` (if exists)

---

## 🔗 Dependencies

**Prerequisites:**

- Phase 1 complete (template exists)

**Blocks:**

- Phase 3 depends on generator working

---

## 💡 Implementation Notes

### Non-Interactive Mode

For CI/automation, the generator should accept experimental type without interactive warning:

```bash
./scripts/new-project.sh my-project experimental-project --non-interactive
```

### Backward Compatibility

- Default template type remains `standard-project`
- Existing commands continue to work unchanged
- New option is purely additive

---

## 🔗 Related Documents

- **Previous:** [Phase 1: Create Template](phase-1.md)
- **Next:** [Phase 3: CI Drift Detection](phase-3.md)
- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Hub:** [README.md](README.md)

---

**Last Updated:** 2025-12-12  
**Status:** 🟠 In Progress
