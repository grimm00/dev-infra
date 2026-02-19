# Architecture Decisions Hub

**Purpose:** Central hub for documenting architectural decisions and migration roadmaps  
**Status:** ✅ Active  
**Last Updated:** 2025-12-31

---

## 📋 Quick Links

### Architecture Decision Records (ADRs)

**Active:**
- **[Workflow Simplification](workflow-simplification/README.md)** - Simplify feature/phase/task hierarchy (🔴 Proposed)
- **[Four-Arm Architecture](four-arm-architecture/README.md)** - How dev-infra, dev-toolkit, proj-cli, work-prod work together (✅ Accepted) ⭐ **NEW**
- **[Transition-Plan Two-Mode](transition-plan-two-mode/README.md)** - Adopt two-mode pattern for `/transition-plan` (🔴 Proposed)
- **[Dev-Infra Identity & Focus](dev-infra-identity-and-focus/README.md)** - Project identity as template factory (✅ Accepted)

**Previous:**
- **[Release Readiness](release-readiness/README.md)** - Release readiness assessment and automation (✅ Accepted)
- **[Template Generation Testing Automation](template-generation-testing-automation/README.md)** - Decisions for automating template generation testing (✅ Accepted)
- **[Templates Enhancement](templates-enhancement/README.md)** - Template enhancements with workflow automation (✅ Accepted)
- **[0001: Template Restructure](0001-template-restructure.md)** - Decision to restructure templates (admin/ → docs/maintainers/)
- **[0002: CI/CD Workflow Improvements](0002-cicd-workflow-improvements.md)** - Decision to implement automated testing, workflow optimizations, and validation enhancements

### Migration Roadmaps
- **[Template Restructure Roadmap](template-restructure-roadmap.md)** - Detailed migration plan for template restructure

---

## 🎯 Overview

This directory documents architectural decisions made for the dev-infra project, following the Architecture Decision Record (ADR) format. Each decision includes context, rationale, consequences, and references to supporting research.

### Decision Lifecycle

1. **Proposed** - Decision under consideration
2. **Approved** - Decision approved, ready for implementation
3. **Implemented** - Decision implemented and verified
4. **Superseded** - Decision replaced by a newer decision

---

## 📁 Directory Structure

```
admin/decisions/
├── README.md                          # 📍 HUB - This file
├── 0001-template-restructure.md       # ADR for template restructure
├── 0002-cicd-workflow-improvements.md # ADR for CI/CD workflow improvements
└── template-restructure-roadmap.md    # Migration roadmap
```

---

## 📚 Related Documentation

- [Research Hub](../research/README.md) - Supporting research and analysis
- [Planning Hub](../planning/README.md) - Implementation planning
- [Hub-and-Spoke Best Practices](../notes/examples/hub-and-spoke-documentation-best-practices.md) - Documentation patterns

---

**Last Updated:** 2025-12-31  
**Status:** ✅ Active

