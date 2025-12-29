# ADR-001: Adopt Two-Mode Pattern for `/transition-plan` Command

**Status:** Proposed  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## Context

The current `/transition-plan` command attempts to do everything in a single pass:
1. Create transition-plan.md
2. Create phase-N.md documents with full detail
3. Generate TDD task ordering

**Problems with current approach:**

1. **Variable Output:** AI generates different amounts of detail each run
2. **Inconsistent TDD:** Task ordering varies, sometimes tests-last instead of tests-first
3. **No Human Review:** No opportunity to review high-level plan before detailed expansion
4. **Unpredictable:** Same input can produce very different outputs

**Opportunity:** The `/research` command already uses a proven two-mode pattern:
- Setup Mode (default): Creates scaffolding
- Conduct Mode (`--conduct`): Fills in details

This pattern enables human review between modes and produces consistent, predictable output.

**Related Research:**
- [Research Summary](../../research/transition-plan-two-mode/research-summary.md)
- [Pattern Analysis](../../research/transition-plan-two-mode/research-pattern-analysis.md)
- [Scaffolding Design](../../research/transition-plan-two-mode/research-scaffolding-design.md)
- [Command Structure](../../research/transition-plan-two-mode/research-command-structure.md)

**Related Requirements:**
- [Requirements Document](../../research/transition-plan-two-mode/requirements.md)

---

## Decision

**Adopt the two-mode pattern for the `/transition-plan` command**, mirroring the proven `/research` command approach.

### Mode Design

| Mode | Trigger | Purpose |
|------|---------|---------|
| **Setup Mode** | Default (no flag) | Create scaffolding documents |
| **Expand Mode** | `--expand` flag | Fill in detailed content |

### Flag Design

| Flag | Purpose | Example |
|------|---------|---------|
| `--expand` | Switch to Expand Mode | `/transition-plan topic --expand` |
| `--phase N` | Expand specific phase | `/transition-plan topic --expand --phase 1` |
| `--all` | Expand all phases | `/transition-plan topic --expand --all` |
| `--tdd` | Use TDD ordering (default in expand) | `/transition-plan topic --expand --tdd` |
| `--no-tdd` | Skip TDD ordering | `/transition-plan topic --expand --no-tdd` |

### State Tracking

Use **document-based state tracking** (no metadata files):

| State | Detection Method |
|-------|------------------|
| Setup complete | Phase files exist |
| Phase expanded | Status indicator: `✅ Expanded` |
| Phase needs expansion | Status indicator: `🔴 Scaffolding` |

### Scaffolding Design

**Target size:** ~60-80 lines (vs ~200-300 for expanded)

**Include in scaffolding:**
- Header metadata, Overview, Goals
- Task section headers (categories only)
- Completion criteria, Deliverables, Dependencies
- Status indicator: `🔴 Scaffolding (needs expansion)`

**Leave for expansion:**
- Detailed TDD task breakdowns
- Code examples, Testing commands
- Implementation notes, Risk assessment

### Command Structure

Refactor command documentation following `/research` pattern:

1. **Workflow Overview** → Two subsections (Setup Mode, Expand Mode)
2. **Step-by-Step Process** → Rename to "Setup Mode Workflow"
3. **NEW: Expand Mode Workflow** → Separate section with steps 1-7
4. **Common Scenarios** → Mode-specific scenarios
5. **Tips** → "When to Use Each Mode" section

---

## Consequences

### Positive

- **Predictable output:** Scaffolding is simpler, more consistent
- **Human review:** Review high-level plan before detailed expansion
- **Incremental progress:** Expand one phase at a time
- **TDD consistency:** Dedicated expand mode ensures consistent task ordering
- **Proven pattern:** Mirrors successful `/research` command design
- **Global command ready:** Works in `~/.cursor/commands/` context

### Negative

- **Two-step workflow:** Users must run command twice for full output
- **Learning curve:** Users need to understand two modes
- **Refactoring effort:** ~4-6 hours to restructure command documentation
- **Net line increase:** ~+160 lines in command file

