# Research Command Audit — Modes, Mapping, and Tier Classification

**Task:** Task 1 of Stage 2, Group 1 (Research Family Foundation)  
**Date:** 2026-05-02  
**Source:** `.cursor/commands/research.md` (1,531 lines)  
**Reference:** Topic 8 (Behavioral Contracts), same tier rubric as [Stage 1 discuss audit](../../../planning/artifacts/discuss-audit.md)

---

## Tier Definitions (from Topic 8, Finding 1)

| Tier | Description | Rubric properties (typical) |
|------|-------------|----------------------------|
| **Tier 1** | Precise — outcome-based, testable | Observable, bounded, outcome-framed, delta-only, failure-aware |
| **Tier 2** | Mixed — directional but incomplete stopping rules | 3–4 properties |
| **Tier 3** | Vague — unbounded judgment, persona, or unknowable triggers | 0–2 properties |

---

## Modes and Child Skill Mapping

| Mode | Command surface | Planned child skill | Primary command sections |
|------|----------------|---------------------|--------------------------|
| **Setup** (default) | `/research [topic] --from-explore \| --from-reflect \| --topic` | **research-setup** | Step-by-Step §1–7 (Identify source → Commit) |
| **Add topic** | `/research [topic] --add-topic N` | **research-setup** | Add Topic Mode Workflow §1–5 |
| **Conduct** | `/research [topic] --conduct [--topic-num \| --topic-name]` | **research-conduct** | Conduct Mode Workflow §1–7, Conduct output checklist |
| **Consolidate** | `/research [topic] --consolidate [--dry-run]` | **research-consolidate** | Consolidate Mode Workflow §1–8 |

**Design note:** Setup and add-topic share the same skill so scaffolding stays one place; add-topic is structurally “late setup” on an existing research directory. Task 6 will confirm whether add-topic ever splits to its own skill.

---

## Behavioral and Judgment-Rich Instructions (by area)

### Cross-cutting / Workflow overview

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| K1 | Follow standardized workflow; create documents per topic; extract requirements; consolidate before decisions | **T1** | Outcome sequence is observable |
| K2 | Sanitize topic name (kebab-case, no spaces) | **T1** | Deterministic rule |

### Setup mode (scaffolding)

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| S1 | Resolve input source exactly one of from-explore / from-reflect / direct topic; extract or prompt for topics | **T1–T2** | “Prompt if needed” is bounded by user reply; topic list must be explicit before file creation |
| S2 | Auto-detect research layout (dev-infra vs template vs project-wide) before paths | **T1** | Observable branch on repo layout |
| S3 | For `--from-reflect`: extract “Actionable Suggestions” or “Opportunities for Improvement”; convert to topics | **T2** | Depends on reflection structure variance |
| S4 | Always commit research scaffolding before finishing setup | **T1** | Matches commit discipline in command |

### Add topic mode

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| A1 | Validate research dir exists; topic N exists in `research-topics.md`; file missing unless `--force` | **T1** | Error table is explicit |
| A2 | Scaffold `topic-N-[name].md` from research document template; populate from research-topics fields | **T1** | Procedural |
| A3 | Update hub README + `research-summary.md` placeholder | **T1** | Procedural |

### Conduct mode

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| C1 | Web search **required** for conduct | **T1** | Binary tool-use obligation |
| C2 | Each finding recorded with source and relevance | **T1** | Observable in doc |
| C3 | Process all topics or one topic by num/name; **research high-priority topics first** when doing all | **T2** | Priority comes from research doc/exploration but “first” ordering can be fuzzy if priorities tie |
| C4 | Formulate queries from question, sub-questions, methodology | **T2** | Quality of queries is judgment-heavy |
| C5 | Update status to complete, goals checked, summary + requirements + hub | **T1** | Procedural |

### Consolidate mode

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| G1 | Preconditions: all topics complete (warn + optional continue), `requirements.md` exists | **T1** | Explicit |
| G2 | Exploration reconciliation: cross-reference themes vs findings; categorize Mandatory vs Recommended | **T2** | Severity table helps but row assignment is judgment |
| G3 | **STOP and wait** after reconciliation report; user chooses amendments | **T1** | Clear human gate |
| G4 | Build mental model of requirement lineage across topics | **T3** | “Mental model” not observable; **must become** explicit tables/checklists in skill |
| G5 | Analyze redundancies, superseded, gaps, stale wording, priorities | **T2** | Categories are procedural; each classification is judgment |
| G6 | **CRITICAL:** Present consolidation proposal; **STOP** for human approval before apply | **T1** | Clear human gate |
| G7 | After approval: merge/remove/add/modify/renumber; Draft → Final | **T1** | Procedural |

### Tips / best practices (agent-facing portions)

Lines ~1499–1507 mix user guidance with agent obligations. Agent-facing items:

| ID | Instruction | Tier | Applies to |
|----|---------------|------|------------|
| T1 | Document sources for every finding | **T1** | conduct |
| T2 | Use web search (required in conduct) | **T1** | conduct |
| T3 | Extract requirements as you research | **T1** | conduct |
| T4 | Keep research summary current after each topic | **T1** | conduct |
| T5 | Consolidate before deciding | **T1** | workflow ordering |

---

## Summary Counts (behavioral / judgment rows above)

| Tier | Approx. count | Notes |
|------|----------------|-------|
| **Tier 1** | 22 | Gates, commits, web search requirement, structured updates |
| **Tier 2** | 7 | Reflection parsing, query formulation, consolidation classification, priority ordering |
| **Tier 3** | 1 | “Build a mental model” — rewrite during **research-consolidate** conversion |

---

## Content Classification for Skill Conversion (preview)

| Block | Destination skill | Notes |
|-------|------------------|-------|
| Setup steps 1–7 + templates | **research-setup** | Procedural + scaffolding |
| Add topic workflow | **research-setup** | Procedural |
| Conduct workflow | **research-conduct** | Hybrid procedural + behavioral (Tier 2 areas need rubric passes) |
| Consolidate workflow | **research-consolidate** | Hybrid; human gates stay Tier 1; analysis steps need tighter bounded procedures |
| Tips / Integration / Reference | Parent **research** + child intros | Orientation only; parent has no procedural steps |

---

## Documented inconsistencies (for later cleanup, out of Group 1 scope)

- Exploration paths: command “Configuration” vs “Step 1” vs explore family paths differ for dev-infra and template layouts. **research** parent aligns with **explore** path detection; skills should not introduce a fourth variant.
- Per-topic filenames: Setup uses `research-[question-name].md`; add-topic uses `topic-N-[name].md`. Both must remain documented until a naming ADR unifies them.

---

**Last Updated:** 2026-05-02
