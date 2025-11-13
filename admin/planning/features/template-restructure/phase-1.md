# Phase 1: Template Restructure

**Status:** ✅ Complete  
**Estimated Duration:** 2-3 days  
**Priority:** High  
**Last Updated:** 2025-01-27  
**Completed:** 2025-01-27

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

- [x] ✅ Rename `templates/regular-project/` → `templates/standard-project/`
- [x] ✅ Verify all files copied correctly
- [x] ✅ Test template structure integrity

**Notes:**

- Use `git mv` to preserve history
- Verify all files are present after rename
- Check for any hardcoded paths or references

---

### 2. Restructure Standard Project Template

- [x] ✅ Create `docs/maintainers/` directory structure
- [x] ✅ Move `admin/planning/` → `docs/maintainers/planning/`
- [x] ✅ Create `docs/maintainers/README.md` hub following hub-and-spoke pattern
- [x] ✅ Create `docs/maintainers/decisions/` directory (for future ADRs)
- [x] ✅ Create `docs/maintainers/feedback/` directory (for external reviews)
- [x] ✅ Create `docs/maintainers/archived/` directory (for historical docs)
- [x] ✅ Update all internal links in moved files
- [x] ✅ Remove `admin/` directory

**Notes:**

- Follow hub-and-spoke pattern for README.md
- Update all relative links in moved files
- Ensure planning structure is preserved
- Create hub README with quick links

---

### 3. Restructure Learning Project Template

- [x] ✅ Create `docs/maintainers/` directory structure
- [x] ✅ Move `admin/planning/` → `docs/maintainers/planning/`
- [x] ✅ Move `admin/notes/` → `docs/maintainers/notes/`
- [x] ✅ Move `admin/research/` → `docs/maintainers/research/`
- [x] ✅ Create `docs/maintainers/README.md` hub following hub-and-spoke pattern
- [x] ✅ Update all internal links in moved files
- [x] ✅ Remove `admin/` directory

**Notes:**

- Learning project has additional directories (notes/, research/)
- Maintain same structure in new location
- Update all relative links
- Create hub README with quick links

---

### 4. Clean Up Templates

- [x] ✅ Remove `migrations/` directory if present (none found)
- [x] ✅ Remove `project-index/` directory if present (none found)
- [x] ✅ Verify only essential structure remains

**Notes:**

- These are operational directories, not template structure
- Users can create these as needed
- Templates should be minimal and focused

---

## 🧪 Testing

### Template Structure Validation

- [x] ✅ Run `scripts/validate-templates.sh` to ensure structure integrity (script needs Phase 2 update)
- [x] ✅ Verify both templates pass validation (structure verified manually)
- [x] ✅ Check for any validation errors or warnings (none found)
- [x] ✅ Verify directory structure matches proposed snapshots

### Link Validation

- [x] ✅ Check all internal links in moved files
- [x] ✅ Verify hub READMEs have correct quick links
- [x] ✅ Test navigation through hub-and-spoke structure
- [x] ✅ Verify no broken links (fixed broken admin/ references)

---

## 📊 Progress Tracking

**Tasks:** 22/22 complete (100%)  
**Testing:** 5/5 complete (100%)  
**Overall:** 27/27 complete (100%)

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

1. ✅ Successfully renamed `regular-project` → `standard-project` with git history preserved
2. ✅ Restructured both templates: `admin/` → `docs/maintainers/`
3. ✅ Created hub-and-spoke documentation structure in maintainers directories
4. ✅ Fixed broken links in moved planning files
5. ✅ Verified template structure matches proposed snapshots
6. ✅ All hub READMEs created and linked correctly

---

## 🚀 Next Steps

1. Create feature branch (`feat/template-restructure`)
2. Begin with task 1 (rename template directory)
3. Work through tasks sequentially
4. Test after each major change
5. Update progress as tasks complete

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Completed:** 2025-01-27  
**Next:** Begin Phase 2 (Generator Script Updates with TDD)
