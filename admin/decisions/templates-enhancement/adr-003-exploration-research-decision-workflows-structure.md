# ADR-003: Exploration/Research/Decision Workflows Structure

**Status:** Proposed  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## Context

New commands (`/explore`, `/research`, `/decision`) create exploration/research/decision workflows. These workflows need directory structure in templates. Commands create topic-specific directories automatically, but templates need hub directories with README.md files.

**Related Research:**
- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [Exploration/Research/Decision Workflows Research](../../research/templates-enhancement/research-exploration-research-decision-workflows.md)

**Related Requirements:**
- [Requirements Document](../../research/templates-enhancement/requirements.md) - FR-3: Exploration/Research/Decision Directories

---

## Decision

**Decision:** Include exploration/research/decision directory structure in templates. Create hub directories with README.md files:
- `docs/maintainers/planning/explorations/` with README.md hub
- `docs/maintainers/research/` with README.md hub
- `docs/maintainers/decisions/` with README.md hub

Commands create topic-specific directories automatically (e.g., `explorations/[topic]/`, `research/[topic]/`, `decisions/[topic]/`). Templates provide hub structure, commands populate it.

**Structure to Include:**
```
docs/maintainers/
├── planning/
│   └── explorations/
│       └── README.md          # Explorations hub
├── research/
│   └── README.md              # Research hub
└── decisions/
    └── README.md              # Decisions hub
```

---

## Consequences

### Positive

- Projects have exploration/research/decision workflows ready
- Supports `/explore`, `/research`, `/decision` commands
- Consistent structure across projects
- Better organization of exploration/research/decision work
- Enables exploration → research → decision → planning workflow

### Negative

- Additional directory structure in templates
- Need to document workflow
- More directories to maintain

---

## Alternatives Considered

### Alternative 1: Don't Include Hub Directories

**Description:** Don't include hub directories. Commands create directories as needed.

**Pros:**
- Simpler templates
- Less structure to maintain
- Commands handle directory creation

**Cons:**
- No central hub for exploration/research/decision work
- Harder to discover existing work
- Less organized structure
- Doesn't match dev-infra pattern

**Why not chosen:** Hub directories provide better organization and discovery. Matching dev-infra pattern provides consistency. Commands create topic-specific directories, but hubs are useful for navigation.

---

### Alternative 2: Include Example Topic Directories

**Description:** Include example topic directories (e.g., `explorations/example-topic/`) in templates.

**Pros:**
- Shows structure to users
- Provides examples
- Clearer template structure

**Cons:**
- More template complexity
- Example may not be relevant
- Commands create directories automatically anyway
- Users may not understand examples are optional

**Why not chosen:** Commands create topic-specific directories automatically. Hub README.md files provide better guidance than example directories. Simpler templates are better.

---

## Decision Rationale

**Key Factors:**
- Commands need hub directories to work properly
- Hub directories provide better organization
- Matching dev-infra pattern provides consistency
- Supports exploration → research → decision → planning workflow
- Commands create topic-specific directories automatically

**Research Support:**
- Research finding: "Templates need `docs/maintainers/planning/explorations/` directory"
- Research finding: "Templates need `docs/maintainers/research/` directory"
- Research finding: "Templates need `docs/maintainers/decisions/` directory"
- Research finding: "Each directory needs hub README.md"

---

## Requirements Impact

**Requirements Affected:**
- FR-3: Exploration/Research/Decision Directories - ✅ Satisfied

**Requirements Refined:**
- Must include hub README.md files
- Must document exploration/research/decision workflow
- Commands create topic-specific directories automatically

---

## References

- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [Exploration/Research/Decision Workflows Research](../../research/templates-enhancement/research-exploration-research-decision-workflows.md)
- [Requirements Document](../../research/templates-enhancement/requirements.md)

---

**Last Updated:** 2025-12-07

