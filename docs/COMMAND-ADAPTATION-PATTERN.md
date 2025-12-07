# Command Adaptation Pattern

**Purpose:** Document the adaptation pattern for porting Cursor commands between projects  
**Status:** ✅ Active  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 📋 Overview

This document describes the adaptation pattern that emerged during the integration of 14 Cursor commands from work-prod into dev-infra. This pattern provides a systematic approach for adapting commands to work across different project structures while preserving proven workflows.

**Pattern Structure:**
Configuration → Path Detection → Feature Detection → Generic Implementation

---

## 🎯 Pattern Rationale

**Why This Pattern Works:**

1. **Configuration First** - Establishes project-specific settings upfront
2. **Path Detection** - Handles different project organizational patterns
3. **Feature Detection** - Supports both feature-specific and project-wide structures
4. **Generic Implementation** - Ensures commands work for any project using dev-infra templates

**Key Benefits:**

- **Reusability** - Commands work across projects without modification
- **Flexibility** - Supports multiple organizational patterns
- **Consistency** - All commands follow the same adaptation approach
- **Maintainability** - Clear pattern makes updates easier

---

## 📐 Pattern Structure

### Step 1: Configuration

**Purpose:** Define project-specific paths and naming conventions

**What to Configure:**

- Base paths for planning directories
- Feature detection paths
- File naming conventions
- Default values and fallbacks

**Example Structure:**

```markdown
## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Feature-Specific Structure (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/`
   - Feature name auto-detected from context or configuration

2. **Project-Wide Structure:**
   - Path: `docs/maintainers/planning/`
   - Used when no feature structure exists

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
- Examples: `pr12-batch-medium-low-01`, `phase-1.md`
```

**Key Principles:**

- Make all paths configurable
- Provide sensible defaults
- Support multiple patterns
- Document configuration clearly

---

### Step 2: Path Detection

**Purpose:** Identify the correct paths based on project structure

**Detection Logic:**

1. **Check for Feature Structure:**
   - Look for `docs/maintainers/planning/features/` directory
   - If exists, use feature-specific paths
   - If not, use project-wide paths

2. **Support Multiple Patterns:**
   - Feature-specific: `docs/maintainers/planning/features/[feature-name]/`
   - Project-wide: `docs/maintainers/planning/`
   - Alternative: `docs/maintainers/planning/[category]/` (if configured)

3. **Handle Edge Cases:**
   - Single feature projects
   - Multi-feature projects
   - Projects without feature structure

**Example Implementation:**

```markdown
**Path Detection:**

This command supports multiple project organization patterns:

