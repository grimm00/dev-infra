# Release Automation v2 - Status & Next Steps

**Feature:** Release Automation v2  
**Category:** 🔧 Internal Tooling  
**Status:** 🟡 Planned  
**Target:** v1.5.0  
**Scope:** Internal only (Phase 3 deferred per ADR-002)  
**Last Updated:** 2025-12-11

---

## 📊 Overall Progress

| Phase | Status | Progress |
|-------|--------|----------|
| Phase 1: Tag Creation Automation | 🟡 Planned | 0% |
| Phase 2: Version Reference Automation | 🟡 Planned | 0% |
| Phase 3: Template Integration | ⏸️ Deferred | N/A |
| **Overall (v1.5.0)** | **🟡 Planned** | **0%** |

> **Note:** Phase 3 deferred per [ADR-002](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md). v1.5.0 scope is internal tooling only.

---

## 📋 Phase Status

### Phase 1: Tag Creation Automation (2-4 hours)

**Status:** 🟡 Planned  
**Priority:** 🔴 High

**Tasks:**
- [ ] Create workflow file
- [ ] Implement version extraction
- [ ] Create annotated tag
- [ ] Push tag
- [ ] Add dry-run mode
- [ ] Update documentation

**Blockers:** None  
**Next Action:** Create `.github/workflows/create-release-tag.yml`

---

### Phase 2: Version Reference Automation (3-5 hours)

**Status:** 🟡 Planned  
**Priority:** 🔴 High

**Tasks:**
- [ ] Create update script
- [ ] Implement file updates
- [ ] Add validation
- [ ] Add dry-run mode
- [ ] Integrate with `/release-finalize`
- [ ] Add tests
- [ ] Documentation

**Blockers:** None  
**Next Action:** Create `scripts/update-version-references.sh`

---

### Phase 3: Template Integration ❌ DEFERRED

**Status:** ⏸️ Deferred per [ADR-002](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md)  
**Reason:** Conflicts with template factory identity (ADR-001)

**Original Sub-Phases (preserved for v1.6.0+ consideration):**
- [ ] 3.1: Script Integration
- [ ] 3.2: Command Integration
- [ ] 3.3: Test in Generated Project
- [ ] 3.4: Documentation
- [ ] 3.5: Validation Tests

**Reconsideration:** v1.6.0+ after graduation criteria met  
**Next Action:** None for v1.5.0

---

## 🎯 Immediate Next Steps (v1.5.0 - Internal Only)

### This Week

1. **Start Phase 1: Tag Creation Automation**
   - Create workflow file
   - Implement version extraction
   - Test with dry-run
   - **Deliverable:** Working workflow (dry-run tested)

2. **Start Phase 2: Version Reference Automation** (parallel with Phase 1)
   - Create update script
   - Implement for `.cursor/rules/main.mdc`
   - Add validation
   - **Deliverable:** Working script for main locations

### Next Week

3. **Complete Phase 1 & 2**
   - Full testing
   - Documentation updates
   - Ready for v1.5.0 use

4. **v1.5.0 Release**
   - Use new automation (internal)
   - Validate end-to-end

### Deferred (v1.6.0+)

5. ~~**Phase 3: Template Integration**~~ ❌ Deferred per ADR-002
   - Reconsider after graduation criteria met
   - See [ADR-002](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md)

---

## 📝 Notes & Decisions

### 2025-12-11: Scope Reduced (ADR-002)

- Phase 3 (Template Integration) deferred per identity decisions
- v1.5.0 scope: Internal tooling only (Phase 1 & 2)
- Reason: Template factory identity - release automation is internal tooling
- Reconsideration: v1.6.0+ after graduation criteria met
- See: [ADR-002](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md)

### 2025-12-11: Feature Created

- Consolidated from scattered CI/CD improvements
- Three related improvements grouped as single feature
- Source: v1.4.0 release retrospective and reflection
- Target: v1.5.0 release

**Migrated From:**
- `admin/planning/ci/tag-creation-automation/improvement-plan.md` → Phase 1
- `admin/planning/ci/version-reference-automation/improvement-plan.md` → Phase 2
- `admin/planning/features/release-commands-template-integration/feature-plan.md` → Phase 3

---

## 🔗 Related

- **[README](README.md)** - Feature hub
- **[Feature Plan](feature-plan.md)** - Overview and goals
- **[Phase 1](phase-1.md)** - Tag Creation details
- **[Phase 2](phase-2.md)** - Version Reference details
- **[Phase 3](phase-3.md)** - Template Integration details

---

**Last Updated:** 2025-12-11  
**Next Update:** After Phase 1 begins

