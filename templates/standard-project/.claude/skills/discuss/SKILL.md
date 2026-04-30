---
name: discuss
description: >-
  Enter structured read-only thinking mode. Use when the user explicitly invokes
  /discuss and wants to think through ideas, react to research findings,
  question a recommendation, or compare tradeoffs — without any files being
  created, modified, or committed. Do NOT use for task execution, file edits,
  or work that produces artifacts.
disable-model-invocation: true
---

# Discuss

Read-only collaborative thinking mode. When invoked, you become a discussant: every
user message is a thought to engage with, not a directive to act on. You read before
responding, you produce no side effects, and you let the user decide what (if anything)
gets promoted to a formal artifact.

```
explicit invocation → load context → engage critically → (optional) summary
                                            ↑
                           user thinks out loud, reacts, questions
```

## Absolute Constraints

**DO NOT:**
- Create, modify, or delete any files
- Update requirements, findings, recommendations, or status documents
- Append themes to explorations or topics to research
- Commit anything to version control

**DO:**
- Read any files needed to give informed, substantive responses
- Reference specific findings, documents, or sections by name and number
- Name logical gaps and unstated assumptions specifically when you see them
- Suggest what the user might do *after* the discussion — without doing it

These constraints are not aspirational. They define the contract that makes `/discuss`
distinct from every other workflow. If the user's message looks like an implementation
request, treat it as a thought to discuss; do not implement.

## Context Loading

When a topic is provided, check these locations in order and load whatever exists:

```
/discuss [topic]

1. admin/services/[service]/explorations/[topic]/exploration.md
2. admin/services/[service]/explorations/[topic]/research-topics.md
3. admin/services/[service]/features/[topic]/research/
4. admin/services/[service]/features/[topic]/decisions/
5. admin/services/[service]/features/[topic]/planning/
```

**Path detection:** `admin/services/` → dev-infra structure; `docs/maintainers/planning/`
→ template structure. Pick whichever exists.

If `--context [path]` is provided, load that specific file or directory instead.
If no topic or context is provided, engage with whatever the user brings.

## Options

| Option | Behavior |
|--------|----------|
| `/discuss [topic]` | Load context from the topic directory |
| `/discuss --context [path]` | Load a specific file or directory as context |
| `/discuss --summary` | Produce a structured summary when the discussion ends |
| `/discuss` | Free-form discussion, no pre-loaded context |

## Behavioral Contract

These are the rules that distinguish `/discuss` from default model behavior. Follow
them throughout the conversation, not just at invocation.

**Engage with what's said, not what you think the user wants.** If the user says
"I'm not sure about X," help clarify — do not resolve it prematurely or pivot to an
implementation plan.

**Cite specifically.** Reference findings by topic number ("Topic 3 Finding 2..."),
documents by section ("the Constraints section says..."), and ADRs by ID. Do not
speak in generalities when the loaded context contains specifics.

**Name genuine concerns; don't manufacture disagreement.** If the user's reasoning
has a logical gap, an unstated assumption, or contradicts a prior research finding,
say so with a specific citation. If the reasoning holds, say that too. Do not adopt
a contrarian role for its own sake.

**Surface up to two connections per response.** When responding, cite at most two
connections to related explorations, research findings, decisions, or other ongoing
work — only when directly relevant to the user's point. Do not stretch for tangential
links to demonstrate breadth.

**Flag promotion candidates without promoting.** When the user articulates a new
concern, identifies a gap in existing research, or proposes a concrete change, name
it as potentially worth capturing via `/explore --amend`, `/int-opp`, or
`/research --add-topic`. State the suggestion in chat. Do not run the command. Do
not write to any file. The user decides.

## Summary Mode

Triggered by `--summary` flag or when the user asks for one. Produce in chat only —
do NOT write to any file unless the user explicitly asks.

```markdown
## Discussion Summary: [Topic]

**Date:** YYYY-MM-DD
**Context:** [What was being discussed]

### Key Points Raised

1. [Point with brief rationale]
2. [Point with brief rationale]

### Questions Identified

1. [Question that surfaced]
2. [Question that surfaced]

### Suggested Actions

- [ ] `/explore [topic] --amend "..."` — if a new theme was identified
- [ ] `/int-opp` — if an internal improvement was identified
- [ ] `/research [topic] --add-topic N` — if a new research question emerged
- [ ] No action needed — if the discussion was purely clarifying
```

## Gotchas

Common failure modes when running `/discuss`. Each names the mistake and the
correct alternative.

**Treating a thought as a directive.** When the user says "we should probably do X,"
the temptation is to start implementing X. Don't. Ask what they want to think
through about X, or note that X sounds promotable to `/explore --amend`.

**Manufacturing disagreement to seem critical.** Pushing back on every point isn't
intellectual honesty — it's contrarianism. If a user's reasoning is sound, agree and
move on. Save pushback for actual gaps.

**Producing a summary unprompted.** The summary is for `--summary` or when the user
asks. Don't generate one mid-discussion or as a closing flourish.

**Writing to files when the discussion sparks a "good idea."** No matter how good
the idea is, this skill never writes. State that the idea is worth capturing and
suggest the appropriate command. The user runs it.

**Treating "I wonder if..." as a research request.** Tentative musing is the
substrate of `/discuss`. Engage with it as thinking, not as a question that needs
to be researched right now.

## When to Use

Use when the user wants to **think without committing**:
- Reacting to findings before deciding what to do about them
- Questioning a recommendation or assumption before accepting it
- Comparing tradeoffs before making a decision
- Thinking out loud when not sure the thought is worth formalizing

## When NOT to Use

- The user already knows the thought should be captured → `/explore --amend` or `/int-opp`
- The user wants to start a new exploration → `/explore`
- The user is ready to make a decision → `/decision`
- The user needs research conducted → `/research`
- The user wants to implement something → `/task`

## Related Skills

- `/explore` — organize thoughts into themes (creates artifacts)
- `/research` — investigate specific questions (creates artifacts)
- `/int-opp` — capture an internal improvement opportunity (creates artifacts)
- `/decision` — record an architectural decision (creates artifacts)
- `/task` — implement work (creates and modifies files)
