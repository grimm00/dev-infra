# Research Family Foundation

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)  
**Group:** Research Family Foundation  
**Status:** 🟠 In Progress — Task 1 complete  
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 1: Audit research command modes and classify behavioral instructions
  - **Purpose:** Produce a conversion map (modes → child skills) and a Topic 8–style tier inventory before authoring skills.
  - **Steps:**
    1. Read `.cursor/commands/research.md` and segment by mode (setup, add-topic, conduct, consolidate).
    2. Map each mode to `research-setup`, `research-conduct`, or `research-consolidate`.
    3. List behavioral or judgment-heavy instructions; assign Tier 1 / 2 / 3 and note rubric gaps for later groups.
  - **Files:** `planning-stage2/artifacts/research-command-audit.md`
  - **Acceptance:** Audit committed; includes mode→skill table and tier table(s); references Topic 8 / Stage 1 discuss audit pattern.

- [ ] Task 2: Design parent `research/SKILL.md` (orientation + family conventions)
  - **Purpose:** Give children a single place for path detection, topic naming, commit scope, and pipeline orientation (mirror `explore/SKILL.md`).
  - **Steps:**
    1. Read `templates/standard-project/.claude/skills/explore/SKILL.md` for tone and structure.
    2. Author parent with `disable-model-invocation: true`, children table, conventions, when-NOT-to-use, related links.
    3. Do **not** embed procedural setup/conduct/consolidate steps — those belong in children.
  - **Files:** `templates/standard-project/.claude/skills/research/SKILL.md`
  - **Acceptance:** Parent exists; references explore for exploration paths; documents v1 filename split (`research-*.md` vs `topic-N-*.md`); no procedural mode steps in body.

- [ ] Task 3: Convert research-setup (scaffolding mode)
  - **Purpose:** Capture initial setup + add-topic behavior in one child skill per group plan (add-topic final placement verified in Task 6).
  - **Steps:**
    1. Extract setup Steps 1–7 and Add Topic workflow from the command audit / source command.
    2. Author child with `read ../SKILL.md` preamble; separate **Setup** and **Add topic** workflows.
    3. Add **Behavioral Contract** and **Gotchas**; apply FR-19 — every behavioral line observable, bounded, outcome-framed, delta-only, failure-aware.
  - **Files:** `templates/standard-project/.claude/skills/research/research-setup/SKILL.md`
  - **Acceptance:** Skill is self-contained for scaffolding; explicitly forbids web research / conduct work; add-topic conflicts and exploration path gotchas documented.

---

## 🎯 Goals

1. Establish the research family structure (parent + children directory layout)
2. Validate that the explore family pattern scales to a larger family (3 children vs 2)
3. Get the scaffolding skill working so research-conduct has a foundation to build on

---

## ✅ Completion Criteria

- [x] Research command audit complete with mode/instruction classification
- [ ] Parent SKILL.md authored with family conventions
- [ ] research-setup skill passes five-property rubric (behavioral contract + gotchas)
- [ ] Family directory structure in place: `research/SKILL.md`, `research/research-setup/SKILL.md`

---

## 🔗 Dependencies

- Stage 1 complete (family pattern proven on explore)
- No dependencies on other Stage 2 groups

---

**Last Updated:** 2026-05-02