1. **Feature-Specific Structure (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
   - Feature name auto-detected from context or configuration

2. **Project-Wide Structure:**
   - Path: `docs/maintainers/planning/phases/phase-N.md`
   - Used when no feature structure exists

3. **Alternative Locations:**
   - `docs/maintainers/planning/[category]/phase-N.md` (if configured)
   - Configurable via project configuration
```

**Key Principles:**

- Auto-detect when possible
- Support manual override (`--feature` option)
- Provide fallback patterns
- Document detection logic clearly

---

### Step 3: Feature Detection

**Purpose:** Identify which feature (if any) the command should operate on

**Detection Logic:**

1. **Manual Override:**
   - Use `--feature` option if provided
   - Overrides all auto-detection

2. **Auto-Detection:**
   - Check if `docs/maintainers/planning/features/` exists
   - If single feature exists, use that feature name
   - If multiple features exist, search for relevant files in each
   - If no features exist, use project-wide structure

3. **Context-Based:**
   - Use current directory context
   - Check for phase/fix files in feature directories
   - Use most relevant feature based on file structure

**Example Implementation:**

```markdown
**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for phase/fix structure in each
  - If no features exist, use project-wide structure
```

**Key Principles:**

- Prefer explicit over implicit
- Provide clear auto-detection logic
- Support manual override
- Handle edge cases gracefully

---

### Step 4: Generic Implementation

**Purpose:** Implement command logic using generic paths and patterns

**Implementation Approach:**

1. **Use Detected Paths:**
   - Use paths from Step 2 (Path Detection)
   - Use feature name from Step 3 (Feature Detection)
   - Build file paths dynamically

2. **Avoid Hardcoding:**
   - No project-specific assumptions
   - No hardcoded feature names
   - No fixed directory structures

3. **Support Multiple Patterns:**
   - Feature-specific workflows
   - Project-wide workflows
   - Mixed patterns

**Example Implementation:**

```markdown
**Workflow:**

1. Detect feature name (or use project-wide)
2. Build paths using detected structure:
   - Feature-specific: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
   - Project-wide: `docs/maintainers/planning/phases/phase-N.md`
3. Execute command logic using generic paths
4. Create/update files in appropriate locations
```

**Key Principles:**

- Use detected paths, don't hardcode
- Support all organizational patterns
- Make logic reusable
- Document implementation clearly

---

## 📚 Examples from Actual Adaptations

### Example 1: `/fix-plan` Command

**Original (work-prod specific):**
```markdown
Location: `docs/maintainers/planning/features/projects/fix/pr##/`
Review file: `docs/maintainers/feedback/sourcery/pr##.md`
```

**Adapted (generic):**
```markdown
**Fix Path Detection:**

1. **Feature-Specific Fixes (default):**
   - Path: `docs/maintainers/planning/features/[feature-name]/fix/`
   - Feature name auto-detected from context or configuration

2. **Project-Wide Fixes:**
   - Path: `docs/maintainers/planning/fix/`
   - Used when no feature structure exists

**Feature Detection:**

- Check if `docs/maintainers/planning/features/` exists
- If multiple features exist, use configuration or prompt user
- If single feature exists, use that feature name
- If no features exist, use project-wide structure
```

**Key Changes:**
- Replaced `features/projects/` with `features/[feature-name]/`
- Added project-wide fallback
- Added feature detection logic
- Made paths configurable

---

### Example 2: `/pr` Command

**Original (work-prod specific):**
```markdown
Phase paths: `docs/maintainers/planning/features/projects/phase-N.md`
Fix paths: `docs/maintainers/planning/features/projects/fix/pr##/`
```

**Adapted (generic):**
```markdown
**Path Detection:**

1. **Feature-Specific Structure (default):**
   - Phase paths: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
   - Fix paths: `docs/maintainers/planning/features/[feature-name]/fix/pr##/`

2. **Project-Wide Structure:**
   - Phase paths: `docs/maintainers/planning/phases/phase-N.md`
   - Fix paths: `docs/maintainers/planning/fix/pr##/`

**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect using same logic as other commands
```

**Key Changes:**
- Replaced `features/projects/` with `features/[feature-name]/`
- Added project-wide structure support
- Added consistent feature detection
- Made paths generic

---

### Example 3: `/reflect` Command

**Original (work-prod specific):**
```markdown
Status: `docs/maintainers/planning/features/projects/status-and-next-steps.md`
Reflections: `docs/maintainers/planning/features/projects/reflections/reflection-*.md`
```

**Adapted (generic):**
```markdown
**Path Detection:**

1. **Feature-Specific Structure (default):**
   - Status: `docs/maintainers/planning/features/[feature-name]/status-and-next-steps.md`
   - Reflections: `docs/maintainers/planning/features/[feature-name]/reflections/reflection-*.md`

2. **Project-Wide Structure:**
   - Status: `docs/maintainers/planning/status-and-next-steps.md` (if exists)
   - Reflections: `docs/maintainers/planning/notes/reflections/reflection-*.md`

**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for status documents in each
  - If no features exist, use project-wide structure
```

**Key Changes:**
- Replaced `features/projects/` with `features/[feature-name]/`
- Added project-wide structure support
- Added alternative reflection locations
- Made detection logic consistent

---

## ✅ Best Practices

### Common Pitfalls to Avoid

1. **Hardcoding Project Names**
   - ❌ Bad: `docs/maintainers/planning/features/projects/`
   - ✅ Good: `docs/maintainers/planning/features/[feature-name]/`

2. **Assuming Single Structure**
   - ❌ Bad: Only supporting feature-specific structure
   - ✅ Good: Supporting both feature-specific and project-wide

3. **No Fallback Logic**
   - ❌ Bad: Failing if feature structure doesn't exist
   - ✅ Good: Falling back to project-wide structure

4. **Inconsistent Detection**
   - ❌ Bad: Different detection logic in each command
   - ✅ Good: Consistent detection logic across all commands

---

### Success Factors

1. **Start with Configuration**
   - Define all paths upfront
   - Make everything configurable
   - Provide sensible defaults

2. **Consistent Pattern**
   - Use same pattern across all commands
   - Document pattern clearly
   - Follow pattern religiously

3. **Test with Different Structures**
   - Test with feature-specific structure
   - Test with project-wide structure
   - Test with mixed patterns

4. **Document Clearly**
   - Document path detection logic
   - Document feature detection logic
   - Provide examples

---

### Validation Approaches

1. **Path Validation**
   - Verify paths exist before using
   - Create paths if needed (if configured)
   - Handle missing paths gracefully

2. **Feature Validation**
   - Verify feature exists (if specified)
   - Validate feature structure
   - Handle invalid features gracefully

3. **Structure Validation**
   - Check if feature structure exists
   - Verify project-wide structure
   - Handle missing structures gracefully

---

## 🔄 Adaptation Workflow

### Step-by-Step Process

1. **Analyze Original Command**
   - Identify project-specific elements
   - List hardcoded paths
   - Note assumptions

2. **Apply Configuration Step**
   - Define generic paths
   - Make paths configurable
   - Add configuration section

3. **Apply Path Detection Step**
   - Add path detection logic
   - Support multiple patterns
   - Add fallback logic

4. **Apply Feature Detection Step**
   - Add feature detection logic
   - Support manual override
   - Handle edge cases

5. **Apply Generic Implementation Step**
   - Replace hardcoded paths with detected paths
   - Use generic patterns
   - Remove project-specific assumptions

6. **Test and Validate**
   - Test with feature-specific structure
   - Test with project-wide structure
   - Verify all paths work correctly

---

## 📖 Related Documentation

- **[Command Adaptation Guide](../admin/planning/opportunities/external/work-prod/cursor-commands/adaptations/command-adaptation-guide.md)** - General adaptation guide
- **[Command Integration Learnings](../admin/planning/opportunities/internal/dev-infra/learnings/cursor-commands-integration-learnings.md)** - Learnings from adaptation work
- **[Template Usage Guide](TEMPLATE-USAGE.md)** - How to use dev-infra templates

---

**Last Updated:** 2025-12-07  
**Status:** ✅ Active  
**Next:** Use this pattern when adapting commands for dev-infra templates

