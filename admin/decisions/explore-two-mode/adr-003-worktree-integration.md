# ADR-003: Worktree Integration for /explore

**Status:** Proposed  
**Created:** 2026-01-10  
**Last Updated:** 2026-01-10

---

## Context

The worktree feature workflow (ADR-002 self-contained feature branches) establishes that feature work should happen on dedicated worktrees. However, exploration is inherently speculative - not all explorations become features.

Research identified a natural gate: the transition from Setup Mode to Conduct Mode represents the shift from "quick idea check" to "real investment."

**Related Research:**
- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Worktree Feature Workflow Learnings](../../planning/opportunities/internal/dev-infra/learnings/worktree-feature-workflow/feature-learnings.md)

**Related Requirements:**
- FR-WT-1: Setup Mode MUST NOT require worktree; Conduct Mode SHOULD prompt
- FR-WT-2: Worktree prompt on conduct
- FR-WT-3: Skip worktree flag (`--no-worktree`)
- FR-WT-4: Automatic worktree flag (`--worktree`)

**Related ADRs:**
- [ADR-002: Self-Contained Feature Branches](../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md)

---

## Decision

**Implement lazy worktree creation: prompt on Conduct Mode transition.**

### Setup Mode (No Worktree)

```bash
/explore my-idea
```
- Runs on current branch (typically develop)
- Creates lightweight scaffolding (~60-80 lines)
- Low investment, acceptable to abandon
- ✅ No worktree prompt

### Conduct Mode (Worktree Prompted)

```bash
/explore my-idea --conduct
```
- Prompts: "Create worktree for this exploration? [Y/n]"
- If yes: Creates `worktrees/feat-my-idea` with branch `feat/my-idea`
- If no: Continues on current branch
- Represents real investment in the idea

### Explicit Flags

```bash
# Always create worktree
/explore my-idea --conduct --worktree

# Never create worktree (skip prompt)
/explore my-idea --conduct --no-worktree
```

### Flow Diagram

```
/explore [topic]                    ← Setup on develop
    ↓
exploration.md (scaffolding)        ← Review scaffolding
    ↓
/explore [topic] --conduct          ← Prompt for worktree
    ↓
[Create worktree?]
    ├─ Yes → worktrees/feat-[topic] ← Full exploration on feature branch
    └─ No  → current branch         ← Continue without worktree
```

---

## Consequences

### Positive

- **Low Friction Start:** Quick explorations don't require worktree overhead
- **Natural Gate:** Conduct mode is meaningful commitment point
- **ADR-002 Alignment:** Serious work happens on self-contained branches
- **Clean Develop:** Abandoned explorations are small (scaffolding only)
- **User Control:** Explicit flags for automation/scripting

### Negative

- **Prompt Interruption:** User must answer prompt (mitigated by flags)
- **Two Branches Possible:** Some exploration content may stay on develop
- **Complexity:** More logic in command implementation

---

## Alternatives Considered

### Alternative 1: Always Create Worktree

**Description:** Create worktree on any `/explore` invocation.

**Pros:**
- Consistent: all exploration on feature branches
- Cleaner develop branch

**Cons:**
- High friction for quick ideas
- Many abandoned worktrees
- Overkill for "will this work?" explorations

**Why not chosen:** Setup mode is intentionally lightweight; worktree overhead is excessive.

---

### Alternative 2: Never Create Worktree (Manual)

**Description:** Leave worktree creation entirely to user.

**Pros:**
- Simplest implementation
- User has full control

**Cons:**
- Users may forget to create worktree
- Conduct mode content on develop violates ADR-002
- No guidance for workflow

**Why not chosen:** Users benefit from prompts at natural decision points.

---

### Alternative 3: Exploration in tmp/ (Ephemeral)

**Description:** Setup mode creates files in gitignored `tmp/` directory.

**Pros:**
- Zero pollution of develop
- Truly ephemeral for quick ideas

**Cons:**
- Lost if not acted on
- Different file location confusing
- Breaks hub-and-spoke pattern

**Why not chosen:** Exploration should be tracked (just lightweight on develop).

---

## Decision Rationale

**Key Factors:**
1. **Natural Gate:** Setup → Conduct transition is meaningful commitment
2. **ADR-002 Alignment:** Serious investment should be self-contained
3. **User Experience:** Prompt at decision point, with override flags
4. **Low Friction:** Quick explorations remain quick

**Research Support:**
- Finding 7: Lazy worktree creation pattern
- Insight 12: Lazy worktree creation via conduct mode
- Feature Learnings: Self-contained branches work well

---

## Requirements Impact

**Requirements Addressed:**
- FR-WT-1: Lazy Worktree Creation ✅
- FR-WT-2: Worktree Prompt on Conduct ✅
- FR-WT-3: Skip Worktree Flag ✅
- FR-WT-4: Automatic Worktree Flag ✅
- NFR-WT-1: ADR-002 Alignment ✅
- NFR-WT-2: Non-Disruptive Prompts ✅

**Requirements Refined:**
- None; requirements validated as-is

---

## References

- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Requirements Document](../../research/explore-two-mode/requirements.md)
- [Worktree Feature Workflow Learnings](../../planning/opportunities/internal/dev-infra/learnings/worktree-feature-workflow/feature-learnings.md)
- [ADR-002: Self-Contained Feature Branches](../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md)

---

**Last Updated:** 2026-01-10
