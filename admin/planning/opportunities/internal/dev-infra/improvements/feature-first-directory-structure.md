# Service-First, Feature-Second Directory Structure

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

**Services are the primary organizational unit; features are the work within a service; phases are steps within a feature's lifecycle.**

Engineering teams organize by service, then feature, then work-phase. The current admin/ structure inverts this by placing phases at the top level, which creates two problems: features fragment across phase directories, and services (which dev-infra has despite not naming them) have no home at all.

Dev-infra is actually a **multi-service project** that has been masquerading as single-service:

- **AI workflow authoring** — commands, skills, rules, the thinking pipeline modernization
- **Template generation** — new-project.sh, templates, template sync
- **Release management** — release automation, readiness, distribution

Grouping features by service reduces cognitive load dramatically (expand the service you care about, collapse the rest) and creates natural extraction seams for future repo splits.

---

## Proposed Solution

Restructure `admin/` to be **service-first, feature-second, phase-third**:

```
admin/
├── services/
│   ├── ai-workflow/
│   │   ├── README.md                           ← service overview
│   │   └── features/
│   │       ├── agentic-workflow-modernization/
│   │       │   ├── requirements.md             ← cross-cutting, feature root
│   │       │   ├── v1-scope.md                 ← cross-cutting, feature root
│   │       │   ├── exploration.md              ← single-file phase
│   │       │   ├── research/
│   │       │   │   ├── README.md
│   │       │   │   ├── research-summary.md
│   │       │   │   └── topic-*.md
│   │       │   ├── decisions/
│   │       │   │   ├── README.md
│   │       │   │   ├── decision-interview.md
│   │       │   │   └── adr-*.md
│   │       │   ├── designs/
│   │       │   │   └── design.md
│   │       │   ├── explorations/               ← sub-artifacts like spikes
│   │       │   │   └── spike/
│   │       │   └── narrative.md
│   │       └── workflow-simplification/
│   │           └── ... (same structure)
│   ├── template-generation/
│   │   ├── README.md
│   │   └── features/
│   │       ├── template-doc-infrastructure/
│   │       └── experimental-template/
│   └── release-management/
│       ├── README.md
│       └── features/
│           └── release-automation-v2/
└── planning/
    └── opportunities/                          ← stays (cross-service)
```

### Three Levels, Each With a Purpose

| Level | Purpose | Changes when... |
|-------|---------|-----------------|
| **Service** | Product/domain grouping | A new product area emerges (rare) |
| **Feature** | Scoped work unit | A new feature begins (often) |
| **Phase** | Workflow step within a feature | Every feature has these subdirectories |

### Key Properties

1. **Services group related features.** `ai-workflow/` holds everything about workflow modernization, command conversion, skill authoring. `template-generation/` holds everything about templates.
2. **Cross-cutting artifacts live at feature root.** `requirements.md`, `v1-scope.md`, status summaries — anything not tied to a single phase.
3. **Phase directories hold phase-specific artifacts.** `research/` holds topic documents. `decisions/` holds ADRs.
4. **Feature is the portable unit.** An entire feature directory can be moved, archived, or extracted.
5. **Services provide natural extraction seams.** If `ai-workflow` eventually becomes its own repo, the extraction boundary is already the service directory.
6. **Visual surface area is minimized.** At the admin/ root you see 2-3 services, not 10+ features.

### Cross-Service Features

Some features span services (e.g., `workflow-simplification` touches both AI workflow and template generation). Handling:

- **Primary service + cross-reference** (recommended): File under the dominant service, link from the secondary. Matches how engineering teams handle cross-team work.
- A `services/cross/` directory could exist if truly cross-cutting features emerge frequently, but defer until observed.

### Cross-Service Artifacts Stay Where They Are

- `admin/planning/opportunities/` — int-opps and learnings span services
- `admin/planning/commands/` — command lifecycle tracking spans services
- `admin/planning/releases/` — release planning spans services

These are legitimately cross-service concerns and belong at the admin top level.

### Initial Service Inventory

Before migration, enumerate services clearly. Current proposed set:

| Service | Scope | Example Features |
|---------|-------|------------------|
| `ai-workflow` | Commands, skills, rules, agentic workflow | agentic-workflow-modernization, workflow-simplification |
| `template-generation` | Templates, new-project.sh, template sync | template-doc-infrastructure, experimental-template, templates-enhancement |
| `release-management` | Release automation, readiness, distribution | release-automation-v2, release-readiness |
| `meta` (maybe) | Identity/strategy/process itself | dev-infra-identity-and-focus, worktree-feature-workflow |

