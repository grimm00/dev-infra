# skill-template-separation

**Purpose:** Formalize skill corpus as a separate product from dev-infra templates (ADR-001)
**Status:** ✅ Complete
**Created:** 2026-05-22
**Completed:** 2026-06-09

---

## Quick Links

- **[ADR-001: Separation Model](decisions/adr-001-separation-model.md)** — accepted decision
- **[Implementation Plan](planning/implementation-plan.md)** — 25 tasks across 6 groups
- **[Status & Next Steps](planning/status-and-next-steps.md)** — progress tracking
- **[.dev-infra.yml schema](../../../../../docs/DEV-INFRA-YML.md)** — `expected_skills` manifest reference

---

## Overview

Implements ADR-001: removes bundled skills/commands/agents from templates, retires `template-sync-manifest.txt`, introduces `expected_skills` in `.dev-infra.yml`, and adds proj-cli warn-not-error validation. Sibling ADRs (installation architecture, per-repo profile schema) are out of scope — separate plans.

**Supersedes:** [global-command-distribution](../global-command-distribution/) (December 2025)

**Extends:** [four-arm-architecture](../four-arm-architecture/) — resolves what ships in templates vs. the external corpus.

---

## Phase Directories

- **[decisions/](decisions/)** — ADR-001 (accepted); ADR-002/003 on research branch
- **[planning/](planning/)** — implementation plan, task groups, plan reviews

## Provenance

Exploration: [../../explorations/skill-template-separation/](../../explorations/skill-template-separation/)
