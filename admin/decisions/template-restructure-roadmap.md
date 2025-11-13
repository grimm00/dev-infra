# Template Restructure Migration Roadmap

**Purpose:** Detailed implementation plan for template restructure (admin/ → docs/maintainers/)  
**Status:** 🟡 Planned  
**Created:** 2025-01-27  
**Last Updated:** 2025-01-27  
**Related ADR:** [0001: Template Restructure](0001-template-restructure.md)

---

## 📋 Quick Links

### Core Documents
- **[ADR 0001](0001-template-restructure.md)** - Architecture decision record
- **[Comprehensive Analysis](../research/template-restructure-comprehensive-analysis.md)** - Research and rationale
- **[Structure Snapshots](../research/structure-snapshots/)** - Current and proposed structures

### Implementation Phases
- **[Phase 1: Template Restructure](#phase-1-template-restructure)** - Core restructuring
- **[Phase 2: Documentation Updates](#phase-2-documentation-updates)** - Documentation alignment
- **[Phase 3: Main Repo Consideration](#phase-3-main-repo-consideration)** - Future evaluation

---

## 🎯 Overview

This roadmap outlines the migration from `admin/` to `docs/maintainers/` in templates, renaming `regular-project` to `standard-project`, and updating all related documentation and tooling.

### Goals

1. Restructure templates to use `docs/maintainers/` instead of `admin/`
2. Rename `regular-project` template to `standard-project`
3. Maintain hub-and-spoke documentation patterns
4. Update all documentation and tooling references
5. Ensure backward compatibility where possible

---

## 🎯 Success Criteria

- [ ] Both templates restructured with `docs/maintainers/` structure
- [ ] Template renamed from `regular-project` to `standard-project`
- [ ] Generator script updated to reference `standard-project`
- [ ] All documentation updated with new structure
- [ ] Hub-and-spoke pattern maintained in new structure
- [ ] Template generation tested and verified
- [ ] Migration guide created for existing projects (if needed)

**Progress:** 0/7 complete (0%)

---

## 🚫 Out of Scope

**Excluded from this migration:**
- ❌ Main repo `admin/` → `docs/maintainers/` migration (deferred to Phase 3)
- ❌ Changes to template functionality (only structure changes)
- ❌ Breaking changes to existing projects (migration guide provided)

---

## 📅 Implementation Phases

### Phase 1: Template Restructure

**Status:** 🔴 Not Started  
**Estimated Duration:** 2-3 days  
**Priority:** High

#### Tasks

1. **Rename Template Directory**
   - [ ] Rename `templates/regular-project/` → `templates/standard-project/`
   - [ ] Verify all files copied correctly
   - [ ] Test template structure integrity

2. **Restructure Standard Project Template**
   - [ ] Create `docs/maintainers/` directory structure
   - [ ] Move `admin/planning/` → `docs/maintainers/planning/`
   - [ ] Create `docs/maintainers/README.md` hub following hub-and-spoke pattern
   - [ ] Create `docs/maintainers/decisions/` directory (for future ADRs)
   - [ ] Create `docs/maintainers/feedback/` directory (for external reviews)
   - [ ] Create `docs/maintainers/archived/` directory (for historical docs)
   - [ ] Update all internal links in moved files
   - [ ] Remove `admin/` directory

3. **Restructure Learning Project Template**
   - [ ] Create `docs/maintainers/` directory structure
   - [ ] Move `admin/planning/` → `docs/maintainers/planning/`
   - [ ] Move `admin/notes/` → `docs/maintainers/notes/`
   - [ ] Move `admin/research/` → `docs/maintainers/research/`
   - [ ] Create `docs/maintainers/README.md` hub following hub-and-spoke pattern
   - [ ] Update all internal links in moved files
   - [ ] Remove `admin/` directory

4. **Update Generator Script**
   - [ ] Update `scripts/new-project.sh` line 651: `template_type="regular-project"` → `template_type="standard-project"`
   - [ ] Update template menu/selection logic if needed
   - [ ] Test script with new template name

5. **Clean Up Templates**
   - [ ] Remove `migrations/` directory if present
   - [ ] Remove `project-index/` directory if present
   - [ ] Verify only essential structure remains

#### Testing

- [ ] Run `scripts/new-project.sh` with `standard-project` template
- [ ] Verify generated project has `docs/maintainers/` structure
- [ ] Verify all hub READMEs are present and correct
- [ ] Verify all links work correctly
- [ ] Test with `learning-project` template
- [ ] Run `scripts/validate-templates.sh` to ensure structure integrity

#### Success Criteria

- ✅ Both templates use `docs/maintainers/` structure
- ✅ Template renamed to `standard-project`
- ✅ Generator script works with new structure
- ✅ All hub-and-spoke patterns maintained
- ✅ No broken links or missing files

---

### Phase 2: Documentation Updates

**Status:** 🔴 Not Started  
**Estimated Duration:** 1-2 days  
**Priority:** High

#### Tasks

1. **Update Template READMEs**
   - [ ] Update `templates/standard-project/README.md` with new structure
   - [ ] Update `templates/learning-project/README.md` with new structure
   - [ ] Update structure diagrams/examples

2. **Update Project Documentation**
   - [ ] Update `docs/BEST-PRACTICES.md` with new structure examples
   - [ ] Update `docs/TEMPLATE-USAGE.md` with new structure references
   - [ ] Update `docs/PROJECT-TYPES.md` with renamed template
   - [ ] Update main `README.md` with new template name

3. **Update Admin Documentation**
   - [ ] Update `admin/README.md` if it references templates
   - [ ] Update planning documents that reference template structure

4. **Create Migration Guide** (if needed)
   - [ ] Document migration steps for existing projects
   - [ ] Create migration script or instructions
   - [ ] Add to `docs/` or appropriate location

#### Testing

- [ ] Verify all documentation links work
- [ ] Check for any remaining references to `regular-project`
- [ ] Check for any remaining references to `admin/` in template context
- [ ] Review documentation for consistency

#### Success Criteria

- ✅ All documentation updated with new structure
- ✅ No broken links in documentation
- ✅ Migration guide available (if needed)
- ✅ Consistent terminology throughout

---

### Phase 3: Main Repo Consideration (Optional, Future)

**Status:** 🔴 Not Started  
**Estimated Duration:** TBD  
**Priority:** Low

#### Tasks

1. **Evaluate Main Repo Structure**
   - [ ] Assess impact of moving main repo `admin/` → `docs/maintainers/`
   - [ ] Review existing workflows and dependencies
   - [ ] Consider team preferences and established patterns

2. **Decision Point**
   - [ ] Make decision based on evaluation
   - [ ] Document decision in ADR if proceeding
   - [ ] Create separate roadmap if proceeding

#### Notes

- This phase is optional and deferred
- Main repo structure is working well as-is
- Can be evaluated separately from template restructure
- No timeline set

---

## 📊 Timeline Estimate

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| Phase 1: Template Restructure | 2-3 days | None |
| Phase 2: Documentation Updates | 1-2 days | Phase 1 complete |
| Phase 3: Main Repo Consideration | TBD | Optional, future |

**Total Estimated Duration:** 3-5 days (Phases 1-2)

---

## ⚠️ Risk Assessment

### High Risk

- **Breaking Changes:** Existing projects using templates may need updates
  - **Mitigation:** Create migration guide, maintain backward compatibility where possible
  - **Impact:** Medium (affects existing projects)

### Medium Risk

- **Documentation Gaps:** Some references may be missed
  - **Mitigation:** Comprehensive review, automated link checking
  - **Impact:** Low (can be fixed incrementally)

- **Generator Script Issues:** Script may have issues with new structure
  - **Mitigation:** Thorough testing, validation scripts
  - **Impact:** Medium (blocks template generation)

### Low Risk

- **Link Updates:** Internal links in moved files may break
  - **Mitigation:** Automated link checking, manual review
  - **Impact:** Low (easy to fix)

---

## 🧪 Testing Strategy

### Unit Testing

- [ ] Template structure validation (`scripts/validate-templates.sh`)
- [ ] Generator script functionality
- [ ] Link validation in moved files

### Integration Testing

- [ ] End-to-end template generation
- [ ] Generated project structure verification
- [ ] Documentation link checking

### Regression Testing

- [ ] Verify existing functionality still works
- [ ] Test with both template types
- [ ] Verify hub-and-spoke patterns maintained

---

## 🔄 Rollback Plan

If issues arise during implementation:

1. **Immediate Rollback:**
   - Revert template directory rename
   - Restore `admin/` directories
   - Revert generator script changes

2. **Partial Rollback:**
   - Keep completed phases
   - Fix issues in current phase
   - Continue with remaining phases

3. **Documentation:**
   - Document issues encountered
   - Update roadmap with lessons learned
   - Revise approach if needed

---

## 📚 References

### Research Documents
- [Comprehensive Analysis](../research/template-restructure-comprehensive-analysis.md)
- [Template Structure Options](../research/template-structure-options.md)
- [Pre-ADR Proposal](../research/0001-template-restructure-proposal.md)

### Structure Snapshots
- [Current Regular Project](../research/structure-snapshots/regular-project.tree.txt)
- [Current Learning Project](../research/structure-snapshots/learning-project.tree.txt)
- [Proposed Standard Project](../research/structure-snapshots/standard-project-proposed.tree.txt)
- [Proposed Learning Project](../research/structure-snapshots/learning-project-proposed.tree.txt)
- [Main Dev-Infra Project](../research/structure-snapshots/dev-infra-main.tree.txt)

### Best Practices
- [Best Practices Guide](../../docs/BEST-PRACTICES.md)
- [Hub-and-Spoke Guide](../notes/examples/hub-and-spoke-documentation-best-practices.md)

---

## 🎊 Key Achievements

(To be updated as phases complete)

---

## 🚀 Next Steps

1. **Review & Approval:** Get stakeholder approval for roadmap
2. **Create Feature Branch:** Create `feat/template-restructure` branch
3. **Begin Phase 1:** Start template restructure implementation
4. **Regular Updates:** Update this roadmap as progress is made

---

**Last Updated:** 2025-01-27  
**Status:** 🟡 Planned  
**Next:** Review and approval, then begin Phase 1

