# Dev-Infra Improvements

**Purpose:** Actionable improvements based on dev-infra learnings  
**Target:** Dev-infra template and other projects  
**Status:** ✅ Active  
**Last Updated:** 2025-12-23

---

## 📋 Quick Links

### Improvement Documents

- **[design-step-in-pipeline.md](design-step-in-pipeline.md)** - Add `/design` step between `/decision` and `/transition-plan` (🔴 Not Started, HIGH priority)
- **[transition-plan-two-mode-pattern.md](transition-plan-two-mode-pattern.md)** - Add Setup/Expand modes to `/transition-plan` (🔴 Not Started, HIGH priority)
- **[research-prior-art-audit.md](research-prior-art-audit.md)** - Add "Prior Art / Existing Solutions Audit" step to `/research` conduct mode (🔴 Not Started, MEDIUM priority)
- **[research-consolidate-exploration-reconciliation.md](research-consolidate-exploration-reconciliation.md)** - Add exploration reconciliation step to `/research --consolidate` (✅ Complete, MEDIUM priority)
- **[decision-command-human-involvement.md](decision-command-human-involvement.md)** - Restructure `/decision` with interview step, options-not-answers, and thin-slice clustering (🔴 Not Started, HIGH priority)
- **[pipeline-phase-start-signals.md](pipeline-phase-start-signals.md)** - Pipeline phases need explicit start signals and clear I/O boundaries (🔴 Not Started, MEDIUM priority)
- **[rules-layer-exploration.md](rules-layer-exploration.md)** - Rules layer deserves its own exploration to understand unique capabilities (🔴 Not Started, LOW priority)
- **[conventions-md-gap.md](conventions-md-gap.md)** - CONVENTIONS.md fills a shared human+agent conventions gap, simplifying AGENTS.md (🔴 Not Started, LOW priority)
- **[skill-config-rendering.md](skill-config-rendering.md)** - Helm-style values files for per-platform skill config rendering (🔴 Not Started, LOW priority, ⚠️ Iffy)
- **[quality-attribute-catalog.md](quality-attribute-catalog.md)** - Standing quality attribute catalog for /design step, retroactively applicable (🔴 Not Started, MEDIUM priority)
- **[feature-first-directory-structure.md](feature-first-directory-structure.md)** - Restructure admin/ to service-first, feature-second, phase-third hierarchy (🔴 Not Started, HIGH priority)
- **[artifact-emission-strategy.md](artifact-emission-strategy.md)** - Move skills from L1 (raw file paths) toward L2/L3 (content + placement guidance); opt-in artifacts (🔴 Not Started, MEDIUM priority)
- **[pr-body-generation-primitive.md](pr-body-generation-primitive.md)** - Prune performative content from `/pr` templates; reuse `update-pr-description` skill as PR/release cluster primitive (🔴 Not Started, MEDIUM priority)
- **[skill-toolbelt-colocated-scripts.md](skill-toolbelt-colocated-scripts.md)** - Give skills co-located scripts for deterministic scaffolding; agent focuses on judgment (🟡 Planned, HIGH priority)

---

## 🎯 Purpose

This directory contains actionable improvement checklists based on learnings from dev-infra development.

---

## 📊 Summary

| Improvement | Status | Priority | Effort |
|-------------|--------|----------|--------|
| `/design` Step in Pipeline | 🔴 Not Started | HIGH | MEDIUM |
| `/transition-plan` Two-Mode Pattern | 🔴 Not Started | HIGH | MEDIUM (~4-6 hrs) |
| `/research` Prior Art Audit | 🔴 Not Started | MEDIUM | LOW (~1 hr) |
| `/research --consolidate` Exploration Reconciliation | ✅ Complete | MEDIUM | LOW (~30 min) |
| `/decision` Human Involvement | 🔴 Not Started | HIGH | MEDIUM |
| Pipeline Phase Start Signals | 🔴 Not Started | MEDIUM | MEDIUM |
| Rules Layer Exploration | 🔴 Not Started | LOW | MEDIUM |
| CONVENTIONS.md Gap | 🔴 Not Started | LOW | LOW |
| Skill Config Rendering (Helm-Style) | 🔴 Not Started | LOW | MEDIUM |
| Quality Attribute Catalog | 🔴 Not Started | MEDIUM | LOW |
| Service/Feature/Phase Directory Structure | 🔴 Not Started | HIGH | HIGH |
| PR Body Generation Primitive | 🔴 Not Started | MEDIUM | LOW / MEDIUM |
| Artifact Emission Strategy (L0-L3 abstraction) | 🔴 Not Started | MEDIUM | HIGH |
| [Installer Managed-Config Coexistence](installer-managed-config-coexistence.md) | 🔴 Not Started | MEDIUM | MEDIUM |

**Total Improvement Documents:** 13  
**Status:** ✅ Active

---

**Last Updated:** 2026-06-10

