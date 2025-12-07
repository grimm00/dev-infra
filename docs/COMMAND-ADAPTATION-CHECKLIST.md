# Command Adaptation Checklist

**Purpose:** Actionable checklist for adapting Cursor commands between projects  
**Status:** ✅ Active  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 📋 How to Use This Checklist

1. Use this checklist when adapting a command from one project to another
2. Work through each section systematically
3. Check off items as you complete them
4. Reference [Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md) for detailed guidance
5. Use [Command Adaptation Template](COMMAND-ADAPTATION-TEMPLATE.md) as a starting point

**Related Documents:**
- **[Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md)** - Detailed pattern explanation
- **[Command Adaptation Template](COMMAND-ADAPTATION-TEMPLATE.md)** - Reusable template

---

## Step 1: Configuration

### Configuration Checklist

- [ ] **Identify project-specific paths**
  - [ ] List all hardcoded paths in original command
  - [ ] Identify base paths (e.g., `docs/maintainers/planning/features/projects/`)
  - [ ] Note any project-specific assumptions

- [ ] **Define generic paths**
  - [ ] Replace project names with `[feature-name]` or `[project-name]`
  - [ ] Create feature-specific path pattern: `docs/maintainers/planning/features/[feature-name]/`
  - [ ] Create project-wide path pattern: `docs/maintainers/planning/`
  - [ ] Document alternative path patterns if needed

- [ ] **Define naming conventions**
  - [ ] Identify hardcoded naming patterns
  - [ ] Create configurable naming format: `[pattern]-[identifier]`
  - [ ] Document default naming conventions
  - [ ] Add examples of naming patterns

- [ ] **Add Configuration section**
  - [ ] Create Configuration section in command file
  - [ ] Document path detection patterns
  - [ ] Document feature detection logic
  - [ ] Document naming conventions
  - [ ] Add configurable options

**Validation:**
- [ ] All paths are generic (no hardcoded project names)
- [ ] Path patterns support multiple organizational structures
- [ ] Naming conventions are configurable
- [ ] Configuration section is clear and complete

**Completion Criteria:**
- [ ] Configuration section added to command file
- [ ] All paths are generic and configurable
- [ ] Naming conventions documented
- [ ] Configuration section follows pattern structure

---

## Step 2: Path Detection

### Path Detection Checklist

- [ ] **Document path detection logic**
  - [ ] Add Path Detection section to command file
  - [ ] Document feature-specific structure paths
  - [ ] Document project-wide structure paths
  - [ ] Document alternative locations (if applicable)

- [ ] **Support multiple patterns**
  - [ ] Feature-specific: `docs/maintainers/planning/features/[feature-name]/[file-type].md`
  - [ ] Project-wide: `docs/maintainers/planning/[file-type].md`
  - [ ] Alternative: `docs/maintainers/planning/[category]/[file-type].md` (if configured)

- [ ] **Add detection logic**
  - [ ] Check if `docs/maintainers/planning/features/` exists
  - [ ] Use feature-specific paths if features directory exists
  - [ ] Use project-wide paths if no features directory
  - [ ] Support manual override (`--feature` option)

**Validation:**
- [ ] Path detection logic documented clearly
- [ ] Multiple organizational patterns supported
- [ ] Detection logic handles edge cases (single feature, multiple features, no features)
- [ ] Manual override option available

**Completion Criteria:**
- [ ] Path Detection section added to command file
- [ ] Multiple path patterns documented
- [ ] Detection logic clearly explained
- [ ] Edge cases handled

---

## Step 3: Feature Detection

### Feature Detection Checklist

- [ ] **Document feature detection logic**
  - [ ] Add Feature Detection section to command file
  - [ ] Document manual override (`--feature` option)
  - [ ] Document auto-detection logic
  - [ ] Document edge case handling

- [ ] **Implement auto-detection**
  - [ ] Check if `docs/maintainers/planning/features/` exists
  - [ ] If single feature exists, use that feature name
  - [ ] If multiple features exist, search for relevant files in each
  - [ ] If no features exist, use project-wide structure

- [ ] **Support manual override**
  - [ ] Add `--feature [name]` option
  - [ ] Override auto-detection when option provided
  - [ ] Validate feature name if provided

**Validation:**
- [ ] Feature detection logic documented clearly
  - [ ] Test with single feature project
  - [ ] Test with multiple feature project
  - [ ] Test with no feature structure
  - [ ] Test manual override option

**Completion Criteria:**
- [ ] Feature Detection section added to command file
- [ ] Auto-detection logic implemented
- [ ] Manual override option available
- [ ] Edge cases handled

---

## Step 4: Generic Implementation

### Generic Implementation Checklist

- [ ] **Replace hardcoded paths**
  - [ ] Find all hardcoded paths in implementation
  - [ ] Replace with detected paths from Step 2
  - [ ] Use feature name from Step 3
  - [ ] Build paths dynamically

- [ ] **Remove project-specific assumptions**
  - [ ] Identify project-specific assumptions
  - [ ] Replace with generic patterns
  - [ ] Remove hardcoded project names
  - [ ] Remove hardcoded feature names

- [ ] **Update file operations**
  - [ ] Use detected paths for file creation
  - [ ] Use detected paths for file reading
  - [ ] Use detected paths for file updates
  - [ ] Handle missing directories gracefully

