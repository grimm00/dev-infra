# Decision Interview: Agentic Workflow Modernization

**Purpose:** Surface the human's priorities, instincts, and constraints before the agent begins decision analysis. These answers shape which decision clusters are tackled first, what tradeoffs are acceptable, and what "v1" means.
**Status:** 🔴 Awaiting Human Input
**Created:** 2026-04-10
**Last Updated:** 2026-04-10

**Context:** 22 consolidated FRs, 3 NFRs, 4 Constraints, 2 Assumptions from 8 research topics. See [requirements.md](../../research/agentic-workflow-modernization/requirements.md) for the full list.

---

## How to Use This File

Answer each question honestly. Short answers are fine. "I don't know" is a valid answer -- it tells the agent where to present more options rather than assuming. Skip questions that don't resonate. Come back to ones that need more thought.

These aren't test questions. There are no wrong answers. The goal is to surface *your* priorities so the decision step isn't just the agent optimizing for technical completeness.

---

## Section 1: User Experience Priorities

### 1.1 Which of the current 26 commands do you use most frequently?

*List the 5-7 commands you invoke most often in a typical week.*

> 

### 1.2 Which commands feel the most friction when using them?

*Not "which are broken" -- which ones feel clunky, too long, or like they could be smoother?*

> 

### 1.3 If you could only convert 5 commands to skills first, which 5 would make the biggest difference in your daily work?

*Think about what you'd notice as a user, not what's technically easiest.*

> 

### 1.4 What does "done" look like for v1?

*Describe what you'd want to be true about the system after the first release. Not the full vision -- the minimum that would feel like real progress.*

> 

---

## Section 2: Backward Compatibility and Migration

### 2.1 Are you willing to break existing command invocations during migration?

*e.g., `/explore` stops working as a command and becomes a skill you invoke differently. Or do old commands need to coexist with new skills?*

> 

### 2.2 How do you feel about a "mixed state" where some workflows are skills and others are still commands?

*Is that acceptable for weeks/months, or would you want to convert everything at once?*

> 

### 2.3 Do other projects (work-prod, proj-cli, etc.) currently use dev-infra commands that would break if commands change?

*If yes, which ones, and how important is their compatibility?*

> 

---

## Section 3: Skill Count and Maintenance

### 3.1 The research estimated 60-80 skills from 26 commands (one skill per workflow mode). Does that feel right, manageable, or too many?

> 

### 3.2 Would you prefer fewer, larger skills (more content per skill, fewer files to maintain) or more, focused skills (less content each, more files)?

*This is a real tradeoff: fewer skills = more context per invocation, more skills = lighter but more to track.*

> 

### 3.3 How important is template sync (keeping standard-project and learning-project in parity) for skills?

*Is it a hard requirement from day one, or can it lag behind the initial conversion?*

> 

---

## Section 4: Rules and Context

### 4.1 The three `.mdc` files currently load ~500+ lines into every conversation. What's your tolerance for slimming them?

*Are you comfortable with aggressive reduction (keep only Cursor-specific config), or do you want to preserve most of the current guidance?*

> 

### 4.2 FR-5 says mutable project state (version numbers, completion status) should be removed from always-on rules. Do you agree? Is there state you'd want to keep?

> 

### 4.3 How do you feel about maintaining both AGENTS.md and CLAUDE.md (C-4: dual-file strategy)?

*Is this acceptable overhead, or would you rather pick one platform and defer the other?*

> 

---

## Section 5: Behavioral Skills and Quality

### 5.1 The five-property rubric (FR-19) is a quality gate for behavioral instructions. Should it be applied strictly (rewrite every Tier 2/3 instruction before shipping) or progressively (ship what's ready, improve over time)?

> 

### 5.2 The gotchas section (FR-20) requires documenting known failure modes for each behavioral skill. Is this something you'd populate upfront from the audit, or build incrementally from real usage?

> 

### 5.3 How important is the discuss skill's behavioral precision to you personally?

*It was the spike subject and has the most Tier 3 instructions. Is getting /discuss right a gate for everything else, or can it be improved in parallel?*

> 

---

## Section 6: Infrastructure and Tooling

### 6.1 The three-state arc (prose -> skills -> hooks/CLI) implies eventual tooling (hooks for deterministic rules, CLI for state surfacing). How important is building that tooling for v1?

*Or is v1 just the skill conversion, with hooks/CLI deferred?*

> 

### 6.2 How do you see proj-cli and proj-clone fitting into this?

*Are they dependencies for the skill distribution story, or parallel efforts that converge later?*

> 

### 6.3 The team marketplace is a "cherry-pick from dev-infra" model. Is shipping to the team marketplace a v1 goal, or is it purely future?

> 

---

## Section 7: Risk and Pace

### 7.1 What's your biggest worry about this modernization?

*What could go wrong that would make you regret starting it?*

> 

### 7.2 Would you rather ship a small, polished v1 (3-5 skills, fully rubric-compliant, with gotchas) or a broader v1 (15-20 skills, mixed quality, iterated later)?

> 

### 7.3 How much time per week can you realistically invest in this alongside your other projects?

*This affects whether stages should be small (completable in a few sessions) or larger (requiring sustained focus).*

> 

---

## Section 8: Open-Ended

### 8.1 Is there anything the research missed that you think is important for decisions?

> 

### 8.2 What's the one thing you'd want a future user of these skills to say about the experience?

> 

### 8.3 Anything else on your mind about this?

> 

---

## After Completing This Interview

Hand this file to the agent (or reference it in a `/decision` invocation). The agent uses your answers to:

1. **Cluster requirements** by decision type, prioritized by your stated priorities
2. **Present options** with tradeoffs framed against your risk tolerance and UX preferences
3. **Scope v1** based on your definition of "done" and available time
4. **Defer appropriately** based on what you explicitly said can wait

Your answers are the human track's input to the decision. The agent's contribution is structured analysis and tradeoff enumeration. Both tracks are needed.

---

**Last Updated:** 2026-04-10
