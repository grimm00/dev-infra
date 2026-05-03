# Audit: `plan-review` command → skill conversion

**Source:** `.cursor/commands/plan-review.md` (416 lines)  
**Feature:** agentic-workflow-modernization / Stage 3 Group 4  
**Date:** 2026-05-03  
**Tier definitions:** ADR-004 — Tier 1 precise, Tier 2 mixed (rewrite for five-property rubric), Tier 3 vague/problematic (rewrite or remove).

---

## Executive summary

| Finding | Detail |
|---------|--------|
| Single-mode procedural skill | Seven numbered steps (load plan → review groups → deps → consistency → issues → report → summary). No alternate modes unlike transition-plan; **one SKILL.md** (+ `assets/` + `references/structure.yaml`) is sufficient. |
| **Staged planning gap** | Path detection lists only `…/planning/` (dev-infra) and maintainer `docs/…/features/[feature]/`. It omits **`planning-stage{N}/`** siblings used throughout agentic-workflow modernization and declared on **`write-plan`** (`references/structure.yaml`). Skill **must** resolve the active stage directory the same way as write-plan. |
| Prior learnings carry-forward gap | Command validates dependencies and consistency **within** the current tree only. It never instructs comparing **prior stage** narratives (`planning-stage{N-1}/status-and-next-steps.md`, milestones, spike notes). Skill adds an explicit **review dimension** + YAML declaration. |
| Report template bulk | Step 6 embeds ~80 lines of markdown template → **Tier 2 delta-only risk** if pasted into SKILL.md. Move verbatim skeleton to **`assets/review-checklist.md`**; SKILL references filenames only (FR-8 friendly). |
| Legacy pointers | Footer still references **`/pre-phase-review`** as deprecated; SKILL should cite **`docs/MIGRATION-v0.10.md`** once and steer uniform-structure readers here only. |

---

## Workflow mapping (command steps → skill)

| Command step | Topic | Skill placement |
|--------------|-------|-----------------|
| §1 Load & parse implementation plan | Frontmatter parity, checkbox census, optional `--group N` narrowing | Workflow §1 |
| §2 Review task group files | Structure, sizing warnings, numbering | Workflow §2 |
| §3 Validate dependencies | Intra-/cross-group + externals | Workflow §3 |
| §4 Check consistency | Plan ↔ status ↔ task bodies ↔ frontmatter | Workflow §4 |
| §5 Identify issues | Blockers / warnings / recommendations | Workflow §5 |
| §6 Generate review report | Path under planning root + template | Workflow §6 + **`assets/review-checklist.md`** |
| §7 Present summary | Chat footer block | Workflow §7 |

---

## Section-by-section classification

| Location / topic | Tier | Rationale | Skill action |
|------------------|------|-----------|--------------|
| Title + overview | 1 | Clear triggers | Keep |
| Plan path detection — dev-infra `planning/` only | **2→fix** | Missing `planning-stage{N}/` breaks Stage 3 meta-planning | **Extend** rows to mirror write-plan parent |
| Plan path — template project | 1 | Stable | Keep |
| Feature detection (“prompt if multiple”) | 2 | Needs bounded stop/list behavior | Prefer explicit `--feature`; else enumerate candidates and STOP |
| Legacy fallback (`feature-plan.md` / `phase-*`) | 1 | Points to migration | Keep short pointer |
| Step 1 frontmatter rules | 1 | Mechanical checks | Keep; duplicate summary in **`references/structure.yaml`** |
| Steps 2–5 checklists | 1 | Observable checks | Keep condensed |
| Step 6 report template fence | 2 | Long | **Move** to `assets/` |
| `--dry-run` | 1 | Display-only path | Keep explicit branch |
| Tips / related commands | 2 | References `/transition-plan`, `/task` | Map to **`write-plan-*`** + task workflows |

---

## Consolidated tier tallies

| Tier | Approx. blocks | Notes |
|------|----------------|-------|
| Tier 1 | 22 | Path tables (extended), YAML rules, checklist bullets, severity taxonomy |
| Tier 2 | 8 | Feature auto-detect, oversize-group heuristics, related-command prose |
| Tier 3 | 0 | None identified after removing merge-to-develop assumptions |

---

## `assets/` / `references/` inventory

| Artifact | Target path | Role |
|----------|-------------|------|
| Review report skeleton + section prompts | `assets/review-checklist.md` | Copy/adapt into dated `plan-review-YYYY-MM-DD.md` |
| Declared inputs, dimensions, outputs | `references/structure.yaml` | Parity with decision/write-plan declarative contracts |

---

## Five-property check (command-wide)

| Property | Pass? | Gap |
|----------|-------|-----|
| Observable | Mostly | Issue taxonomy clear; staged-root choice must be explicit |
| Bounded | Mostly | `--group` scopes well; multi-feature detection needs STOP semantics |
| Outcome-framed | Yes | Report path + readiness labels |
| Delta-only | **Fail** raw | Large template fence → **fix** via `assets/review-checklist.md` |
| Failure-aware | Partial | Weak on missing prior-stage artifacts when carry-forward claimed |

---

## Skill design decisions (from audit)

1. **Path parity:** Duplicate the write-plan **`planning/` vs `planning-stage{N}/`** detection table (short form) + cite canonical YAML glob notes.
2. **Prior-stage carry-forward:** Add Workflow §4b (after consistency) requiring explicit scan of **prior** stage status/narratives when `planning-stage{N}/` with `N>1`.
3. **FR-8:** SKILL holds behavioral contract + numbered workflow; checklist prose lives in **`assets/`**; machine-readable dimensions live in **`references/structure.yaml`**.
4. **Invocation:** Align YAML `disable-model-invocation` with sibling planner skills (**true**) — routed via tooling/description like write-plan-expand.

---

**Last Updated:** 2026-05-03
