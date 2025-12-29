# Transition-Plan Two-Mode - Phase 3: Expand Mode Workflow

**Phase:** 3 - Expand Mode Workflow  
**Duration:** ~2 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 2 complete

---

## 📋 Overview

Create new Expand Mode Workflow section with TDD logic and detailed expansion steps.

**Success Definition:** Expand Mode fills scaffolding with TDD detail, following RED → GREEN → REFACTOR ordering.

**Target File:** `.cursor/commands/transition-plan.md`  
**Target Location:** After Setup Mode Workflow section (new section)

---

## 🎯 Goals

1. **Create section** - New "Expand Mode Workflow (`--expand`)" section
2. **Add 7 steps** - Complete expansion workflow
3. **Include TDD logic** - RED → GREEN → REFACTOR task ordering
4. **Document flags** - `--phase N`, `--all` handling

---

## 📝 Tasks

### Task 1: Create Section Header

**Purpose:** Establish the new Expand Mode section.

- [ ] Add new section after Setup Mode Workflow
- [ ] Mirror `/research` Conduct Mode section structure
- [ ] Add introduction explaining when to use

**Content to Add:**
```markdown
## Expand Mode Workflow (`--expand`)

**When to use:** After scaffolding has been created (Setup Mode), use Expand Mode to fill in detailed TDD tasks.

**Prerequisite:** Phase scaffolding documents must exist with status `🔴 Scaffolding`.
```

---

### Task 2: Write Step 1 - Identify Phase(s) to Expand

**Purpose:** Document how to determine expansion scope.

- [ ] Document `--phase N` for specific phase
- [ ] Document `--all` for batch expansion
- [ ] Document default behavior (prompt for phase)

**Content to Add:**
```markdown
### 1. Identify Phase(s) to Expand

**Determine scope:**

1. **Specific Phase** (`--phase N`):
   - Expand only the specified phase
   - Useful for incremental progress
   - Example: `/transition-plan [topic] --expand --phase 1`

2. **All Phases** (`--all`):
   - Expand all scaffolding phases at once
   - Useful after reviewing all scaffolding
   - Example: `/transition-plan [topic] --expand --all`

3. **Interactive** (no flag):
   - List phases with status
   - Prompt user to select phase
   - Show which phases need expansion (`🔴 Scaffolding`)

**Read phase scaffolding document:**

```bash
# Find phase documents
ls docs/maintainers/planning/features/[feature]/phase-*.md

# Check scaffolding status
grep "Status:" docs/maintainers/planning/features/[feature]/phase-1.md
```

**Checklist:**

- [ ] Phase(s) to expand identified
- [ ] Phase document exists
- [ ] Phase status is `🔴 Scaffolding`
```

---

### Task 3: Write Step 2 - Read Phase Scaffolding

**Purpose:** Document how to extract information from scaffolding.

- [ ] Document what to extract from scaffolding
- [ ] Document how to identify expansion needs

**Content to Add:**
```markdown
### 2. Read Phase Scaffolding

**Extract from scaffolding:**

- Phase number and name
- Goals (list of objectives)
- Task categories (high-level groupings)
- Completion criteria (success measures)
- Deliverables (expected outputs)
- Dependencies (prerequisites and blocks)

**Identify expansion needs:**

- Which task categories need TDD breakdown?
- What code examples are needed?
- What implementation notes would help?

**Example scaffolding extraction:**

```markdown
# From phase-1.md scaffolding:
Goals:
1. Add Setup Mode subsection
2. Add Expand Mode subsection
3. Document mode selection

Task Categories:
- Setup Mode Documentation
- Expand Mode Documentation
- Flag Documentation

Deliverables:
- Updated Workflow Overview section
```

**Checklist:**

- [ ] Phase scaffolding read
- [ ] Goals extracted
- [ ] Task categories identified
- [ ] Deliverables understood
```

---

### Task 4: Write Step 3 - Determine TDD vs Non-TDD

**Purpose:** Document how to determine if TDD ordering applies.

