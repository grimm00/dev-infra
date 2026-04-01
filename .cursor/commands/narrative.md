# Narrative Command

Create a "story of the work" document after completing a feature or significant piece of work. Captures the why, what, and how in a format suitable for demos, PR descriptions, apprentice learning, and team knowledge sharing.

---

## Why This Exists

Existing commands capture specific aspects of work: `/reflect` tracks daily progress and personal growth, `/int-opp` extracts reusable learnings for other projects, and `/review` validates individual commits. None of them produce a coherent story of how a piece of work evolved from problem to solution.

A narrative fills that gap. It answers three questions that other artifacts don't:

1. **Why did this work matter?** (business context, not just ticket number)
2. **What made it interesting or hard?** (technical challenges, not just a diff)
3. **How did the approach evolve?** (decisions, discoveries, pivots -- the journey, not just the destination)

This is especially valuable for:

- **PR descriptions** that give reviewers the full picture
- **Demo preparation** where you need to explain the work to a non-technical or mixed audience
- **Apprentice learning** as a record of how real engineering problems get solved
- **Team knowledge** when someone later asks "why was it done this way?"

---

## Usage

**Command:** `/narrative [topic] [options]`

**Examples:**

- `/narrative workflow-simplification` - Create narrative for a completed feature
- `/narrative workflow-simplification --pr` - Also generate a PR-ready version
- `/narrative workflow-simplification --demo` - Also generate demo talking points

**Options:**

- `[topic]` - Topic name matching the exploration/planning/feature directory name
- `--pr` - Also generate a condensed version suitable for a PR description
- `--demo` - Also generate structured talking points for demos/presentations

---

## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Dev-Infra Structure:**
   - Output: `admin/narratives/[topic]/`
   - Sources: `admin/explorations/[topic]/`, `admin/research/[topic]/`, `admin/decisions/[topic]/`, `admin/planning/features/[topic]/`

2. **Template Structure (for generated projects):**
   - Output: `docs/maintainers/narratives/[topic]/`
   - Sources: `docs/maintainers/planning/explorations/[topic]/`, `docs/maintainers/planning/features/[topic]/`

3. **Lightweight Structure:**
   - Output: `narratives/[topic]/` or `docs/narratives/[topic]/`
   - Sources: any exploration, research, or planning directories found

**Auto-detection:**
- Check if `admin/narratives/` exists or `admin/` exists → use dev-infra structure
- Check if `docs/maintainers/` exists → use template structure
- Otherwise → use lightweight structure

**Creates:**

```
narratives/[topic]/
  narrative.md            - The full narrative document
  pr-description.md       - PR-ready version (if --pr)
  demo-notes.md           - Demo talking points (if --demo)
```

---

## Process

### 1. Gather Context

Read all relevant artifacts to reconstruct the story:

**Primary sources (check all, use what exists):**

- **Exploration:** `[explorations-path]/[topic]/exploration.md`
- **Research:** `[research-path]/[topic]/` -- hub, summary, topic documents
- **Decisions:** `[decisions-path]/[topic]/` -- ADRs
- **Planning:** `[planning-path]/features/[topic]/` -- implementation plan, tasks
- **Spike learnings:** `[explorations-path]/[topic]/spike-learnings.md`

**Git history:**

```bash
git log --oneline --all --grep="[topic]"
```

Or if on a feature branch:

```bash
git log --oneline HEAD --not origin/develop
```

**Implementation files:**

- Scripts, templates, or source files created/modified
- Tests created/modified
- Configuration changes

### 2. Identify the Story Arc

Every narrative should have a clear arc. Not all sections will apply to every piece of work, but consider:

- **The Problem** - What existed before, what was wrong or missing, why action was needed
- **The Constraints** - What made this harder than it looks (unique characteristics, broken assumptions, new territory)
- **The Architecture Decision** - What approach was chosen and why (if there were alternatives)
- **The Build** - How it was implemented, in what order, and why that order
- **The Discoveries** - What was learned along the way that changed the plan (spikes, surprises, bugs caught early)
- **The Testing Challenge** - How correctness was verified, especially for novel patterns
- **The Result** - What was produced, what patterns were established for future use

### 3. Write the Narrative

**Tone:** Technical but accessible. Write as if explaining the work to a thoughtful colleague who knows the domain but hasn't been following this specific project. Avoid jargon where plain language works, but don't shy away from specifics when precision matters.

**Structure:** Use the template below but adapt it. Not every section will apply. A narrative for a small bugfix will be shorter than one for a multi-phase migration. An exploration narrative may focus more on the evolution of thinking than on implementation.

**Evidence:** Ground the story in specifics -- commit hashes, error messages, code snippets, before/after comparisons. The narrative should be verifiable, not just a good story.

