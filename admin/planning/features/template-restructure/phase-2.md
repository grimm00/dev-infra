# Phase 2: Generator Script Updates (TDD)

**Status:** ✅ Complete  
**Estimated Duration:** 1-2 days  
**Priority:** High  
**Last Updated:** 2025-01-27  
**Completed:** 2025-01-27

---

## 📋 Overview

Phase 2 focuses on updating the generator script to work with the new `standard-project` template name. This phase uses a **Test-Driven Development (TDD)** approach: write tests first, then update the script to make tests pass. This ensures the script changes are well-tested and properly validated.

---

## 🎯 Success Criteria

- ✅ Tests written for new template name functionality
- ✅ Generator script updated to use `standard-project`
- ✅ All tests pass
- ✅ Template generation works with new template name
- ✅ Both template types (standard-project, learning-project) work correctly
- ✅ Error handling works for invalid template names
- ✅ Integration tests verify end-to-end functionality

---

## 🧪 TDD Approach

### Test-First Development

1. **Write Tests First:**
   - Test template name selection logic
   - Test template path resolution
   - Test template structure validation
   - Test error handling for invalid names
   - Test both template types

2. **Update Script:**
   - Make tests pass
   - Refactor as needed
   - Ensure all existing tests still pass

3. **Integration Testing:**
   - End-to-end template generation
   - Verify new structure works
   - Test both template types

---

## 📅 Tasks

### 1. Write Tests for Template Name Changes

- [x] ✅ Create test for `standard-project` template selection
- [x] ✅ Create test for template path resolution with new name
- [x] ✅ Create test for template validation with new name
- [x] ✅ Create test for error handling (invalid template name)
- [x] ✅ Create test for menu/selection logic (covered in template structure tests)
- [x] ✅ Ensure existing tests still pass

**Notes:**
- Use BATS testing framework (existing test infrastructure)
- Test both positive and negative cases
- Mock external dependencies as needed
- Follow existing test patterns

---

### 2. Update Generator Script

- [x] ✅ Update `scripts/new-project.sh` line 651: `template_type="regular-project"` → `template_type="standard-project"`
- [x] ✅ Search for all references to "regular-project" in script
- [x] ✅ Update template menu/selection logic if needed
- [x] ✅ Update any hardcoded template paths
- [x] ✅ Update template validation logic if needed (validate-templates.sh)
- [x] ✅ Ensure backward compatibility considerations

**Notes:**
- Check for all references to "regular-project"
- Verify template selection menu works
- Update any comments or documentation in script
- Maintain existing functionality for learning-project

---

### 3. Run Tests and Fix Issues

- [x] ✅ Run all BATS tests
- [x] ✅ Fix any failing tests
- [x] ✅ Ensure all tests pass (63 tests passing)
- [x] ✅ Verify no regressions in existing functionality
- [x] ✅ Update tests if needed based on implementation

**Notes:**
- Run full test suite
- Check for any test failures
- Fix issues iteratively
- Document any test changes

---

### 4. Integration Testing

- [x] ✅ Test template generation with `standard-project` template (copy_template tests)
- [x] ✅ Verify generated project has correct structure (template structure tests)
- [x] ✅ Test template generation with `learning-project` template (copy_template tests)
- [x] ✅ Verify both templates work correctly (template structure tests)
- [x] ✅ Test error cases (invalid template name, missing template) (copy_template tests)
- [x] ✅ Verify user experience (prompts, messages) (show_next_steps tests)

**Notes:**
- End-to-end testing
- Manual testing of script execution
- Verify generated project structure
- Check user-facing messages

---

## 🧪 Testing Strategy

### Unit Tests (BATS)

- Template name selection
- Template path resolution
- Template validation
- Error handling
- Menu/selection logic

### Integration Tests

- End-to-end template generation
- Generated project structure verification
- Both template types
- Error scenarios

### Manual Testing

- Script execution flow
- User prompts and messages
- Generated project validation
- Edge cases

---

## 📊 Progress Tracking

**Tasks:** 15/15 complete (100%)  
**Testing:** 8/8 complete (100%)  
**Overall:** 23/23 complete (100%)

---

## 🔗 Dependencies

- **Phase 1 Complete:** Template structure must be restructured first
- **Test Infrastructure:** BATS framework available
- **Existing Tests:** Current test suite as baseline

---

## ⚠️ Risks & Mitigation

### High Risk

- **Test Infrastructure Issues:** Tests may need updates for new approach
  - **Mitigation:** Review existing test patterns, adapt as needed

### Medium Risk

- **Breaking Changes:** Script changes may affect existing functionality
  - **Mitigation:** Comprehensive testing, ensure all tests pass

### Low Risk

- **Template Name Conflicts:** No conflicts expected
  - **Mitigation:** Template renamed, no overlap

---

## 📚 Related Documents

- **[Feature Plan](feature-plan.md)** - High-level plan
- **[Phase 1: Template Restructure](phase-1.md)** - Structure changes (prerequisite)
- **[Phase 3: Documentation Updates](phase-3.md)** - Documentation updates
- **[Status & Next Steps](status-and-next-steps.md)** - Current status
- **[Migration Roadmap](../../decisions/template-restructure-roadmap.md)** - Complete roadmap
- **[ADR 0001](../../decisions/0001-template-restructure.md)** - Architecture decision

---

## 🎊 Key Achievements

1. ✅ Successfully updated generator script to use `standard-project`
2. ✅ Updated validate-templates.sh for new template name and structure
3. ✅ Comprehensive test suite: 63 tests organized by behavior/specification
4. ✅ Added tests for all functions (copy_template, customize_project, verify_github_auth, init_git_repo, show_next_steps)
5. ✅ Merged sed-portability.bats into customize_project tests
6. ✅ All tests passing with TDD approach
7. ✅ Tests organized by behavior (not script order) for better maintainability

---

## 🚀 Next Steps

1. Wait for Phase 1 completion
2. Review existing test infrastructure
3. Write tests for template name changes
4. Update generator script
5. Run tests and fix issues
6. Integration testing

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Completed:** 2025-01-27  
**Dependencies:** Phase 1 complete ✅  
**Next:** Begin Phase 3 (Documentation Updates)

