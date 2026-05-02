# Standalone Skills (Spike + Reflect)

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)
**Group:** Standalone Skills (Spike + Reflect)
**Status:** ✅ Expanded
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 8: Audit spike command for behavioral instructions
  - **Purpose:** Classify spike’s judgment-heavy guidance with the same Tier 1–3 frame as Stage 2 research audit; isolate the **time-boxed behavioral contract** (criteria-before-build, throwaway scope, stop-at-timer, evidence-backed learnings) for Task 9.
  - **Steps:**
    1. Read `.cursor/commands/spike.md` end-to-end; note procedural steps vs tone/judgment sections (Key principles, Guidance for the spike, Tips).
    2. For each behavioral cluster, assign Tier 1–3 using [Topic 8 rubric](../artifacts/research-command-audit.md) (observable, bounded, outcome-framed, delta-only, failure-aware).
    3. Write `planning-stage2/artifacts/spike-command-audit.md` (tier table + core contract summary + conversion notes for SKILL.md).
  - **Files:** `planning-stage2/artifacts/spike-command-audit.md`
  - **Acceptance:** Audit cites command sections; time-box contract called out; tiers documented; file linkable from this group file.

- [ ] Task 9: Convert spike to SKILL.md
  - **Purpose:** Replace `/spike` with a standalone skill: procedural flow (questions → success criteria → minimal build → `spike-learnings.md` → commit) plus **time-boxed behavioral contract** and **gotchas**, mirroring int-opp/narrative one-shot skills (flat directory, templates co-located).
  - **Steps:**
    1. Read Task 8 audit and Stage 1 patterns in `int-opp/SKILL.md` / `narrative/SKILL.md`.
    2. Author `templates/standard-project/.claude/skills/spike/SKILL.md` with YAML frontmatter, path detection, options table, workflow, **Behavioral Contract**, **Gotchas**.
    3. Add co-located template `templates/spike-learnings.md`; SKILL instructs copy-then-fill like narrative.
    4. Map every **Behavioral Contract** bullet to the five-property rubric (same wording convention as research children).
  - **Files:** `templates/standard-project/.claude/skills/spike/SKILL.md`, `templates/standard-project/.claude/skills/spike/templates/spike-learnings.md`
  - **Acceptance:** Skill is self-contained (no parent read); dry-run/document-learnings/time-box/force behaviors preserved; rubric passes; gotchas populated from audit + command tips.

- [ ] Task 10: Audit reflect command for behavioral instructions
  - **Purpose:** Classify reflect’s hybrid surface (long procedural report + synthesis judgment); isolate **personal-growth / suggestion-quality contract** for Task 11.
  - **Steps:**
    1. Read `.cursor/commands/reflect.md`; separate path/config, procedural steps (Steps 1–6, 8), vs tone/synthesis guidance (Tips, suggestion quality).
    2. Tier behavioral lines per research audit frame; flag dev-infra-specific reflection path rules vs template paths.
    3. Write `planning-stage2/artifacts/reflect-command-audit.md`.
  - **Files:** `planning-stage2/artifacts/reflect-command-audit.md`
  - **Acceptance:** Audit covers scopes/flags; hybrid pattern explicit; template vs dev-infra paths documented.

- [ ] Task 11: Convert reflect to SKILL.md
  - **Purpose:** Standalone hybrid skill: procedural flow (gather → patterns → opportunities/issues → structured suggestions → reflection file → hub optional → docs-branch commit) plus **behavioral contract** for honest, evidence-backed reflection; mirror narrative hybrid section.
  - **Steps:**
    1. Read Task 10 audit and `narrative/SKILL.md` hybrid + template pattern.
    2. Author `templates/standard-project/.claude/skills/reflect/SKILL.md` with path detection (feature, project-wide, dev-infra centralized), flags table, workflow, reflection filename conventions, **Behavioral Contract**, **Gotchas**.
    3. Add `templates/reflection-report.md` as scaffold; SKILL references it for Step 6 output.
    4. Behavioral bullets satisfy five-property rubric; gotchas from audit + command failure modes.
  - **Files:** `templates/standard-project/.claude/skills/reflect/SKILL.md`, `templates/standard-project/.claude/skills/reflect/templates/reflection-report.md`
  - **Acceptance:** dev-infra `admin/planning/notes/reflections/` rule preserved; `--include-learnings all` behavior summarized; rubric + gotchas complete.

---

## 🎯 Goals

1. Complete the two standalone conversions using proven Stage 1 patterns
2. These should be straightforward — the patterns are established

---

## ✅ Completion Criteria

- [ ] spike skill passes five-property rubric
- [ ] reflect skill passes five-property rubric
- [ ] Both include populated gotchas sections
- [ ] Both authored in `templates/standard-project/.claude/skills/`

---

## 🔗 Dependencies

- No dependency on Groups 1-2 (spike and reflect are independent of research family)
- Could theoretically run in parallel with Group 2, but sequential is fine

---

## 🔗 Artifacts

- Task 8: [spike-command-audit.md](../artifacts/spike-command-audit.md)
- Task 10: [reflect-command-audit.md](../artifacts/reflect-command-audit.md)

---

**Last Updated:** 2026-05-02
