# Status and Next Steps - Experimental Template

**Feature:** Experimental Template  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-12-15  
**Target:** v1.6.0

---

## 📊 Current Status

### Overall Progress

| Metric | Value |
|--------|-------|
| **Phases Complete** | 2 of 4 |
| **Progress** | 50% |
| **Status** | 🟠 In Progress |
| **Current Phase** | Phase 3: CI Drift Detection |

### Phase Status

| Phase | Status | Effort | Notes |
|-------|--------|--------|-------|
| Phase 1: Create Template | ✅ Complete | 2-3 hours | PR #47 (2025-12-15) |
| Phase 2: Update Generator | ✅ Complete | 1-2 hours | PR #48 (2025-12-15) |
| Phase 3: CI Drift Detection | 🔴 Not Started | 2-3 hours | Ready to start |
| Phase 4: Stability Indicators | 🔴 Not Started | 1-2 hours | Ready after Phase 1 |

---

## ✅ Completed Milestones

### Phase 1: Create Template (2025-12-15)
- Created `templates/experimental-project/` directory
- Copied standard-project as base
- Added `/status` evolving command
- Added `docs/EXPERIMENTAL.md` documentation
- Updated README with stability disclaimer
- Merged via PR #47

### Phase 2: Update Generator (2025-12-15)
- Updated `new-project.sh` to accept experimental-project type
- Added interactive menu option with ⚠️ warning
- Implemented stability warning for experimental selection
- Updated help text and documentation
- Added 8 comprehensive tests
- Updated `docs/PROJECT-TYPES.md` and `docs/TEMPLATE-USAGE.md`
- Merged via PR #48

---

## 🚀 Next Steps

### Immediate

1. **Begin Phase 3: CI Drift Detection**
   - Run: `/task-phase 3`
   - Create drift detection script
   - Integrate with CI workflow

2. **Begin Phase 4: Stability Indicators** (can run parallel)
   - Run: `/task-phase 4`
   - Add stability indicators to command docs

### Release (v1.6.0)

3. **Complete remaining phases**
   - Phase 3: CI drift detection
   - Phase 4: Stability indicators

4. **Update Release Notes**
   - Document new template availability
   - List included Evolving commands

---

## 📋 Blockers and Dependencies

### Current Blockers

| Blocker | Impact | Resolution |
|---------|--------|------------|
| None | - | Phases 1-2 complete |

### Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| Standard template exists | ✅ Complete | Base for experimental |
| Generator script works | ✅ Complete | Updated in Phase 2 |
| CI validation exists | ✅ Complete | Base for drift detection |
| ADR-003 Command Tiers | ✅ Complete | Defines Evolving tier |
| ADR-004 Graduation | ✅ Complete | Defines graduation criteria |
| ADR-001 Experimental Template | ✅ Accepted | Template creation approved |
| ADR-002 Implementation Approach | ✅ Accepted | Separate template approach |

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

**Last Updated:** 2025-12-15

