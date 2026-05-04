# Audit: `handoff` command → handoff skill conversion

**Source:** `.cursor/commands/handoff.md` (~190 lines)
**Feature:** agentic-workflow-modernization / Stage 4 — Group 2 — Task 6
**Date:** 2026-05-03
**Rubric:** five-property skill contract (*Observable*, *Bounded*, *Outcome-framed*, *Delta-only*, *Failure-aware*).

---

## Executive summary

| Finding | Detail |
|---------|--------|
| Primary value | **Session continuity artifact** — git snapshot + conversational state captured into a transient markdown file for resume or teammate pickup. |
| Shape | **Procedural** with a **large inline template block** requiring extraction to `assets/handoff-template.md` for Delta-only hygiene. |
| Path detection | Same three-tier precedent as reviewer/commit: admin/tmp → tmp → lightweight `tests/tmp/`. Lightweight uses **flat** `tests/tmp/handoff-[topic].md` (no `handoffs/` subfolder). |
| Resume path | **`--resume`** is a distinct procedural branch — search glob `handoff-*.md`, disambiguate if multiple, summarize for assistant context. |

---

## Procedural vs template separation

| Region | Classification | Skill action |
|--------|----------------|-------------|
| Configuration / Usage | Procedural | Keep in SKILL Configuration + Usage tables |
| Gather-context shell blocks | Procedural | Workflow § gather |
| Markdown **Template** fence | Template **asset** | **Move** verbatim to `assets/handoff-template.md` |
| `--resume` process | Procedural | Dedicated SKILL section |
| Tips / Related | Mixed | Compress to Gotchas |

**Approximate share**

| Bucket | Share |
|--------|-------|
| Procedural | **~65%** |
| Template scaffolding | **~25%** |
| Narrative coaching | **~10%** |

---

## Five-property check

| Property | Pass? | Remediation |
|----------|-------|--------------|
| **Observable** | Yes | Output filepath + surfaced document body |
| **Bounded** | Yes | Topic auto-detect from branch bounded; resume limited to filesystem search |
| **Outcome-framed** | Yes | Written `handoff-*.md` + user confirmation |
| **Delta-only** | **Fail (raw)** | Fence must relocate to **`assets/handoff-template.md`** |
| **Failure-aware** | Partial | SKILL must escalate missing base dirs / non-gitignored destinations |

---

## Decomposition recommendation (Task 7)

1. SKILL at `templates/standard-project/.claude/skills/handoff/SKILL.md`.
2. `assets/handoff-template.md` — canonical copy of command Template.
3. `references/structure.yaml` declaring output filename pattern (`handoff-{topic}.md`), root detection rows, **`--resume`** search globs.
