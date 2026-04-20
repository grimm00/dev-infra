# Feature-First Directory Structure

**Source:** /discuss session — agentic-workflow-modernization decision phase wrap-up (2026-04-14)
**Target:** dev-infra admin/ directory structure (all templates)
**Status:** 🔴 Not Started
**Priority:** HIGH
**Effort:** HIGH (filesystem migration + command path updates + link rewrites)
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Problem Statement

The current `admin/` directory is organized **phase-first, topic-second**:

```
admin/
├── explorations/[topic]/
├── research/[topic]/
├── decisions/[topic]/
├── designs/[topic]/
├── narratives/[topic]/
└── planning/features/[topic]/
```

This structure encodes an implicit assumption: **workflow phases are the primary unit of engineering.** In practice, this creates friction:

1. **`requirements.md` is pigeonholed.** Living under `research/[topic]/` implies research is the only generator of requirements. But requirements get shaped throughout the feature lifecycle: interviews surface priorities (decisions), designs validate system coherence (NFR checklist), spikes validate assumptions that become requirements. The directory location tells a false story about who's allowed to produce or modify requirements.

2. **Cross-cutting artifacts have no natural home.** `v1-scope.md` was placed in `decisions/` because it emerged from the interview, but it's actually a cross-phase synthesis. Future cross-cutting artifacts (quality attribute catalogs, status summaries, feature-level documentation) face the same ambiguity.

3. **Feature traceability is distributed.** To see everything about `agentic-workflow-modernization`, you grep across 6+ top-level directories. The feature is the cognitive unit, but the filesystem fragments it.

4. **Contradicts self-contained principle.** [ADR-002 of worktree-feature-workflow](../../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md) says feature branches should be self-contained. Phase-first structure is the filesystem antithesis: artifacts for one feature spread across the whole admin tree.

---

## Core Insight

**Features are the primary unit; phases are steps within a feature's lifecycle.**

Engineering teams organize by service, feature, component — not by "the research directory." The current structure inverts this. Topic-first organization mirrors how humans think about their work.

---

## Proposed Solution

Restructure `admin/` to be **feature-first, phase-second**:

```
admin/
├── features/
│   └── [topic]/
│       ├── requirements.md           ← cross-cutting, lives at root
│       ├── v1-scope.md               ← cross-cutting, lives at root
│       ├── exploration.md            ← single-file phase
│       ├── research/
│       │   ├── README.md
│       │   ├── research-summary.md
│       │   ├── topic-1-*.md
│       │   └── ...
│       ├── decisions/
│       │   ├── README.md
│       │   ├── decision-interview.md
│       │   ├── adr-001-*.md
│       │   └── ...
│       ├── designs/
│       │   └── design.md
│       ├── explorations/             ← sub-artifacts like spikes
│       │   └── spike/
│       └── narrative.md              ← single-file phase
└── planning/
    └── opportunities/                ← stays where it is (cross-feature)
```

### Key Properties

1. **Cross-cutting artifacts live at feature root.** `requirements.md`, `v1-scope.md`, status summaries — anything not tied to a single phase.
2. **Phase directories hold phase-specific artifacts.** `research/` holds topic documents. `decisions/` holds ADRs.
3. **Feature is the portable unit.** `admin/features/agentic-workflow-modernization/` contains everything about that feature.
4. **Grep-able by feature.** Search anything within one directory tree.

### Cross-Feature Artifacts Stay Where They Are

- `admin/planning/opportunities/` — int-opps and learnings span features
- `admin/planning/commands/` — command lifecycle tracking spans features
- `admin/planning/releases/` — release planning spans features

These are legitimately cross-feature concerns and belong at the admin top level.

---

## Migration Implications

### What Changes

- All existing feature directories move to `admin/features/[topic]/`
- Internal markdown links need rewriting (`../decisions/[topic]/X.md` → `../decisions/X.md`)
- Commands that reference these paths need updating (`/explore`, `/research`, `/decision`, `/design`, `/narrative`, `/transition-plan`)
- CI scripts that scan `admin/` need path updates
- Templates (`standard-project/docs/maintainers/` and `learning-project/`) need parallel restructuring

### Migration Effort Estimate

- **Filesystem moves:** Low (git mv handles it)
- **Link rewrites:** Medium (many internal references across docs)
- **Command updates:** Medium (6-7 commands reference these paths)
- **Template sync:** Medium (parallel structure in both templates)
- **Regression testing:** Medium (verify commands still work)

**Total:** 1-2 focused sessions for a careful migration.

### Why HIGH Priority

1. **It fixes a fundamental model error.** Every future feature suffers from the current pigeonholing.
2. **Migration cost grows over time.** More features, more links, more commands = harder to migrate later.
3. **Blocks workflow evolution.** The proposed design step, interview-as-start-signal, cross-cutting artifacts — all require a home that the current structure doesn't naturally provide.

### Why NOT Immediately

The agentic-workflow-modernization feature is mid-lifecycle (decisions done, design done, about to enter transition planning). Mid-implementation restructuring creates migration overhead on a feature still in motion.

**Recommended timing:** Complete transition planning for agentic-workflow-modernization, then do the restructure as a standalone feature before beginning Stage 1 skill conversion. This way, Stage 1 work happens against the cleaner structure.

---

## Intermediate Step (If Migration Not Ready)

Move only `requirements.md` and `v1-scope.md` out of phase directories into a new home (e.g., `admin/features/[topic]/` or kept at `admin/decisions/[topic]/`). This validates the "cross-cutting at root" pattern without committing to full restructure. If the pattern feels right, proceed with full migration.

This is lower-risk validation but carries the cost of two migrations instead of one.

---

## Related Int-Opps

- [pipeline-phase-start-signals.md](pipeline-phase-start-signals.md) — Start signals need a home that cross-cutting artifacts can share
- [design-step-in-pipeline.md](design-step-in-pipeline.md) — Design documents need a clear location
- [quality-attribute-catalog.md](quality-attribute-catalog.md) — Catalog is a cross-feature artifact (admin/planning/)

---

## Open Questions

- Should `features/` be the wrapping directory or should feature directories live at `admin/` root (e.g., `admin/agentic-workflow-modernization/`)? Cleaner without `features/` but less scannable.
- How do partial-scope artifacts (e.g., `admin/planning/features/[topic]/`) map to the new structure? Likely the same topic directory but lives at `admin/features/[topic]/planning/` or similar.
- Does this affect `docs/maintainers/` in templates, or is that structure separate? Parallel restructure likely needed.

---

**Last Updated:** 2026-04-14
