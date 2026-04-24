# Decision Interview: Agentic Workflow Modernization

**Purpose:** Surface the human's priorities, instincts, and constraints before the agent begins decision analysis. These answers shape which decision clusters are tackled first, what tradeoffs are acceptable, and what "v1" means.
**Status:** 🔴 Awaiting Human Input
**Created:** 2026-04-10
**Last Updated:** 2026-04-10

**Context:** 22 consolidated FRs, 3 NFRs, 4 Constraints, 2 Assumptions from 8 research topics. See [requirements.md](../../research/agentic-workflow-modernization/requirements.md) for the full list.

---

## How to Use This File

Answer each question honestly. Short answers are fine. "I don't know" is a valid answer -- it tells the agent where to present more options rather than assuming. Skip questions that don't resonate. Come back to ones that need more thought.

These aren't test questions. There are no wrong answers. The goal is to surface _your_ priorities so the decision step isn't just the agent optimizing for technical completeness.

---

## Section 1: User Experience Priorities

### 1.1 Which of the current 26 commands do you use most frequently?

_List the 5-7 commands you invoke most often in a typical week._

> I use explore, research, transition-plan, review, commit, and int-opp. I could see myself using "narrative" more even though it's fairly new. That said, I don't know if any commands in this workflow can really exist without the other. One thing I can say is that this is usually the exploration is more used than most simply because sometimes the ideas don't go into full formal documents. Sometimes it can be for fixes or other kinds of explorations that can go right to transitions, while some simply are left to be looked over or trashed later.

### 1.2 Which commands feel the most friction when using them?

_Not "which are broken" -- which ones feel clunky, too long, or like they could be smoother?_

> Explore definitely, specifically it's "conduct" mode. Explore should really just be a way to extrapolate themes from unstructure thoughts and then amend as more questions, thoughts, or even research come about. Explorations should be detailed enough to be able to be done in one pass but not so much that it takes over research, therefore conduct will be deprecated. Otherwise, it's still be one of the most useful commands here.

> The various "fix-implement, fix-review, etc" plans also have a lot of friction when it comes to coordination. Also the various release commands could probably be could be consolidated into a release agent with multiple skils.

> In fact, given the idea of "models" exist in engineering, our models can surround agents with narrow scopes. I noticed that a lot of my release commands could exist under a "Release" parent dir like we discussed with explore, but we could also research what a "Release manager" does, for example, and use that as a model for said skillset.

### 1.3 If you could only convert 5 commands to skills first, which 5 would make the biggest difference in your daily work?

_Think about what you'd notice as a user, not what's technically easiest._

> This is a good question, and I don't know really. In fact, this is a good question to ask because if right now I don't know if I'll notice any difference, then does this signal either us assessing the cost of this a little more carefully, or start thinking about gamechangers that enforce that this modernization is a great transition.

### 1.4 What does "done" look like for v1?

_Describe what you'd want to be true about the system after the first release. Not the full vision -- the minimum that would feel like real progress._

> This is a good question. I think all commands converted to skills available for templates would work. Probably start off with the core skill that hasn't gone through the prompt-tinkerer escalation just to "have" them, with each flash extracted into their own "sub-skill", with a "<skill>-start" for each one. I am willing to be challenged on this though.

---

## Section 2: Backward Compatibility and Migration

### 2.1 Are you willing to break existing command invocations during migration?

_e.g., `/explore` stops working as a command and becomes a skill you invoke differently. Or do old commands need to coexist with new skills?_

> Since I've been the sole user, I would not mind. This does not break the way I mentally engage with the pipeline.

### 2.2 How do you feel about a "mixed state" where some workflows are skills and others are still commands?

_Is that acceptable for weeks/months, or would you want to convert everything at once?_

> For me, this won't matter much. I think if the skill conversions work wth great success, I will be ready to push forward with more conversations/v2 stuff.

### 2.3 Do other projects (work-prod, proj-cli, etc.) currently use dev-infra commands that would break if commands change?

_If yes, which ones, and how important is their compatibility?_

> No. Other projects would in fact be better with the skills, we'd just have a way to give dev-infra-managed projects the skills.

---

## Section 3: Skill Count and Maintenance

### 3.1 The research estimated 60-80 skills from 26 commands (one skill per workflow mode). Does that feel right, manageable, or too many?

> It sounds like too many, but I think because of think because of the "derive from role model" development of skills will help make this very manageable and honestly, necessary.

### 3.2 Would you prefer fewer, larger skills (more content per skill, fewer files to maintain) or more, focused skills (less content each, more files)?

_This is a real tradeoff: fewer skills = more context per invocation, more skills = lighter but more to track._

> I believe our structured "skill families" will allow us to not have to have to choose between the two.

### 3.3 How important is template sync (keeping standard-project and learning-project in parity) for skills?

_Is it a hard requirement from day one, or can it lag behind the initial conversion?_

> It is not a hard day 1 requirement.

---

## Section 4: Rules and Context

### 4.1 The three `.mdc` files currently load ~500+ lines into every conversation. What's your tolerance for slimming them?

_Are you comfortable with aggressive reduction (keep only Cursor-specific config), or do you want to preserve most of the current guidance?_

> I am comfortable with this. In fact, I think rules files deserve its own exploration. I don't think this has had enough thought put into how to fully utilize this part of Cursor.

