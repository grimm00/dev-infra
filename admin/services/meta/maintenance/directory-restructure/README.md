# Directory Restructure

**Purpose:** Migrate `admin/` from phase-first to service-first structure
**Type:** Maintenance (structural refactoring)
**Status:** 🟠 In Progress
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

**Source int-opp:** [feature-first-directory-structure.md](../../../../planning/opportunities/internal/dev-infra/improvements/feature-first-directory-structure.md)

---

## 📋 What This Work Does

Restructures `admin/` from its current **phase-first** organization (explorations/, research/, decisions/, etc. at top level, with topic names underneath) to a **service-first** organization with three levels:

```
admin/services/[service]/[work-category]/[work-unit]/
```

Where:
- **Service** — domain grouping (ai-workflow, template-generation, release-management, meta)
- **Work category** — explorations, features, or maintenance
- **Work unit** — the scoped piece of work (feature name, ticket, refactor name)

See [plan.md](plan.md) for the full mapping and migration sequence.

---

## 🎯 Why This Work Matters

The phase-first structure has multiple failure modes:

1. **Cross-cutting artifacts pigeonholed.** `requirements.md` lives in `research/` by default even though it's shaped throughout the feature lifecycle.
2. **Feature traceability fragmented.** To see everything about one feature, grep across 6+ top-level directories.
3. **Explorations forced into feature shape.** Every exploration goes through a full feature pipeline even when the outcome should be "answered a question" or "minor CI fix."
4. **No home for cross-project work.** Multi-service concerns (like this restructure) have no natural location.

This restructure fixes all four. It's a prerequisite for agentic-workflow-modernization Stage 1 (skills would otherwise reference paths that change later).

---

## 📊 Status

| Step | Status |
|------|--------|
| Service enumeration | ✅ Complete |
| Bootstrap meta service | ✅ Complete (this directory) |
| Migration plan | ✅ Complete (see plan.md) |
| Execute migration | 🔴 Not started |
| Update command path references | 🔴 Not started |
| Update CI scripts | 🔴 Not started |
| Update templates (docs/maintainers/) | 🔴 Not started |
| Verify | 🔴 Not started |

---

## 🔗 Related

- [feature-first-directory-structure int-opp](../../../../planning/opportunities/internal/dev-infra/improvements/feature-first-directory-structure.md) — The proposal
- [artifact-emission-strategy int-opp](../../../../planning/opportunities/internal/dev-infra/improvements/artifact-emission-strategy.md) — Follow-on work (L2/L3 abstraction)

---

**Last Updated:** 2026-04-24
