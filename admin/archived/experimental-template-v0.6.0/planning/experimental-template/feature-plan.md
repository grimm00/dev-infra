# Experimental Template - Feature Plan

**Feature:** Experimental Template  
**Status:** 🔴 Not Started  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Target:** v0.6.0  
**Priority:** Medium

---

## 📋 Overview

Create an experimental template (`templates/experimental-project/`) that includes Evolving tier commands from dev-infra, enabling team projects to access experimental features before they graduate to the standard template.

**Problem:** ADR-003 established command tiers with "Evolving" tier containing unstable commands. These are currently dev-infra only, but team projects specifically want access to them.

**Solution:** New template type that includes standard template content plus Evolving tier commands, with clear stability communication.

---

## 🎯 Success Criteria

- [ ] `templates/experimental-project/` directory exists with all content
- [ ] Generator script offers experimental-project as template choice
- [ ] CI validates template sync between standard and experimental
- [ ] Stability indicators visible in command documentation
- [ ] Documentation explains experimental template purpose and stability
- [ ] Team projects can generate and use experimental template

---

## 📅 Implementation Phases

### Phase 1: Create Experimental Template

**Goal:** Create `templates/experimental-project/` directory with all required content

**Tasks:**
- Copy standard-project structure to experimental-project
- Add Evolving tier commands from dev-infra
- Update template README with stability disclaimer
- Mark template as experimental in documentation

**Deliverables:**
- `templates/experimental-project/` directory
- Evolving tier commands in `.cursor/commands/`
- Updated README with stability information

**Estimated Effort:** 2-3 hours

---

### Phase 2: Update Generator Script

**Goal:** Update `new-project.sh` to support experimental-project template

**Tasks:**
- Add experimental-project to template type validation
- Update interactive menu to offer experimental choice
- Update help text with experimental option
- Add stability warning when selecting experimental
- Test generator with new template type

**Deliverables:**
- Updated `scripts/new-project.sh`
- New template type tests
- Documentation update

**Estimated Effort:** 1-2 hours

---

### Phase 3: Add CI Drift Detection

**Goal:** Implement CI validation for template synchronization

**Tasks:**
- Create drift detection script (`scripts/validate-template-sync.sh`)
- Define shared file categories (what must be in sync)
- Integrate with existing template validation workflow
- Document shared vs experimental-only files

**Deliverables:**
- `scripts/validate-template-sync.sh`
- Shared file documentation
- CI workflow integration

**Estimated Effort:** 2-3 hours

---

### Phase 4: Add Stability Indicators

**Goal:** Implement stability communication for experimental commands

**Tasks:**
- Add stability badges (🟢/🟠/🔴) to command documentation
- Create stability level definitions document
- Update template README with stability explanation
- Add graduation checklist based on ADR-004

**Deliverables:**
- Stability indicators in command docs
- `STABILITY-LEVELS.md` documentation
- Graduation checklist template

**Estimated Effort:** 1-2 hours

---

## 📊 Requirements Coverage

| Requirement | Phase | Notes |
|-------------|-------|-------|
| FR-1: Template Generation | Phase 1 | New template directory |
| FR-2: Generator Script Update | Phase 2 | Add template type |
| FR-3: Stability Indicators | Phase 4 | Add badges to docs |
| FR-4: CI Drift Detection | Phase 3 | Sync validation |
| NFR-1: Maintainability | Phase 3 | CI-assisted sync |
| NFR-2: User Experience | Phase 2 | Clear template choice |
| NFR-3: Explicit Opt-In | Phase 1-2 | Separate template |
| NFR-4: Cross-Platform | Phase 3 | No symlinks |
| NFR-5: Clear Communication | Phase 4 | Stability docs |

---

## ⚠️ Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Sync drift between templates | Medium | CI drift detection (Phase 3) |
| User confusion about stability | Low | Clear documentation (Phase 4) |
| Maintenance burden | Medium | CI automation, categorized files |
| No Evolving commands to include | Low | Feature depends on command availability |

---

## 🔗 Dependencies

**Prerequisites:**
- ADR-001 accepted (experimental template decision)
- ADR-002 accepted (implementation approach)
- Evolving tier commands exist in dev-infra

**Blocks:**
- Team projects wanting experimental features
- Command graduation process (ADR-004)

---

## 📚 References

- **ADRs:** [admin/decisions/experimental-template/](../../decisions/experimental-template/)
- **Research:** [admin/research/experimental-template/](../../research/experimental-template/)
- **Requirements:** [requirements.md](../../research/experimental-template/requirements.md)

---

**Last Updated:** 2025-12-12

