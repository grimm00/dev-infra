# Feature-Scale Work Bypassed PR via the Docs-Direct Allowance

**Source:** Realization mid-`skill-corpus-installation` (2026-06-09)
**Target:** dev-infra Git Flow conventions + `/task` workflow
**Status:** 🔴 Not Started
**Priority:** MEDIUM (process integrity; caught after ~12 direct commits)
**Effort:** LOW (a convention clarification + a `/task` nudge)
**Confidence:** ✅ Clear — the divergence is concrete and observed.
**Created:** 2026-06-09
**Last Updated:** 2026-06-09

---

## Problem Statement

AGENTS.md Git Flow allows `docs/*` and `chore/*` to "push directly to develop/main
with minimal validation," while `feat/*` requires a PR. During
`skill-corpus-installation`, the dev-infra side of the feature is **all planning
docs** (`.md` under `admin/`), so every commit was a `docs(...)` commit — and ~12 of
them landed **directly on `develop`** across Groups 1–3, with **no feat branch, no PR,
no review checkpoint, and no CI gate on the feature as a unit**.

This is *technically* within the letter of the docs-direct allowance, but it bypassed
the **spirit** of the established workflow. The sibling feature
`skill-template-separation` ran the intended way: `feat/*` branch per group → PR →
review/CI → merge (PRs #106–#111). The difference: that feature touched code;
this one's dev-infra footprint is docs-only, so the allowance silently applied
commit-by-commit and nobody hit a branch/PR gate.

Two compounding factors made it frictionless to not notice:
1. **The interactive `/task` flow** committed each task's doc updates straight to
   develop (the command's own docs-only detection sanctions direct merge).
2. **The real code lives in external repos** (`agentic-ocean`), so dev-infra never
   "felt" like it was hosting feature code — yet it was hosting the feature's entire
   planning lifecycle.

Related: the external corpus repos (`agentic-ocean`) also received commits straight to
`main` until this was caught (now corrected: `develop` + feat/PR established there).

---

## Why It Matters

- No PR = no review checkpoint and no CI gate on the feature as a coherent unit.
- Divergence from the documented convention erodes the convention.
- A reader can't review the feature as a whole (it's dribbled across develop history).

---

## Proposed Improvements

> **The rule, in one line:** *direct-to-develop is for one-off doc fixes; a multi-group **feature** — even a docs-only one — runs on a branch and lands via PR.*


1. **Clarify the docs-direct allowance.** State in AGENTS.md (and `/task`'s docs-only
   detection) that direct-to-develop is for **one-off doc fixes**, *not* for running a
   multi-group **feature's** planning tree. A feature is branch-and-PR even when its
   footprint is docs-only.
2. **`/task` nudge.** When `/task` operates inside a feature planning tree
   (`features/<feature>/planning/`) and detects a multi-group plan, it should **nudge
   onto a `docs/*` or `feat/*` branch + PR** rather than committing to develop — or at
   least warn once per feature.
3. **Branch-first for feature planning.** Consider: even docs-only feature work starts
   on a branch (matches `skill-template-separation`), so the feature lands via one (or
   per-group) reviewable PR.

---

## Cheap to Reverse

These are convention + a soft nudge, not enforcement. If the nudge proves noisy, drop
it; the AGENTS.md clarification is harmless either way.

---

## Related

- AGENTS.md — Git Flow (branch rules, docs/chore direct-merge allowance)
- `~/.cursor/commands/task.md` — docs-only detection / direct-merge workflow
- `skill-corpus-installation` (this feature) — the case that surfaced it
- `skill-template-separation` — the sibling feature that followed feat→PR correctly

---

**Last Updated:** 2026-06-09
