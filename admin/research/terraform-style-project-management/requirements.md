# Requirements - Terraform-Style Project Management

**Source:** Research on terraform-style project management  
**Status:** Complete  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Overview

This document captures requirements discovered during research on implementing Terraform-style project management in dev-infra.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### State File Format

#### FR-1: Last Sync Timestamp

**Description:** State file must include `last_sync` timestamp to track when project was last synced with template.

**Source:** [research-state-file-format.md](research-state-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-2: Sync Rules Configuration

**Description:** State file must support sync rules (always/ask/never) for file categories.

**Source:** [research-state-file-format.md](research-state-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-3: Customizations Tracking

**Description:** State file must track intentional customizations with file, reason, and date.

**Source:** [research-state-file-format.md](research-state-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-4: Human-Readable Format

**Description:** State file must remain human-readable and editable (YAML format).

**Source:** [research-state-file-format.md](research-state-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### Plan/Apply Workflow

#### FR-5: Plan Shows Diff

**Description:** `proj plan` must show diff without modifying any files (read-only operation).

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-6: Apply Confirms Changes

**Description:** `proj apply` must confirm before making any changes (unless `--yes` flag).

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-7: Apply Respects Sync Rules

**Description:** Apply must respect sync rules - always (apply), ask (prompt), never (skip).

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-8: Selective Apply

**Description:** Support selective apply with `--file <path>` flag for specific files.

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-9: Change Summary

**Description:** Show clear summary of changes (added/modified/deleted/unchanged counts).

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** High

**Status:** 🔴 Pending

---

### Conflict Resolution

#### FR-10: Three-Tier Sync Rules

**Description:** Support three-tier sync rules: always, ask, never.

**Source:** [research-conflict-resolution.md](research-conflict-resolution.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-11: Customize Command

**Description:** `proj customize <file>` command to mark files as intentionally customized.

**Source:** [research-conflict-resolution.md](research-conflict-resolution.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-12: Prompt for Ask Files

**Description:** Prompt user for files in `ask` category during apply.

**Source:** [research-conflict-resolution.md](research-conflict-resolution.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-13: Show Diff in Prompts

**Description:** Show diff during conflict resolution prompts for informed decisions.

**Source:** [research-conflict-resolution.md](research-conflict-resolution.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-14: Remember Skip Option

**Description:** "Remember skip" option adds file to customizations automatically.

**Source:** [research-conflict-resolution.md](research-conflict-resolution.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### Registry Architecture

#### FR-15: Local Registry Cache

**Description:** Local registry cache at XDG-compliant location (`~/.dev-infra/registry.json`).

**Source:** [research-registry-architecture.md](research-registry-architecture.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-16: Init Registers Project

**Description:** `proj init` registers project in work-prod (when available).

**Source:** [research-registry-architecture.md](research-registry-architecture.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-17: Registry Sync Command

**Description:** `proj registry sync` syncs local cache from work-prod.

**Source:** [research-registry-architecture.md](research-registry-architecture.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-18: Registry List Command

**Description:** `proj registry list` shows managed projects.

**Source:** [research-registry-architecture.md](research-registry-architecture.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### Drift Detection

#### FR-19: Version Comparison

**Description:** Plan must show template version vs project version.

**Source:** [research-drift-detection.md](research-drift-detection.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-20: Detect Local Modifications

**Description:** Plan must detect locally modified files.

**Source:** [research-drift-detection.md](research-drift-detection.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-21: Distinguish Modification Types

**Description:** Plan must distinguish customized vs unrecorded modifications.

**Source:** [research-drift-detection.md](research-drift-detection.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-22: Suggest Customize Command

**Description:** Plan must suggest `proj customize` for unrecorded changes.

**Source:** [research-drift-detection.md](research-drift-detection.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### CI/CD Push Updates

#### FR-23: Auto-Update Opt-In

**Description:** `auto_update` field in `.dev-infra.yml` controls opt-in for automated updates.

**Source:** [research-cicd-push-updates.md](research-cicd-push-updates.md)

**Priority:** Low (V2)

**Status:** 🔴 Pending

---

#### FR-24: GitHub Actions Workflow

**Description:** GitHub Actions workflow triggered on dev-infra release for push updates.

**Source:** [research-cicd-push-updates.md](research-cicd-push-updates.md)

**Priority:** Low (V2)

**Status:** 🔴 Pending

---

#### FR-25: PR with Changelog

**Description:** PRs created with clear title and changelog link.

**Source:** [research-cicd-push-updates.md](research-cicd-push-updates.md)

**Priority:** Low (V2)

**Status:** 🔴 Pending

---

#### FR-26: Rate Limiting

**Description:** Rate limiting to respect GitHub API limits (10 projects/batch).

**Source:** [research-cicd-push-updates.md](research-cicd-push-updates.md)

**Priority:** Low (V2)

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

#### NFR-1: Backward Compatibility

**Description:** State file format must be backward-compatible with template-metadata v1.

**Source:** [research-state-file-format.md](research-state-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### NFR-2: Colored Output

**Description:** Use colored output for clear diff visualization (Rich library).

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-3: Plan Performance

**Description:** Plan must complete in <5 seconds for typical projects.

**Source:** [research-plan-apply-workflow.md](research-plan-apply-workflow.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-4: Skip Customized Files

**Description:** Skip prompts for files in customizations list automatically.

**Source:** [research-conflict-resolution.md](research-conflict-resolution.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-5: Offline Registry Operations

**Description:** Registry operations must work offline (read from cache).

**Source:** [research-registry-architecture.md](research-registry-architecture.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### NFR-6: Drift Detection Performance

**Description:** Drift detection must be fast (< 2 seconds for typical project).

**Source:** [research-drift-detection.md](research-drift-detection.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-7: GitHub App Authentication (V2)

**Description:** V1 uses PAT, V2 should migrate to GitHub App for scalability.

**Source:** [research-cicd-push-updates.md](research-cicd-push-updates.md)

**Priority:** Low (V2)

**Status:** 🔴 Pending

---

## ⚠️ Constraints

#### C-1: Work-prod API Required for Registration

**Description:** Project registration requires work-prod API to be running.

**Source:** [research-registry-architecture.md](research-registry-architecture.md)

---

#### C-2: Backward Compatibility Required

**Description:** Must work with existing projects without forced migration.

**Source:** [Exploration document]

---

#### C-3: proj-cli Integration

**Description:** Commands will be implemented in proj-cli package.

**Source:** [Exploration document]

---

#### C-4: GitHub API Rate Limits

**Description:** CI/CD push updates must respect GitHub API rate limits.

**Source:** [research-cicd-push-updates.md](research-cicd-push-updates.md)

---

## 💭 Assumptions

#### A-1: proj-cli as Implementation Target

**Description:** Commands will be implemented in proj-cli package.

**Source:** [Exploration document]

---

#### A-2: YAML Format Confirmed

**Description:** State file will use YAML format (per template-metadata research).

**Source:** [Template Metadata Research](../template-metadata/README.md)

---

#### A-3: Single User Context

**Description:** Initial implementation assumes single-user context (personal projects).

**Source:** [Template Metadata Research](../template-metadata/README.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Template Metadata Research](../template-metadata/README.md)
- [Exploration](../../explorations/terraform-style-project-management/exploration.md)

---

## 📊 Priority Summary

| Priority | Count |
|----------|-------|
| High | 18 |
| Medium | 11 |
| Low (V2) | 4 |

**V1 Implementation Focus:** 18 High-priority requirements + selected Medium-priority

---

## 🚀 Next Steps

1. ✅ Requirements document complete
2. Use `/decision terraform-style-project-management --from-research` to make decisions
3. Decisions may refine requirements
4. Implementation planning after decisions

---

**Last Updated:** 2025-12-22
