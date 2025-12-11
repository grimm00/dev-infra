# Identity & Focus - Transition Plan

**Feature:** Dev-Infra Identity & Focus Implementation  
**Status:** 🔴 Not Started  
**Created:** 2025-12-11  
**Source:** ADR-001, ADR-002, ADR-003, ADR-004  
**Type:** Governance/Process

---

## Overview

This transition plan implements the 4 ADRs from the dev-infra identity and focus decisions:

| ADR | Decision | Implementation |
|-----|----------|----------------|
| ADR-001 | Template Factory Identity | Document identity, add category metadata |
| ADR-002 | v1.5.0 Internal Only | Update Release Automation v2 scope |
| ADR-003 | Command Tiers | Add tier/stability metadata to commands |
| ADR-004 | Graduation Process | Create graduation checklist template |

**Transition Type:** Governance/Process (documentation + metadata + rescoping)

---

## Transition Goals

1. **Document the identity decision** in project documentation
2. **Rescope Release Automation v2** to internal tooling only
3. **Add metadata** for command tiers and planning categories
4. **Create governance tools** for graduation process

---

## Pre-Transition Checklist

- [x] ADRs created and reviewed
- [x] Research complete
- [x] Requirements documented
- [ ] ADRs approved (status → Accepted)
- [ ] Team aligned on decisions

---

## Transition Steps

### Step 1: Approve ADRs and Update Status (5 mins)

**Goal:** Officially accept the decisions

**Tasks:**
- [ ] Change ADR-001 status: Proposed → Accepted
- [ ] Change ADR-002 status: Proposed → Accepted
- [ ] Change ADR-003 status: Proposed → Accepted
- [ ] Change ADR-004 status: Proposed → Accepted
- [ ] Update decisions-summary.md status
- [ ] Update README.md status

**Deliverables:**
- ADRs marked as Accepted
- Decision hub updated

---

### Step 2: Rescope Release Automation v2 (15-30 mins)

**Goal:** Align Release Automation v2 with identity decision (ADR-002)

**Tasks:**
- [ ] Update `admin/planning/features/release-automation-v2/feature-plan.md`:
  - Mark Phase 3 as "❌ Deferred (per ADR-002)"
  - Update success criteria to remove template integration
  - Add note about internal-only scope
  - Update total effort estimates
- [ ] Update `admin/planning/features/release-automation-v2/phase-3.md`:
  - Change status to "⏸️ Deferred"
  - Add deferral reason linking to ADR-002
- [ ] Update `admin/planning/features/release-automation-v2/status-and-next-steps.md`
- [ ] Update feature hub `admin/planning/features/README.md`

**Deliverables:**
- Release Automation v2 scoped to Phase 1-2 only
- Phase 3 marked as deferred with rationale
- Documentation updated

---

### Step 3: Update Cursor Rules with Identity (15-30 mins)

**Goal:** Document template factory identity in project rules (ADR-001)

**Tasks:**
- [ ] Update `.cursor/rules/main.mdc`:
  - Add "Project Identity" section
  - Clarify template factory focus
  - Document internal vs template separation
- [ ] Update `.cursor/rules/template.mdc`:
  - Add guidance on what goes in templates
  - Add graduation criteria reference
- [ ] Update project README.md with identity statement

**Deliverables:**
- Identity documented in Cursor rules
- AI assistant has clear guidance

---

### Step 4: Add Category Metadata to Planning (30 mins)

**Goal:** Clarify work categorization (ADR-001, ADR-003)

**Tasks:**
- [ ] Create category metadata standard:
  ```markdown
  **Category:** 🎯 Template Feature | 🔧 Internal Tooling | ⚙️ CI/CD
  ```
- [ ] Add category to existing feature plans:
  - Release Automation v2 → 🔧 Internal Tooling
  - Release Readiness → 🔧 Internal Tooling (v1.4.0, complete)
- [ ] Add category to CI improvement plans
- [ ] Document category convention in workflow rules

**Deliverables:**
- Category metadata standard defined
- Existing plans updated
- Documentation updated

---

### Step 5: Add Command Tier Metadata (30-45 mins)

**Goal:** Classify commands by tier and stability (ADR-003)

**Tasks:**
- [ ] Define metadata format for commands:
  ```markdown
  **Tier:** Essential | Valuable | Advanced | Internal
  **Stability:** 🔴 Very Stable | 🟡 Stable | 🟢 Evolving
  ```
- [ ] Update dev-infra commands with tier/stability:
  - Essential (5): pr, task-phase, fix-plan, fix-implement, reflect
  - Valuable (6): explore, research, decision, pre-phase-review, pr-validation, post-pr
  - Advanced (7): transition-plan, reflection-artifacts, int-opp, address-review, task-release, cursor-rules, fix-review
  - Internal (5): release-prep, release-finalize, post-release, status, task-improvement
- [ ] Document command tiers in template README
- [ ] Consider if any tier changes needed

**Deliverables:**
- Command metadata format defined
- All commands classified
- Documentation updated

---

### Step 6: Create Graduation Checklist Template (30 mins)

**Goal:** Formalize graduation process (ADR-004)

**Tasks:**
- [ ] Create `admin/planning/templates/graduation-checklist.md`:
  - Required criteria section
  - Recommended criteria section
  - Optional criteria section
  - Decision section with rationale
- [ ] Document graduation process in workflow rules
- [ ] Add graduation checklist to templatization workflow

**Deliverables:**
- Graduation checklist template created
- Process documented
- Ready for use

---

### Step 7: Update Exploration Status (5 mins)

**Goal:** Complete the exploration → research → decision → transition workflow

**Tasks:**
- [ ] Update `admin/explorations/dev-infra-identity-and-focus/README.md`:
  - Status: Decisions Proposed → ✅ Transitioned
  - Add transition plan link
- [ ] Update `admin/explorations/README.md`:
  - Move to "Completed Explorations"

**Deliverables:**
- Exploration marked complete
- Full workflow documented

---

## Post-Transition Checklist

- [ ] All ADRs accepted
- [ ] Release Automation v2 rescoped
- [ ] Identity documented in Cursor rules
- [ ] Category metadata added to plans
- [ ] Command tiers documented
- [ ] Graduation checklist created
- [ ] Exploration completed
- [ ] Ready to proceed with v1.5.0 (Phase 1-2 only)

---

## Effort Summary

| Step | Effort | Priority |
|------|--------|----------|
| 1. Approve ADRs | 5 mins | 🔴 High |
| 2. Rescope v1.5.0 | 15-30 mins | 🔴 High |
| 3. Update Cursor Rules | 15-30 mins | 🔴 High |
| 4. Category Metadata | 30 mins | 🟡 Medium |
| 5. Command Tiers | 30-45 mins | 🟡 Medium |
| 6. Graduation Checklist | 30 mins | 🟡 Medium |
| 7. Update Exploration | 5 mins | 🟢 Low |
| **Total** | **~2-3 hours** | |

---

## Definition of Done

- [ ] All 7 steps complete
- [ ] ADRs accepted
- [ ] v1.5.0 scope clear (internal only)
- [ ] Identity documented
- [ ] Governance tools created
- [ ] Ready for Release Automation v2 implementation

---

## References

- [ADR-001: Project Identity](adr-001-project-identity.md)
- [ADR-002: v1.5.0 Scope](adr-002-release-automation-v2-scope.md)
- [ADR-003: Command Strategy](adr-003-command-strategy.md)
- [ADR-004: Graduation Process](adr-004-graduation-process.md)
- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)
- [Requirements](../../research/dev-infra-identity-and-focus/requirements.md)

---

**Last Updated:** 2025-12-11

