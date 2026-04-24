# Agentic Workflow Modernization

**Purpose:** Convert dev-infra's 26 Cursor commands to portable skills with precise behavioral contracts; slim rules layer; establish cross-platform distribution
**Status:** 🟠 Decision + Design Complete; Stage 1 (Thinker) pending
**Created:** 2026-03-25
**Migrated to new structure:** 2026-04-24

---

## 📋 At a Glance

This feature re-architects dev-infra's workflow system for the age of AI-assisted development. It moves from monolithic commands + long rules files to lean skills + minimal rules + explicit behavioral contracts, with cross-platform portability (Cursor + Claude Code).

**Current pipeline position:**
```
/explore ✅ → /research ✅ → /decision ✅ → /design ✅ → /transition-plan (next) → /task
```

---

## 📚 Feature Artifacts

### Cross-Cutting (at root)

- **[requirements.md](requirements.md)** — 22 FRs, 3 NFRs, 4 Constraints, 2 Assumptions (consolidated)
- **[v1-scope.md](v1-scope.md)** — 22 conclusions (C1-1 through C8-3) + CP-1 (Explicit Over Implicit)
- **[narrative.md](narrative.md)** — Story of how the thinking evolved (12 acts)

### Provenance

This feature was promoted from a service-level exploration:

- **[../../explorations/agentic-workflow-modernization/](../../explorations/agentic-workflow-modernization/)** — Original exploration that produced this feature (10 themes, research topics, outcomes record)

### Phase Directories

- **[research/](research/)** — 8 conducted topics + summary + hub
- **[decisions/](decisions/)** — 5 ADRs + interview + summary + hub
- **[designs/](designs/)** — Holistic design document (7 sections, 11 quality attributes assessed)
- **[spikes/](spikes/)** — Skill family discovery, SKILL.md experiments, learnings

---

## 🎯 Key Decisions (from 5 ADRs)

| ADR | Decision |
|-----|----------|
| [ADR-001](decisions/adr-001-v1-skill-selection.md) | Staged v1 by role groups: ~16 skills across 4 stages |
| [ADR-002](decisions/adr-002-skill-architecture.md) | Family directories for multi-mode (explore, research); flat for single-mode |
| [ADR-003](decisions/adr-003-content-redistribution.md) | Aggressive rules slimming (~1,500 → ~50 lines) |
| [ADR-004](decisions/adr-004-quality-and-conversion.md) | Five-property rubric applied strictly during conversion |
| [ADR-005](decisions/adr-005-distribution-and-portability.md) | Author in `templates/standard-project/.claude/skills/`; distribution deferred to v2+ |

---

## 🚧 Status

| Step | Status |
|------|--------|
| Exploration | ✅ Complete |
| Research (10 topics) | ✅ Complete |
| Decision interview + 5 ADRs | ✅ Complete |
| Design document | ✅ Complete |
| Transition plan | 🔴 Pending |
| Stage 1 execution (Thinker skills) | 🔴 Pending |

**Next concrete step:** `/transition-plan` decomposing Stage 1 into tasks.

---

## 🔗 Related

- **Service:** [ai-workflow](../../README.md)
- **Related int-opps:** [feature-first-directory-structure](../../../../planning/opportunities/internal/dev-infra/improvements/feature-first-directory-structure.md), [artifact-emission-strategy](../../../../planning/opportunities/internal/dev-infra/improvements/artifact-emission-strategy.md), [decision-command-human-involvement](../../../../planning/opportunities/internal/dev-infra/improvements/decision-command-human-involvement.md)
- **Learnings:** [decision-interview-exercise-learnings](../../../../planning/opportunities/internal/dev-infra/learnings/decision-interview-exercise-learnings.md)

---

**Last Updated:** 2026-04-24
