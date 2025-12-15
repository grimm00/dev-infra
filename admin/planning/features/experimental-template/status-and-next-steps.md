# Status and Next Steps - Experimental Template

**Feature:** Experimental Template  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-12-12  
**Target:** v1.6.0

---

## 📊 Current Status

### Overall Progress

| Metric | Value |
|--------|-------|
| **Phases Complete** | 1 of 4 |
| **Progress** | 25% |
| **Status** | 🟠 In Progress |
| **Current Phase** | Phase 2: Update Generator |

### Phase Status

| Phase | Status | Effort | Notes |
|-------|--------|--------|-------|
| Phase 1: Create Template | ✅ Complete | 2-3 hours | Completed 2025-12-12 |
| Phase 2: Update Generator | 🔴 Not Started | 1-2 hours | Blocked by Phase 1 |
| Phase 3: CI Drift Detection | 🔴 Not Started | 2-3 hours | Blocked by Phase 2 |
| Phase 4: Stability Indicators | 🔴 Not Started | 1-2 hours | Blocked by Phase 1 |

---

## 🚀 Next Steps

### Immediate (When Ready to Implement)

1. **Review and Approve ADRs**
   - [ ] ADR-001: Experimental Template Creation
   - [ ] ADR-002: Implementation Approach

2. **Identify Evolving Commands**
   - [ ] Review dev-infra commands
   - [ ] Determine which commands are Evolving tier
   - [ ] Document command list

3. **Begin Phase 1**
   - Run: `/task-phase 1`
   - Create experimental-project template

### Short-term (After Phase 1)

4. **Continue with Phase 2**
   - Run: `/task-phase 2`
   - Update generator script

5. **Parallel: Phase 3 & 4**
   - Phase 3: CI drift detection
   - Phase 4: Stability indicators

### Release (v1.6.0)

6. **Create PR**
   - Run: `/pr --feature experimental-template`
   - Include all phases

7. **Update Release Notes**
   - Document new template availability
   - List included Evolving commands

---

## 📋 Blockers and Dependencies

### Current Blockers

| Blocker | Impact | Resolution |
|---------|--------|------------|
| ADRs not yet accepted | Cannot begin | Review and approve ADRs |
| Evolving commands unknown | Phase 1 blocked | Identify commands |

### Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| Standard template exists | ✅ Complete | Base for experimental |
| Generator script works | ✅ Complete | Base for updates |
| CI validation exists | ✅ Complete | Base for drift detection |
| ADR-003 Command Tiers | ✅ Complete | Defines Evolving tier |
| ADR-004 Graduation | ✅ Complete | Defines graduation criteria |

---

## 📝 Notes

### Key Decisions Made

1. **Separate Template** - Not flags or addon system
2. **CI Drift Detection** - Automated sync validation
3. **ADR-004 Graduation** - Use existing criteria

### Open Questions

1. Which specific commands are currently Evolving tier?
2. Should experimental template be in v1.6.0 or later?
3. Any additional stability indicators needed?

---

## 🔗 Related Documents

- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Transition Plan:** [transition-plan.md](transition-plan.md)
- **Phase Documents:** [phase-1.md](phase-1.md) | [phase-2.md](phase-2.md) | [phase-3.md](phase-3.md) | [phase-4.md](phase-4.md)
- **ADRs:** [admin/decisions/experimental-template/](../../decisions/experimental-template/)

---

**Last Updated:** 2025-12-12

