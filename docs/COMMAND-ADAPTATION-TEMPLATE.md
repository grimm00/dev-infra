# Command Adaptation Template

**Purpose:** Reusable template for adapting Cursor commands between projects  
**Status:** ✅ Active Template  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 📋 How to Use This Template

1. Copy this template to create a new command adaptation document
2. Replace all `[PLACEHOLDER]` sections with actual values
3. Follow the adaptation pattern: Configuration → Path Detection → Feature Detection → Generic Implementation
4. Reference [Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md) for detailed guidance

**Template Location:** `docs/COMMAND-ADAPTATION-TEMPLATE.md`  
**Usage:** Copy and customize for each command adaptation

---

## Command Adaptation: [Command Name] for [Target Project]

**Source Command:** `/[command-name]` from [source-project]  
**Target:** [target-project] template  
**Status:** 🔴 Not Started  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## 📋 Overview

[Brief description of the command and what adaptations are needed]

**Key Adaptation Goal:** [Main goal of adaptation, e.g., "Make paths generic", "Support multiple project structures"]

---

## 🎯 Original Command

**Command:** `/[command-name]`  
**Purpose:** [Original purpose of the command]  
**Location:** `.cursor/commands/[command-name].md` (in source project)

**Key Features:**
- [Feature 1]
- [Feature 2]
- [Feature 3]

**Original Structure:**
- [Describe original command structure]
- [Note any project-specific assumptions]

---

## 🔄 Adaptations Needed

### 1. Configuration

**Change:** Replace project-specific paths with configurable paths  
**Reason:** Command should work for any project using dev-infra templates  
**Impact:** Command becomes reusable across projects

**Original:**
```markdown
[Example of original project-specific configuration]
```

**Adapted:**
```markdown
## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Feature-Specific Structure (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/`
   - Feature name auto-detected from context or configuration
   - Example: `docs/maintainers/planning/features/my-feature/`

2. **Project-Wide Structure:**
   - Path: `docs/maintainers/planning/`
   - Used when no feature structure exists
   - Example: `docs/maintainers/planning/`

**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for relevant files in each
  - If no features exist, use project-wide structure

**Naming Conventions:**

- Default format: `[pattern]-[identifier]`
- Configurable via project configuration
- Examples: `[project-specific-examples]`
```

**Files to modify:**
- `.cursor/commands/[command-name].md` - Add Configuration section

---

### 2. Path Detection

**Change:** Add path detection logic to support multiple project structures  
**Reason:** Projects may organize files differently  
**Impact:** Command works with both feature-specific and project-wide structures

**Original:**
```markdown
[Example of original hardcoded paths]
```

**Adapted:**
```markdown
**Path Detection:**

This command supports multiple project organization patterns:

