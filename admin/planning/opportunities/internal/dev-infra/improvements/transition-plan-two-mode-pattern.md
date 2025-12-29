# Transition Plan Two-Mode Pattern

**Source:** Work-prod Phase 1 Implementation (project-type-field)  
**Target:** dev-infra `/transition-plan` command (all templates)  
**Status:** 🔴 Not Started  
**Priority:** HIGH  
**Effort:** MEDIUM (~4-6 hours)  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

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

### Phase 1: Command Redesign (~2 hours)

- [ ] Update `/transition-plan` command documentation
- [ ] Add "Setup Mode" section (default behavior)
- [ ] Add "Expand Mode" section (`--expand` flag)
- [ ] Define scaffolding templates (minimal phase structure)
- [ ] Define expansion logic (TDD task ordering rules)
- [ ] Add flag documentation (`--expand`, `--phase`, `--tdd`, `--no-tdd`)

### Phase 2: Template Updates (~2 hours)

- [ ] Create scaffolding templates for phase documents
- [ ] Create TDD expansion rules (tests before implementation)
- [ ] Create non-TDD expansion rules (for docs-only phases)
- [ ] Update phase document template with scaffolding/expanded markers

### Phase 3: Distribution (~1 hour)

- [ ] Update dev-infra command
- [ ] Sync to standard-project template
- [ ] Sync to learning-project template
- [ ] Update template-sync-manifest.txt
- [ ] Update command documentation

### Phase 4: Testing (~1 hour)

- [ ] Test setup mode creates minimal scaffolding
- [ ] Test expand mode with `--tdd` creates TDD ordering
- [ ] Test expand mode with `--no-tdd` skips TDD ordering
- [ ] Test `--phase N` only expands specific phase
- [ ] Test `--all` expands all phases

---

## 🔗 Related Documents

- [ADR-001: Commands as Guides](../../../../decisions/command-simplification/adr-001-commands-as-guides.md)
- [/research command](../../../../.cursor/commands/research.md) - Pattern to follow
- [/transition-plan command](../../../../.cursor/commands/transition-plan.md) - Command to update
- [Phase Document Template](../../../../docs/PHASE-DOCUMENT-TEMPLATE.md)

---

## 📊 Success Criteria

- [ ] Setup mode creates consistent scaffolding every time
- [ ] Expand mode enforces TDD task ordering when `--tdd` specified
- [ ] Phase documents follow TDD pattern (tests before implementation)
- [ ] Human review possible between scaffolding and expansion
- [ ] Command synced to all templates

---

## 🚀 Next Steps

1. **Create exploration** - `/explore transition-plan-two-mode-pattern`
2. **Research similar patterns** - `/research --conduct`
3. **Create ADR** - Document the decision
4. **Implement** - Update command documentation

---

**Last Updated:** 2025-12-23


