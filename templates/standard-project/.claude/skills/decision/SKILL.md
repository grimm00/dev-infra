---
name: decision
description: >-
  Create Architecture Decision Records from research: human decision-interview
  first, then one ADR per decision point with alternatives and rationale.
  Use after research is complete and the user wants /decision or to record
  topic decisions. Do NOT run planning/task implementation in this skill —
  hand off to the project's planning workflow after ADRs exist.
disable-model-invocation: true
---

# Decision

Make **documented architecture decisions** from research artifacts. **Hybrid
skill:** procedural file scaffolding + behavioral judgment (decision framing,
alternative quality, human pacing).

**North star:** The user stays in control and enriched by slowing down — not
rushed to a single “right answer” before priorities are explicit (see
decision-interview pattern).

---

## When to use

- Research outputs exist (summary + topic docs or equivalent) and the user
  wants ADRs for a topic.
- User says `/decision`, “decision command”, or “turn this research into ADRs”.

## When not to use

- Research scaffolding is missing → point to **research-setup** first.
- User only wants brainstorming without records → **discuss**.
- User wants implementation tasks → **task** / planning pipeline, not this skill.

---

## Path resolution

Pick **one** row and use it consistently for `topic` (kebab-case slug):

| Structure | Topic root | Decisions directory | Research summary (typical) | Requirements (typical) |
|-----------|------------|--------------------|----------------------------|-------------------------|
| Dev-Infra feature | `admin/services/[service]/features/[topic]/` | `[topic-root]/decisions/` | `research/research-summary.md` or under `research/` | `[topic-root]/requirements.md` or `research/requirements.md` |
| Template maintainer | `docs/maintainers/` | `docs/maintainers/decisions/[topic]/` | `docs/maintainers/research/[topic]/research-summary.md` | `docs/maintainers/research/[topic]/requirements.md` |
| Project-wide | `docs/maintainers/` | `docs/maintainers/decisions/[topic]/` | same as template row | same as template row |

**Do not** use `admin/decisions/[topic]/` for dev-infra feature work — that path
conflicts with feature-local hubs; feature **`[topic]/decisions/`** is canonical.

---

## Preconditions (stop if unmet)

1. User supplies or confirms `topic` and at least one research path to read
   (`--from-research` equivalent).
2. After reading: if there are **no** findings and **no** stated decision
   questions, **stop** — research is not ready.

---

## Workflow

### 0. Decision interview (human priorities)

**Goal:** Surface priorities, friction, and constraints **before** clustering
decision points (phase start signal from agentic-workflow research).

1. Compute `decisions/` directory for the topic from the table above.
2. Interview artifact path: **`[decisions-dir]/decision-interview.md`**.
3. If the file **does not exist**: offer to create a stub with sections modeled
   on typical interview flow:
   - **How to use** (short answers; skip ok)
   - **User experience priorities** (which workflows matter; friction)
   - **Constraints / instincts** (scope, risk, “v1 means…”)
   - Optional: **architecture / validation** prompts  
   Then **stop** until the user fills enough to guide clustering **or** types an
   explicit in-chat waiver: e.g. `waive decision interview`.
4. If the file **exists**: read it first; use it to order which decision clusters
   to tackle and what tradeoffs are acceptable. If it is still marked awaiting
   input and empty where it matters, **stop** and ask the user to complete or
   waive.

### 1. Load research and requirements

1. Read `research-summary.md` (or equivalent) for the topic.
2. Read per-topic research files linked from the hub or under `research/`.
3. Read `requirements.md` when present (functional + non-functional).
4. **Outputs:** mental model of constraints, findings, and candidate requirements
   IDs to reference later.

### 2. Identify decision points (cluster)

For each cluster of related unknowns:

1. Name **one** decision question (one ADR per decision point later).
2. List **2–3 alternatives** with **pros/cons** — **do not** present a single
   recommended winner until the user chooses or defers (see Behavioral
   Contract).
