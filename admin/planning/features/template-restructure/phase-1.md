# Phase 1: Template Restructure

**Status:** 🔴 Not Started  
**Estimated Duration:** 2-3 days  
**Priority:** High  
**Last Updated:** 2025-01-27

---

## 📋 Overview

Phase 1 focuses on the core template restructure: renaming the template, moving maintainer documentation from `admin/` to `docs/maintainers/`, updating the generator script, and ensuring all changes are tested and validated.

---

## 🎯 Success Criteria

- ✅ Both templates use `docs/maintainers/` structure
- ✅ Template renamed to `standard-project`
- ✅ Generator script works with new structure
- ✅ All hub-and-spoke patterns maintained
- ✅ No broken links or missing files
- ✅ Template generation tested and verified

---

## 📅 Tasks

### 1. Rename Template Directory

- [ ] Rename `templates/regular-project/` → `templates/standard-project/`
- [ ] Verify all files copied correctly
- [ ] Test template structure integrity

**Notes:**
- Use `git mv` to preserve history
- Verify all files are present after rename
- Check for any hardcoded paths or references

---

### 2. Restructure Standard Project Template

- [ ] Create `docs/maintainers/` directory structure
- [ ] Move `admin/planning/` → `docs/maintainers/planning/`
- [ ] Create `docs/maintainers/README.md` hub following hub-and-spoke pattern
- [ ] Create `docs/maintainers/decisions/` directory (for future ADRs)
- [ ] Create `docs/maintainers/feedback/` directory (for external reviews)
- [ ] Create `docs/maintainers/archived/` directory (for historical docs)
- [ ] Update all internal links in moved files
- [ ] Remove `admin/` directory

**Notes:**
- Follow hub-and-spoke pattern for README.md
- Update all relative links in moved files
- Ensure planning structure is preserved
- Create hub README with quick links

---

### 3. Restructure Learning Project Template

- [ ] Create `docs/maintainers/` directory structure
- [ ] Move `admin/planning/` → `docs/maintainers/planning/`
- [ ] Move `admin/notes/` → `docs/maintainers/notes/`
- [ ] Move `admin/research/` → `docs/maintainers/research/`
- [ ] Create `docs/maintainers/README.md` hub following hub-and-spoke pattern
- [ ] Update all internal links in moved files
- [ ] Remove `admin/` directory

**Notes:**
- Learning project has additional directories (notes/, research/)
- Maintain same structure in new location
- Update all relative links
- Create hub README with quick links

---

### 4. Update Generator Script

- [ ] Update `scripts/new-project.sh` line 651: `template_type="regular-project"` → `template_type="standard-project"`
- [ ] Update template menu/selection logic if needed
- [ ] Test script with new template name

**Notes:**
- Check for all references to "regular-project"
- Verify template selection menu works
- Test script execution end-to-end

---

### 5. Clean Up Templates

- [ ] Remove `migrations/` directory if present
- [ ] Remove `project-index/` directory if present
- [ ] Verify only essential structure remains

**Notes:**
- These are operational directories, not template structure
- Users can create these as needed
- Templates should be minimal and focused

---

## 🧪 Testing

### Template Structure Validation

- [ ] Run `scripts/validate-templates.sh` to ensure structure integrity
- [ ] Verify both templates pass validation
- [ ] Check for any validation errors or warnings

### Template Generation Testing

- [ ] Run `scripts/new-project.sh` with `standard-project` template
- [ ] Verify generated project has `docs/maintainers/` structure
- [ ] Verify all hub READMEs are present and correct
- [ ] Verify all links work correctly
- [ ] Test with `learning-project` template
- [ ] Verify generated project structure matches expected

### Link Validation

- [ ] Check all internal links in moved files
- [ ] Verify hub READMEs have correct quick links
- [ ] Test navigation through hub-and-spoke structure
- [ ] Verify no broken links

---

## 📊 Progress Tracking

**Tasks:** 0/25 complete (0%)  
**Testing:** 0/11 complete (0%)  
**Overall:** 0/36 complete (0%)

---

## 🔗 Dependencies

- None - Phase 1 is self-contained

---

## ⚠️ Risks & Mitigation

### High Risk

- **Broken Links:** Internal links may break during move
  - **Mitigation:** Update all links as part of move process, validate after

### Medium Risk

- **Generator Script Issues:** Script may have issues with new template name
  - **Mitigation:** Thorough testing, check all references

### Low Risk

- **File Permissions:** File permissions should be preserved
  - **Mitigation:** Use `git mv` to preserve metadata

---

## 📚 Related Documents

- **[Feature Plan](feature-plan.md)** - High-level plan
- **[Status & Next Steps](status-and-next-steps.md)** - Current status
- **[Migration Roadmap](../../decisions/template-restructure-roadmap.md)** - Complete roadmap
- **[ADR 0001](../../decisions/0001-template-restructure.md)** - Architecture decision
- **[Structure Snapshots](../../research/structure-snapshots/)** - Proposed structures

---

## 🎊 Key Achievements

(To be updated as tasks complete)

---

## 🚀 Next Steps

1. Create feature branch (`feat/template-restructure`)
2. Begin with task 1 (rename template directory)
3. Work through tasks sequentially
4. Test after each major change
5. Update progress as tasks complete

---

**Last Updated:** 2025-01-27  
**Status:** 🔴 Not Started  
**Next:** Create feature branch and begin implementation

