# Phase 1: Create Experimental Template

**Phase:** 1 of 4  
**Duration:** 2-3 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** ADRs approved, Evolving commands identified

---

## 📋 Overview

Create the `templates/experimental-project/` directory by copying the standard-project template and adding Evolving tier commands from dev-infra.

**Success Definition:** A complete experimental template directory exists with all standard content plus Evolving tier commands, and includes stability disclaimers.

---

## 🎯 Goals

1. Create experimental-project template directory
2. Include all standard-project content
3. Add Evolving tier commands
4. Add stability documentation

---

## 📝 Tasks

### Task 1: Copy Standard Template Structure

**Objective:** Create experimental-project by copying standard-project

**Process:**

1. [ ] Copy entire `templates/standard-project/` to `templates/experimental-project/`
2. [ ] Verify all files and directories copied correctly
3. [ ] Update template name in copied files (where referenced)

**Commands:**

```bash
# Copy standard template
cp -r templates/standard-project templates/experimental-project

# Verify structure
ls -la templates/experimental-project/
```

---

### Task 2: Identify Evolving Tier Commands

**Objective:** Determine which commands belong in Evolving tier

**Process:**

1. [ ] Review dev-infra `.cursor/commands/` directory
2. [ ] Identify commands marked as Evolving or experimental
3. [ ] Check ADR-003 for command tier definitions
4. [ ] Create list of commands to add

**Expected Commands:**

- Commands in development but not yet stable
- Commands with `Status: 🟠 Evolving` or similar
- Commands explicitly excluded from standard template

---

### Task 3: Add Evolving Commands to Template

**Objective:** Copy Evolving tier commands to experimental template

**Process:**

1. [ ] Copy identified Evolving commands to `templates/experimental-project/.cursor/commands/`
2. [ ] Ensure command files have correct stability indicators
3. [ ] Verify command documentation is complete
4. [ ] Update any internal references if needed

---

### Task 4: Update Template README

**Objective:** Add stability disclaimer and experimental context to README

**Process:**

1. [ ] Update `templates/experimental-project/README.md`
2. [ ] Add stability disclaimer section at top
3. [ ] Explain what "experimental" means
4. [ ] List included Evolving commands
5. [ ] Link to graduation process

**Stability Disclaimer Template:**

```markdown
## ⚠️ Experimental Template

This template includes **experimental/evolving commands** that are not yet
stable enough for the standard template. These commands:

- 🟠 May change without notice
- 🟠 May have incomplete documentation
- 🟠 May be removed or significantly modified
- 🟠 Provide early access to new features

**Use this template if:**

- You want early access to new commands
- You're comfortable with potential breaking changes
- You can provide feedback on evolving features

**Use standard-project if:**

- You need maximum stability
- You're building production systems
- You prefer proven, stable commands

**Evolving Commands Included:**

- [List of commands with 🟠 indicator]

**Graduation:** Commands graduate to standard-project when they meet
[ADR-004 graduation criteria](link-to-adr-004).
```

---

### Task 5: Add Experimental Documentation

**Objective:** Create experimental-specific documentation files

**Process:**

1. [ ] Create `templates/experimental-project/docs/EXPERIMENTAL.md`
2. [ ] Document Evolving commands and their status
3. [ ] Explain feedback mechanism
4. [ ] Link to graduation criteria

---

### Task 6: Verify Template Structure

**Objective:** Validate template is complete and correct

**Process:**

1. [ ] Run existing template validation tests
2. [ ] Verify all required directories exist
3. [ ] Verify all required files present
4. [ ] Check for broken links in documentation

**Commands:**

```bash
# Run template validation
bats tests/unit/validate-templates.bats

# Verify structure
./scripts/validate-templates.sh
```

---

## ✅ Completion Criteria

- [ ] `templates/experimental-project/` directory exists
- [ ] All standard-project content included
- [ ] Evolving tier commands added
- [ ] README includes stability disclaimer
- [ ] EXPERIMENTAL.md documentation created
- [ ] Template passes validation tests
- [ ] No broken links in documentation

### Test Coverage Goals

- [ ] Template passes all existing `validate-templates.bats` tests
- [ ] At least 1 test specific to experimental template structure
- [ ] Documentation link validation passes
- [ ] Evolving commands are present and have stability indicators

---

## 📦 Deliverables

1. `templates/experimental-project/` directory
2. Evolving tier commands in `.cursor/commands/`
3. Updated README with stability information
4. `docs/EXPERIMENTAL.md` guide
5. Passing validation tests

---

## 🔗 Dependencies

**Prerequisites:**

- ADRs approved (ADR-001 ✅, ADR-002 ✅)
- Evolving tier commands identified (see [Evolving Commands Inventory](evolving-commands-inventory.md))

**Blocks:**

- Phase 2: Generator script update

---

## 💡 Implementation Notes

### Intentionally Different Files

These files will differ between `standard-project` and `experimental-project` by design:

| File/Directory         | Difference                        | Reason         |
| ---------------------- | --------------------------------- | -------------- |
| `README.md`            | Has experimental disclaimer       | User awareness |
| `.cursor/commands/`    | Has additional Evolving commands  | Core feature   |
| `docs/EXPERIMENTAL.md` | Experimental-only file            | Documentation  |
| `start.txt`            | May reference experimental nature | Initial setup  |

**All other files should be identical** and will be validated by CI drift detection (Phase 3).

---

### Template Structure

```
templates/experimental-project/
├── .cursor/
│   └── commands/
│       ├── [stable commands from standard]
│       └── [evolving tier commands]  ← NEW
├── .github/
│   └── workflows/
├── backend/
├── frontend/
├── docs/
│   ├── maintainers/
│   └── EXPERIMENTAL.md              ← NEW
├── tests/
├── scripts/
├── README.md                         ← UPDATED
└── start.txt
```

### Stability Indicators

Commands should include stability in their header:

```markdown
# Command Name

**Status:** 🟠 Evolving  
**Stability:** Experimental - may change without notice
```

---

## 🔗 Related Documents

- **Previous:** None (first phase)
- **Next:** [Phase 2: Update Generator](phase-2.md)
- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Hub:** [README.md](README.md)

---

**Last Updated:** 2025-12-12  
**Status:** 🟠 In Progress
