# Transition-Plan Two-Mode Pattern - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 🎯 What Are We Exploring?

Redesigning the `/transition-plan` command to follow a two-mode pattern:

| Mode | Behavior | Output |
|------|----------|--------|
| **Setup** (default) | Creates scaffolding | `transition-plan.md`, `phase-N.md` headers |
| **Expand** (`--expand`) | Fills in detail | TDD-ordered tasks, code examples, notes |

**This is significant because:**

1. **First fully-utilized global command** from dev-infra
2. **Proves the global command distribution model** (v4 discovery)
3. **Establishes the two-mode pattern** for other commands to follow

---

## 🤔 Why Explore This?

### Problem Statement

The current `/transition-plan` command tries to do everything at once:
- Create transition-plan.md
- Create phase-N.md documents with full TDD task ordering
- Expand all tasks with implementation details
- Add code examples and notes

**Results in:**

1. **Variable output** - AI sometimes skips phases or doesn't follow TDD ordering
2. **Inconsistent TDD** - Tasks sometimes ordered implementation-first, tests-last
3. **No human review** - Can't review scaffolding before detailed expansion
4. **Unpredictable** - Different runs produce different levels of detail

### Evidence

Work-prod project-type-field Phase 1 was created with tests as Task 4 (last), not Task 1 (first). This violated TDD principles in the `/task-phase` command.

### Opportunity

The `/research` command already uses a two-mode pattern successfully:

| Mode | `/research` |
|------|-------------|
| **Setup** (default) | Creates templates/structure |
| **Detail** (`--conduct`) | Fills in content |

We can apply the same pattern to `/transition-plan`.

---

## 💡 Initial Thoughts

### Proposed Two-Mode Architecture

**Setup Mode (default):**

```
/transition-plan --from-adr decisions/feature/adr-001.md
  → Creates transition-plan.md (basic structure)
  → Creates phase-N.md scaffolding (headers, goals, empty tasks)
  → Creates feature README hub
  → Outputs: Planning structure ready for expansion
```

**Expand Mode (`--expand`):**

```
/transition-plan [topic] --expand [--phase N] [--tdd|--no-tdd]
  → Reads existing phase-N.md scaffolding
  → Expands tasks with TDD ordering (tests before implementation)
  → Adds implementation notes, code examples
  → Adds acceptance criteria, completion checklists
  → Commits changes
```

### Proposed Flags

| Flag | Mode | Purpose |
|------|------|---------|
| `--expand` | Expand | Switch to expand mode |
| `--phase N` | Expand | Only expand specific phase |
| `--tdd` | Expand | Force TDD task ordering (default for code phases) |
| `--no-tdd` | Expand | Skip TDD ordering (for docs-only phases) |
| `--all` | Expand | Expand all phases at once |

### Example Workflow

```bash
# 1. Create scaffolding (Setup Mode)
/transition-plan --from-adr decisions/project-type-field/adr-003.md

# Output:
#   → transition-plan.md (basic structure)
#   → phase-1.md (scaffolding)
#   → phase-2.md (scaffolding)
#   → phase-3.md (scaffolding)
#   → README.md (feature hub)

# 2. Human review scaffolding
# User checks: Are phases correct? Any missing?

# 3. Expand Phase 1 with TDD (Expand Mode)
/transition-plan project-type-field --expand --phase 1 --tdd

# Output:
#   → phase-1.md expanded with TDD task ordering:
#     - Task 1: Write tests for X (RED)
#     - Task 2: Implement X (GREEN)
#     - Task 3: Write tests for Y (RED)
#     - Task 4: Implement Y (GREEN)
#     - Task 5: Documentation and cleanup

# 4. Human review Phase 1 detail
# User checks: Are tasks in TDD order? Any missing?

# 5. Continue with remaining phases
/transition-plan project-type-field --expand --phase 2 --tdd
/transition-plan project-type-field --expand --phase 3 --no-tdd  # docs-only phase
```

---

## 🎯 Global Command Context

### Why This Is the First Global Command

Per the v4 discovery in [dev-infra-identity-and-focus exploration](../dev-infra-identity-and-focus/exploration.md):

1. **Cursor supports global commands** from `~/.cursor/commands/`
2. **Project commands override global** - clean isolation
3. **Global rules NOT supported** - `~/.cursor/rules/` doesn't work

### Distribution Model

```
~/.cursor/commands/               # Global - available in ALL projects
├── transition-plan.md            # ← This command (updated)
├── task-phase.md
├── pr.md
├── fix-plan.md
└── ... (19 commands from dev-infra)

project/.cursor/commands/         # Local - project-specific overrides
└── custom-command.md             # Override or extend
```

### Benefits of Global Commands

| Aspect | Before (v1) | After (v2) |
|--------|-------------|------------|
| Command Location | Embedded in templates | Global + optional project |
| Updates | Sync per-project | Update globally once |
| Feedback Loop | Per-project learnings | Centralized |
| Template Size | Heavy (~20 command files) | Light (optional) |

---

## 🔍 Key Questions

### Architecture

- [ ] Should setup mode create minimal scaffolding or comprehensive structure?
- [ ] Should expand mode work on single phase or default to all?
- [ ] How should `--tdd` vs `--no-tdd` be determined automatically?

### Implementation

- [ ] What changes to command structure are needed?
- [ ] How to detect if phase already expanded (avoid double-expansion)?
- [ ] Should scaffolding include placeholder tasks or empty task sections?

### Global Command Concerns

- [ ] How to handle version mismatches between global and project commands?
- [ ] Should there be a "command version" header for tracking?
- [ ] How to handle global command updates gracefully?

### Testing

- [ ] How to validate setup mode creates consistent scaffolding?
- [ ] How to validate expand mode enforces TDD ordering?
- [ ] Should tests be added to dev-infra for command behavior?

---

## 📊 Benefits

| Benefit | Description |
|---------|-------------|
| **Predictable output** | Scaffolding is simple, always consistent |
| **Human review** | User can check structure before detail |
| **Enforced TDD** | `--tdd` flag ensures tests-first ordering |
| **Incremental** | Can expand one phase at a time |
| **Follows proven pattern** | Same as `/research` + `--conduct` |
| **Debugging** | If expansion is wrong, only re-expand that phase |

---

## 🚀 Next Steps

1. **Review research topics** in `research-topics.md`
2. **Conduct research** using `/research --from-explore transition-plan-two-mode`
3. **Make decision** using `/decision` if architectural changes needed
4. **Implement** - Update command documentation

---

## 📝 Notes

### Scope Considerations

This exploration focuses on the command redesign, not the global installation mechanism. Global installation is covered by the dev-infra-identity-and-focus exploration (Scenario 6).

### Existing Command Size

The current `/transition-plan` command is **1096 lines**. The two-mode pattern should:
- **Simplify** setup mode to ~200-300 lines
- **Keep** expand mode comprehensive for detail generation
- **Total** may actually increase slightly, but complexity is distributed

### Related Patterns

The `/research` command uses this pattern successfully:
- `--conduct` flag triggers detail mode
- Default creates structure only
- User reviews structure before conducting research

---

**Last Updated:** 2025-12-29


