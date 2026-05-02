# Single-Mode Skills

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Single-Mode Skills
**Status:** ✅ Complete
**Completed:** 2026-05-01
**Last Updated:** 2026-05-01

---

## 📝 Tasks

- [x] Task 12: Convert int-opp (single-mode procedural skill)
  - **Purpose:** Convert the 1,152-line `/int-opp` command into a flat skill focused on capturing internal improvement opportunities
  - **Steps:**
    1. Read `.cursor/commands/int-opp.md` — identify the core procedural workflow (project detection, directory creation, learning capture, improvement classification)
    2. Create `templates/standard-project/.claude/skills/int-opp/SKILL.md`
    3. Frontmatter: dual-location description (routing only), `disable-model-invocation: true`
    4. Workflow section: detect project → create/locate opportunity directory → capture learning → classify improvement → commit
    5. Path detection: dev-infra (`admin/services/[service]/opportunities/`) vs template project (`docs/maintainers/opportunities/`)
    6. Behavioral contract with five-property rubric — key judgment points:
       - "Classify by type: learning, improvement, or command-adaptation" (observable, bounded)
       - "Preserve the user's framing of what was learned" (outcome-framed, delta-only)
       - "Create actionable items, not vague observations" (observable, outcome-framed)
    7. Gotchas section (FR-20): at least 5 failure modes
    8. Stay under 500-line limit (C-2)
  - **Files:** `templates/standard-project/.claude/skills/int-opp/SKILL.md`
  - **Content reduction:** The source command is 1,152 lines. Most of that is template content (README templates, hub templates, directory structure templates) and detailed project discovery logic. The skill should capture the workflow and behavioral contract; templates can be inline but lean. Target: ~120-180 lines.
  - **Acceptance:**
    - Skill exists with dual-location description
    - All behavioral instructions pass five-property rubric
    - Gotchas section populated with at least 5 failure modes
    - Under 500 lines, operationally complete without companion files
    - Path detection covers both dev-infra and template project structures

---

- [x] Task 13: Convert narrative (single-mode hybrid skill)
  - **Purpose:** Convert the 302-line `/narrative` command into a skill that creates "story of the work" documents
  - **Steps:**
    1. Read `.cursor/commands/narrative.md` — identify the procedural workflow (gather context, identify story arc, write narrative) and behavioral contract (tone, evidence-grounding, structure)
    2. Create `templates/standard-project/.claude/skills/narrative/SKILL.md`
    3. Frontmatter: dual-location description (routing only), `disable-model-invocation: true`
    4. Workflow section: gather context from artifacts → identify story arc → write narrative → optional PR/demo variants → commit
    5. Behavioral contract — this is the hybrid part (FR-6):
       - **Procedural:** gather context (read explorations, research, decisions, git history)
       - **Behavioral:** tone ("technical but accessible, as if explaining to a thoughtful colleague"), evidence-grounding ("ground in specifics — commit hashes, error messages, before/after"), story-arc identification
    6. Apply five-property rubric to behavioral instructions:
       - "Write as if explaining to a thoughtful colleague who knows the domain" (outcome-framed, bounded audience)
       - "Ground the story in specifics — commit hashes, error messages, code snippets" (observable, bounded)
       - "Not all arc sections will apply — omit sections that don't serve the story" (bounded, failure-aware)
    7. Gotchas section (FR-20): at least 5 failure modes — especially around tone (too corporate, too casual), evidence (assertions without citations), and arc (chronological dump vs actual story)
    8. Stay under 500-line limit (C-2)
  - **Files:** `templates/standard-project/.claude/skills/narrative/SKILL.md`
  - **Content reduction:** Source is 302 lines — already compact. The skill may be similar in size (~150-200 lines) since narrative has genuine behavioral complexity that can't be reduced without losing quality. The template section can be condensed.
  - **Acceptance:**
    - Skill exists with dual-location description
    - Procedural steps and behavioral contract clearly separated (FR-6 hybrid encoding)
    - All behavioral instructions pass five-property rubric
    - Gotchas section populated with at least 5 failure modes
    - Under 500 lines, operationally complete without companion files
    - Tone and evidence-grounding contracts are specific enough to produce consistent output

---

- [x] Task 14: Verify both skills pass five-property rubric and self-containment requirement (FR-8)
  - **Purpose:** Final quality gate before Group 5 (Cutover) — verify both skills meet the standard established by discuss and explore
  - **Steps:**
    1. Re-read `int-opp/SKILL.md` — check every behavioral instruction against the rubric (observable, bounded, outcome-framed, delta-only, failure-aware)
    2. Re-read `narrative/SKILL.md` — same rubric check, with special attention to the hybrid behavioral/procedural boundary
    3. Verify each skill works without companion files (FR-8) — no external references that would break if the skill were the only file available
    4. Verify each skill is under 500 lines (C-2)
    5. Spot-check: do the skills reference correct paths for their artifacts? Do "Related" sections point to valid sibling skills?
    6. Compare gotchas quality: do the gotchas name specific mistakes with specific alternatives? (Same bar as discuss skill's 8 gotchas)
  - **Files:** No new files — this is a verification task
  - **Acceptance:**
    - Both skills pass all five rubric properties on every behavioral instruction
    - Both are self-contained (FR-8)
    - Both under 500 lines
    - Gotchas are specific and actionable (not generic warnings)
    - No broken references to other skills or paths

---

## 🎯 Goals

1. Apply the patterns proven in Groups 2-3 to two more skills (one purely procedural, one hybrid)
2. Demonstrate the rubric and structure work for skills of varying behavioral complexity
3. Complete the Thinker role group (5 skills total: discuss, explore-start, explore-amend, int-opp, narrative)

---

## ✅ Completion Criteria

- [x] `int-opp/SKILL.md` exists (165 lines + 3 templates)
- [x] `narrative/SKILL.md` exists (148 lines + 2 templates)
- [x] Both pass five-property rubric (all 10 behavioral instructions verified)
- [x] Both have populated gotchas sections (int-opp: 6, narrative: 5)
- [x] Both under 500 lines and operationally complete without companion files
- [x] Templates-as-assets pattern applied (first use in Stage 1)
- [ ] Manual smoke test deferred to Group 5 (Cutover)

---

## 🔗 Dependencies

- Group 1 (Foundation): AGENTS.md exists
- Group 2 (Discuss): rubric application pattern established
- Group 3 (Explore Family): family-vs-flat decision pattern established (these are flat — no family)
- These two skills don't have inter-dependencies; can be done in either order

---

**Last Updated:** 2026-05-01
