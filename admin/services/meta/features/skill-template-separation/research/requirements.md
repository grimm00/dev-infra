# Requirements — Skill-Template Separation

**Status:** Draft
**Created:** 2026-05-06
**Last Updated:** 2026-05-06

---

## Overview

Requirements extracted from research findings across 7 topics. This document starts as a skeleton and is populated during research-conduct, then consolidated and finalized during research-consolidate.

---

## Functional Requirements

### FR-MVPC-1: AGENTS.md Required
The minimal template MUST include AGENTS.md with project conventions sufficient for AI agents to operate without exploration.
**Source:** Topic 1 — Finding 2 (AGENTS.md standard), Finding 7 (agent landing site)

### FR-MVPC-2: proj-cli State File Required
The minimal template MUST include `.dev-infra.yml` for proj-cli state tracking (template version, customizations).
**Source:** Topic 1 — Finding 3 (proj-cli needs)

### FR-MVPC-3: Git Hygiene for Agent Scratch
The minimal template MUST include `.gitignore` with entries for agent scratch paths (`.scratch/`, `tmp/`, `admin/tmp/`).
**Source:** Topic 1 — Finding 7 (scratch path convention)

### FR-MVPC-4: README with Project Identity
The minimal template SHOULD include a README.md with project identity and getting-started instructions.
**Source:** Topic 1 — Finding 6 (modern scaffold convergence)

### FR-MVPC-5: No Pre-Built Skill Structure
The minimal template SHOULD NOT include directory structure that skills create on demand (explorations, research, decisions, planning).
**Source:** Topic 1 — Finding 4 (skills create on demand), Finding 5 (80% analysis)

### FR-MVPC-6: No Bundled Skills/Commands/Agents
The minimal template MUST NOT bundle skills, commands, or agents (these are global installs with independent lifecycle).
**Source:** Topic 1 — Finding 5 (migration already done)

---

## Non-Functional Requirements

### NFR-MVPC-1: Fast Generation
The minimal template SHOULD be generatable in < 5 seconds with no network calls.
**Source:** Topic 1 — Finding 6 (modern scaffold UX)

### NFR-MVPC-2: Immediate Operability
The minimal template SHOULD produce a working project (passes CI, agents can operate) immediately after generation without additional setup steps.
**Source:** Topic 1 — Finding 6 (day-one productivity)

---

## Constraints

### C-MVPC-1: AGENTS.md Must Be Parameterized
AGENTS.md content depends on project type (tech stack, framework, conventions). The template must parameterize this rather than shipping a generic placeholder.
**Source:** Topic 1 — Analysis

### C-MVPC-2: No Breaking Existing Projects
Existing projects generated from comprehensive templates are not affected — they keep their structure. Migration is a separate concern (Topic 5).
**Source:** Topic 1 — Analysis

---

## Assumptions

*(Extracted during research-conduct)*

---

## Traceability

| Requirement | Source Topic | Evidence |
|-------------|-------------|----------|
| *(populated during consolidate)* | | |

---

## Next Steps

Requirements are extracted as research proceeds. After all topics are complete, use research-consolidate to deduplicate, prioritize, and move from Draft to Final status.