### 4.2 FR-5 says mutable project state (version numbers, completion status) should be removed from always-on rules. Do you agree? Is there state you'd want to keep?

> I think project state can be tracked elsewhere. That is maybe a v2-v3 thing: the tracking of project state, which is something that might not even be a part of this workflow, but maybe a feature of the other parts of the "four-arm architecture".

### 4.3 How do you feel about maintaining both AGENTS.md and CLAUDE.md (C-4: dual-file strategy)?

_Is this acceptable overhead, or would you rather pick one platform and defer the other?_

> You know, I think this talk of CLAUDE.md and AGENTS.md we've had and that my colleagues have had calls out a gap in repo architecture: the existence of CONVENTIONS.md. While this "Feels" like a file that exists in some repo somewhere, I dont think I've seen a file that specifically talks about conventions myself. I found that AGENTS.md as a conventions file was actually filling a gap that would be useful to both agents AND humans. This means that AGENTS.md could carry more information relevant to agents within the agentic coding domain. Looking for thoughts on this.

---

## Section 5: Behavioral Skills and Quality

### 5.1 The five-property rubric (FR-19) is a quality gate for behavioral instructions. Should it be applied strictly (rewrite every Tier 2/3 instruction before shipping) or progressively (ship what's ready, improve over time)?

> I believe the skill conversions will be the best opportunity to make these rewrites, so yes, they should be applied strictly.

### 5.2 The gotchas section (FR-20) requires documenting known failure modes for each behavioral skill. Is this something you'd populate upfront from the audit, or build incrementally from real usage?

> I'd probably populate it upfront from the audit. I also think during each convert that I can provide failure modes I've experienced in the past, but again, some of these might be fixed with future hooks.

### 5.3 How important is the discuss skill's behavioral precision to you personally?

_It was the spike subject and has the most Tier 3 instructions. Is getting /discuss right a gate for everything else, or can it be improved in parallel?_

> One thing I will say is the discuss command seems to work as is right now. I would want to make sure the change itself improves and not degrade the quality that I've been accustomed to.

---

## Section 6: Infrastructure and Tooling

### 6.1 The three-state arc (prose -> skills -> hooks/CLI) implies eventual tooling (hooks for deterministic rules, CLI for state surfacing). How important is building that tooling for v1?

_Or is v1 just the skill conversion, with hooks/CLI deferred?_

> Hooks/CLI can be deferred.

### 6.2 How do you see proj-cli and proj-clone fitting into this?

_Are they dependencies for the skill distribution story, or parallel efforts that converge later?_

> The proj CLI will help with the lifecycle of projects, but I don't think they are matters of importance for v1, but they are definitely a story for skill distribution, but I also think that is for v2+ or another cycle.

### 6.3 The team marketplace is a "cherry-pick from dev-infra" model. Is shipping to the team marketplace a v1 goal, or is it purely future?

> Future. In fact, I got some feedback that might have given us more to chew on; my rotation lead mentioned that while he was talking with an agent, he appreciated that said agent detected that it was a design question, so it went into a "plan" mode and asked clarifying questions. Therefore, the auto-loading may be more important than I initially thought, since I hadn't considered that my personal understanding of my commands/skills won't carry over to others who don't understand the workflow at all and might just talk to a prompt normally without any invocation of a skill. And while Cursor doesn't autoload skills like Claude, it still has the ability to contextually switch modes based on what prompt it's given, so it will, for example, go to "plan" mode when it detects certain questions. This is worth exploring because, frankly, it's something I didn't even think about as something to take advantage of.

---

## Section 7: Risk and Pace

### 7.1 What's your biggest worry about this modernization?

_What could go wrong that would make you regret starting it?_

> That I'm not able to eventually advertise it enough as a replacement for hex or superpowers. I'm also worried that I'm not paying enough attention to where implicit invocation could work (even if a subskill is auto-loaded, the skill could still be pointed at the parent skill explicitly in said skill itself.)

### 7.2 Would you rather ship a small, polished v1 (3-5 skills, fully rubric-compliant, with gotchas) or a broader v1 (15-20 skills, mixed quality, iterated later)?

> Small and polished v1.

### 7.3 How much time per week can you realistically invest in this alongside your other projects?

_This affects whether stages should be small (completable in a few sessions) or larger (requiring sustained focus)._

> I think I have been given a greenlight to put as much time into this as I feel necessary. If we're going 80-20, maybe 8 hours per week, but it could realistically be 16+ hours a week, and not even including extra time outside of work.

---

## Section 8: Open-Ended

### 8.1 Is there anything the research missed that you think is important for decisions?

> I think it may be important to research the chat itself. I think while it is the main way we interact with agents, we have not understood how it "functions" if that makes sense. Maybe the ai-prompt-lifecycle research done here could help.

### 8.2 What's the one thing you'd want a future user of these skills to say about the experience?

> I would like to see users be able to feel more engaged with the work they're doing, whether they're projects, ideas, or even small support tickets; they should feel in control and even enriched through the experience of slowing down.

### 8.3 Anything else on your mind about this?

> My engagement in this interview and overall modernization process is still being balanced with my lack of domain knowledge in the things my team touches daily. Sometimes I don't know where I o

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
