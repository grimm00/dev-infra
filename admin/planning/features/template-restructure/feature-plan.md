# Template Restructure Feature Plan

**Purpose:** High-level implementation plan for template restructure feature  
**Status:** 🟡 Planned  
**Last Updated:** 2025-01-27

---

## 🎯 Feature Description

Restructure dev-infra templates to move maintainer documentation from `admin/` to `docs/maintainers/`, rename `regular-project` to `standard-project`, and update all related tooling and documentation. This improves clarity, aligns with industry standards, and maintains the hub-and-spoke documentation pattern.

---

## 🔍 User Problem

Current template structure has several issues:

1. **Mixed Audience Signals:** `admin/` name doesn't clearly indicate it's for project maintainers/planners
2. **Inconsistent with Industry:** `docs/` is the universally recognized location for documentation
3. **User Confusion:** Template consumers may not understand `admin/` is for their own project planning
4. **Naming Ambiguity:** "regular-project" is vague; "standard-project" is clearer

---

## ✅ Success Criteria

1. **Templates Restructured:** Both templates use `docs/maintainers/` structure
2. **Template Renamed:** `regular-project` → `standard-project`
3. **Hub-and-Spoke Maintained:** All documentation patterns preserved
4. **Generator Updated:** Script works with new template name
5. **Documentation Updated:** All references updated to new structure
6. **No Broken Links:** All internal links work correctly
7. **Testing Complete:** Template generation verified and working

**Progress:** 0/7 complete (0%)

---

## 🚫 Out of Scope

**Excluded from this feature:**
- ❌ Main repo `admin/` → `docs/maintainers/` migration (deferred to Phase 3)
- ❌ Changes to template functionality (only structure changes)
- ❌ Breaking changes to existing projects (migration guide provided)

---

## 📋 Implementation Phases

### Phase 1: Template Restructure
- Rename template directory
- Restructure both templates (admin/ → docs/maintainers/)
- Update generator script
- Clean up templates
- Testing and validation

### Phase 2: Documentation Updates
- Update template READMEs
- Update project documentation
- Update admin documentation
- Create migration guide (if needed)

### Phase 3: Main Repo Consideration (Optional, Future)
- Evaluate main repo structure
- Make decision based on evaluation

---

## 🔗 Dependencies

- **Research Complete:** Comprehensive analysis and ADR approved
- **Roadmap Created:** Detailed migration roadmap available
- **Structure Snapshots:** Current and proposed structures documented

---

## ⏱️ Timeline Estimate

- **Phase 1:** 2-3 days
- **Phase 2:** 1-2 days
- **Total:** 3-5 days (Phases 1-2)

---

## 📚 Related Documents

- **[Migration Roadmap](../../decisions/template-restructure-roadmap.md)** - Detailed implementation plan
- **[ADR 0001](../../decisions/0001-template-restructure.md)** - Architecture decision
- **[Comprehensive Analysis](../../research/template-restructure-comprehensive-analysis.md)** - Research and rationale
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress
- **[Phase 1 Plan](phase-1.md)** - Detailed Phase 1 tasks

---

## 🎊 Key Achievements

(To be updated as phases complete)

---

## 🚀 Next Steps

1. Review Phase 1 plan
2. Create feature branch (`feat/template-restructure`)
3. Begin Phase 1 implementation
4. Update status as progress is made

---

**Last Updated:** 2025-01-27  
**Status:** 🟡 Planned  
**Next:** Begin Phase 1 implementation

