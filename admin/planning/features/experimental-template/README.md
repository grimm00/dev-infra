# Experimental Template - Feature Hub

**Purpose:** Create experimental template with Evolving tier commands  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-15  
**Target:** v1.6.0

---

## 📋 Quick Links

### Planning Documents

- **[Feature Plan](feature-plan.md)** - Feature overview and phases
- **[Transition Plan](transition-plan.md)** - Transition from decisions to implementation
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress tracking

### Phase Documents

- **[Phase 1: Create Template](phase-1.md)** - Create experimental-project directory (✅ Complete - PR #47)
  - **[Phase 1 Review](phase-1-review.md)** - Pre-implementation review (✅ Ready)
- **[Phase 2: Update Generator](phase-2.md)** - Update new-project.sh script (✅ Complete - PR #48)
- **[Phase 3: CI Drift Detection](phase-3.md)** - Add template sync validation (✅ Complete - PR #49)
- **[Phase 4: Stability Indicators](phase-4.md)** - Add stability communication (✅ Complete - Direct merge)
  - **[Phase 4 Review](phase-4-review.md)** - Pre-implementation review (✅ Ready)

### Supporting Documents

- **[Evolving Commands Inventory](evolving-commands-inventory.md)** - Commands for experimental template
- **[Manual Testing Guide](manual-testing.md)** - Verification scenarios for all phases

### Related Documents

- **[Decisions](../../decisions/experimental-template/)** - ADRs for this feature
- **[Research](../../research/experimental-template/)** - Research findings
- **[Exploration](../../explorations/experimental-template/)** - Initial exploration
- **[Requirements](../../research/experimental-template/requirements.md)** - Feature requirements

---

## 🎯 Feature Overview

Create an experimental template (`templates/experimental-project/`) that exposes Evolving tier commands to template users, enabling team projects to access experimental features.

**Key Deliverables:**
1. New template directory with Evolving tier commands
2. Generator script updated to offer experimental template
3. CI drift detection for template sync
4. Stability indicators in command documentation

---

## 📊 Progress

| Phase | Status | Description |
|-------|--------|-------------|
| Phase 1 | ✅ Complete | Create experimental-project template |
| Phase 2 | ✅ Complete | Update generator script |
| Phase 3 | ✅ Complete | Add CI drift detection |
| Phase 4 | ✅ Complete | Add stability indicators |

**Overall:** 100% complete 🎉

---

## 🚀 Next Steps

1. ✅ All phases complete!
2. Include in v1.6.0 release
3. Update CHANGELOG with experimental template feature
4. Capture learnings with `/int-opp --phase 4`

---

## 🔗 Related

- **ADR-001:** [Experimental Template Creation](../../decisions/experimental-template/adr-001-experimental-template-creation.md)
- **ADR-002:** [Implementation Approach](../../decisions/experimental-template/adr-002-implementation-approach.md)
- **Requirements:** [requirements.md](../../research/experimental-template/requirements.md)

---

**Last Updated:** 2025-12-15

