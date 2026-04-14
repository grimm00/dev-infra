# Skill Configuration Rendering (Helm-Style Values)

**Source:** /discuss session — agentic-workflow-modernization interview follow-up (2026-04-14)
**Target:** dev-infra skill distribution pipeline (v2+)
**Status:** 🔴 Not Started
**Priority:** LOW (v2+ concern, but format awareness needed in v1)
**Effort:** MEDIUM (rendering script + values file convention)
**Confidence:** ⚠️ Iffy — won't know if it feels right until we try it. Cheap to revert (static keys).
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Problem Statement

Skills have YAML frontmatter (description, flags) and a markdown body. When distributing skills across platforms (Cursor vs Claude Code) or contexts (personal vs team), the *content* stays the same but the *configuration* needs to differ:

- `disable-model-invocation`: `true` for Cursor (manual invocation), `false` for Claude Code (auto-detection)
- `description`: invocation-trigger wording for Cursor, intent-classifier wording for Claude Code
- Path references: may differ per project type or template structure

Currently, achieving this requires maintaining separate files or manually editing before shipping. Neither scales.

---

## Proposed Solution: Helm-Style Values Files

**Analogy:** Helm separates chart templates from values files. The same chart renders differently per environment. Apply the same pattern to skills.

### Concept

```yaml
# .claude/skills/discuss/SKILL.md (template)
---
description: "{{ .description }}"
disable-model-invocation: {{ .disable_auto_detect | default true }}
---

## Behavioral Contract
...
```

```yaml
# values/cursor.yaml (authoring mode)
description: "Use when the user says /discuss or /discuss [topic]"
disable_auto_detect: true
```

```yaml
# values/claude-code.yaml (distribution mode)
description: "Use when the user is reacting to findings, questioning assumptions, or thinking through implications without wanting to create artifacts"
disable_auto_detect: false
```

### Rendering

A script (`render-skills.sh --env cursor`) would produce static SKILL.md files from templates + values. Neither platform has a native rendering step — this is our tooling.

---

## What This Separates

| Layer | What It Contains | Changes Per... |
|-------|-----------------|----------------|
| **Skill body** | Behavioral contract, gotchas, workflow | Rarely (skill evolution) |
| **Skill config** | Description, flags, path conventions | Per platform/environment |

This is the same content/config separation that Helm brought to infrastructure manifests.

---

## Why "Iffy"

- Neither Cursor nor Claude Code expects templated skills — this is a custom layer we'd build and maintain
- The number of config variations may be small enough (2-3 environments) that static copies are cheaper than a rendering pipeline
- Template syntax in SKILL.md could confuse agents if they read the template source instead of rendered output
- The value only materializes at distribution scale — for a sole author, it's overhead

**Cheap to reverse:** If rendering feels wrong, the fallback is static per-platform copies with a diff check. The skill body stays the same either way.

---

## V1 Implication

V1 authors static skills with no rendering. But the *awareness* of content/config separation can inform v1 skill design:

- Keep platform-specific config (description, flags) cleanly separated from behavioral content
- Don't hardcode path conventions deep in skill body text where they'd be hard to parameterize later
- Write descriptions that could be swapped without touching the body

This is a "design for future rendering without building it now" posture.

---

## Connection to Other Decisions

- **C6-1 (hooks/CLI deferred):** Rendering tooling lives in the same deferred infrastructure bucket
- **C6-3 (auto-detection deferred to distribution):** The description swap is the primary use case
- **FR-21 (dual-location description):** Already anticipates description serving different roles — rendering formalizes this
- **CP-1 (explicit over implicit):** Rendering is explicit (you choose the values file), unlike auto-detection

---

## Related

- [decision-interview.md](../../../../decisions/agentic-workflow-modernization/decision-interview.md) — Section 6.3 (auto-detection insight)
- [v1-scope.md](../../../../decisions/agentic-workflow-modernization/v1-scope.md) — C6-1, C6-3
- [Topic 5: Skill Location](../../../../research/agentic-workflow-modernization/topic-5-skill-location-and-portability.md)
- [Topic 6: Dual Distribution](../../../../research/agentic-workflow-modernization/topic-6-dual-distribution.md)

---

**Last Updated:** 2026-04-14
