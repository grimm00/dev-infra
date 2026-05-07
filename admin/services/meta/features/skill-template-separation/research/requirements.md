# Requirements — Skill-Template Separation

**Status:** Draft
**Created:** 2026-05-06
**Last Updated:** 2026-05-07

---

## Overview

Requirements extracted from research findings across 9 topics. This document starts as a skeleton and is populated during research-conduct, then consolidated and finalized during research-consolidate.

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

### FR-PROF-1: Profile Location
The per-repo profile MUST live at `~/.cursor/repos/<slug>.yaml` where slug is derived from `basename $(git remote get-url origin) .git`.
**Source:** Topic 2 — Finding 3 (pragmatic location), Finding 4 (slug derivation)

### FR-PROF-2: Schema Versioning
The profile MUST include a `schema_version` field (integer, starting at 1) for forward compatibility.
**Source:** Topic 2 — Finding 6 (schema versioning)

### FR-PROF-3: Minimum Schema Sections
The profile schema MUST support at minimum: `ticket:`, `paths:`, and `artifacts:` sections.
**Source:** Topic 2 — Finding 7 (ticket-intake seed), Analysis (schema shape)

### FR-PROF-4: Lookup Precedence Chain
Skills MUST resolve configuration via: invocation flag → AGENTS.md → external profile → skill defaults. Skills MUST NOT hardcode paths without consulting this chain.
**Source:** Topic 2 — Analysis (lookup convention), `skills-path-roots-configurable.md`

### FR-PROF-5: Slug Override
The profile MUST support an optional `slug:` override field for basename collision cases.
**Source:** Topic 2 — Finding 4 (slug derivation)

### FR-PROF-6: Backwards-Compatible Migration
The `ticket-intake/repos/<slug>.yaml` migration MUST be backwards-compatible — read unified profile first, fall back to legacy location.
**Source:** Topic 2 — Finding 7 (ticket-intake precedent), `per-repo-skill-profile-unified.md`

---

## Non-Functional Requirements

### NFR-MVPC-1: Fast Generation
The minimal template SHOULD be generatable in < 5 seconds with no network calls.
**Source:** Topic 1 — Finding 6 (modern scaffold UX)

### NFR-MVPC-2: Immediate Operability
The minimal template SHOULD produce a working project (passes CI, agents can operate) immediately after generation without additional setup steps.
**Source:** Topic 1 — Finding 6 (day-one productivity)

### NFR-PROF-1: Lookup Performance
Profile lookup MUST complete in < 100ms (single file read + YAML parse) to avoid perceptible latency on every skill invocation.
**Source:** Topic 2 — Analysis (lookup convention must be fast)

### NFR-PROF-2: Additive Schema
The schema MUST be additive — new optional sections can be added without requiring a schema_version bump or breaking existing profiles.
**Source:** Topic 2 — Finding 6 (schema versioning best practices)

### NFR-PROF-3: Human-Editable
The profile file MUST be human-editable with clear inline comments explaining each section's purpose.
**Source:** Topic 2 — Analysis (user-editable config)

---

## Constraints

### C-MVPC-1: AGENTS.md Must Be Parameterized
AGENTS.md content depends on project type (tech stack, framework, conventions). The template must parameterize this rather than shipping a generic placeholder.
**Source:** Topic 1 — Analysis

### C-MVPC-2: No Breaking Existing Projects
Existing projects generated from comprehensive templates are not affected — they keep their structure. Migration is a separate concern (Topic 5).
**Source:** Topic 1 — Analysis

### C-PROF-1: Cursor-Specific Location
The `~/.cursor/repos/` location is Cursor-specific. If multi-editor support becomes a requirement, migration to `~/.config/ai-workflow/repos/` is the documented path. v1 does not need to support this.
**Source:** Topic 2 — Finding 2 (XDG), Finding 3 (pragmatic tradeoff)

### C-PROF-2: State Separation
Controller state (setup status, last-seen, detection cache) MUST NOT be mixed with user-editable config in the same YAML sections.
**Source:** Topic 2 — Finding 2 (XDG config vs state), skill-package-controller Theme 2

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
