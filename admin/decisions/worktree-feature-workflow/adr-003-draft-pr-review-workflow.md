# ADR-003: Draft PR Review Workflow

**Status:** ✅ Accepted  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## Context

The current dev-infra workflow uses phase-based PRs with Sourcery reviews at each phase. This provides early bug detection. However, with self-contained feature branches (ADR-002), we need a way to preserve this early feedback without defeating branch isolation.

**The tension:**
- Self-contained branches = all docs on feature branch = merge at end
- But waiting until end = no early Sourcery feedback = bugs compound

**Related Research:**
- [research-phase-based-review.md](../../research/worktree-feature-workflow/research-phase-based-review.md)

**Related Requirements:**
- FR-20: Open Draft PR After First Commit
- FR-21: Draft PRs for Early Feedback
- FR-22: /pr Command Draft Support
- NFR-11: Push Frequently for Incremental Feedback
- NFR-12: Single PR Per Feature

---

## Decision

**Use draft PRs for continuous Sourcery feedback throughout feature development.**

### Workflow

```
develop → feat/feature
  └── First meaningful commit → Push → Open Draft PR
  └── Phase 1 work → Push → Sourcery reviews automatically
  └── Phase 2 work → Push → Sourcery reviews automatically
  └── ...
  └── Feature complete → Mark Ready for Review → Final review → Merge
```

### Key Properties

| Property | Value |
|----------|-------|
| PR count | Single PR per feature |
| PR timing | Open after first commit |
| PR state | Draft until feature complete |
| Feedback | On every push |
| Merge | Atomic (all code + docs) |

### Command Support

```bash
# Create initial draft PR
/pr --draft --feature my-feature

# Mark ready when complete
/pr --ready --feature my-feature
```

---

## Consequences

### Positive

- **Early feedback:** Sourcery reviews on every push
- **No merge pressure:** Draft PR = no expectation of merge
- **Single PR:** One PR number tracks entire feature
- **Atomic merge:** All content merges together
- **Branch isolation preserved:** Feature stays independent until merge

### Negative

- **Requires discipline:** Must open draft PR early
- **Platform dependency:** Requires GitHub/GitLab with draft PR support
- **PR duration:** Long-running features = long-running PRs

---

## Alternatives Considered

### Alternative 1: Phase PRs to develop

**Description:** Merge each phase to develop as before.

**Pros:**
- Familiar workflow
- Each phase is visible on develop

**Cons:**
- Defeats self-contained isolation
- Can't abandon features cleanly
- Docs on develop before feature complete

**Why not chosen:** Conflicts with ADR-002 (self-contained branches).

---

### Alternative 2: Single PR at end (no early feedback)

**Description:** Only create PR when feature is complete.

**Pros:**
- Simplest workflow
- True isolation

**Cons:**
- No Sourcery feedback until end
- Bugs compound
- Large review at end

**Why not chosen:** Early feedback is too valuable to lose.

---

### Alternative 3: Sourcery CLI locally

**Description:** Run Sourcery CLI locally instead of via PR.

**Pros:**
- No PR needed
- Immediate local feedback

**Cons:**
- Requires paid Sourcery subscription
- Not as integrated as GitHub
- Must remember to run

**Why not chosen:** Draft PR is simpler and more integrated.

---

## Decision Rationale

**Key Insight from Research:**
> The real value is per-push feedback, not per-merge.

Draft PRs provide the same feedback loop as phase-based PRs:
1. Push code → Sourcery reviews
2. Fix issues → Push again
3. Repeat until quality is good

**The difference:** Draft PRs don't merge until feature is complete, preserving isolation.

**Key Factors:**
1. **Feedback timing:** Per-push, not per-merge
2. **Branch isolation:** Preserved (no early merge)
3. **Simplicity:** Single PR, natural workflow
4. **Minimal changes:** Just add `--draft` flag to `/pr` command

---

## Implementation

1. Update `/pr` command to support `--draft` flag
2. Document draft PR workflow in commands
3. Open draft PR after first meaningful commit
4. Push frequently for incremental feedback
5. Mark ready for review when feature complete

---

## References

- [Research: Phase-Based Review](../../research/worktree-feature-workflow/research-phase-based-review.md)
- [Requirements Document](../../research/worktree-feature-workflow/requirements.md)

---

**Last Updated:** 2026-01-09
