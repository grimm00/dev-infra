# ADR-002: Self-Contained Feature Branches

**Status:** ✅ Accepted  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## Context

We need to decide what content lives on feature branches vs the develop branch. This affects:
- Branch isolation (can features be abandoned cleanly?)
- Review workflow (what gets reviewed together?)
- Documentation organization (where do docs live?)
- Merge strategy (atomic vs incremental?)

**Related Research:**
- [research-self-contained-feature-branches.md](../../research/worktree-feature-workflow/research-self-contained-feature-branches.md)
- [research-review-gate-pattern.md](../../research/worktree-feature-workflow/research-review-gate-pattern.md)

**Related Requirements:**
- FR-8 to FR-13: Documentation location requirements
- NFR-6: Feature Independence
- NFR-7: Atomic Feature Merges

---

## Decision

**Use full isolation: ALL feature-specific documentation lives on the feature branch.**

### Content on Feature Branch

| Category | Location | Description |
|----------|----------|-------------|
| Exploration | `admin/explorations/[feature]/` | Initial exploration docs |
| Research | `admin/research/[feature]/` | Research findings |
| Decisions | `admin/decisions/[feature]/` | Feature ADRs |
| Planning | `admin/planning/features/[feature]/` | Feature plans, phases |
| Code | Various | Implementation |
| Tests | `tests/` | Feature tests |

### Content on Develop

| Category | Location | Description |
|----------|----------|-------------|
| Global rules | `.cursor/rules/` | AI rules |
| Commands | `.cursor/commands/` | Workflow commands |
| Templates | `templates/` | Project templates |
| User docs | `docs/` | End-user documentation |
| Cross-feature | Various | Shared concepts |

### Merge Strategy

```
Feature branch (all docs + code) → Single PR → Develop
```

All feature content merges atomically in one PR.

---

## Consequences

### Positive

- **Clean abandonment:** Abandoned features leave no trace in develop
- **Complete context:** Reviewers see full picture (code + docs + decisions)
- **Atomic history:** Feature arrives complete, with full context
- **Independent features:** No cross-branch doc references
- **Prevents repeated exploration:** "No action" decisions are preserved

### Negative

- **Larger PRs:** Single PR contains all feature content
- **Doc duplication risk:** Must be careful not to reference other feature branches
- **Merge conflicts:** Possible if two features touch same global docs

---

## Alternatives Considered

### Alternative 1: Partial isolation (docs on develop)

**Description:** Only code on feature branch, docs always on develop.

**Pros:**
- Docs always visible
- Smaller feature PRs

**Cons:**
- Abandoned features leave orphan docs on develop
- Docs and code reviewed separately (loses context)
- No atomic "feature complete" state

**Why not chosen:** Orphan docs on abandoned features is messy.

---

### Alternative 2: Phase-based merges

**Description:** Merge docs and code separately at each phase.

**Pros:**
- Incremental progress visible
- Smaller merges

**Cons:**
- Defeats isolation
- Complex branch management
- Harder to abandon features

**Why not chosen:** Research showed isolation is more valuable than incremental visibility.

---

## Decision Rationale

**Key Factors:**
1. **Clean abandonment:** Must be able to drop features without cleanup
2. **Holistic review:** Reviewers need full context
3. **Atomic merge:** Complete feature lands together
4. **This exploration validated it:** We're using this pattern right now

**Research Support:**
- Topic 2 research confirmed full isolation is preferred
- Topic 3 research confirmed holistic review value
- This exploration is proof-of-concept

---

## Implementation

1. Create all feature docs on feature branch
2. Use standard paths: `admin/explorations/`, `admin/research/`, `admin/decisions/`
3. Merge everything in single PR
4. Global docs (rules, commands, templates) stay on develop

---

## References

- [Research: Self-Contained Feature Branches](../../research/worktree-feature-workflow/research-self-contained-feature-branches.md)
- [Research: Review Gate Pattern](../../research/worktree-feature-workflow/research-review-gate-pattern.md)
- [Requirements Document](../../research/worktree-feature-workflow/requirements.md)

---

**Last Updated:** 2026-01-09