- [ ] Document when TDD ordering applies
- [ ] Document alternative ordering for non-code tasks

**Content to Add:**
```markdown
### 3. Determine TDD vs Non-TDD

**TDD Ordering applies when:**

- Phase involves code implementation
- Phase involves script creation
- Phase involves testable functionality

**Non-TDD Ordering for:**

- Documentation-only phases
- Configuration phases
- Planning phases

**Task Ordering Patterns:**

| Phase Type | Task Order | Example |
|------------|------------|---------|
| **Code + Tests (TDD)** | Tests → Implementation → Docs | Write tests, implement code, document |
| **Scripts (TDD)** | Tests → Script → Integration | Write bats tests, create script, integrate |
| **Documentation Only** | Create → Link → Verify | Create docs, add links, verify links work |
| **Configuration** | Plan → Implement → Validate | Define config, apply changes, verify |

**Decision Logic:**

```
IF phase creates code or scripts:
  → Use TDD ordering (RED → GREEN → REFACTOR)
ELSE IF phase creates documentation:
  → Use Create → Link → Verify ordering
ELSE:
  → Use logical dependency ordering
```

**Checklist:**

- [ ] Phase type determined (code/script/docs/config)
- [ ] Task ordering pattern selected
- [ ] TDD applicability decided
```

---

### Task 5: Write Step 4 - Expand Tasks with Detail (Main Logic)

**Purpose:** This is the core expansion logic - creating detailed TDD tasks.

- [ ] Document TDD expansion process
- [ ] Include example expanded task
- [ ] Document what sections to add

**Content to Add:**
```markdown
### 4. Expand Tasks with Detail

**This is the core expansion step.** Transform task categories into detailed, actionable tasks.

**For TDD phases (code/scripts):**

**TDD Task Structure:**

```markdown
### Task N: [Task Name]

**Purpose:** [Why this task exists]

**TDD Flow:**

1. **RED - Write failing test:**
   - [ ] Create test file: `tests/test_[feature].py`
   - [ ] Write test for [specific behavior]
   - [ ] Verify test fails (no implementation yet)

   **Test code:**
   ```python
   def test_feature_behavior():
       # Arrange
       ...
       # Act
       result = feature_function()
       # Assert
       assert result == expected
   ```

2. **GREEN - Implement minimum code:**
   - [ ] Create implementation file: `src/[feature].py`
   - [ ] Write minimum code to pass test
   - [ ] Run test, verify it passes

   **Implementation:**
   ```python
   def feature_function():
       # Minimum implementation
       return expected
   ```

3. **REFACTOR - Clean up:**
   - [ ] Review code for improvements
   - [ ] Extract helper functions if needed
   - [ ] Ensure tests still pass

**Checklist:**
- [ ] Test written and failing
- [ ] Implementation passes test
- [ ] Code refactored and clean
```

**For Documentation phases:**

```markdown
### Task N: [Task Name]

**Purpose:** [Why this task exists]

- [ ] Read existing content to understand current state
- [ ] Create new content as specified
- [ ] Verify content is complete and accurate
- [ ] Update any cross-references

**Content to Add:**
```markdown
[Specific markdown content to add]
```

**Checklist:**
- [ ] Content created
- [ ] Links verified
- [ ] Cross-references updated
```

**Expansion adds:**

| Section | Scaffolding | After Expansion |
|---------|-------------|-----------------|
| Tasks | Categories only | Full TDD breakdown |
| Code Examples | None | Language-specific samples |
| Testing Commands | None | Specific commands to run |
| Implementation Notes | None | Patterns, tips, examples |
| Progress Tracking | None | Task status table |

**Target expansion:**

- Scaffolding: ~60-80 lines
- Expanded: ~200-300 lines
- Added: ~150-200 lines of detail

**Checklist:**

- [ ] Task categories expanded to full tasks
- [ ] TDD flow added where applicable
- [ ] Code examples included
- [ ] Testing commands documented
- [ ] Implementation notes added
```

---

