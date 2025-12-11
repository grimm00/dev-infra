# Requirements - Dev-Infra Identity & Focus

**Source:** Research on dev-infra identity, focus, and organization  
**Status:** ✅ Final  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 📋 Overview

This document captures requirements discovered during research on dev-infra's identity and focus, specifically around the question of whether dev-infra should be primarily a "template factory."

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### From Template User Needs Research

#### FR-1: Template Workflow Commands

**Description:** Templates should include only workflow commands that apply to all projects.

**Source:** [research-template-user-needs.md](research-template-user-needs.md)

**Priority:** 🔴 High

**Status:** 🟡 Partially Met (18 commands currently)

---

#### FR-2: Dev-Infra Specific Commands

**Description:** Dev-infra-specific commands should stay in dev-infra only.

**Source:** [research-template-user-needs.md](research-template-user-needs.md)

**Priority:** 🔴 High

**Status:** ✅ Met (5 commands are dev-infra only)

---

#### FR-3: Template Command Upgrade Path

**Description:** Templates should have a way to "upgrade" to advanced commands if needed.

**Source:** [research-template-user-needs.md](research-template-user-needs.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### From Command Maintenance Research

#### FR-4: Command Stability Levels

**Description:** Commands must have explicit stability levels (Stable/Evolving/Experimental).

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

#### FR-5: Template Command Stability

**Description:** Template commands must be at "Stable" level.

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Priority:** 🔴 High

**Status:** 🟡 Implicit (not tracked)

---

#### FR-6: Command Graduation Review

**Description:** Command graduation requires manual review before templatization.

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### From Release Automation Scope Research

#### FR-7: Release Automation As Internal Tooling

**Description:** Release automation should be internal tooling by default, not automatically templatized.

**Source:** [research-release-automation-scope.md](research-release-automation-scope.md)

**Priority:** 🔴 High

**Status:** ✅ Met (release commands are dev-infra only)

---

#### FR-8: Template Integration Requires Graduation

**Description:** Template integration requires explicit graduation decision, not automatic inclusion.

**Source:** [research-release-automation-scope.md](research-release-automation-scope.md)

**Priority:** 🔴 High

**Status:** 🔴 No formal process

---

### From Graduation Criteria Research

#### FR-9: Graduation Checklist

**Description:** All template features must pass graduation checklist before templatization.

**Source:** [research-graduation-criteria.md](research-graduation-criteria.md)

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

#### FR-10: Graduation Documentation

**Description:** Graduation decisions must be documented with rationale.

**Source:** [research-graduation-criteria.md](research-graduation-criteria.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### From Organizational Structure Research

#### FR-11: Planning Category Metadata

**Description:** All planning documents must have explicit category (Template Feature | Internal Tooling | CI/CD).

**Source:** [research-organizational-structure.md](research-organizational-structure.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

#### FR-12: Template Feature Location

**Description:** Template features must be in template-specific planning location.

**Source:** [research-organizational-structure.md](research-organizational-structure.md)

**Priority:** 🟢 Low (incremental adoption)

**Status:** 🔴 Not Started

---

### From Minimum Viable Tooling Research

#### FR-13: Command Tiers

**Description:** Templates should have explicit command tiers (Essential/Valuable/Advanced).

**Source:** [research-minimum-viable-tooling.md](research-minimum-viable-tooling.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

#### FR-14: Essential Command Count

**Description:** Essential command set should be ≤7 commands.

**Source:** [research-minimum-viable-tooling.md](research-minimum-viable-tooling.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### From Other Projects Research

#### FR-15: No Internal Tooling In Templates

**Description:** Templates should not include dev-infra internal tooling.

**Source:** [research-other-projects.md](research-other-projects.md)

**Priority:** 🔴 High

**Status:** ✅ Mostly Met (some gray areas)

---

#### FR-16: Template Inspectability

**Description:** Templates should be understandable by inspection (WYSIWYG).

**Source:** [research-other-projects.md](research-other-projects.md)

**Priority:** 🟡 Medium

**Status:** ✅ Met (direct file structure)

---

## 🎯 Non-Functional Requirements

### From Template User Needs Research

#### NFR-1: Template Command Stability

**Description:** Template commands should be stable (minimal changes after release).

**Source:** [research-template-user-needs.md](research-template-user-needs.md)

**Priority:** 🔴 High

**Status:** 🟡 Informal

---

#### NFR-2: Template Maintenance Predictability

**Description:** Template maintenance burden should be predictable.

**Source:** [research-template-user-needs.md](research-template-user-needs.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not tracked

---

### From Command Maintenance Research

#### NFR-3: Command Change Tracking

**Description:** Command changes should be tracked in releases.

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not implemented

---

#### NFR-4: Essential Command Limit

**Description:** Essential command set should be ≤7 commands.

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not defined

---

### From Release Automation Scope Research

#### NFR-5: Template Complexity Justification

**Description:** Templates should not grow more complex without clear user need.

**Source:** [research-release-automation-scope.md](research-release-automation-scope.md)

**Priority:** 🔴 High

**Status:** 🔴 No process

---

#### NFR-6: Internal Tooling Evolution

**Description:** Internal tooling can evolve faster than template features.

**Source:** [research-release-automation-scope.md](research-release-automation-scope.md)

**Priority:** 🟡 Medium

**Status:** ✅ Implicit

---

### From Graduation Criteria Research

#### NFR-7: Graduation Time Requirement

**Description:** Features should be in dev-infra for ≥1 release before graduation.

**Source:** [research-graduation-criteria.md](research-graduation-criteria.md)

**Priority:** 🔴 High

**Status:** 🔴 Not enforced

---

#### NFR-8: Graduation Decision Tracking

**Description:** Graduation decisions should be tracked in planning docs.

**Source:** [research-graduation-criteria.md](research-graduation-criteria.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Not implemented

---

### From Organizational Structure Research

#### NFR-9: Incremental Structure Changes

**Description:** Structure changes should be incremental, not breaking.

**Source:** [research-organizational-structure.md](research-organizational-structure.md)

**Priority:** 🔴 High

**Status:** ✅ Can be met with metadata-first approach

---

#### NFR-10: Template Work Visibility

**Description:** Template work should be visually prominent in planning.

**Source:** [research-organizational-structure.md](research-organizational-structure.md)

**Priority:** 🟢 Low

**Status:** 🔴 Not implemented

---

### From Minimum Viable Tooling Research

#### NFR-11: Template Complexity Justification

**Description:** Template complexity should be justified by user value.

**Source:** [research-minimum-viable-tooling.md](research-minimum-viable-tooling.md)

**Priority:** 🔴 High

**Status:** 🔴 Not tracked

---

#### NFR-12: Template Simplicity Option

**Description:** Simpler templates should be an option (editions).

**Source:** [research-minimum-viable-tooling.md](research-minimum-viable-tooling.md)

**Priority:** 🟢 Low (v2.0 consideration)

**Status:** 🔴 Not implemented

---

### From Other Projects Research

#### NFR-13: Appropriate Template Complexity

**Description:** Template complexity should be appropriate for user projects, not dev-infra projects.

**Source:** [research-other-projects.md](research-other-projects.md)

**Priority:** 🔴 High

**Status:** 🟡 Mostly met

---

#### NFR-14: Internal/Template Separation

**Description:** Internal tooling should be separate from template content.

**Source:** [research-other-projects.md](research-other-projects.md)

**Priority:** 🔴 High

**Status:** ✅ Mostly met

---

## ⚠️ Constraints

### C-1: v1.5.0 Scope Alignment

**Description:** v1.5.0 scope must align with template-centric identity decision.

**Source:** [research-release-automation-scope.md](research-release-automation-scope.md)

**Impact:** Blocks v1.5.0 planning until identity decision made

---

### C-2: Template Addition Justification

**Description:** Template additions require demonstrated user need.

**Source:** [research-release-automation-scope.md](research-release-automation-scope.md)

**Impact:** Prevents speculative template features

---

## 💭 Assumptions

### A-1: User Projects Are Simpler

**Description:** Template users have simpler needs than dev-infra (they're not meta-projects).

**Source:** [research-template-user-needs.md](research-template-user-needs.md)

**Impact:** Justifies simpler templates

---

### A-2: Commands As Documentation

**Description:** AI commands function as documentation, not executable code.

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Impact:** Different maintenance model needed

---

### A-3: Stability Over Features

**Description:** For templates, stability is more valuable than feature count.

**Source:** [research-command-maintenance.md](research-command-maintenance.md)

**Impact:** Fewer, more stable commands preferred

---

## 📊 Requirements Summary

| Category | High Priority | Medium Priority | Low Priority | Total |
|----------|---------------|-----------------|--------------|-------|
| Functional | 7 | 5 | 4 | 16 |
| Non-Functional | 7 | 5 | 2 | 14 |
| Constraints | 2 | - | - | 2 |
| Assumptions | 3 | - | - | 3 |

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [All Research Documents](README.md)
- [Exploration](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

## 🚀 Next Steps

1. Review and prioritize requirements
2. Use `/decision dev-infra-identity-and-focus --from-research` to make decisions
3. Decisions may refine requirements

---

**Last Updated:** 2025-12-11

