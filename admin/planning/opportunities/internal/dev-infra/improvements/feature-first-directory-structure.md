# Service-First, Feature-Second Directory Structure

**Source:** /discuss session — agentic-workflow-modernization decision phase wrap-up (2026-04-14)
**Target:** dev-infra admin/ directory structure (all templates)
**Status:** 🔴 Not Started
**Priority:** HIGH
**Effort:** HIGH (filesystem migration + command path updates + link rewrites)
**Created:** 2026-04-14
**Last Updated:** 2026-04-24

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

**The top-level dimension adapts to the project; the work unit is the middle level; phases are steps (when applicable) at the leaf level.**

Engineering teams organize by domain first (service, category, area), then by scoped work unit (feature, ticket, investigation), then by lifecycle step (when the work has phases). The current admin/ structure inverts this by placing phases at the top level, which creates two problems: work units fragment across phase directories, and the natural top-level dimension (whatever it is for that project) has no home at all.

### The General Pattern

```
admin/
└── [top-level-dimension]/
    └── [work-unit]/
        ├── [cross-cutting artifacts at unit root]
        └── [phase subdirs, if the unit has a lifecycle]
```

### Top-Level Dimension Adapts Per Project

Different project types have different natural top-level dimensions:

| Project Type | Top-Level Dimension | Work Unit | Example |
|--------------|--------------------|-|---------|
| dev-infra | Service (domain) | Feature | `services/ai-workflow/features/agentic-workflow-modernization/` |
| support-shark | Work category | Ticket | `categories/tickets/t-1234/` |
| Product repo | Service (bounded context) | Feature | `services/auth/features/sso-integration/` |
| Personal knowledge base | Life area | Project | `areas/work/projects/[name]/` |

The structure isn't "services at the top" — it's "**choose your top-level dimension**, then work unit, then phases (optional)." The flexibility is the point.

### Dev-Infra's Top-Level Dimension: Services

Dev-infra is a **multi-service project** that has been masquerading as single-service:

- **AI workflow authoring** (`ai-workflow`) — commands, skills, rules, the thinking pipeline modernization
- **Template generation** (`template-generation`) — new-project.sh, templates, template sync
- **Release management** (`release-management`) — release automation, readiness, distribution
- **Meta** (`meta`) — dev-infra about itself: identity, process, structure, worktree workflow, directory organization

The **meta** service is particularly important. It holds things that are about the project's own process and structure, not about its external products. Without a meta service, concerns like dev-infra-identity-and-focus, worktree-feature-workflow, and the directory restructure itself have no natural home.

Grouping features by service reduces cognitive load dramatically (expand the service you care about, collapse the rest) and creates natural extraction seams for future repo splits.

### Why Phase-First Fails Beyond dev-infra

The current structure assumes **all work follows the full feature lifecycle** (explore → research → decision → design → transition → task). This fails for:

- **Support tickets** (support-shark): investigate → fix → close. Most tickets skip the pipeline.
- **One-off investigations:** scoped question, brief answer, done. No design step.
- **Experiments:** hypothesis → test → learn. Lifecycle doesn't match the full pipeline.

The adaptive top-level model accommodates all of these. Phase-first cannot.

---

## Proposed Solution

For **dev-infra specifically**, restructure `admin/` to be **service-first, then work-category, then work-unit, then phase**. Three work categories live under each service: `explorations/`, `features/`, and `maintenance/`. (Other projects adopt the same pattern with their own top-level dimension.)

```
admin/
├── services/
│   ├── ai-workflow/
│   │   ├── README.md                           ← service overview
│   │   ├── explorations/                       ← service-level questions
│   │   │   └── [topic]/
│   │   │       ├── exploration.md              ← questions asked
│   │   │       └── outcomes.md                 ← what came of it (features? maintenance? answered?)
│   │   ├── features/                           ← new capabilities (full pipeline)
│   │   │   ├── agentic-workflow-modernization/
│   │   │   │   ├── requirements.md             ← cross-cutting, feature root
│   │   │   │   ├── v1-scope.md
│   │   │   │   ├── research/
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── research-summary.md
│   │   │   │   │   └── topic-*.md
│   │   │   │   ├── decisions/
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── decision-interview.md
│   │   │   │   │   └── adr-*.md
│   │   │   │   ├── designs/
│   │   │   │   │   └── design.md
│   │   │   │   ├── spikes/                     ← feature-level spikes
│   │   │   │   │   └── [name]/
│   │   │   │   └── narrative.md
│   │   │   └── workflow-simplification/
│   │   │       └── ... (same structure)
│   │   └── maintenance/                        ← structural, CI, tooling (lighter pipeline)
│   │       └── [name]/
│   │           └── [lightweight phases]
│   ├── template-generation/
│   │   ├── README.md
│   │   ├── explorations/
│   │   ├── features/
│   │   │   ├── template-doc-infrastructure/
│   │   │   └── experimental-template/
│   │   └── maintenance/
│   ├── release-management/
│   │   ├── README.md
│   │   ├── explorations/
│   │   ├── features/
│   │   │   └── release-automation-v2/
│   │   └── maintenance/
│   └── meta/                                   ← dev-infra about itself
│       ├── README.md
│       ├── explorations/
│       ├── features/
│       │   ├── dev-infra-identity-and-focus/
│       │   └── worktree-feature-workflow/
│       └── maintenance/
│           └── directory-restructure/          ← THIS WORK lives here
└── planning/
    └── opportunities/                          ← stays (cross-service)
```

