# Audit: `review` command → review skill conversion

**Source:** `templates/standard-project/.cursor/commands/review.md` (~334 lines)  
**Feature:** agentic-workflow-modernization / Stage 4 — Group 1 (Review Skill)  
**Date:** 2026-05-03  
**Rubric:** five-property skill contract (*Observable*, *Bounded*, *Outcome-framed*, *Delta-only*, *Failure-aware*) — aligned with **plan-review** SKILL.md behavioral rubric table.

---

## Executive summary

| Finding | Detail |
|---------|--------|
| Primary value | **Review-then-commit pause** — stage changes, capture `summary.md` + `diff.patch`, present bundle, **STOP** (never auto-commit). |
| Hybrid shape | **Procedural:** file discovery, optional confirmation, `git add`, folder creation, `git diff --staged`, artifact paths. **Behavioral:** what to look for in diffs, how to phrase summary, when to wait for human approval. |
| Path detection | Three layouts: **dev-infra** (`admin/tmp/reviews/...`), **template** (`tmp/reviews/...`), **lightweight** (`tests/tmp/reviews/...`) with explicit decision order. |
| Delta-only pressure | **summary.md template** is a large fenced block — **must** live in `assets/summary-template.md`; SKILL references path only. |
| Downstream coupling | **commit** command (Group 2) consumes same folder shape; `references/structure.yaml` should declare files for cross-skill parity. |

---

## Procedural vs behavioral classification

| Region / topic | Procedural | Behavioral | Notes |
|----------------|------------|--------------|-------|
| Configuration — review base paths | ● | | Deterministic tables + detection order |
| `.gitignore` verification | ● | | Warn if path not ignored |
| Usage / CLI examples | ● | | Maps to invocation patterns |
| **Why This Exists** + benefits | | ● | Motivation / risk framing for reviewer |
| Process 1 — Identify changed files | ● | ● | Commands + exclusions; judgment on “intent” |
| Process 2 — Stage files | ● | ● | Mechanical `git add`; confirm unintended files |
| Process 3 — Capture artifacts | ● | | Paths, filenames, `git diff --staged` |
| summary.md **template body** | ● | ● | Structure is procedural; fill quality is behavioral |
| Process 4 — Present for review | ● | ● | Bullet list + reminder tone |
| Process 5 — **STOP and Wait** | ● | ● | CRITICAL invariant: no commit |
| Integration diagram | | ● | Reinforces pause |
| Common scenarios (`--scope`, `--all`) | ● | ● | Behavior flags |
| Tips / what to look for | | ● | Diff review checklist |
| Important callouts | ● | ● | NEVER commit / show before stage |

**Approximate share (instruction-bearing bullets):**

| Bucket | Share |
|--------|-------|
| Procedural (git + filesystem + artifact layout) | **~55%** |
| Behavioral (review judgment + STOP contract + motivation) | **~45%** |

---

## Section-by-section classification (command → skill intent)

| Command section | Tier (1=precise, 2=mixed, 3=vague) | Skill action |
|-----------------|-------------------------------------|--------------|
| Title + purpose | 1 | Keep; SKILL intro |
| Configuration + detection | 1 | Keep; duplicate in `references/structure.yaml` roots |
| Usage / options | 1 | Table in SKILL |
| Why This Exists | 2 | Condense Why / motivation; optional pointer to Stage 4 design |
| Process 1–3 | 1–2 | Checklists + failure-aware exclusions (secrets, scratch) |
| summary template fence | 2 → **assets** | **Move** to `assets/summary-template.md` |
| Process 4–5 STOP | **1 critical** | **Behavioral Contract** header + Gotcha |
| Integration + scenarios | 1–2 | Short diagrams / tables |
| Tips + Important | 1–2 | **Gotchas** + bold STOP |

---

## Five-property check (command as-is)

| Property | Pass? | Gap / remediation for skill |
|----------|-------|------------------------------|
| **Observable** | Mostly | Outputs named (`summary.md`, `diff.patch`); SKILL should reference `references/structure.yaml` for machine-readable parity. |
| **Bounded** | Mostly | `--scope`, `--all`, confirmation paths bound fan-out; SKILL must say what to do when user cancels selection. |
| **Outcome-framed** | Yes | Explicit artifact tree and presentation bundle. |
| **Delta-only** | **Fail** (raw command) | Long template in SKILL would repeat command sin — **extract to asset**. |
| **Failure-aware** | Partial | `.gitignore` warn present; add explicit “no writable temp” / empty selection STOP in SKILL Gotchas if missing. |

---

## Template inventory (`assets/` targets)

| Source in command | Skill path | Role |
|-------------------|------------|------|
| `summary.md` fenced template | `assets/summary-template.md` | Copied/filled per review |
| Integration Mermaid-ish prose | Inline short text in SKILL | Keep minimal; diagrams optional ASCII |

*(diff.patch has no prose template — generated via `git diff --staged`.)*

---

## Decomposition recommendation (Tasks 2–3)

**Single `review` skill** at `templates/standard-project/.claude/skills/review/SKILL.md` with:

1. Imperative workflow (mirror Process 1–4).
2. **Behavioral Contract** carrying STOP + presentation expectations + “what to look for.”
3. **`assets/summary-template.md`** for delta-only discipline.
4. **`references/structure.yaml`** declaring detection paths + output files for **commit** coupling.

---

## Validation (Task 3)

Validated against delivered files:
`templates/standard-project/.claude/skills/review/SKILL.md`,
`references/structure.yaml`,
`assets/summary-template.md` (against command template).

### Five-property checklist (skill + YAML)

| Property | Status | Evidence |
|----------|--------|----------|
| **Observable** | Pass | SKILL **Workflow** + **Configuration** list artifacts; YAML `required_artifacts`, `artifact_folder`, `review_roots`. |
| **Bounded** | Pass | SKILL tables for `--scope`, `--all`, default confirmation; **Bounded stop** on empty selection. YAML `invocation_aliases` documents flags. |
| **Outcome-framed** | Pass | Explicit outcomes: folder with `summary.md` + `diff.patch`, presentation bundle, then STOP. |
| **Delta-only** | Pass | Summary scaffold moved to `assets/summary-template.md`; SKILL cites path; **Gotchas** forbid template sprawl in SKILL. |
| **Failure-aware** | Pass | `.gitignore` gate in SKILL + YAML `gitignore_required`; exclusions for secrets/scratch; **Gotchas** for layout precedence. |

### `structure.yaml` ↔ SKILL alignment

| YAML key / concept | SKILL location |
|--------------------|----------------|
| `review_roots.*.artifact_base_dir` | **Configuration** (three bullets) matches `admin/tmp/reviews`, `tmp/reviews`, `tests/tmp/reviews`. |
| Detection order | YAML lists dev-infra → template → lightweight; SKILL states “first match wins” consistent with historical command precedence when `admin/` exists. |
| `artifact_folder.dirname_pattern` | SKILL **Configuration** folder shape `review-[description]-YYYY-MM-DD`. |
| `required_artifacts[]` | **Workflow §3** and **Configuration** filenames. |
| `integration.commit_skill` | **Integration** + SKILL STOP handoff to commit. |

### STOP / no-commit contract

| Requirement | Location |
|-------------|----------|
| “Do NOT `git commit`” / STOP | **Workflow §5** (bold), **Gotchas** first bullet. |
| Presentation before wait | **Workflow §4** |

**Residual risk (documented for Group 2):** Commit skill must treat `references/structure.yaml` as stable API — renames here require simultaneous commit SKILL updates.
