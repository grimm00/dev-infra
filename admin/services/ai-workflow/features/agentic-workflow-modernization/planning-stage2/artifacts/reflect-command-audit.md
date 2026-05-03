# Reflect Command Audit — Behavioral Instructions and Tier Classification

**Task:** Stage 2, Group 3, Task 10  
**Date:** 2026-05-02  
**Source:** `.cursor/commands/reflect.md` (~824 lines)  
**Reference:** Tier definitions in [research-command-audit.md](research-command-audit.md)

---

## Tier Definitions (summary)

| Tier | Description | Rubric properties (typical) |
|------|-------------|----------------------------|
| **Tier 1** | Precise — outcome-based, testable | Observable, bounded, outcome-framed, delta-only, failure-aware |
| **Tier 2** | Mixed — directional but incomplete stopping rules | 3–4 properties |
| **Tier 3** | Vague — unbounded judgment or persona | 0–2 properties |

---

## Core pattern: hybrid skill (procedural + personal-growth synthesis)

`/reflect` is **hybrid** like `/narrative`:

- **Procedural (Tier 1 heavy):** Fixed gather steps (commits, PRs, status docs), suggestion **shape** (priority, category, effort), reflection **file location** rules, commit/branch naming for docs-only workflow.
- **Behavioral / synthesis (Tier 2):** “Thoughtful analysis,” identifying patterns, prioritizing suggestions, calibrating what counts as evidence — must be tightened in SKILL **Behavioral Contract** to Tier-1-style outcomes (evidence cited, no fabricated metrics, honest uncertainty).

---

## Path and structure (must not be lost)

| Surface | Reflection output path | Notes |
|---------|------------------------|-------|
| **dev-infra** | `admin/planning/notes/reflections/reflection-[topic]-[date].md` | Command explicitly centralizes dev-infra reflections |
| **Template — feature** | `docs/maintainers/planning/features/[feature]/reflections/...` | Hub README update when exists |
| **Template — project-wide** | `docs/maintainers/planning/notes/reflections/...` or alternate `docs/maintainers/planning/reflections/...` | Detect from status doc layout |

Learnings inputs: `--include-learnings` vs `all`; cross-phase pattern grouping — **Tier 2** synthesis unless bounded by “list recurring strings / counts from files.”

---

## Behavioral / judgment-rich instructions (by area)

### Steps 1–4 — Gather and classify

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| G1 | Analyze recent commits, PRs, status, optional learnings | **T1** | Tool-assisted; outputs listed |
| G2 | Identify dev vs workflow vs doc patterns | **T2** | Pattern quality depends on interpretation |
| G3 | `--include-learnings all`: cluster recurring successes/issues | **T2** | Needs explicit “cite phase/file for each cluster” in skill |

### Step 5 — Suggestions

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| S1 | Priority 🔴🟡🟢 + category + effort Quick/Moderate/Significant | **T1** | Format is structured |
| S2 | Each suggestion: context, suggestion, benefits, next steps | **T1** | Template in command |
| S3 | “Thoughtful,” “strategic” framing in overview | **T3** in prose | Replace with outcome rules in SKILL |

### Step 6 — Reflection report

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| R1 | Large report scaffold: Current State, Working Well, Opportunities, Issues, Suggestions, Next Steps, Trends | **T1** | File structure observable |
| R2 | Optional cross-phase section when `--include-learnings all` | **T1** | Conditional block |
| R3 | Update reflections README when exists | **T1** | Checklist |

### Step 8 — Commit workflow

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| P1 | Docs-only branch, merge to develop, delete branch | **T1** | Procedural; platform may vary — skill should describe intended git sequence without assuming GitHub |

---

## Conversion notes (Task 11)

- Mirror **narrative** hybrid: procedural workflow + **Behavioral Contract** for tone/evidence (ground claims, omit empty sections, no invented metrics).
- Preserve **dev-infra centralized path** as first-class detection branch.
- Collapse 800+ lines into skill-sized workflow; link **templates/reflection-report.md** for long scaffold.
- **Gotchas:** vague suggestions, wrong output path for dev-infra, skipping README hub update, treating reflect as int-opp (different artifact purpose).

---

**Last Updated:** 2026-05-02
