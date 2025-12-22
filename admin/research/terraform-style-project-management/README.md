# Terraform-Style Project Management - Research Hub

**Purpose:** Research for implementing Terraform-like project infrastructure management  
**Status:** 🔴 Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

| Priority | Topic | Document | Status |
|----------|-------|----------|--------|
| 🔴 High | State File Format | [research-state-file-format.md](research-state-file-format.md) | 🔴 Not Started |
| 🔴 High | Registry Architecture | [research-registry-architecture.md](research-registry-architecture.md) | 🔴 Not Started |
| 🔴 High | Plan/Apply Workflow | [research-plan-apply-workflow.md](research-plan-apply-workflow.md) | 🔴 Not Started |
| 🟡 Medium | CI/CD Push Updates | [research-cicd-push-updates.md](research-cicd-push-updates.md) | 🔴 Not Started |
| 🟡 Medium | Drift Detection | [research-drift-detection.md](research-drift-detection.md) | 🔴 Not Started |
| 🔴 High | Conflict Resolution | [research-conflict-resolution.md](research-conflict-resolution.md) | 🔴 Not Started |

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

## 📊 Recommended Research Order

Based on dependencies identified in exploration:

1. **State File Format** - Foundational (builds on template-metadata)
2. **Plan/Apply Workflow** - Core UX
3. **Conflict Resolution** - Required for safe applies
4. **Registry Architecture** - Enables CI/CD
5. **Drift Detection** - Quality of life
6. **CI/CD Push Updates** - Automation layer

---

## 🚀 Next Steps

1. Complete research documents for each topic
2. Review requirements in `requirements.md`
3. Use `/decision terraform-style-project-management --from-research` to make decisions

---

**Last Updated:** 2025-12-22

