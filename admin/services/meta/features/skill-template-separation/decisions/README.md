# Decisions Hub — Skill-Template Separation

**Purpose:** Index every Architecture Decision Record for `skill-template-separation`, linking outward to research summaries, requirements extracts, and the decision interview artifact.

---

## Linked inputs

| Artifact | Location |
|-----------|----------|
| Research summary | [../research/research-summary.md](../research/research-summary.md) |
| Requirements | [../research/requirements.md](../research/requirements.md) |
| Decision interview | [./decision-interview.md](./decision-interview.md) |

---

## ADR index

| File | Decision (one sentence) | Status |
|------|--------------------------|--------|
| [adr-001-separation-model.md](adr-001-separation-model.md) | Skill corpus becomes a separate product with its own repo; templates carry only a manifest | 🔴 Proposed |
| [adr-002-installation-architecture.md](adr-002-installation-architecture.md) | Symlink farm from corpus project dir to editor paths; three-tier distribution model | 🔴 Proposed |
| [adr-003-per-repo-profile-schema.md](adr-003-per-repo-profile-schema.md) | Unified profile at `~/.config/ai-workflow/repos/<slug>.yaml` with ticket/paths/artifacts sections | 🔴 Proposed |

---

## Supporting summary checklist

See [decisions-summary.md](decisions-summary.md) for a one-screen rollup of all ADR intents and requirements impact.