### Task 6: Write Step 5 - Update Phase Status

**Purpose:** Document how to update status indicators.

- [ ] Document status change from Scaffolding to Expanded
- [ ] Document where status appears

**Content to Add:**
```markdown
### 5. Update Phase Status

**Update status in phase document:**

**Header:**
```markdown
# Before:
**Status:** 🔴 Scaffolding (needs expansion)

# After:
**Status:** ✅ Expanded
```

**Footer:**
```markdown
# Before:
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan [topic] --expand --phase [N]`

# After:
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
```

**Remove placeholder message:**

```markdown
# Remove this from Tasks section:
> ⚠️ **Scaffolding:** Run `/transition-plan [topic] --expand --phase [N]` to add detailed TDD tasks.
```

**Add progress tracking table:**

```markdown
## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: [Name] | 🔴 Not Started | |
| Task 2: [Name] | 🔴 Not Started | |
```

**Checklist:**

- [ ] Header status updated to `✅ Expanded`
- [ ] Footer status updated
- [ ] Placeholder message removed
- [ ] Progress tracking table added
```

---

### Task 7: Write Step 6 - Update Hub Status

**Purpose:** Document how to update feature hub.

- [ ] Document hub status table update
- [ ] Document progress tracking update

**Content to Add:**
```markdown
### 6. Update Hub Status

**Update feature hub (README.md):**

```markdown
# Before:
| [Phase 1](phase-1.md) | Workflow Overview | 🔴 Scaffolding |

# After:
| [Phase 1](phase-1.md) | Workflow Overview | ✅ Expanded |
```

**Update status-and-next-steps.md:**

```markdown
# Before:
| Phase 1: Workflow Overview | 🔴 Scaffolding | 0% | Needs expansion |

# After:
| Phase 1: Workflow Overview | ✅ Expanded | 0% impl | Ready for implementation |
```

**Checklist:**

- [ ] Feature hub updated
- [ ] Status document updated
- [ ] Phase listed as ready for implementation
```

---

### Task 8: Write Step 7 - Commit Changes

**Purpose:** Document commit workflow for expansion.

- [ ] Document commit message format
- [ ] Document branch workflow

**Content to Add:**
```markdown
### 7. Commit Changes

**Commit expanded phase:**

**Since expansion is documentation-only, use docs workflow:**

```bash
# Stage expanded phase
git add docs/maintainers/planning/features/[feature]/phase-N.md
git add docs/maintainers/planning/features/[feature]/README.md
git add docs/maintainers/planning/features/[feature]/status-and-next-steps.md

# Commit with descriptive message
git commit -m "docs(planning): expand Phase N scaffolding with detailed tasks

Expand Phase N ([Name]) from ~[X] lines scaffolding to ~[Y] lines
with detailed implementation tasks:

- Task 1: [Name]
- Task 2: [Name]
- ...

Includes [TDD breakdown / documentation steps / etc.]"

# Push to develop (docs can push directly)
git push origin develop
```

**Checklist:**

- [ ] Changes committed
- [ ] Commit message descriptive
- [ ] Pushed to develop
```

---

### Task 9: Document Flag Handling Details

**Purpose:** Complete documentation of flag handling.

- [ ] Document `--phase N` validation
- [ ] Document `--all` batch processing
- [ ] Document error handling

**Content to Add:**
```markdown
### Flag Handling

**`--phase N` Flag:**

```
/transition-plan [topic] --expand --phase N

Validation:
- Check phase-N.md exists
- Check status is 🔴 Scaffolding
- Error if phase already expanded

Processing:
- Expand single phase
- Update phase status
- Update hub
- Commit changes
```

**`--all` Flag:**

```
/transition-plan [topic] --expand --all

Processing:
- Find all phase-*.md files with 🔴 Scaffolding status
- Expand each phase in order (1, 2, 3, ...)
- Update each phase status
- Update hub once at end
- Single commit for all expansions
```

**Error Handling:**

