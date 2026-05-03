# Dev-Infra Learnings — Agentic Workflow Stage 3: Pipeline Synthesis Gap

**Project:** Dev-Infra
**Topic:** Missing synthesis step in the group-cycle pipeline
**Date:** 2026-05-02
**Last Updated:** 2026-05-02

---

## 📋 Overview

During Stage 3 of the agentic-workflow-modernization feature, we identified that the group-cycle agent pipeline has no step for capturing learnings that arise during implementation. Narratives, int-opps, and reflections are all human-initiated commands with no automatic trigger — meaning mid-implementation discoveries (like adding the `assets/` + `references/` convention, or recognizing that `write-plan` needed family decomposition) live only in conversation context and evaporate between sessions. This became visible when plan-review had nothing structured to check for "prior-learnings carry-forward."

---

## ✅ What Worked Well

### Group-cycle agent mechanical ceremony

**Why it worked:** The `post-pr` → `pre-phase-review` → expand → execute → PR → validate → report pipeline reliably handles bookkeeping: checkboxes, status docs, Sourcery review, PR descriptions. These mechanical steps never get forgotten because they're encoded in the agent definition.
**Template implications:** The ceremony-as-code pattern is sound. The gap is not in the mechanical steps but in the absence of a synthesis step.

### In-chat course corrections

**Why it worked:** When we realized write-plan needed family decomposition (overriding the subagent's single-skill decision) and that decision needed `assets/` extraction, we caught it in real-time discussion and inserted Group 3. The `/discuss` skill enabled thinking-without-committing before modifying the plan.
**Template implications:** The `/discuss` → plan modification loop works. The problem is that the *reasoning* behind the modification isn't captured anywhere persistent — it lived in a chat session.

---

## 🟡 What Needs Improvement

### No synthesis step in group-cycle pipeline

**What the problem was:** The pipeline goes from task execution (Step 2) directly to PR creation (Step 3). There is no "what did we learn?" step. Step 6 (Report) produces a chat summary, not a persisted artifact. Learnings from implementation — scope additions, pattern discoveries, decomposition overrides — aren't captured in a format that plan-review or future stages can consume.
**How to prevent:** Add a "Step 2.5: Capture learnings" or fold synthesis into Step 6 as a committed artifact (not just a chat message). This artifact would be a lightweight structured document — not a full narrative, but enough for plan-review to verify carry-forward.
**Template changes needed:** Update `group-cycle.agent.md` pipeline definition. Consider whether the synthesis artifact lives in `planning-stageN/artifacts/` or alongside the Sourcery review in `admin/feedback/`.

### Narrative / int-opp / reflection have no pipeline trigger

**What the problem was:** All three are human-initiated commands. Narrative is stage-scoped ("after a feature or significant piece of work"), int-opp is learning-scoped ("capture what worked"), and reflection is personal ("daily progress and growth"). None of them are triggered by the pipeline, so they only happen when someone remembers to run them.
**How to prevent:** Define cadence expectations: narrative after stage completion, int-opp after significant course corrections, reflection at session end. Consider encoding at least the narrative trigger into the stage-transition workflow (when `write-plan --setup` is run for a new stage, prompt for a prior-stage narrative).
**Template changes needed:** When these commands are converted to skills (Stage 4), their `## When to Use` sections should include pipeline integration points, not just manual invocation patterns.

### int-opp is outward-facing; no inward-facing equivalent

**What the problem was:** `int-opp` captures "learnings from project work to improve dev-infra templates and future projects" — it's aimed at other projects. The most valuable learnings during Stage 3 were ones that fed back into *this project's* next cycle: assets convention, family decomposition override, plan-review restoration. These aren't "opportunities for other projects"; they're "things the next group needs to know."
**How to prevent:** Distinguish between outward-facing learnings (int-opp: "here's what other projects should do") and inward-facing carry-forward (pipeline synthesis: "here's what the next cycle needs to account for"). Plan-review's `structure.yaml` should declare which artifact types it expects as inputs.
**Template changes needed:** plan-review's `references/structure.yaml` should declare expected prior-cycle artifacts. The synthesis step should produce artifacts that match that schema.

---

## 💡 Unexpected Discoveries

### Plan-review's value depends on upstream artifact reliability

**Finding:** We initially deferred plan-review from Stage 3, then restored it after realizing it was the only skill that enforces cross-stage learning carry-forward. But even with plan-review converted, it can only verify what exists. If the synthesis artifacts don't exist because nothing triggered their creation, plan-review reviews an empty shelf.
**How to leverage:** Design plan-review's skill contract to *flag* missing artifacts (not just check existing ones). If a prior stage has no narrative, no learnings doc, no course-correction notes, plan-review should warn — not silently pass.

### Chat-context learnings are the highest-value, most-perishable artifacts

**Finding:** The most impactful decisions during Stage 3 (overriding write-plan decomposition, restoring plan-review, inserting Group 3, adding assets/references convention) all happened in `/discuss` sessions. These decisions shaped the entire stage but existed only in ephemeral conversation context. Without the human remembering to formalize them, they'd be invisible to future stages.
**How to leverage:** The `/discuss --summary` output format is close to what's needed — it captures key points, questions, and suggested actions. If summaries were optionally persisted (user-triggered, not automatic), they could serve as lightweight synthesis artifacts.

---

## ⏱️ Time Investment

| Activity | Time | Notes |
|----------|------|-------|
| Identifying the gap | ~10 min | Emerged naturally during `/discuss` about plan-review's input requirements |
| Tracing root cause | ~5 min | Quick once we looked at the group-cycle pipeline steps and noticed the absence |
| Scoping the three sub-problems | ~10 min | Distinguishing trigger, overlap, and feed-forward took most of the thinking |

---

## 📝 Additional Notes

- This learning is directly relevant to Stage 4 (Executor role group), where `narrative`, `int-opp`, and `reflect` will be converted to skills. The pipeline integration question should be resolved *during* their conversion, not deferred.
- The `assets/` miss in the research family (which prompted this entire discussion) is the canonical example: a mid-implementation discovery that changed the convention for all Stage 3 skills, caught only because the human noticed it in chat.
- Consider whether `group-cycle.agent.md` Step 6 (Report) should commit a `group-N-learnings.md` artifact alongside the Sourcery review file. This would be the lightest-weight intervention — no new skills or triggers, just an addition to the existing pipeline.

---

**Last Updated:** 2026-05-02