If services can't be named clearly in one session, that signals the service layer isn't ready to commit to — stop at feature-first restructure and revisit later.

---

## Migration Implications

### What Changes

- Enumerate services and create service directories with README hubs
- All existing feature directories move to `admin/services/[service]/features/[topic]/`
- Each feature's phase artifacts consolidate into one feature directory
- Internal markdown links need rewriting (`../decisions/[topic]/X.md` → `../decisions/X.md` within the feature)
- Commands that reference these paths need updating (`/explore`, `/research`, `/decision`, `/design`, `/narrative`, `/transition-plan`) — they need to resolve service + feature, not just phase + feature
- CI scripts that scan `admin/` need path updates
- Templates (`standard-project/docs/maintainers/` and `learning-project/`) need parallel restructuring

### Migration Effort Estimate

- **Service enumeration:** Low (design exercise; 2-3 hours of thought + capture)
- **Filesystem moves:** Low (git mv handles it)
- **Link rewrites:** Medium-High (many internal references across docs; adding service layer adds a path segment)
- **Command updates:** Medium (6-7 commands reference these paths; need service-aware path resolution)
- **Template sync:** Medium (parallel structure in both templates)
- **Regression testing:** Medium (verify commands still work)

**Total:** 2-3 focused sessions for a careful migration with the service layer.

### Why HIGH Priority

1. **It fixes a fundamental model error.** Every future feature suffers from the current pigeonholing.
2. **Migration cost grows over time.** More features, more links, more commands = harder to migrate later.
3. **Blocks workflow evolution.** The proposed design step, interview-as-start-signal, cross-cutting artifacts — all require a home that the current structure doesn't naturally provide.
4. **Service-first supports eventual extraction.** If AI workflow authoring becomes its own repo (per ADR-005 of agentic-workflow-modernization, future skills repo consideration), the service directory is the natural extraction boundary. Doing this now with one service's worth of features is cheaper than doing it later with more.

### Why NOT Immediately

The agentic-workflow-modernization feature is mid-lifecycle (decisions done, design done, about to enter transition planning). Mid-implementation restructuring creates migration overhead on a feature still in motion.

**Recommended timing:** Complete transition planning for agentic-workflow-modernization, then do the restructure as a standalone feature before beginning Stage 1 skill conversion. This way, Stage 1 work happens against the cleaner structure.

---

## Staging Options (If Full Migration Not Ready)

### Option A: Two-stage restructure

1. **Stage 1:** Feature-first only (`admin/features/[topic]/`). Defer the service layer until observed need.
2. **Stage 2:** Add service layer (`admin/services/[service]/features/[topic]/`) once service boundaries are clear.

**Tradeoff:** Two migrations instead of one, but lower risk at each step.

### Option B: Cross-cutting promotion only

Move only `requirements.md` and `v1-scope.md` out of phase directories. Validates the "cross-cutting at root" pattern without committing to structural change.

**Tradeoff:** Lowest risk, but leaves the bigger problem unaddressed.

### Option C: Full restructure in one pass

Enumerate services, move everything, update all paths, in one coordinated migration.

**Tradeoff:** Highest upfront cost, lowest ongoing cost.

**Recommended:** Option C (full restructure) if service enumeration is easy, Option A (two-stage) if service boundaries are fuzzy.

---

## Related Int-Opps

- [pipeline-phase-start-signals.md](pipeline-phase-start-signals.md) — Start signals need a home that cross-cutting artifacts can share
- [design-step-in-pipeline.md](design-step-in-pipeline.md) — Design documents need a clear location
- [quality-attribute-catalog.md](quality-attribute-catalog.md) — Catalog is a cross-feature artifact (admin/planning/)

---

## Open Questions

- **Service naming:** Are the initial services (`ai-workflow`, `template-generation`, `release-management`, possibly `meta`) the right split? Worth one focused session to validate.
- **Cross-service features:** How should features like `workflow-simplification` that span multiple services be handled? (Proposed: primary-service filing + cross-reference.)
- **Meta/strategy features:** Does `dev-infra-identity-and-focus` belong in a `meta` service or at the admin root? Could go either way.
- **Partial-scope artifacts:** How do `admin/planning/features/[topic]/` directories map to the new structure? Likely consolidate into the feature directory under the service.
- **Template structure:** Does this affect `docs/maintainers/` in templates, or is that structure separate? Parallel restructure likely needed.
- **Relationship to four-arm architecture:** Each "arm" (dev-infra, work-prod, proj-cli, dev-toolkit) is a separate project. The service layer inside dev-infra is a sub-arm structure. Does this pattern suggest work-prod and proj-cli should also organize this way?

---

**Last Updated:** 2026-04-14
