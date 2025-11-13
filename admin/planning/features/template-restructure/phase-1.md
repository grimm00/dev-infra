# Phase 1: Template Restructure

**Status:** 🔴 Not Started  
**Estimated Duration:** 2-3 days  
**Priority:** High  
**Last Updated:** 2025-01-27

---

## 📋 Overview

Phase 1 focuses solely on template structure changes: renaming the template directory, moving maintainer documentation from `admin/` to `docs/maintainers/` in both templates, and cleaning up templates. No code changes are included in this phase - generator script updates are handled in Phase 2.

---

## 🎯 Success Criteria

- ✅ Both templates use `docs/maintainers/` structure
- ✅ Template renamed to `standard-project`
- ✅ All hub-and-spoke patterns maintained
- ✅ No broken links or missing files
- ✅ Template structure validated
- ✅ All internal links updated correctly

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

### 4. Clean Up Templates

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
- [ ] Verify directory structure matches proposed snapshots

### Link Validation

- [ ] Check all internal links in moved files
- [ ] Verify hub READMEs have correct quick links
- [ ] Test navigation through hub-and-spoke structure
- [ ] Verify no broken links

---

## 📊 Progress Tracking

**Tasks:** 0/22 complete (0%)  
**Testing:** 0/5 complete (0%)  
**Overall:** 0/27 complete (0%)

---

## 🔗 Dependencies

- None - Phase 1 is self-contained

---

## ⚠️ Risks & Mitigation

### High Risk

- **Broken Links:** Internal links may break during move
  - **Mitigation:** Update all links as part of move process, validate after

### Low Risk

- **File Permissions:** File permissions should be preserved
  - **Mitigation:** Use `git mv` to preserve metadata

---

## 📚 Related Documents

- **[Feature Plan](feature-plan.md)** - High-level plan
- **[Phase 2: Generator Script Updates](phase-2.md)** - Code changes with TDD
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

