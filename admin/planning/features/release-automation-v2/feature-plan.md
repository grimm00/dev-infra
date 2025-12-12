# Release Automation v2 - Feature Plan

**Feature:** Release Automation v2  
**Status:** 🟡 Planned  
**Category:** 🔧 Internal Tooling  
**Priority:** 🔴 High  
**Target Release:** v1.5.0  
**Created:** 2025-12-11  
**Source:** v1.4.0 Release Retrospective and Reflection  
**Scope:** Internal only (per [ADR-002](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md))

---

## 📋 Overview

Complete the release automation system by eliminating the remaining manual steps discovered during the v1.4.0 release cycle. This feature groups three related improvements into a cohesive release automation enhancement.

**Problem Statement:**

v1.4.0 introduced excellent release automation (`/release-prep`, `/release-finalize`, `/post-release`), but revealed gaps:

1. **Tag creation is manual** - After PR merge, must run `git tag` and `git push` manually
2. **Version references need manual updates** - Must grep and update version strings across codebase
3. **Templates don't have release automation** - Generated projects miss these benefits

**Solution:**

Three phased improvements that together deliver **zero-manual releases**.

---

## 🎯 Goals

### Primary Goals

1. **Eliminate Manual Tag Creation**
   - GitHub Actions workflow to auto-create tags on release PR merge
   - Consistent tag format and annotations
   - Triggers existing release distribution workflow

2. **Automate Version Reference Updates**
   - Script to update all known version locations
   - Integration with `/release-finalize`
   - Validation to ensure updates successful

3. **Extend Automation to Templates**
   - Add release scripts to templates
   - Add release commands to templates
   - Ensure generated projects can use full workflow

### Stretch Goals

- Release metrics dashboard (visualize historical data)
- CHANGELOG incremental updates during development
- Release automation for learning-project template

---

## 🎯 Success Criteria

### Must Have (MVP) - Updated per ADR-002

- [ ] Tags created automatically when release PRs merge to main
- [ ] Version references updated automatically by `/release-finalize`
- [x] ~~Standard-project template includes release automation~~ ❌ Deferred
- [ ] v1.5.0 released using the new automation
- [ ] Documentation updated for all changes

**Note:** Template integration (Phase 3) deferred per identity decision

### Should Have

- [ ] Dry-run mode for all automation
- [ ] Validation/verification of all automated steps
- [ ] Error handling and clear error messages
- [ ] Template validation tests for release components

### Nice to Have

- [ ] Learning-project template gets release automation
- [ ] Release metrics visualization
- [ ] Incremental CHANGELOG updates during development

---

## 📅 Implementation Phases

### Phase 1: Tag Creation Automation (2-4 hours)

**Goal:** Eliminate manual tag creation

**Deliverables:**
- `.github/workflows/create-release-tag.yml`
- Version extraction from branch name
- Annotated tag creation
- Dry-run testing mode
- Documentation updates

**Details:** See [phase-1.md](phase-1.md)

---

### Phase 2: Version Reference Automation (3-5 hours)

**Goal:** Eliminate manual version scanning and updates

**Deliverables:**
- `scripts/update-version-references.sh`
- Integration with `/release-finalize`
- Known locations documentation
- Validation of updates
- Dry-run mode

**Details:** See [phase-2.md](phase-2.md)

---

### Phase 3: Template Integration ❌ DEFERRED

**Status:** ⏸️ Deferred per [ADR-002](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md)

**Reason:** Conflicts with template factory identity (ADR-001). Release automation is internal tooling that should not be templatized without meeting graduation criteria.

**Original Scope (preserved for future reference):**
- Release scripts in standard-project template
- Release commands in template `.cursor/commands/`
- Path detection for template structure
- Template validation tests
- Documentation updates

**Reconsideration:** v1.6.0+ after graduation criteria met

**Details:** See [phase-3.md](phase-3.md) (marked as deferred)

---

## 📊 Effort Estimates

| Phase | Estimated | Dependencies | Status |
|-------|-----------|--------------|--------|
| Phase 1: Tag Creation | 2-4 hours | None | 🟡 Planned |
| Phase 2: Version References | 3-5 hours | None | 🟡 Planned |
| Phase 3: Template Integration | ~~8-13 hours~~ | ~~Phase 1 & 2~~ | ❌ Deferred |
| **Total (v1.5.0)** | **5-9 hours** | | |

**v1.5.0 Scope (per ADR-002):**
- ✅ Phase 1 & 2: Internal tooling only
- ❌ Phase 3: Deferred (doesn't align with template factory identity)

**Recommended Approach:**
- Phase 1 & 2 can be done in parallel (no dependencies)
- Phase 3 deferred to v1.6.0+ pending graduation criteria

---

## 🚨 Risks & Mitigations

### Risk 1: Tag Creation Workflow Complexity

**Risk:** GitHub Actions workflow may have edge cases  
**Impact:** Tags created incorrectly or not at all  
**Mitigation:**
- Comprehensive testing with dry-run mode
- Test with mock release PRs before v1.5.0
- Clear error messages and validation

### Risk 2: Version Reference Locations Change

**Risk:** New version references added that script doesn't know about  
**Impact:** Manual updates still needed  
**Mitigation:**
- Document all known locations
- Add easy configuration to add new locations
- Periodic audits of version references

### Risk 3: Template Path Detection

**Risk:** Commands may not work in template structure  
**Impact:** Generated projects can't use release automation  
**Mitigation:**
- Comprehensive path detection testing
- Test in actual generated project
- Clear documentation of path expectations

---

## 📈 Expected Benefits

### Quantitative

| Metric | Current | Target | Improvement |
|--------|---------|--------|-------------|
| Manual steps per release | 3-4 | 0 | 100% reduction |
| Time for tag creation | 5-10 mins | 0 | 100% reduction |
| Time for version updates | 15-20 mins | 0 | 100% reduction |
| Template users with automation | 0 | All | ∞ improvement |

### Qualitative

- **Confidence:** Automated steps reduce human error
- **Consistency:** Every release follows same process
- **Velocity:** Faster releases, more frequent if needed
- **Value:** Templates significantly more valuable

---

## 🔗 Related

**Source Documents:**
- `admin/planning/releases/v1.4.0/retrospective.md` - Identified gaps
- `admin/planning/notes/reflections/reflection-v1.4.0-release-cycle-2025-12-11.md` - Detailed analysis

**Foundation (v1.4.0):**
- `admin/planning/features/release-readiness/` - Original feature
- `scripts/check-release-readiness.sh` - Assessment script
- `scripts/create-release-branch.sh` - Branch creation
- `scripts/analyze-releases.sh` - Historical tracking

**Commands:**
- `.cursor/commands/release-prep.md`
- `.cursor/commands/release-finalize.md`
- `.cursor/commands/post-release.md`

---

## 📝 Notes

### Why Group These Improvements?

1. **Same Goal:** All three close gaps in release automation
2. **Same Release:** All target v1.5.0
3. **Related Workflow:** All part of release process
4. **Better Story:** "Release Automation v2" vs 3 separate changes
5. **Easier Tracking:** Single feature vs scattered CI improvements

### Deferred Issues Integration

During implementation, review the 22 deferred issues from v1.4.0:
- Fix any related to release workflow
- Bundle appropriate fixes into v1.5.0
- Document what was addressed

---

**Last Updated:** 2025-12-11  
**Status:** 🟡 Planned  
**Next:** Begin Phase 1 - Tag Creation Automation

