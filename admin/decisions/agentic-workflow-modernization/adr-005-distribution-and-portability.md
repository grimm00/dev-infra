# ADR-005: Distribution and Portability

**Status:** Accepted
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Context

Skills need a canonical authoring location, cross-platform portability constraints, and a distribution strategy. The interview heavily deferred distribution concerns to v2+ (C6-1, C6-2, C6-3, C3-3) but the authoring location affects v1 development workflow.

Key requirements:

- FR-12: `.claude/skills/` as canonical location
- FR-13: No platform-breaking features in portable skills
- FR-14: Canonical source in templates
- FR-15: Marketplace-compatible format (structural constraint)
- FR-16: Distribution channel declaration (deferred)
- FR-9: Template sync manifest for skills (follows)
- FR-10: Doc-gen template relocation to assets/ (follows)
- C-3: Marketplace distribution blocked for explicit-only skills (mitigated)
- NFR-2: Marketplace updates must not overwrite customizations
- A-2: Cross-platform compatibility validated

---

## Decision

**Author in `templates/standard-project/.claude/skills/` from day one. Distribution and marketplace deferred to v2+.**

### V1 Authoring Location

Skills are authored in `templates/standard-project/.claude/skills/` as the canonical source (FR-14). This means:

- Skills live alongside the template they'll eventually be distributed through
- No migration needed when template sync activates
- `learning-project` receives skills via template sync (FR-9) when ready (C3-3: not day-one)
- Dev-infra's own `.claude/skills/` directory is reserved for spike test fixtures and dev-infra-specific skills (not template-distributed)

### Cross-Platform Portability

All v1 skills must be portable (FR-13). Prohibited features in skill bodies:

- `context: fork` (Claude Code only)
- `$ARGUMENTS` / `$N` substitution (Claude Code only)
- `` !`command` `` shell preprocessing (Claude Code only)
- `${CLAUDE_SKILL_DIR}` (Claude Code only)

These are enforced during the conversion quality gate (ADR-004).

### Marketplace-Compatible Format (FR-15)

Skills are structured so that the skill directory can be copied 1:1 into a Claude Code marketplace plugin without transformation:

- `SKILL.md` at skill root
- Companion files in subdirectories (`assets/`, `references/`)
- No references to paths outside the skill directory

This is a structural constraint applied during authoring, not a distribution mechanism.

### What Is Deferred to V2+

| Concern | Status | Trigger |
|---------|--------|---------|
| Template sync for skills (FR-9) | Deferred | After Stage 1 skills stabilize |
| Doc-gen template relocation (FR-10) | Deferred | During conversion of generating skills |
| Distribution channel declaration (FR-16) | Deferred | When marketplace becomes relevant |
| Team marketplace shipping | Deferred (C6-3) | When team distribution begins |
| Helm-style config rendering | Deferred (int-opp) | When multi-environment distribution needed |
| Skills repo extraction | Deferred | When independent versioning is warranted by consumer demand |
| proj-cli / proj-clone integration (C6-2) | Parallel | Not a v1 dependency |

### Auto-Detection Policy

- All workflow skills: `disable-model-invocation: true` (FR-2) for Cursor
- When shipped to Claude Code (v2+): flag toggled or description tuned for intent matching
- Platform adapter is per-environment config, not content fork (C3-2 spike finding)

---

## Consequences

### Positive

- Canonical source established from day one -- no later migration
- Marketplace-compatible format is a structural constraint, not a distribution burden
- Cross-platform portability enforced during quality gate
- Heavy deferral keeps v1 focused on skill quality, not distribution infrastructure
- Skills repo extraction remains an option if complexity warrants it later

### Negative

- Authoring in `templates/standard-project/` is slightly less convenient for personal use (deeper path)
- Dev-infra's own `.claude/skills/` is not where workflow skills live (potential confusion)
- Template sync is needed before learning-project gets skills

---

## Alternatives Considered

### Alternative A: Author in Dev-Infra Root `.claude/skills/`

Skills at repo root, template sync copies them to templates later.

**Why not chosen:** Creates a migration step. FR-14 is clear that templates are the canonical source. Starting there avoids the "copy from root to templates" step and establishes the right mental model from day one.

### Alternative C: Separate Skills Repository

Extract skills into their own repo for independent versioning.

**Why not chosen:** Premature for v1. No independent consumers exist yet (sole user, C2-1). Adds a fifth arm to the four-arm architecture (context-switching risk, C8-3). The natural extraction point is when team distribution creates real consumer demand. Authoring in dev-infra preserves full traceability between skills and the research/decisions that informed them.

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-12 (`.claude/skills/` canonical) | Satisfied -- canonical path within templates |
| FR-13 (no platform-breaking features) | Enforced during conversion quality gate |
| FR-14 (canonical source in templates) | Directly satisfied -- authoring location |
| FR-15 (marketplace-compatible format) | Structural constraint applied during authoring |
| FR-16 (distribution channels) | Deferred to v2+ |
| FR-9 (template sync) | Deferred until skills stabilize |
| FR-10 (doc-gen relocation) | Deferred until generating skills converted |
| C-3 (marketplace bug) | Mitigated by dual-distribution model |
| NFR-2 (no overwrite) | Inherently satisfied by Claude Code plugin cache |
| A-2 (cross-platform) | Validated; portability enforced per skill |

---

## References

- [V1 Scope](v1-scope.md) -- C2-3, C3-3, C6-1, C6-2, C6-3
- [Requirements](../../research/agentic-workflow-modernization/requirements.md)
- [Topic 5: Skill Location and Portability](../../research/agentic-workflow-modernization/topic-5-skill-location-and-portability.md)
- [Topic 6: Dual Distribution](../../research/agentic-workflow-modernization/topic-6-dual-distribution.md)
- [Skill Config Rendering Int-Opp](../../planning/opportunities/internal/dev-infra/improvements/skill-config-rendering.md)

---

**Last Updated:** 2026-04-14
