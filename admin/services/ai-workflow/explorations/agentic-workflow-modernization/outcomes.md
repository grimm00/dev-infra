# Exploration Outcomes — agentic-workflow-modernization

**Status:** ✅ Promoted to feature
**Created:** 2026-04-24

---

## What This Exploration Produced

This exploration started 2026-03-25 as a question: how should dev-infra's command and rules architecture relate to Cursor's evolving primitives (skills, rules, commands) and third-party workflow systems (Superpowers/Hex)?

### Primary Outcome: Feature

**[features/agentic-workflow-modernization/](../../features/agentic-workflow-modernization/)** — Full feature lifecycle promoted from this exploration. Has completed research (10 topics), decision interview, 5 ADRs, and design document. Stage 1 implementation pending.

### Secondary Outcomes: Internal Opportunities

The exploration also surfaced several systemic insights about the workflow itself, captured as int-opps:

- [decision-command-human-involvement](../../../../planning/opportunities/internal/dev-infra/improvements/decision-command-human-involvement.md) — `/decision` needs interview + options-not-answers + thin-slice patterns
- [pipeline-phase-start-signals](../../../../planning/opportunities/internal/dev-infra/improvements/pipeline-phase-start-signals.md) — Each pipeline phase needs explicit start artifacts
- [design-step-in-pipeline](../../../../planning/opportunities/internal/dev-infra/improvements/design-step-in-pipeline.md) — Pipeline gap between decision and transition-plan
- [feature-first-directory-structure](../../../../planning/opportunities/internal/dev-infra/improvements/feature-first-directory-structure.md) — Restructure admin/ to service/feature/phase
- [artifact-emission-strategy](../../../../planning/opportunities/internal/dev-infra/improvements/artifact-emission-strategy.md) — Move skills toward L2/L3 artifact abstraction
- [quality-attribute-catalog](../../../../planning/opportunities/internal/dev-infra/improvements/quality-attribute-catalog.md) — Standing NFR reference for design step
- [skill-config-rendering](../../../../planning/opportunities/internal/dev-infra/improvements/skill-config-rendering.md) — Helm-style values files for per-platform skill config
- [rules-layer-exploration](../../../../planning/opportunities/internal/dev-infra/improvements/rules-layer-exploration.md) — `.mdc` rules deserve their own exploration
- [conventions-md-gap](../../../../planning/opportunities/internal/dev-infra/improvements/conventions-md-gap.md) — Shared human+agent conventions need a home

### Tertiary Outcomes: Validated Spikes

Service-level spikes that originated from this exploration are documented in the feature's `spikes/` directory (since they validated feature-specific hypotheses):

- AGENTS.md portability (Spike A)
- Command-to-skill conversion patterns (Spike B)
- Nested skill discovery (post-research, validated skill family pattern)

---

## What's in This Directory

- **[exploration.md](exploration.md)** — Original 10 themes, constraints, spike determinations
- **[research-topics.md](research-topics.md)** — 11 research topics derived from exploration themes (10 conducted)
- **[outcomes.md](outcomes.md)** — This file

---

**Last Updated:** 2026-04-24
