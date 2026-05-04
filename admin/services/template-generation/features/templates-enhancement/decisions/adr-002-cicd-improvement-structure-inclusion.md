# ADR-002: CI/CD Improvement Structure Inclusion

**Status:** Proposed  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## Context

Templates currently include feature planning structure (`docs/maintainers/planning/features/`) but not CI/CD improvement structure. CI/CD improvements have different structure than features (no `status-and-next-steps.md`, use `improvement-plan.md` instead of `feature-plan.md`). Projects need CI/CD improvement structure to plan CI/CD improvements properly.

**Related Research:**
- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [CI/CD Improvement Structure Research](../../research/templates-enhancement/research-cicd-improvement-structure-in-templates.md)

**Related Requirements:**
- [Requirements Document](../../research/templates-enhancement/requirements.md) - FR-2: CI/CD Improvement Structure

---

## Decision

**Decision:** Include CI/CD improvement structure in templates. Create `docs/maintainers/planning/ci/` directory with README.md hub and improvement-plan.md template. Structure should match dev-infra pattern: `docs/maintainers/planning/ci/[improvement-name]/` with README.md, improvement-plan.md, and phase-N.md files.

**Structure to Include:**
```
docs/maintainers/planning/ci/
├── README.md              # CI/CD planning hub
└── [improvement-name]/    # Individual improvements (created by commands)
    ├── README.md
    ├── improvement-plan.md
    └── phase-N.md
```

**Key Differences from Features:**
- Uses `improvement-plan.md` instead of `feature-plan.md`
- No `status-and-next-steps.md` file (status tracked in README.md)
- Similar phase structure to features

---

## Consequences

### Positive

- Projects can plan CI/CD improvements from the start
- Consistent CI/CD improvement structure across projects
- Clear separation between features and CI/CD improvements
- Supports `/task-improvement` command workflow
- Better organization of CI/CD planning

### Negative

- Templates become slightly more complex
- Need to document CI/CD vs feature structure differences
- Additional directory structure to maintain

---

## Alternatives Considered

### Alternative 1: Use Same Structure as Features

**Description:** Use feature structure (`feature-plan.md`, `status-and-next-steps.md`) for CI/CD improvements.

**Pros:**
- Simpler template structure
- Single structure to maintain
- Less documentation needed

**Cons:**
- Doesn't match dev-infra patterns
- CI/CD improvements have different needs than features
- Status tracking approach differs
- Doesn't support `/task-improvement` command properly

**Why not chosen:** CI/CD improvements have different structure needs (no status-and-next-steps.md, different planning approach). Matching dev-infra patterns provides consistency and supports existing commands.

---

### Alternative 2: Don't Include CI/CD Structure

**Description:** Don't include CI/CD improvement structure in templates. Projects can create it manually if needed.

**Pros:**
- Simpler templates
- Less to maintain
- Projects only add what they need

**Cons:**
- Projects miss out on CI/CD improvement structure
- Inconsistent structure across projects
- Manual setup required
- Doesn't support `/task-improvement` command

**Why not chosen:** CI/CD improvements are common and benefit from standardized structure. Including structure in templates provides better developer experience and supports workflow automation.

---

## Decision Rationale

**Key Factors:**
- CI/CD improvements are common and need structure
- Structure differs from features (different needs)
- Matching dev-infra patterns provides consistency
- Supports `/task-improvement` command workflow
- Better developer experience with structure ready

**Research Support:**
- Research finding: "CI/CD improvements need `docs/maintainers/planning/ci/` directory in templates"
- Research finding: "CI/CD structure differs from features - no `status-and-next-steps.md`"
- Research finding: "CI/CD improvements use `improvement-plan.md` instead of `feature-plan.md`"

---

## Requirements Impact

**Requirements Affected:**
- FR-2: CI/CD Improvement Structure - ✅ Satisfied

**Requirements Refined:**
- Structure must match dev-infra pattern
- Must include README.md hub
- Must include improvement-plan.md template
- Must document CI/CD vs feature structure differences

---

## References

- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [CI/CD Improvement Structure Research](../../research/templates-enhancement/research-cicd-improvement-structure-in-templates.md)
- [Requirements Document](../../research/templates-enhancement/requirements.md)

---

**Last Updated:** 2025-12-07

