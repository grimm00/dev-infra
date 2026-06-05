# .dev-infra.yml Reference

**Purpose:** Schema reference for the per-project dev-infra metadata file  
**Status:** ✅ Active  
**Last Updated:** 2026-06-05

---

## Overview

Every project generated from a dev-infra template includes a **`.dev-infra.yml`** file at the repository root. The file records which template produced the project, which dev-infra version was used, and — per [ADR-001](../admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md) — which **skills the template workflow assumes** via the `expected_skills` manifest.

Templates do **not** bundle skill copies. The manifest tells `proj-cli` (and humans) which globally installed skills align with the template's planning and workflow conventions.

**Related:** [Template Files Guide](TEMPLATE-FILES.md) · [Skill-Template Separation ADR-001](../admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md)

---

## File Location

| Property | Value |
|----------|-------|
| **Path** | `.dev-infra.yml` (project root) |
| **Format** | YAML |
| **Checked in** | Yes — version-controlled project metadata |

---

## Schema (v1)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `template` | string | Yes | Template type: `standard-project` or `learning-project` |
| `version` | string | Yes | dev-infra version used at project generation (semver) |
| `created` | string (date) | Recommended | ISO date (`YYYY-MM-DD`) when the project was generated |
| `expected_skills` | list[string] | Yes (ADR-001) | Bare skill identifiers the template workflow assumes |

Future fields (`last_sync`, `sync`, `customizations`) may be added when template sync features land — see [template-metadata research](../admin/services/template-generation/features/template-metadata/research/research-essential-fields.md).

---

## `expected_skills` Field

### Purpose

Declares the skill corpus entries a generated project expects (FR-BNDL-2). Supports warn-not-error validation during `proj-cli` setup (FR-BNDL-3, implemented in Group 5 of the skill-template-separation plan).

### Format

```yaml
expected_skills:
  - commit
  - decision
  - explore
  # ... bare identifiers, one per list item
```

**Rules:**

1. **Bare identifiers only** — use the skill directory name (e.g. `explore`), not a service prefix (`ai-workflow/explore`).
2. **Sorted alphabetically** in template sources (recommended for diff stability).
3. **Strings only** — no nested objects or version pins in v1.
4. **Non-blocking** — missing skills must never fail project setup (NFR-BNDL-1).

### Identifier convention decision

| Option | Example | Verdict |
|--------|---------|---------|
| Bare names | `explore` | ✅ **Chosen** — matches global install paths (`~/.cursor/skills/explore/`, `~/.claude/skills/explore/`) |
| Namespaced | `ai-workflow/explore` | ❌ Rejected — no stable namespace in the external corpus product yet; adds lookup complexity without benefit for v1 |

Group 5 (`proj-cli` validation) resolves each entry by checking for an installed skill directory under the user's global skills path.

### Validation behavior (proj-cli)

When `proj-cli` setup runs (Group 5):

1. Read `expected_skills` from `.dev-infra.yml`.
2. For each identifier, check whether the skill is installed globally.
3. **Warn** for each missing skill with install guidance.
4. **Never error** or block setup — projects must work without skills installed (graceful degradation via AGENTS.md and docs).

---

## Example

**Standard project template** (`templates/standard-project/.dev-infra.yml`):

```yaml
template: standard-project
version: "[DEV_INFRA_VERSION]"
created: "[CREATED_DATE]"

expected_skills:
  - commit
  - decision
  - discuss
  - explore
  - handoff
  - int-opp
  - narrative
  - plan-review
  - pre-commit-review
  - reflect
  - research
  - spike
  - write-plan
```

Placeholders `[DEV_INFRA_VERSION]` and `[CREATED_DATE]` are substituted when project generation tooling fills metadata (future `new-project.sh` / `proj-cli` enhancement).

---

## Template inventory (2026-06-05)

Both `standard-project` and `learning-project` templates ship the same 13-entry list — the skills formerly bundled under `templates/standard-project/.claude/skills/` before ADR-001 template cleanup (PR #107). The learning template never had a bundled skills tree but uses the same workflow commands and assumes the same global skill corpus.

---

## See Also

- [Template Files Guide](TEMPLATE-FILES.md) — `.dev-infra.yml` in template file inventory
- [Template Metadata Requirements](../admin/services/template-generation/features/template-metadata/requirements.md) — FR-8 file naming
- [Skill-Template Separation implementation plan](../admin/services/meta/features/skill-template-separation/planning/implementation-plan.md)