| Error | Message | Action |
|-------|---------|--------|
| Phase not found | "Phase N does not exist" | List available phases |
| Already expanded | "Phase N already expanded" | Skip or use --force |
| No scaffolding | "No scaffolding phases found" | Run setup mode first |
```

---

### Task 10: Verify Changes Against Criteria

**Purpose:** Confirm all completion criteria met.

- [ ] "Expand Mode Workflow (`--expand`)" section created
- [ ] 7 steps documented with detail
- [ ] TDD ordering logic included (RED → GREEN → REFACTOR)
- [ ] `--phase N` flag handling documented
- [ ] `--all` flag handling documented
- [ ] Status update to `✅ Expanded` documented

---

## ✅ Completion Criteria

- [ ] "Expand Mode Workflow (`--expand`)" section created
- [ ] 7 steps documented with detail
- [ ] TDD ordering logic included (RED → GREEN → REFACTOR)
- [ ] `--phase N` flag handling documented
- [ ] `--all` flag handling documented
- [ ] Status update to `✅ Expanded` documented

---

## 📦 Deliverables

- Expand Mode Workflow section (~300-400 lines)
- TDD expansion logic documentation
- Flag handling documentation
- Error handling documentation

---

## 🔗 Dependencies

### Prerequisites

- [x] Phase 2: Setup Mode Workflow complete
- [x] ADR-001: Flag-Based Mode Switching reviewed

### Blocks

- Phase 4 (Supporting Content)

---

## 📊 Progress Tracking

| Task                                  | Status         | Notes |
| ------------------------------------- | -------------- | ----- |
| Task 1: Create Section Header         | ✅ Complete    |       |
| Task 2: Step 1 - Identify Phases      | 🔴 Not Started |       |
| Task 3: Step 2 - Read Scaffolding     | 🔴 Not Started |       |
| Task 4: Step 3 - Determine TDD        | 🔴 Not Started |       |
| Task 5: Step 4 - Expand Tasks (Main)  | 🔴 Not Started |       |
| Task 6: Step 5 - Update Phase Status  | 🔴 Not Started |       |
| Task 7: Step 6 - Update Hub Status    | 🔴 Not Started |       |
| Task 8: Step 7 - Commit Changes       | 🔴 Not Started |       |
| Task 9: Document Flag Handling        | 🔴 Not Started |       |
| Task 10: Verify Changes               | 🔴 Not Started |       |

---

## 💡 Implementation Notes

### Pattern Reference: /research Conduct Mode

The `/research --conduct` workflow (lines 658-900) provides the pattern:

| /research Conduct | /transition-plan Expand |
|-------------------|-------------------------|
| Step 1: Identify research | Step 1: Identify phase(s) |
| Step 2: Conduct web research | Step 2: Read scaffolding |
| Step 3: Fill in findings | Step 3: Determine TDD |
| Step 4: Update status | Step 4: Expand tasks (main) |
| Step 5: Update summary | Step 5: Update phase status |
| Step 6: Update hub | Step 6: Update hub status |
| Step 7: Commit | Step 7: Commit |

### TDD Ordering Critical

The key difference between Setup and Expand is **TDD task ordering**:

```
SCAFFOLDING (Setup Mode):
- [ ] Setup Mode Documentation
- [ ] Expand Mode Documentation
- [ ] Flag Documentation

EXPANDED (Expand Mode):
- [ ] Task 1: Read current content
- [ ] Task 2: Write Setup Mode (content included)
- [ ] Task 3: Write Expand Mode (content included)
- [ ] Task 4: Update introduction
- [ ] Task 5: Verify changes
```

For code/test tasks, ensure test tasks come BEFORE implementation tasks.

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Previous Phase: Phase 2](phase-2.md)
- [Next Phase: Phase 4](phase-4.md)
- [ADR-001: Mode Switching](../../../decisions/transition-plan-two-mode/adr-001-flag-based-mode-switching.md)
- [/research Command](../../../../.cursor/commands/research.md) - Conduct Mode pattern

---

**Last Updated:** 2025-12-29  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