3. Note decision criteria (e.g. portability, complexity, team size).

**Observable output:** Ordered list of decision points (titles only) shown to
the user; User confirms order or edits before file writes.

### 3. Create or update decisions hub README

In `[decisions-dir]/README.md`:

- Purpose: decisions hub for topic; links to research + requirements.
- Table listing each ADR with status (Proposed until user accepts).
- `decisions-summary.md` link.

Use the project's status emoji conventions if already present; otherwise 🔴 /
🟡 / ✅ as in existing docs.

### 4. Write ADRs (one file per decision point)

**Filename:** `adr-[NNN]-[kebab-name].md` in `[decisions-dir]/`,
zero-padded numbering matching hub order.

**Required sections (non-negotiable):**

1. **Context** — problem, forces, links to research + requirements.
2. **Decision** — clear decision statement.
3. **Consequences** — Positive and Negative subsections.
4. **Alternatives Considered** — at least two, each with pros/cons and **why not
   chosen** (or “deferred” with reason).
5. **Decision Rationale** — ties back to interview priorities and research.
6. **Requirements Impact** — affected/refined requirements.
7. **References** — research paths, interview file if used.

**Status:** start as **Proposed** unless the user directs otherwise.

### 5. Create `decisions-summary.md`

Summarize each ADR in one screen: decision one-liner, status, link. Requirements
impact at high level, pointer to full `requirements.md`.

### 6. Update parent decisions index (if present)

| Structure | Parent index |
|-----------|----------------|
| Template / project-wide | `docs/maintainers/decisions/README.md` |
| Dev-Infra | `admin/decisions/README.md` **or** service hub if that is where the repo lists decision topics — use whichever file already lists other topics. If none exists, skip (do not invent org-wide policy). |

Add the topic link only if that file exists and is the established pattern.

### 7. Commit guidance (bounded)

1. Propose a single commit or small series with message shape:
   `docs(decisions): add [topic] ADRs` (or per-ADR if user prefers).
2. List `git add` paths concretely.
3. **Stop.** Do not merge to a branch unless the user's repository policy asks —
   the old command's merge-to-develop flow is not universal.

---

## Behavioral Contract

**Options, not answers.** Until the user selects or explicitly defers, present
**2–3** credible alternatives with tradeoffs for each decision point. A
recommended default is allowed **only** if the user asks for a recommendation
after seeing alternatives.

**One ADR per decision point.** Do not combine unrelated decisions in one ADR.

**Traceability.** Each ADR's Context and References must include paths the reader
can open — no orphan decisions.

**Interview informs rationale.** The `decision-interview.md` content (or waiver)
must visibly influence **Decision Rationale** and ordering — if not, you skipped
the point of step 0.

**Bounded analysis.** Enough analysis to distinguish alternatives; stop when
sections are complete and consistent. Do not continue into implementation
planning.

**Failure-aware.** If paths conflict or hub already exists with different
numbering, **pause** and ask whether to append, renumber, or align with existing
ADRs.

---

## Gotchas

**Wrong dev-infra root.** Using a global `admin/decisions/[topic]/` path for
feature work breaks links; use `admin/services/.../features/[topic]/decisions/`.

**Skipping interview silently.** Without priorities, decision order defaults to
technical completeness — that violates the interview-first pattern; only proceed
with an explicit waiver.

**Single-option ADRs.** An ADR with one “alternative” is incomplete — fold more
options in or document why others were eliminated in research.

**Paste-only ADRs.** Filling the template with placeholders and lorem-style
text — each section needs substantive ties to **this** topic's research.

**Merged recommendations.** If you “hallucinate” a decision the user did not
accept, rewind: alternatives first, then record their choice.

**Planning bleed.** Do not create `implementation-plan.md` here — that belongs
to the planning / write-plan step after ADRs stabilize.

---

**Last Updated:** 2026-05-02
