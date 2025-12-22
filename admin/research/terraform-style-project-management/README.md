# Terraform-Style Project Management - Research Hub

**Purpose:** Research for implementing Terraform-like project infrastructure management  
**Status:** ✅ Complete  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings ⭐
- **[Requirements](requirements.md)** - 26 FRs, 7 NFRs, 4 Constraints discovered

### Research Documents

| Priority | Topic | Document | Status |
|----------|-------|----------|--------|
| 🔴 High | State File Format | [research-state-file-format.md](research-state-file-format.md) | ✅ Complete |
| 🔴 High | Plan/Apply Workflow | [research-plan-apply-workflow.md](research-plan-apply-workflow.md) | ✅ Complete |
| 🔴 High | Conflict Resolution | [research-conflict-resolution.md](research-conflict-resolution.md) | ✅ Complete |
| 🔴 High | Registry Architecture | [research-registry-architecture.md](research-registry-architecture.md) | ✅ Complete |
| 🟡 Medium | Drift Detection | [research-drift-detection.md](research-drift-detection.md) | ✅ Complete |
| 🟡 Medium | CI/CD Push Updates | [research-cicd-push-updates.md](research-cicd-push-updates.md) | ✅ Complete |

---

## 🎯 Research Overview

This research supports implementing Terraform-style project management in dev-infra, enabling:

1. **State Tracking** - `.dev-infra.yml` tracks what version/config each project has
2. **Plan/Apply Workflow** - Preview changes before applying them
3. **CI/CD Push Updates** - Automatically create PRs when templates change
4. **Drift Detection** - Know when projects have diverged from templates
5. **Conflict Resolution** - Handle intentional customizations gracefully

**Source:** [Terraform-Style Project Management Exploration](../../explorations/terraform-style-project-management/exploration.md)

---

## 🔗 Related Research

**Research Topic 1 (State File Format)** builds on completed research:

- **[Template Metadata Research](../template-metadata/README.md)** - Already researched `.dev-infra.yml` format, essential fields, and migration strategy (✅ Complete)

This existing research provides foundation for state file format decisions.

---

## 📊 Key Findings Summary

1. **State File** - Extend template-metadata with `last_sync`, `sync` rules, `customizations`
2. **Plan/Apply** - Two-phase approach essential for safety; use git-style diffs
3. **Conflicts** - Three-tier sync rules (always/ask/never) + customizations list
4. **Registry** - Work-prod as source of truth, local cache for performance
5. **Drift** - Integrate into plan command, distinguish intentional vs unintentional
6. **CI/CD** - Opt-in auto-updates, Dependabot-style PRs, rate limiting

---

## 🚀 Next Steps

1. ✅ Research complete
2. Use `/decision terraform-style-project-management --from-research` to make decisions
3. Decisions will create ADR documents
4. Implementation in proj-cli package

---

**Last Updated:** 2025-12-22
