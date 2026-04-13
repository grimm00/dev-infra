# Decision Command Needs Structured Human Involvement

**Source:** /discuss session -- agentic-workflow-modernization (2026-04-10)
**Target:** dev-infra workflow pipeline (all templates)
**Status:** 🔴 Not Started
**Priority:** HIGH
**Effort:** MEDIUM (command redesign + interview pattern)
**Created:** 2026-04-10
**Last Updated:** 2026-04-10

---

## Problem Statement

The current `/decision` command takes consolidated requirements as input and produces ADRs as output. In practice, the agent does ~95% of the work: it reads all requirements, selects an approach, and drafts the ADR. The human rubber-stamps.

This is the exact opposite of the dual-track model identified in Topic 7 Finding 8: both the human and agent should bring their parallel processing to the decision. The human has priorities, risk tolerance, UX intuition, and cross-project context that the agent doesn't have. The agent has structured analysis, tradeoff enumeration, and completeness that the human doesn't have. The current command uses only the agent's capabilities.

**Evidence from this research effort:**

- The Topic 6 reframing (marketplace as team subset) came from the human's parallel thinking, not from any agent research. A decision step that only used the agent's analysis would have produced the overbuilt monorepo marketplace model.
- The escalation ladder insight (hooks/CLI for both tracks) came from a `/discuss` session where the human connected Topic 8 findings to their proj-cli work. The agent would not have made this connection.
- The user explicitly noted: "I don't know how exactly this kind of designing works but those kinds of questions are at least what I'm sensing" -- indicating the current workflow doesn't surface the human's judgment at decision time.

---

## Proposed Solution

Restructure `/decision` to include structured human involvement before ADR drafting.

### 1. Interview Step (New)

Before the agent drafts options, it interviews the human to understand priorities:

- "Of these 22 requirements, which 5 would you ship first if you could only ship 5?"
- "Which constraints are you willing to bend?"
- "What's your risk tolerance for breaking existing command users?"
- "What matters more: completeness or shippability?"

This surfaces the human's parallel processing (cross-project connections, UX intuition, priority judgment) before the agent does analysis.

### 2. Options, Not Answers (New)

The agent presents 2-3 viable options with explicit tradeoffs rather than jumping to a recommendation. The human reacts and challenges. Only then do they converge on a decision. This is a structured `/discuss` before the ADR is written.

### 3. Thin Slice Pattern (New)

Group requirements into decision clusters rather than deciding everything at once:

- "Skill structure decisions" (FR-7, FR-8, FR-10, FR-21)
- "Distribution decisions" (FR-12, FR-14, FR-15, FR-16)
- "Behavioral contract decisions" (FR-19, FR-20, FR-22)

Some decisions gate others (FR-7/one-skill-per-workflow gates naming and decomposition), so ordering matters. Each cluster gets its own decision cycle (interview → options → convergence → ADR).

### Proposed Flow

```
/decision [topic] --from-research
  → Read consolidated requirements
  → Interview: surface human priorities (NEW)
  → Cluster: group requirements into decision clusters (NEW)
  → For each cluster:
    → Present 2-3 options with tradeoffs (NEW)
    → STOP: wait for human reaction and challenge (NEW)
    → Converge: human + agent agree on approach
    → Draft ADR for this cluster
  → Final review: human reviews all ADRs together
```

### Connection to Design Step

Good decisions pre-filter for design. If decisions are made with explicit tradeoffs surfaced and human priorities encoded, the design step inherits clean inputs. The staging question ("what combination of skills is releasable?") becomes answerable because the decisions already express which requirements are v1 vs v2.

---

## Decision Science Patterns Referenced

| Pattern | Application |
|---------|-------------|
| **Options, Not Answers** | Present 2-3 approaches with tradeoffs before recommending |
| **Thin Slice** | Group requirements into decision clusters, decide each independently |
| **Interview Before Analysis** | Surface human priorities before agent does structured analysis |
| **Structured Disagreement** | Explicitly invite the human to challenge options before convergence |

---

## Related

- [design-step-in-pipeline.md](design-step-in-pipeline.md) -- The design step int-opp (complementary: decision feeds design)
- [Topic 7 Finding 8](../../../../research/agentic-workflow-modernization/topic-7-conversation-orchestration.md) -- Dual-track model (human as concurrent agent)
- [Topic 8 Finding 9](../../../../research/agentic-workflow-modernization/topic-8-behavioral-contracts.md) -- Escalation ladder applies to both tracks
- `/decision` command -- `.cursor/commands/decision.md`

---

**Last Updated:** 2026-04-10