---

## narrative.md Template

```markdown
# Narrative: [Title]

**Branch:** `[branch name]`
**Date:** [start] → [end]

---

## Why This Matters

[Business or project context. Why does this work exist? What problem does it solve?
Who is affected? Write for someone who knows the domain but not this specific task.]

---

## What Made This One Different

[What was surprising, hard, or novel about this work? How did it differ from similar
work done before? What assumptions broke?

A comparison table is effective here for migrations or pattern-breaking work.]

---

## How It Was Built

### [Decision/Architecture Section]

[What approach was chosen and why. If there were alternatives, briefly explain them
and why they were rejected.]

### [Implementation Approach]

[How the work was phased. Why that phasing? What was the thinking behind the order?]

### [Discoveries That Changed the Plan]

[What was learned during implementation that wasn't anticipated? Spikes, error
messages, API limitations. These are the most valuable parts of the narrative --
they capture knowledge that documentation misses.]

### [Testing / Verification]

[How was correctness verified? What new testing patterns were needed?]

---

## What Was Learned

### For the Project

[Patterns established, conventions created, reusable approaches.]

### For the Engineer

[Meta-lessons: what this work taught about process, experimentation, understanding
fundamentals, breaking work into phases, etc.]

---

## The Commits

```
[commit hash] [commit message]
[commit hash] [commit message]
```

---

## Related Artifacts

| Artifact | Location |
|----------|----------|
| [Name] | [Relative path] |
```

---

## When to Use `/narrative` vs Other Commands

| Situation | Command | Why |
|-----------|---------|-----|
| Capturing daily progress | `/reflect` | Personal growth tracking |
| Extracting reusable learnings | `/int-opp` | Cross-project improvement |
| Reviewing changes before commit | `/review` | Code quality gate |
| Telling the story of completed work | `/narrative` | Knowledge sharing, demos, PR enrichment |
| Thinking through ideas without artifacts | `/discuss` | No side effects needed |

### Key Distinction

- `/reflect` is about **you** (what did I learn today?)
- `/int-opp` is about **the tooling** (what should improve?)
- `/narrative` is about **the work** (what's the story of this feature?)

---

## Integration

```
/explore [topic]           <- Understand the problem space
    |
/spike [topic]             <- Validate risky assumptions
    |
/research [topic]          <- Investigate questions
    |
/decision [topic]          <- Make architecture decisions
    |
/transition-plan [topic]   <- Plan the implementation
    |
/task                      <- Build it (phased commits)
    |
/narrative [topic]         <- Tell the story (this command)
    |
    ├── PR description     <- Enrich the PR with context
    ├── Demo prep          <- Drive presentations
    └── Knowledge base     <- Future reference
```

`/narrative` is a **post-completion command**. Run it after the work is done, when you can see the full arc. It draws from all the artifacts created during earlier phases.

**Note:** Narratives can also capture exploration sessions, research journeys, or decision processes -- not just implementation. If the thinking itself was the work, the narrative tells that story.

---

## Tips

### When to Write a Narrative

- **After completing a multi-phase feature** -- the story is richest when there were decisions, pivots, and discoveries
- **Before opening a PR** -- writing the narrative clarifies your own understanding and produces a better PR description
- **When the work established new patterns** -- future contributors will benefit from understanding why the pattern exists
- **After a significant exploration or decision session** -- the journey of how thinking evolved is worth capturing

### When NOT to Write a Narrative

- Simple bug fixes with no interesting story
- Routine maintenance (dependency bumps, config updates)
- Work that's still in progress -- the story isn't complete yet

### Writing Quality

- **Show, don't tell.** Instead of "this was hard," show the error message that surprised you.
- **Include the wrong turns.** The discoveries that changed the plan are more valuable than the final solution.
- **Use before/after comparisons.** The contrast between old and new reveals the "why" better than any explanation.
- **Keep it honest.** If the initial approach was wrong and you had to pivot, say so. That's the most useful part for future readers.

---

## Reference

**Related Commands:**

- `/reflect` - Daily/phase reflection (personal growth)
- `/int-opp` - Internal improvement opportunities (cross-project)
- `/review` - Pre-commit review (code quality)
- `/discuss` - Structured conversation (no artifacts)
- `/transition-plan` - Implementation planning (pre-work)
- `/explore` - Exploration (pre-research)

**Output Location:**

- **Dev-Infra:** `admin/narratives/[topic]/`
- **Template Structure:** `docs/maintainers/narratives/[topic]/`
- **Lightweight:** `narratives/[topic]/` or `docs/narratives/[topic]/`

---

**Last Updated:** 2026-03-25
**Status:** ✅ Active
