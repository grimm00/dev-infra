# Decisions Summary — Agentic Workflow Modernization

**Purpose:** All decisions at a glance
**Status:** ✅ Complete
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Key Decisions

### ADR-001: V1 Skill Selection and Ordering

**Decision:** Staged v1 with role groups as stages. Four stages, ~16 skills total.

| Stage | Role Group | Skills | Focus |
|-------|-----------|--------|-------|
| 1 | Thinker | discuss, explore-start, explore-amend, int-opp, narrative | Behavioral precision thesis |
| 2 | Researcher | research-setup, research-conduct, research-consolidate, spike, reflect | Multi-mode decomposition |
| 3 | Planner | decision, transition-plan, plan-review | Pattern application |
| 4 | Reviewer | review, commit, handoff | Mechanical completion |

Each stage is session-completable (1-2 focused sessions). Mixed command/skill state between stages is the go/no-go signal.

---

### ADR-002: Skill Architecture

**Decision:** Family directories for multi-mode commands, flat for single-mode.

- **Families:** `explore/` (2 children), `research/` (3 children) — parent SKILL.md provides progressive disclosure and shared contract
- **Flat:** All other skills (`discuss/`, `int-opp/`, `spike/`, etc.)
- **Naming:** `{command}-{mode}` for multi-mode, `{command}` for single-mode
- **Context sharing:** Explicit child-to-parent reference (CP-1), not automatic inheritance
- **Role model:** Informs design reasoning, not directory structure

---

### ADR-003: Content Redistribution

**Decision:** Aggressive rules slimming. ~1,500 lines of `.mdc` rules reduced to ~50.

| Content Type | Destination |
|---|---|
| Portable conventions | AGENTS.md + CLAUDE.md (inline) |
| Cursor-specific config | Trimmed `.mdc` (~50 lines) |
| Procedural reference | Skill bodies and `assets/` |
| Mutable project state | Removed entirely |

---

### ADR-004: Quality and Conversion Process

**Decision:** Strict five-property rubric applied during every conversion. No Tier 2/3 instructions shipped.

Seven-step conversion workflow: audit → rubric → gotchas → separate workflow/contract → dual-location description → verify self-containment → regression test.

UX north star: "in control and enriched through slowing down."

---

### ADR-005: Distribution and Portability

**Decision:** Author in `templates/standard-project/.claude/skills/` from day one. Distribution deferred to v2+.

- Cross-platform portability enforced during quality gate
- Marketplace-compatible format as structural constraint (not distribution mechanism)
- Template sync, marketplace, skills repo extraction, proj-cli integration all deferred
- Auto-detection toggled per platform at distribution time (v2+)

---

## Cross-Cutting Principle

**CP-1: Explicit Over Implicit** — The system prefers explicit, deterministic mechanisms over implicit, probabilistic ones. Applied to invocation (disable auto-detect), context sharing (explicit parent reference), enforcement (hooks over prose), and commit safety (pre-commit hooks over instructions).

---

## Requirements Coverage

All 22 FRs, 3 NFRs, 4 Constraints, and 2 Assumptions are addressed:

| Status | Count | Examples |
|--------|-------|---------|
| Directly satisfied | 15 | FR-2, FR-4, FR-5, FR-7, FR-8, FR-12, FR-13, FR-14, FR-19, FR-20, FR-21 |
| Deferred to v2+ | 4 | FR-16, FR-17, FR-9 (follows), FR-10 (follows) |
| Documented for future | 3 | FR-22 (hooks), FR-3 (passive auto-detect), FR-18 (session resume) |

---

## Next Steps

1. `/transition-plan --from-adr` — Convert these decisions into an implementation plan
2. Begin Stage 1 (Thinker role group) skill conversion
3. Design step for per-skill behavioral contract design

---

## References

- [Decision Interview](decision-interview.md)
- [V1 Scope](v1-scope.md) — 22 conclusions + CP-1
- [Requirements](../../research/agentic-workflow-modernization/requirements.md)
- [Research Summary](../../research/agentic-workflow-modernization/research-summary.md)

---

**Last Updated:** 2026-04-14
