# Decision Interview Exercise — Learnings

**Project:** dev-infra
**Topic:** First real use of the decision interview pattern (agentic-workflow-modernization)
**Date:** 2026-04-14
**Status:** ✅ Complete
**Last Updated:** 2026-04-14

---

## 📋 Overview

The decision interview was proposed as an int-opp (`decision-command-human-involvement.md`) to address the `/decision` command's lack of human involvement. This document captures what we learned from actually running it for the first time across 8 sections, producing 22 conclusions and 1 cross-cutting principle.

**Interview:** [decision-interview.md](../../../../decisions/agentic-workflow-modernization/decision-interview.md)
**Scope Output:** [v1-scope.md](../../../../decisions/agentic-workflow-modernization/v1-scope.md)

---

## ✅ What Worked Exceptionally Well

### The Interview Surfaced Priorities the Agent Could Not Have Inferred

The entire point of the interview was to extract human judgment before agent analysis. This worked exactly as hoped:

- **C1-2 (explore conduct deprecated):** This came purely from lived experience — the user recognized overlap with research that no amount of requirements analysis would surface.
- **C8-2 (UX north star: "in control and enriched through slowing down"):** This reframes the entire project's value proposition. An agent analyzing requirements would optimize for speed and coverage, not for deceleration as a feature.
- **C1-3 (role-based models as decomposition lenses):** The "Research Agent as a programming model, not a runtime agent" clarification came from the user correcting a reasonable misunderstanding. Without the interview, the agent would have designed around runtime agents.

### Section-by-Section Pacing Created Natural Discussion Checkpoints

Each section completed in a `/discuss` → fill out → `/discuss` → capture cycle. This rhythm:

- Kept the human engaged (not just filling out a form)
- Let the agent identify connections between answers (e.g., linking 6.3's auto-detection insight to CP-1)
- Allowed conclusions to reference earlier conclusions (C7-3 references C1-1 and C2-2)
- Prevented "form fatigue" — the human could step away between sections

### Cross-Cutting Principles Emerged Organically

CP-1 (Explicit Over Implicit) was not a question in the interview. It emerged from discussing the spike results in the context of Section 3. The interview structure created space for these meta-insights to surface because the discussion wasn't rushed toward a single output.

### The Two-Artifact Pattern (Interview + Scope) Worked Well

Keeping raw answers in `decision-interview.md` and interpreted conclusions in `v1-scope.md` served different purposes:

- **Interview:** Human voice preserved, useful for "why did we decide this?" traceability
- **Scope:** Agent-synthesized, structured for the decision step to consume
- Neither document was burdened with the other's purpose

---

## 🟡 What Needs Improvement

### Some Answers Were Incomplete or Cut Off

Section 8.3's answer was truncated ("I don't know where I o..."). The interview format didn't have a mechanism to detect incomplete input. A future version should either:

- Confirm each answer before moving on ("Got it — anything to add to 8.3?")
- Flag suspiciously short or mid-sentence answers

### The Interview Didn't Self-Adapt Based on Earlier Answers

Sections 6-8 could have been sharper if the questions adapted to what was already established. For example:

- By the time Section 7 asked about "small vs broad v1," the answer was already heavily implied by C1-1 (thinking pipeline focus) and C5-1 (strict rubric). The question felt somewhat redundant.
- Section 6.1 (hooks/CLI importance for v1) was nearly pre-answered by the deferred infrastructure theme running through all prior sections.

A future version could mark questions as "already answered by [CX-Y]" and skip or rephrase them.

### No Explicit Prioritization Step

The interview collected priorities implicitly (through phrasing, emphasis, and what was deferred). But there was no explicit "rank these 5 things" step. The thin-slice clustering proposed in the int-opp was not tested — we went section-by-section through the interview instead. This worked, but the original proposal's clustering approach remains unvalidated.

### The Conclusion-Capture Rhythm Was Manual

Each section required a separate "let's capture" prompt from the user. This is consistent with the dual-track model (human decides when to formalize) but could be smoother. Possible improvement: the agent proactively offers to capture after each discussion, with the human confirming or deferring.

---

## 💡 Unexpected Discoveries

### The Interview Is a Pipeline Start Signal

The interview itself became the "start signal" for the decision phase — exactly what the `pipeline-phase-start-signals.md` int-opp proposed. Filing the interview answers is the explicit act that says "the decision phase has begun." This validates the start-signal concept with a real example.

### Discussion and Capture Are Two Distinct Modes

The `/discuss` sessions were genuinely different from the capture steps. Discussion was exploratory, sometimes divergent (the auto-detection thread in 6.3, the implicit vs explicit tension in 7.1). Capture was convergent — distilling discussion into precise conclusions. This suggests the decision command should have explicit mode transitions rather than blending them.

### The Interview Revealed New Int-Opps

Four new int-opps were created during the interview process itself:

- `rules-layer-exploration.md` (from Section 4 discussion)
- `conventions-md-gap.md` (from Section 4 discussion)
- `pipeline-phase-start-signals.md` (from the artifact placement discussion)
- `decision-command-human-involvement.md` (the interview's own genesis)

This suggests the interview is not just a scoping tool but also a discovery tool for workflow gaps.

### 22 Conclusions Is a Lot — Grouping Will Matter

The scope document has 22 conclusions (C1-1 through C8-3) plus CP-1. When the decision step consumes this, it needs a strategy for managing this volume. The role-model grouping (Thinker, Researcher, Planner, Reviewer) may help cluster conclusions the same way it clusters skills.

---

## ⏱️ Time Investment Analysis

**Breakdown:**

- Interview design + template: ~30 min (prior session)
- Section 1-3 (fill + discuss + capture): ~2 hrs across sessions
- Section 4-5 (fill + discuss + capture): ~1.5 hrs
- Section 6-8 (fill + discuss + capture): ~1 hr
- Spike (nested skill discovery, informed Section 3): ~1 hr

**Total:** ~6 hours across multiple sessions

**What took longer than expected:**

- Sections 1-3 generated the most discussion because they established foundational scope decisions. Later sections were faster because they could reference earlier conclusions.
- The spike was unplanned but high-value — it validated C3-2 with empirical evidence rather than assumptions.

**What was faster than expected:**

- Sections 6-8 went quickly because the deferred-infrastructure theme was already well-established. Most answers confirmed what earlier discussions had implied.

**Estimation lesson:**

- Budget ~1 hour per section for "foundational" sections (1-3), ~30 min per section for "confirmatory" sections (6-8). Total: ~6-8 hours for an 8-section interview on a complex topic.

---

## 📊 Metrics and Impact

**Output metrics:**

- 8 interview sections completed
- 22 conclusions captured (C1-1 through C8-3)
- 1 cross-cutting principle (CP-1)
- 4 new int-opps identified during the process
- 1 empirical spike conducted

**Quality indicators:**

- Every conclusion references specific prior artifacts (research findings, requirements, spike results)
- Cross-references between conclusions create a coherent narrative (C7-3 → C1-1, C2-2; C5-1 → C1-4)
- The UX north star (C8-2) provides a qualitative anchor that pure requirements analysis would miss

**Process validation:**

- The `decision-command-human-involvement.md` int-opp proposed interview + options-not-answers + thin-slice. This exercise validated the interview step. Options-not-answers and thin-slice remain untested (they apply to the decision step itself, which hasn't happened yet).

---

## 🔗 Template Implications

If the interview pattern proves repeatable:

1. **Decision interview template:** A reusable 8-section template could be generated by the `/decision` command's interview step, adapted per topic.
2. **Scope document template:** The `v1-scope.md` structure (conclusions per section + cross-cutting principles + requirement impact tables) is generalizable.
3. **The `/discuss` → capture rhythm** should be the default interaction pattern for interview sections, not a manual ad-hoc choice.

---

**Last Updated:** 2026-04-14