- [ ] **Update workflow logic**
  - [ ] Use detected paths in workflow steps
  - [ ] Use feature detection results
  - [ ] Support both feature-specific and project-wide workflows
  - [ ] Make logic template-agnostic

**Validation:**
- [ ] All hardcoded paths replaced
  - [ ] Test with feature-specific structure
  - [ ] Test with project-wide structure
  - [ ] Test with different feature names
  - [ ] Verify file operations work correctly

**Completion Criteria:**
- [ ] Implementation uses detected paths
- [ ] No hardcoded project-specific assumptions
- [ ] File operations work with both structures
- [ ] Workflow logic is generic

---

## Overall Validation

### Overall Validation Checklist

- [ ] **Path validation**
  - [ ] All paths are generic (no hardcoded project names)
  - [ ] Path detection works for feature-specific structure
  - [ ] Path detection works for project-wide structure
  - [ ] Path detection handles edge cases

- [ ] **Feature detection validation**
  - [ ] Auto-detection works for single feature
  - [ ] Auto-detection works for multiple features
  - [ ] Auto-detection works for no features
  - [ ] Manual override works correctly

- [ ] **Implementation validation**
  - [ ] Command works with feature-specific structure
  - [ ] Command works with project-wide structure
  - [ ] File operations work correctly
  - [ ] Workflow produces expected outputs

- [ ] **Documentation validation**
  - [ ] Configuration section is complete
  - [ ] Path Detection section is complete
  - [ ] Feature Detection section is complete
  - [ ] Implementation is documented clearly

**Validation Steps:**

1. **Test with feature-specific structure:**
   ```bash
   # Create test feature structure
   mkdir -p docs/maintainers/planning/features/test-feature
   
   # Run command with feature-specific structure
   # Verify paths are correct
   ```

2. **Test with project-wide structure:**
   ```bash
   # Remove features directory
   rm -rf docs/maintainers/planning/features
   
   # Run command with project-wide structure
   # Verify paths are correct
   ```

3. **Test with manual override:**
   ```bash
   # Run command with --feature option
   # Verify feature name is used correctly
   ```

4. **Test file operations:**
   ```bash
   # Run command to create/update files
   # Verify files are created in correct locations
   # Verify file contents are correct
   ```

**Completion Criteria:**
- [ ] All validation tests pass
- [ ] Command works with both structures
- [ ] File operations work correctly
- [ ] Documentation is complete

---

## Completion Criteria

### Overall Completion Checklist

- [ ] **Configuration complete**
  - [ ] Configuration section added
  - [ ] All paths are generic
  - [ ] Naming conventions documented

- [ ] **Path Detection complete**
  - [ ] Path Detection section added
  - [ ] Multiple patterns supported
  - [ ] Detection logic implemented

- [ ] **Feature Detection complete**
  - [ ] Feature Detection section added
  - [ ] Auto-detection implemented
  - [ ] Manual override available

- [ ] **Generic Implementation complete**
  - [ ] Hardcoded paths replaced
  - [ ] Project-specific assumptions removed
  - [ ] File operations updated
  - [ ] Workflow logic is generic

- [ ] **Validation complete**
  - [ ] Path validation passed
  - [ ] Feature detection validation passed
  - [ ] Implementation validation passed
  - [ ] Documentation validation passed

- [ ] **Documentation complete**
  - [ ] Command file updated
  - [ ] All sections documented
  - [ ] Examples included
  - [ ] Related documents linked

**Final Checklist:**

- [ ] Command adapted for target project
- [ ] All hardcoded paths replaced
- [ ] All project-specific assumptions removed
- [ ] Command works with both feature-specific and project-wide structures
- [ ] Validation tests pass
- [ ] Documentation is complete
- [ ] Ready for use in target project

---

## Tips and Best Practices

### Tips for Successful Adaptation

1. **Start with Configuration**
   - Define all paths upfront
   - Make everything configurable
   - Provide sensible defaults

2. **Follow the Pattern**
   - Use the same pattern across all commands
   - Document pattern clearly
   - Follow pattern religiously

3. **Test Thoroughly**
   - Test with feature-specific structure
   - Test with project-wide structure
   - Test with different feature names
   - Test edge cases

4. **Document Clearly**
   - Document path detection logic
   - Document feature detection logic
   - Provide examples
   - Link to related documents

### Common Pitfalls to Avoid

- ❌ **Hardcoding project names** - Always use generic paths
- ❌ **Assuming single structure** - Support multiple patterns
- ❌ **No fallback logic** - Always provide fallbacks
- ❌ **Inconsistent detection** - Use same logic across commands
- ❌ **Skipping validation** - Always validate adaptations

### Success Factors

- ✅ **Clear configuration** - Define paths upfront
- ✅ **Consistent pattern** - Use same pattern everywhere
- ✅ **Thorough testing** - Test all scenarios
- ✅ **Complete documentation** - Document everything clearly

---

## Related Documentation

- **[Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md)** - Detailed pattern explanation
- **[Command Adaptation Template](COMMAND-ADAPTATION-TEMPLATE.md)** - Reusable template
- **[Phase Document Template](PHASE-DOCUMENT-TEMPLATE.md)** - Template for phase documents

---

**Last Updated:** 2025-12-07  
**Status:** ✅ Active  
**Next:** Use this checklist when adapting commands for dev-infra templates

