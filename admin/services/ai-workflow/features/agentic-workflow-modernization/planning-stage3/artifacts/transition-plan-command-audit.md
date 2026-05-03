# Audit: `transition-plan` command → write-plan skill conversion

**Source:** `.cursor/commands/transition-plan.md` (820 lines)  
**Feature:** agentic-workflow-modernization / Stage 3 Group 2  
**Date:** 2026-05-02  
**Tier definitions:** ADR-004 — Tier 1 precise, Tier 2 mixed (rewrite for five-property rubric), Tier 3 vague/problematic (rewrite or remove).

---

## Executive summary

| Finding | Detail |
|---------|--------|
| Two modes | **Setup (default)** scaffolds `implementation-plan.md` + `status-and-next-steps.md` + `tasks/NN-*.md`. **Expand (`--expand`)** adds detail to one group file and flips status Scaffolding → Expanded. |
| Shared core | Path detection (dev-infra vs template), uniform output contract (frontmatter rules, group file naming), templates for the three output types, error handling, and “related commands” apply to **both** modes. |
| Mode-specific surface | Setup: source loading (ADR / artifact / reflection), transition typing, grouping extraction, initial commits. Expand: group selection, TDD vs non-TDD guidance, expansion templates, removal of scaffolding banner. |
| Template-extractable | Large literal markdown **templates** for `implementation-plan.md`, `status-and-next-steps.md`, and group scaffolding (~60–80 lines) — belong in **`assets/`** for the skill; SKILL should reference filenames, not paste hundreds of lines. |

---

## Mode mapping

| Region / topic | Setup | Expand | Shared | Notes |
|----------------|-------|--------|--------|-------|
| Configuration — plan path detection | ● | ● | ● | Same output roots for both modes |
| Workflow overview (Setup vs Expand headers) | ● | ● | | Mode labels differ; both reference same artifacts |
| Usage / flags | ● heavy | ● subset | ● | `--expand`, `--group`, `--all` only expand |
| Setup Step 1 — Load source documents | ● | | | ADR vs artifact vs reflection |
| Setup Step 2 — Determine transition type | ● | | | |
| Setup Step 3 — Organize into task groups | ● | | | |
| Setup Step 4–6 — Create plan, status, task files | ● | | | |
| Setup Step 7 — Commit scaffolding | ● | | | |
| Expand Step 1 — Identify group(s) | | ● | | |
| Expand Step 2 — TDD vs non-TDD | | ● | | |
| Expand Step 3 — Expand task detail | | ● | | |
| Expand Step 4 — Update group status | | ● | | |
| Expand Step 5 — Commit | | ● | | |
| Input source details (ADR / artifact / reflection) | ● | | | Expand reuses *reading* group file only |
| Release transition type | ● | | | Alters grouping focus, same file shape |
| Error handling | ● | ● | ● | Different error messages, same categories |
| Tips / scenarios / related commands | ● | ● | ● | |

---

## Behavioral instruction split (heuristic for decomposition)

**Method:** Count major *instruction-bearing* subsections (numbered steps, checklists, template blocks) as behavioral units; assign each to Setup-only, Expand-only, or Shared (both or neither).

| Bucket | Approx. units | Share of total |
|--------|---------------|----------------|
| Shared | Path detection, frontmatter rules, scaffolding/expand templates references, error/tips/related, usage intro | **~38%** |
| Setup-only | Source load, transition type, group organization, create three file kinds, setup commit | **~40%** |
| Expand-only | Group identification, TDD routing, expansion patterns, status flip, expand commit | **~22%** |

**Cross-mode dependency:** Expand **requires** Setup outputs (`implementation-plan.md`, group files). That is a **sequential pipeline**, not parallel workflows (contrast **research** family: setup / conduct / consolidate are distinct lifecycles).

**design.md heuristic reinterpretation:** The "below 30% shared → family" rule was meant to detect *independent* modes. Here, shared **contract** (paths, YAML rules, filenames, quality gates) dominates what the agent must hold invariant; mode-specific prose is *which phase of the same plan* is running. Effective **shared behavioral contract** (paths + output schema + tier rules) is **high** (~70%+ of rubric-relevant constraints).

---

## Section-by-section classification

| Location / topic | Tier | Rationale | Skill action |
|------------------|------|-----------|--------------|
| Title + two-mode overview | 1 | Clear | Keep; rename to write-plan |
| Plan path detection | 1 | Tables for dev-infra vs template | Keep; add `planning-stageN/` note for staged plans |
| Feature detection | 2 | “Prompt user if multiple” — needs stop/default | Clarify bounded behavior |
| Setup workflow Steps 1–7 | 1–2 | Structured; some open-ended extraction from ADRs | Keep; behavioral contract for “when to stop” |
| Expand workflow Steps 1–5 | 1–2 | | Keep |
| `implementation-plan` YAML rules | 1 | | Keep; also live in `references/structure.yaml` |
| Templates in command (code fences) | 2 | Long — delta-only violation if pasted into SKILL | **Move** bodies to `assets/` |
| `--from-reflection` “internally calls reflection-artifacts” | 2 | Depends on another command existing | Failure-aware: if no artifact, stop or delegate |
| Release transition type | 1 | | Keep as branch of Setup |
| Error handling | 1 | | Keep |
| Tips / incremental vs `--all` | 1 | | Keep in SKILL Gotchas + workflow |

---

## Template inventory (`assets/` targets)

| Command artifact | Skill path | Role |
|------------------|------------|------|
| `implementation-plan.md` template (frontmatter + sections) | `assets/implementation-plan.md` | Copy/adapt per feature |
| `status-and-next-steps.md` template | `assets/status-and-next-steps.md` | Copy/adapt per feature |
| Group scaffolding template (~60–80 lines) | `assets/task-group-skeleton.md` | One file per group at setup |
| Expand-mode task patterns (TDD vs docs vs command) | Inline tables in SKILL or short `assets/expand-patterns.md` (optional) | Kept in SKILL tables to avoid file sprawl |

---

## Consolidated tier tallies

| Tier | Approx. blocks | Notes |
|------|----------------|-------|
| Tier 1 | 28 | Paths, YAML, step checklists, error messages |
| Tier 2 | 12 | Multi-feature detection, reflection chaining, ADR extraction Judgment |
| Tier 3 | 2 | Optional: prescriptive “commits with this message” — soften for FR-8 portability |

---

## Five-property check (command-wide)

| Property | Pass? | Gap |
|----------|-------|-----|
| Observable | Mostly | “Organize into task groups” needs example outputs |
| Bounded | Mostly | “Prompt to select feature” needs default when unclear |
| Outcome-framed | Yes | File paths and checkboxes explicit |
| Delta-only | **Fail** in raw command | Long template fences — **fix** via `assets/` |
| Failure-aware | Partial | “Already has plan” — covered; weak on missing requirements file |

---

## Decomposition recommendation (for Task 5)

**Recommendation:** **Single `write-plan` skill** with clearly separated **Setup** and **Expand** workflows (same document), plus `assets/` + `references/structure.yaml`.

**Rationale:** Modes are **phases of one capability** (materialize planning tree → deepen one group). A **family** (write-plan-setup / write-plan-expand) would duplicate path detection, frontmatter rules, and structure.yaml unless a parent SKILL held everything — at which point children add little but orchestration friction. Research family differs: conducts are **independently** invokable lifecycles with separate behavioral contracts.

**If evidence later shows teams invoke only “expand” from muscle memory:** optional thin wrapper files could be added in a follow-up; not required for Stage 3.

---

**Last Updated:** 2026-05-02
