# Feature Transition Plan - Experimental Template

**Feature:** Experimental Template  
**Status:** 🔴 Not Started  
**Created:** 2025-12-12  
**Source:** [ADR-001: Experimental Template Creation](../../decisions/experimental-template/adr-001-experimental-template-creation.md)  
**Type:** Feature

---

## Overview

Transition from ADR decisions to implementation of the experimental template feature. This template will provide team projects access to Evolving tier commands not yet stable enough for the standard template.

**Decision:** Create `templates/experimental-project/` with Evolving tier commands  
**Implementation:** Separate template directory with CI drift detection

---

## Transition Goals

From the ADRs and research:
- Enable team projects to use experimental commands
- Maintain clear stability boundaries
- Keep sync between templates manageable
- Provide clear stability communication

---

## Pre-Transition Checklist

- [x] ADR-001: Experimental Template Creation - Proposed
- [x] ADR-002: Implementation Approach - Proposed
- [x] Research complete with requirements
- [ ] ADRs approved/accepted
- [ ] Resources allocated for implementation

---

## Transition Phases

### Phase 1: Create Experimental Template

**Goal:** Create `templates/experimental-project/` directory with all required content

**Estimated Effort:** 2-3 hours

**Prerequisites:**
- [ ] ADRs approved
- [ ] Evolving tier commands identified

**Tasks:**
1. Copy standard-project structure to experimental-project
2. Identify and add Evolving tier commands
3. Update template README with stability disclaimer
4. Add experimental-specific documentation
5. Verify template structure completeness

**Deliverables:**
- `templates/experimental-project/` directory
- Evolving tier commands included
- Stability documentation

**Definition of Done:**
- [ ] Template directory exists with complete structure
- [ ] Evolving commands present
- [ ] README includes stability disclaimer
- [ ] Template validates successfully

---

### Phase 2: Update Generator Script

**Goal:** Enable `new-project.sh` to generate experimental projects

**Estimated Effort:** 1-2 hours

**Prerequisites:**
- [ ] Phase 1 complete
- [ ] Template structure validated

**Tasks:**
1. Add experimental-project to template type validation
2. Update interactive menu with experimental option
3. Add stability warning when selecting experimental
4. Update help text documentation
5. Add tests for new template type

**Deliverables:**
- Updated `scripts/new-project.sh`
- Generator tests for experimental type
- Updated documentation

**Definition of Done:**
- [ ] Generator accepts experimental-project type
- [ ] Stability warning displayed on selection
- [ ] Tests pass for new template type
- [ ] Documentation updated

---

### Phase 3: Add CI Drift Detection

**Goal:** Automate validation of template synchronization

**Estimated Effort:** 2-3 hours

**Prerequisites:**
- [ ] Phase 2 complete
- [ ] Shared file categories defined

**Tasks:**
1. Document shared file categories
2. Create `scripts/validate-template-sync.sh` script
3. Integrate with existing CI workflow
4. Add tests for drift detection
5. Document sync requirements

**Deliverables:**
- `scripts/validate-template-sync.sh`
- Shared file documentation (`TEMPLATE-SYNC.md`)
- CI workflow integration

**Definition of Done:**
- [ ] Drift detection script works
- [ ] CI fails on detected drift
- [ ] Shared files documented
- [ ] Tests pass

---

### Phase 4: Add Stability Indicators

**Goal:** Clear stability communication in all relevant documentation

**Estimated Effort:** 1-2 hours

**Prerequisites:**
- [ ] Phase 1 complete (commands in place)
- [ ] Stability research reviewed

**Tasks:**
1. Add stability badges to Evolving commands (🟠)
2. Create `docs/STABILITY-LEVELS.md` guide
3. Add graduation checklist based on ADR-004
4. Update template README with stability explanation
5. Create feedback mechanism documentation

**Deliverables:**
- Stability badges on commands
- `docs/STABILITY-LEVELS.md`
- Graduation checklist

**Definition of Done:**
- [ ] Evolving commands have 🟠 badge
- [ ] Stability levels documented
- [ ] Graduation path clear
- [ ] Feedback mechanism documented

---

## Post-Transition

- [ ] All phases complete
- [ ] Template generation tested end-to-end
- [ ] CI drift detection operational
- [ ] Documentation complete
- [ ] Release notes prepared for v0.6.0
- [ ] Team notified of availability

---

## Definition of Done (Feature Complete)

- [ ] `templates/experimental-project/` exists and is complete
- [ ] Generator script supports experimental-project
- [ ] CI validates template sync
- [ ] Stability indicators visible
- [ ] Documentation complete
- [ ] Tests passing
- [ ] Ready for v0.6.0 release

---

## Implementation Notes

**Command to implement phases:**
```bash
/task-phase 1   # Implement Phase 1: Create Template
/task-phase 2   # Implement Phase 2: Update Generator
/task-phase 3   # Implement Phase 3: CI Drift Detection
/task-phase 4   # Implement Phase 4: Stability Indicators
```

**PR Strategy:**
- Consider one PR per phase for easier review
- Or combined PR for all phases if small enough
- Use `feat/experimental-template` branch

---

## References

- **ADR-001:** [Experimental Template Creation](../../decisions/experimental-template/adr-001-experimental-template-creation.md)
- **ADR-002:** [Implementation Approach](../../decisions/experimental-template/adr-002-implementation-approach.md)
- **Requirements:** [requirements.md](../../research/experimental-template/requirements.md)
- **Research:** [research-summary.md](../../research/experimental-template/research-summary.md)

---

**Last Updated:** 2025-12-12