### Neutral

- **Backwards compatibility:** Default (setup) mode produces less output than before
  - Mitigation: Document migration path, `--all` flag for batch expansion

---

## Alternatives Considered

### Alternative 1: Status Quo (No Change)

**Description:** Keep current single-pass approach.

**Pros:**
- No development effort
- No user learning curve

**Cons:**
- Variable output persists
- Inconsistent TDD ordering persists
- No human review opportunity

**Why not chosen:** Core problems remain unsolved.

---

### Alternative 2: Configuration-Based Consistency

**Description:** Add configuration options to control output verbosity and TDD ordering.

**Pros:**
- Single-pass workflow preserved
- User customization

**Cons:**
- Doesn't address human review need
- Configuration complexity
- Still variable based on AI interpretation

**Why not chosen:** Doesn't address the root cause (wanting review before detail).

---

### Alternative 3: Separate Commands

**Description:** Create two separate commands: `/transition-scaffold` and `/transition-expand`.

**Pros:**
- Clear separation
- No flag complexity

**Cons:**
- Command proliferation
- Inconsistent with `/research` pattern
- More commands to learn

**Why not chosen:** Flag-based switching is simpler and proven.

---

## Decision Rationale

The two-mode pattern was chosen because:

1. **Proven pattern:** `/research` command already uses this successfully
2. **Human review:** The core need is reviewing scaffolding before expansion
3. **Consistency:** Simpler scaffolding = more predictable output
4. **Incremental:** Phase-by-phase expansion matches real workflows
5. **Global command:** Pattern works in `~/.cursor/commands/` context

**Key research support:**

| Finding | Support |
|---------|---------|
| Flag-based mode switching | Mirrors `/research --conduct` pattern |
| Document-based state tracking | No metadata files needed |
| Scaffolding ~60-80 lines | Clear separation from expanded content |
| `/research` structure as template | Proven documentation organization |

---

## Requirements Impact

**High-Priority Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-1: Setup Mode Creates Scaffolding | Default mode behavior |
| FR-2: Expand Mode Fills Details | `--expand` flag triggers |
| FR-3: TDD Task Ordering | Default in expand mode |
| FR-5: Mode Switching via `--expand` | Primary mode switch flag |
| FR-8: Scaffolding Template | ~60-80 lines target |
| FR-11: Separate Setup Workflow | Command restructure |
| FR-12: Expand Mode Workflow | New command section |
| FR-13: Mode-Specific Overview | Workflow Overview update |
| NFR-1: Consistent Output | Simpler scaffolding |
| NFR-4: Document-Based State | Status indicators |
| NFR-6: Scaffolding Consistency | Template-based output |
| NFR-8: Proven Pattern | Mirrors `/research` |

**See:** [requirements.md](../../research/transition-plan-two-mode/requirements.md) for complete list

---

## Implementation Notes

### Phase 1: Command Structure (~2 hours)

1. Add Workflow Overview subsections (Setup Mode, Expand Mode)
2. Rename "Step-by-Step Process" to "Setup Mode Workflow"
3. Simplify setup steps to scaffolding only

### Phase 2: Expand Mode Workflow (~2 hours)

1. Create "Expand Mode Workflow" section
2. Add steps 1-7 for expansion process
3. Include TDD logic in task expansion step

### Phase 3: Supporting Content (~1-2 hours)

1. Add mode-specific scenarios
2. Add "When to Use Each Mode" tips
3. Update Usage section with expand examples
4. Update Common Issues for two-mode workflow

### Estimated Total: 4-6 hours

---

## References

- [Research Hub](../../research/transition-plan-two-mode/README.md)
- [Research Summary](../../research/transition-plan-two-mode/research-summary.md)
- [Requirements Document](../../research/transition-plan-two-mode/requirements.md)
- [Exploration](../../explorations/transition-plan-two-mode/exploration.md)
- [Opportunity Document](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)
- [/research Command](../../.cursor/commands/research.md) - Pattern source

---

**Last Updated:** 2025-12-29