### Four Levels, Each With a Purpose

| Level | Purpose | Changes when... |
|-------|---------|-----------------|
| **Service** | Product/domain grouping | A new product area emerges (rare) |
| **Work category** | Kind of work (exploration, feature, maintenance) | Fixed — these three categories are structural |
| **Work unit** | Scoped piece of work | A new unit begins (often) |
| **Phase** | Workflow step within a unit (optional) | Only for units with lifecycles (features) |

### Work Categories

**`explorations/`** — Questions asked at the service level. Can fan out to:
- **A. Feature(s):** exploration leads to new capability → promote to `features/[name]/`
- **B. Maintenance item(s):** exploration surfaces structural/CI/tooling work → promote to `maintenance/[name]/`
- **C. Answered questions:** exploration concludes without action → stays in `explorations/` with `outcomes.md` documenting the conclusion

Explorations do NOT inherit the full feature pipeline. Their artifacts are `exploration.md` and optionally `outcomes.md`. If exploration reveals feature-worthy work, a new feature directory is created that references the exploration.

**`features/`** — New capabilities that go through the full thinking pipeline (requirements → research → decisions → designs → transition-plan → task). Each feature is self-contained with cross-cutting artifacts at its root.

**`maintenance/`** — Structural refactoring, CI improvements, tooling, infrastructure, housekeeping. Lighter pipeline than features — typically just planning and execution, no research/decision/design formality unless the scope grows.

### Why This Fixes the "Explorations Treated Like Features" Problem

The current `admin/explorations/[topic]/` treats every exploration as a feature-in-waiting. In reality, many explorations:
- Answer a question and need no implementation
- Surface CI or tooling improvements (not features)
- Reveal that the right action is nothing

The new structure makes this explicit: an exploration's outcome is documented, and it's promoted to the right work category — or stays archived if no action is warranted. Explorations never get forced down a feature-shaped pipeline just because they happen to exist.

### Cross-Cutting Artifacts Live at the Work-Unit Root

For features specifically, cross-cutting artifacts belong at the feature root, not under a phase directory:

- `requirements.md` — shaped throughout the lifecycle (research, interview, spikes), not owned by research
- `v1-scope.md` — synthesis from interview + ADRs, not owned by decisions
- `status-and-next-steps.md` — current state, not tied to any phase

This addresses the original pigeonholing problem: cross-cutting content has a natural home at the root of the thing it cuts across.

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

| Service | Scope | Example Features | Example Maintenance |
|---------|-------|------------------|---------------------|
| `ai-workflow` | Commands, skills, rules, agentic workflow | agentic-workflow-modernization, workflow-simplification | (future: skill sync, command lifecycle tooling) |
| `template-generation` | Templates, new-project.sh, template sync | template-doc-infrastructure, experimental-template, templates-enhancement | Template sync validation, generator improvements |
| `release-management` | Release automation, readiness, distribution | release-automation-v2, release-readiness | CI improvements for releases |
| `meta` | Dev-infra about itself: identity, process, structure | dev-infra-identity-and-focus, worktree-feature-workflow | **directory-restructure (this work)**, template sync infrastructure |

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

### Recommended Timing (Updated 2026-04-24)

**Restructure first, before agentic-workflow-modernization transition planning.**

Original recommendation was to restructure between transition planning and Stage 1 conversion. Revised reasoning:

1. **Stage 1 skills reference feature paths in their bodies.** If skills are authored before the restructure, every converted skill needs path updates after. Cleaner to author against permanent paths.
2. **Restructure is lower effort than Stage 1 conversion.** Structural refactoring with no behavioral requirements vs 5 skills × strict rubric × regression testing.
3. **Restructure validates the proposed pattern.** If service boundaries reveal problems, we adjust before committing to workflow migration. Otherwise we risk migrating twice.
4. **Framed as maintenance, not a feature.** Under the refined model, directory restructure lives in `services/meta/maintenance/directory-restructure/`. Lighter pipeline — planning + execution, no research/decisions/design formality needed.

### Framing: This Work Is Maintenance

The restructure itself exemplifies the work-category distinction this int-opp proposes:

- **Not a feature:** No new capability, just structural refactoring of existing infrastructure
- **Not an exploration:** The thinking is already done (this int-opp + discussion)
- **Is maintenance:** Structural improvement to how dev-infra organizes its own artifacts

Therefore it lives under `meta/maintenance/` and gets the lighter pipeline: service enumeration + migration plan + execution + verification. No formal requirements, research, decision, or design phases.

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

## Capstone: Tool Injection vs Framework Marriage

The restructure is not just aesthetic. It changes dev-infra's social contract with downstream projects.

### The Current Contract (Heavyhanded, Marriage-Like)

The phase-first `admin/` structure says to an adopting project: *"Here is dev-infra's worldview. Your directory looks exactly like ours. Your phases are `research`, `decisions`, `designs`, `narratives`. You will internalize our mental model before you get any value."*

This is a high-commitment contract. Adopters must be ideologically aligned before they try anything. They "marry into" dev-infra's philosophy. If they have their own conventions, there's no partial adoption path — it's all or nothing.

### The Proposed Contract (Light, Tool-Like)

The service-first structure says: *"Here are distinct tools (`ai-workflow`, `template-generation`). Pick the ones that solve your problems. The patterns inside each are self-contained — you don't need to understand all of them to use one."*

This is a low-commitment contract. Adopters can try one service without buying into the others. They can combine dev-infra's services with their own conventions. Adoption is additive, not substitutive.

### Why This Matters

1. **Adoption threshold lowers.** Heavy contracts gatekeep. Light tools welcome.
2. **Consumer autonomy is respected.** Other projects have their own conventions. The modular structure admits that dev-infra's way isn't the only way — it's a useful way.
3. **Extraction becomes a non-event.** If a service becomes its own repo, adopters who used only that service never notice. The boundary was already there.
4. **Matches successful tool patterns.** Hex is a plugin. Cursor skills are discrete. Unix philosophy is small tools that compose. All work because adoption is additive.

### Identity Refinement

ADR-001 of dev-infra-identity-and-focus established dev-infra as a "template factory." This restructure refines that identity: **dev-infra is a factory producing tools, not a framework imposing structure.** A factory doesn't marry you to anything — it produces artifacts you use as you see fit.

The current phase-first structure is subtly frameworky ("here's how you organize features"). The service-first structure is factory-like ("here are services we've built — use the ones that fit").

### Implication

This reframes the restructure as more than a directory cleanup. It's a social contract update. Worth considering whether this deserves its own ADR when the restructure happens, or at least a callout in the ADR that captures the structural decision.

---

## Related Int-Opps

- [pipeline-phase-start-signals.md](pipeline-phase-start-signals.md) — Start signals need a home that cross-cutting artifacts can share
- [design-step-in-pipeline.md](design-step-in-pipeline.md) — Design documents need a clear location
- [quality-attribute-catalog.md](quality-attribute-catalog.md) — Catalog is a cross-feature artifact (admin/planning/)

---

## Validation Across Projects

### Dev-Infra (current session)

- `requirements.md` pigeonholed under `research/` because phase-first implied research was the only requirement generator
- `v1-scope.md` had no natural home (ended up in `decisions/` as a placement of convenience)
- Feature traceability fragmented across 6+ top-level directories

### Support-Shark (Jira ticket hub)

- Phase-first cannot accommodate ticket-based work (tickets don't follow the full feature lifecycle)
- A desired `jira/ticket-1234/` directory has no phase-first home
- The adaptive top-level model accommodates this as `categories/tickets/t-1234/`

Two independent failure modes in two different projects = the phase-first structure has a real bug, not just a personal preference. This is a generalizable workflow pattern, not a dev-infra-specific fix.

---

## Open Questions

- **Service naming:** Are the initial services (`ai-workflow`, `template-generation`, `release-management`, possibly `meta`) the right split? Worth one focused session to validate.
- **Cross-service features:** How should features like `workflow-simplification` that span multiple services be handled? (Proposed: primary-service filing + cross-reference.)
- **Meta/strategy features:** Does `dev-infra-identity-and-focus` belong in a `meta` service or at the admin root? Could go either way.
- **Mixed work units in one project:** Can a project have both features AND tickets AND investigations (each with different lifecycles) coexisting under different top-level dimensions? Likely yes, but needs a worked example.
- **Partial-scope artifacts:** How do `admin/planning/features/[topic]/` directories map to the new structure? Likely consolidate into the feature directory under the service.
- **Template structure:** Does this affect `docs/maintainers/` in templates, or is that structure separate? Parallel restructure likely needed.
- **Relationship to four-arm architecture:** Each "arm" (dev-infra, work-prod, proj-cli, dev-toolkit) is a separate project. The service layer inside dev-infra is a sub-arm structure. Does this pattern suggest work-prod and proj-cli should also organize this way?

---

**Last Updated:** 2026-04-24
