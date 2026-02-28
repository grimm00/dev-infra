# Workflow Simplification - Feature Hub

**Purpose:** Simplify the feature/phase/task hierarchy in dev-infra templates
**Status:** 🟠 In Progress
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## 📋 Quick Links

- **[Feature Plan](feature-plan.md)** - Detailed implementation plan (Medium Tier)
- **[Status & Next Steps](status-and-next-steps.md)** - Progress tracking
- **[Research Hub](../../../research/workflow-simplification/README.md)** - Research findings
- **[Decisions Hub](../../../decisions/workflow-simplification/README.md)** - Architecture decisions

---

## 🎯 Overview

Simplify the workflow from a rigid multi-file phase structure (`feature-plan.md` + `phase-N.md`) to a flexible, tiered `implementation-plan.md` model.

**Key Changes:**
- **Tiered Structure:** Simple (1-8 tasks), Medium (9-15 tasks), Complex (16+ tasks).
- **Hybrid Command:** Rename `/task-phase` to `/task` with `next`/`N`/bare modes.
- **Spec-Only Boundary:** Dev-infra owns specs (templates, validation rules), dev-toolkit owns implementation.
- **Migration:** Minor version bump (v0.10.0) with "new features only" adoption.

---

## 📊 Status

**Current Phase:** Implementation
**Progress:** 0% (Just started)

---

**Last Updated:** 2026-02-19
