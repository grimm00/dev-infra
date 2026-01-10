# Transition Plan Two-Mode Pattern

**Source:** Work-prod Phase 1 Implementation (project-type-field)  
**Target:** dev-infra `/transition-plan` command (all templates)  
**Status:** ✅ Complete  
**Priority:** HIGH  
**Effort:** MEDIUM (~4-6 hours estimated, ~3 hours actual)  
**Created:** 2025-12-23  
**Completed:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Problem Statement

The `/transition-plan` command currently tries to do everything at once:
- Create transition-plan.md
- Create phase-N.md documents with full TDD task ordering
- Expand all tasks with implementation details
- Add code examples and notes

**Results in:**
1. **Variable output** - AI sometimes skips phases or doesn't follow TDD ordering
2. **Inconsistent TDD** - Tasks sometimes ordered implementation-first, tests-last
3. **No human review** - Can't review scaffolding before detailed expansion
4. **Unpredictable** - Different runs produce different levels of detail

**Evidence:** Work-prod project-type-field Phase 1 was created with tests as Task 4 (last), not Task 1 (first). This violated TDD principles in the `/task-phase` command.

---

## 🎯 Proposed Solution

**Follow the `/research` pattern:**

| Mode | `/research` | `/transition-plan` (proposed) |
|------|-------------|-------------------------------|
| **Setup** (default) | Creates templates/structure | Creates scaffolding |
| **Detail** (`--conduct`/`--expand`) | Fills in content | Expands with TDD ordering |

### Two-Mode Pattern

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

---

## 📊 Proposed Flags

| Flag | Mode | Purpose |
|------|------|---------|
| `--expand` | Expand | Switch to expand mode |
| `--phase N` | Expand | Only expand specific phase |
| `--tdd` | Expand | Force TDD task ordering (default for code phases) |
| `--no-tdd` | Expand | Skip TDD ordering (for docs-only phases) |
| `--all` | Expand | Expand all phases at once |

---

## 📋 Example Workflow

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

## 🎯 Benefits

| Benefit | Description |
|---------|-------------|
| **Predictable output** | Scaffolding is simple, always consistent |
| **Human review** | User can check structure before detail |
| **Enforced TDD** | `--tdd` flag ensures tests-first ordering |
| **Incremental** | Can expand one phase at a time |
| **Follows proven pattern** | Same as `/research` + `--conduct` |
| **Debugging** | If expansion is wrong, only re-expand that phase |

---

## 📋 Implementation Tasks

### Phase 1: Workflow Overview ✅ (PR #55)

- [x] Update `/transition-plan` command documentation
- [x] Add "Two Modes:" header with Setup and Expand subsections
- [x] Add status indicators (`🔴 Scaffolding`, `✅ Expanded`)
- [x] Add flag documentation (`--expand`, `--phase N`, `--all`)

### Phase 2: Setup Mode Workflow ✅ (PR #55)

- [x] Rename "Step-by-Step Process" to "Setup Mode Workflow"
- [x] Create scaffolding templates (~60-80 lines)
- [x] Update Summary Report for scaffolding output
- [x] Defer TDD content to Expand Mode

### Phase 3: Expand Mode Workflow ✅ (PR #56)

- [x] Create Expand Mode Workflow section header
- [x] Implement 7 steps: Identify → Read → Determine TDD → Expand → Update Phase → Update Hub → Commit
- [x] Add TDD task templates and code examples
- [x] Add Flag Handling section (`--phase N`, `--all`)
- [x] Add Summary Report template

### Phase 4: Supporting Content ✅ (PR #56)

- [x] Update Usage section with mode-specific examples
- [x] Add 4 Common Scenarios
- [x] Add "When to Use Each Mode" guidance
- [x] Add 4 new Common Issues for two-mode troubleshooting

---

## 🔗 Related Documents

- [ADR-001: Commands as Guides](../../../../decisions/command-simplification/adr-001-commands-as-guides.md)
- [/research command](../../../../.cursor/commands/research.md) - Pattern to follow
- [/transition-plan command](../../../../.cursor/commands/transition-plan.md) - Command to update
- [Phase Document Template](../../../../docs/PHASE-DOCUMENT-TEMPLATE.md)

---

## 📊 Success Criteria

- [x] Setup mode creates consistent scaffolding every time
- [x] Expand mode enforces TDD task ordering for code phases
- [x] Non-TDD ordering available for docs-only phases
- [x] Human review possible between scaffolding and expansion
- [x] Command documentation complete with examples

---

## ✅ Completion Summary

**Completed:** 2025-12-29  
**PRs:** #55 (Phases 1-2), #56 (Phases 3-4)  
**Time:** ~3 hours (vs 4-6 hour estimate)  
**Deferred Issues:** 6 (all MEDIUM/LOW)

**See:**
- [Feature Hub](../../../features/transition-plan-two-mode/README.md)
- [Feature Learnings](../learnings/transition-plan-two-mode/feature-learnings.md)
- [/transition-plan Command](../../../../.cursor/commands/transition-plan.md)

---

**Last Updated:** 2025-12-29