1. **Feature-Specific Structure (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/[file-type].md`
   - Feature name auto-detected from context or configuration

2. **Project-Wide Structure:**
   - Path: `docs/maintainers/planning/[file-type].md`
   - Used when no feature structure exists

3. **Alternative Locations:**
   - `docs/maintainers/planning/[category]/[file-type].md` (if configured)
   - Configurable via project configuration
```

**Files to modify:**
- `.cursor/commands/[command-name].md` - Add Path Detection section

---

### 3. Feature Detection

**Change:** Add feature detection logic  
**Reason:** Support both feature-specific and project-wide workflows  
**Impact:** Command adapts to project organization automatically

**Original:**
```markdown
[Example of original feature-specific assumption]
```

**Adapted:**
```markdown
**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for relevant files in each
  - If no features exist, use project-wide structure
```

**Files to modify:**
- `.cursor/commands/[command-name].md` - Add Feature Detection section

---

### 4. Generic Implementation

**Change:** Replace hardcoded paths with detected paths  
**Reason:** Make command work for any project structure  
**Impact:** Command becomes template-agnostic

**Original:**
```markdown
[Example of original implementation with hardcoded paths]
```

**Adapted:**
```markdown
**Workflow:**

1. Detect feature name (or use project-wide)
2. Build paths using detected structure:
   - Feature-specific: `docs/maintainers/planning/features/[feature-name]/[file-type].md`
   - Project-wide: `docs/maintainers/planning/[file-type].md`
3. Execute command logic using generic paths
4. Create/update files in appropriate locations
```

**Files to modify:**
- `.cursor/commands/[command-name].md` - Update implementation to use detected paths

---

## 📝 Implementation Steps

### Step 1: Add Configuration Section

- [ ] Add Configuration section to command file
- [ ] Define path detection patterns
- [ ] Define feature detection logic
- [ ] Define naming conventions
- [ ] Add configurable options

**Example:**
```markdown
## Configuration

**Path Detection:**
[Path detection patterns]

**Feature Detection:**
[Feature detection logic]

**Naming Conventions:**
[Naming conventions]
```

---

### Step 2: Add Path Detection Logic

- [ ] Add Path Detection section
- [ ] Document feature-specific paths
- [ ] Document project-wide paths
- [ ] Document alternative locations
- [ ] Add detection logic

**Example:**
```markdown
**Path Detection:**

1. **Feature-Specific Structure (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/[file-type].md`

2. **Project-Wide Structure:**
   - Path: `docs/maintainers/planning/[file-type].md`
```

---

### Step 3: Add Feature Detection Logic

- [ ] Add Feature Detection section
- [ ] Document manual override (`--feature` option)
- [ ] Document auto-detection logic
- [ ] Document edge case handling

**Example:**
```markdown
**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  [Auto-detection logic]
```

---

### Step 4: Update Implementation

- [ ] Replace hardcoded paths with detected paths
- [ ] Use feature detection results
- [ ] Update file creation/update logic
- [ ] Test with different project structures

**Example:**
```markdown
**Workflow:**

1. Detect feature name (or use project-wide)
2. Build paths using detected structure
3. Execute command logic using generic paths
```

---

## 📚 Examples

### Example Configuration

```markdown
## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Feature-Specific Structure (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
   - Feature name auto-detected from context or configuration

2. **Project-Wide Structure:**
   - Path: `docs/maintainers/planning/phases/phase-N.md`
   - Used when no feature structure exists

**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for phase files in each
  - If no features exist, use project-wide structure
```

### Example Path Patterns

**Feature-Specific:**
- `docs/maintainers/planning/features/[feature-name]/phase-N.md`
- `docs/maintainers/planning/features/[feature-name]/fix/pr##/`
- `docs/maintainers/planning/features/[feature-name]/reflections/reflection-*.md`

**Project-Wide:**
- `docs/maintainers/planning/phases/phase-N.md`
- `docs/maintainers/planning/fix/pr##/`
- `docs/maintainers/planning/notes/reflections/reflection-*.md`

### Example Implementation

```markdown
**Workflow:**

1. Detect feature name:
   - Use `--feature` option if provided
   - Otherwise, auto-detect from project structure

2. Build paths:
   - Feature-specific: `docs/maintainers/planning/features/[feature-name]/[file-type].md`
   - Project-wide: `docs/maintainers/planning/[file-type].md`

3. Execute command:
   - Use detected paths for file operations
   - Create/update files in appropriate locations
```

---

## ✅ Definition of Done

- [ ] Configuration section added
- [ ] Path Detection section added
- [ ] Feature Detection section added
- [ ] Implementation updated to use generic paths
- [ ] All hardcoded paths replaced
- [ ] Command tested with feature-specific structure
- [ ] Command tested with project-wide structure
- [ ] Documentation updated
- [ ] Ready for use in target project

---

## 🔗 Related Documentation

- **[Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md)** - Detailed pattern explanation
- **[Command Adaptation Guide](../admin/planning/opportunities/external/work-prod/cursor-commands/adaptations/command-adaptation-guide.md)** - General adaptation guide

---

## 📝 Notes

**Customization Tips:**
- Replace `[PLACEHOLDER]` sections with actual values
- Customize path patterns for your project structure
- Add project-specific configuration options
- Include examples from your actual adaptation

**Validation:**
- Test with feature-specific structure
- Test with project-wide structure
- Verify all paths work correctly
- Check edge cases (single feature, multiple features, no features)

---

**Last Updated:** YYYY-MM-DD  
**Status:** 🔴 Not Started  
**Next:** Follow implementation steps to adapt command

