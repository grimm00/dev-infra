# Spike Command Audit — Behavioral Instructions and Tier Classification

**Task:** Stage 2, Group 3, Task 8  
**Date:** 2026-05-02  
**Source:** `.cursor/commands/spike.md` (~481 lines)  
**Reference:** Tier definitions in [research-command-audit.md](research-command-audit.md) (same five-property rubric as Stage 1 Topic 8)

---

## Tier Definitions (summary)

| Tier | Description | Rubric properties (typical) |
|------|-------------|----------------------------|
| **Tier 1** | Precise — outcome-based, testable | Observable, bounded, outcome-framed, delta-only, failure-aware |
| **Tier 2** | Mixed — directional but incomplete stopping rules | 3–4 properties |
| **Tier 3** | Vague — unbounded judgment or persona | 0–2 properties |

---

## Core pattern: time-boxed behavioral contract

The command’s durable “contract” (what a skill must preserve) is **not** the directory layout alone; it is the coupling of:

1. **Criteria before build** — Success criteria stated and shown to the user *before* substantive spike work (Step 2; checklist).
2. **Bounded duration** — Explicit timer / `--time-box`; **stop when time expires** and still document (Step 3, Scenario 4, Tips).
3. **Throwaway scope** — Minimal prototype, no polish; spike code may be discarded (Step 3 “Key principles”).
4. **Evidence-backed learnings** — `spike-learnings.md` ties answers to observations (errors, behavior, edge-case table); **Go / No-Go** is explicit (Step 4 template).
5. **Commit the artifact** — Learnings file committed; spike subdirectory often not tracked (Step 5).

These items map cleanly to **Tier 1** when expressed as outcomes (what files show, when to stop, what must appear in learnings).

---

## Behavioral / judgment-rich instructions (by area)

### Workflow overview & when to use

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| W1 | Use spike when uncertainty is “can it work?”; use research for “what’s best?” | **T1–T2** | Binary routing is clear; edge cases between “compare options” vs “prove viability” need user judgment |
| W2 | Risk framework: HIGH risk + “will this work?” → spike | **T2** | “HIGH risk” label comes from exploration, not always explicit in repo |
| W3 | Hands-on validation vs desk research | **T1** | Observable choice of activity type |

### Step 1 — Questions to validate

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| Q1 | Extract technical questions, edge cases, success criteria from exploration | **T2** | Quality of “what to validate” depends on reading exploration docs |
| Q2 | Prefer “can it work?” over “what’s best?” | **T1** | Decision rule is phrased as observable question form |

### Step 2 — Success criteria

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| C1 | Criteria before building; specific and testable | **T1** | Checklist + template enforce ordering |
| C2 | Agree time-box duration (default 2–4h) | **T1** | User-visible; `--time-box` bounds |

### Step 3 — Build minimal prototype

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| B1 | Throwaway mindset; minimal scope; real environment | **T2** | “Minimal” and “real” need calibration; **failure mode:** over-building |
| B2 | Stop when timer ends; document regardless | **T1** | Clear stop rule |
| B3 | AI “assists” — human-driven step | **T2** | Division of labor not enforceable in prose alone |

### Step 4 — Document learnings

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| D1 | Template sections: Questions Answered, Findings, Edge Cases, Go/No-Go, Refined Questions | **T1** | Observable structure |
| D2 | Findings include specific evidence | **T1** | Matches rubric “observable” |
| D3 | `--document-learnings` skips to documentation | **T1** | Mode flag |

### Tips & scenarios

| ID | Instruction (paraphrase) | Tier | Notes |
|----|--------------------------|------|-------|
| T1 | Don’t polish; document as you go | **T1** | Behavioral lines convertible to skill gotchas + contract |

---

## Conversion notes (Task 9)

- **Standalone skill:** Flat `spike/` directory (ADR-002); no parent SKILL — unlike research children.
- **Preserve:** Path detection matrix (dev-infra / template / lightweight); integration bullets pointing to explore/research/decision can become a short **Related** section.
- **Lift to Behavioral Contract:** criteria-first, timer stop, throwaway scope, evidence in learnings, commit learnings (not necessarily throwaway code).
- **Gotchas:** scope creep, skipping success criteria, polishing spike code, confusing spike vs research/POC, forgetting commit — all grounded in command Tips/Scenarios.

---

**Last Updated:** 2026-05-02
