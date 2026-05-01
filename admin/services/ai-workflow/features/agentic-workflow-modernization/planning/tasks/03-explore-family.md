# Explore Family

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Explore Family
**Status:** 🟠 In Progress
**Last Updated:** 2026-04-30

---

## 📝 Tasks

- [x] Task 8: Design parent `explore/SKILL.md` (orientation + family conventions)
  - **Purpose:** Create the progressive-disclosure index for the explore skill family
  - **Delivered:** `templates/standard-project/.claude/skills/explore/SKILL.md` (83 lines)
  - **Content:** Orientation paragraph, pipeline diagram, children table, family conventions (path detection, output sizing, commit discipline, topic naming), "when NOT to use" routing table
  - **Key decision:** `disable-model-invocation: true` — parent is reference only, not invoked directly
  - **Spike reference:** nested-skill-discovery spike validated explicit parent reference pattern
  - **Post-delivery update needed:** Output sizing table should be updated from `~60-80 lines` to `~80-120 lines` per the self-sufficient exploration reframing (see Design Change below)

---

- [x] Task 9: Convert explore-start (setup mode) with explicit parent reference (CP-1)
  - **Purpose:** Convert the setup-mode workflow from the 1,375-line `/explore` command into a standalone skill
  - **Delivered:** `templates/standard-project/.claude/skills/explore/explore-start/SKILL.md` (212 lines)
  - **Content:** Input sources table (5 sources), workflow (resolve → extract → create → commit → stop), scaffolding templates inline, behavioral contract (5 rubric-applied instructions), 6 gotchas
  - **Explicit parent reference:** Line 2 of body: "read `../SKILL.md` for family conventions"
  - **Post-delivery update needed:** Apply the self-sufficient exploration reframing:
    1. Replace "scaffolding" language with "exploration" throughout
    2. Drop `🔴 Scaffolding (needs expansion)` status → no status marker or `✅ Exploration`
    3. Remove template placeholders; themes should have ~4-6 context-rich bullets
    4. Add `**Context:**` line to research-topics.md template per topic
    5. Update "Do not expand themes" behavioral contract → "Themes should have enough context to stand alone but stay at bullet-point depth — not multi-paragraph analysis"
    6. Update "Next Steps" in templates to point to `/explore-amend`, `/research`, or implementation — not to a defunct conduct step
    7. Update output sizing from ~60-80 to ~80-120 lines for exploration.md

---

- [ ] Task 10: Convert explore-amend with explicit parent reference (CP-1)
  - **Purpose:** Create the mutation skill that appends new themes and questions to an existing exploration
  - **Steps:**
    1. Read amend-mode sections from `.cursor/commands/explore.md` (lines 80-99, 776-783, 950-1005)
    2. Create `templates/standard-project/.claude/skills/explore/explore-amend/SKILL.md`
    3. Frontmatter: dual-location description (routing only), `disable-model-invocation: true`
    4. Body line 1: explicit parent reference "read `../SKILL.md` for family conventions"
    5. Workflow section: read existing exploration → validate status → determine next theme/question number → append theme → append question → update spike table → add amendment metadata → commit
    6. Behavioral contract with five-property rubric:
       - "Append, never overwrite" (observable, bounded) — the mutation contract
       - "Auto-number correctly" (observable, bounded) — count existing `### Theme N:` headings, increment
       - "Update the spike determination table" (observable) — every new theme gets a risk row
       - "Add amendment metadata" (observable) — `**Amended:** YYYY-MM-DD - [reason]`
       - "Preserve existing content verbatim" (bounded, failure-aware) — do not edit, reformat, or reorder existing themes
    7. Gotchas section (FR-20): at least 5 failure modes with correct alternatives
    8. Stay under 500-line limit (C-2)
  - **Files:** `templates/standard-project/.claude/skills/explore/explore-amend/SKILL.md`
  - **Acceptance:**
    - Skill has explicit parent reference
    - All behavioral instructions pass five-property rubric
    - Gotchas section populated with at least 5 failure modes
    - Mutation contract is structurally verifiable: auto-numbering, spike table, metadata
    - No conduct-mode logic included (C1-2)
    - Under 500 lines
  - **Mutation contract testing (from discussion):** During conversion, verify the structural correctness claims by mentally tracing an amend on a 3-theme exploration — does the numbering produce Theme 4? Does the spike table get a new row? Does the amendment note appear in metadata? This is the "contract complexity" test identified in the skill testing discussion.
  - **Note:** explore conduct mode is deprecated per C1-2 — do NOT create explore-conduct skill

---

- [ ] Task 11: Validate family pattern works on both Cursor and Claude Code (manual test)
  - **Purpose:** Confirm the spike's findings hold with production-quality skills
  - **Steps:**
    1. In Cursor: attach `explore-start/SKILL.md` and invoke it with a test topic
    2. Verify: does the skill read `../SKILL.md` (parent) as instructed?
    3. Verify: does the output follow family conventions (path detection, sizing, commit discipline)?
    4. Repeat with `explore-amend/SKILL.md` on an existing exploration
    5. In Claude Code (if accessible): invoke explore-start and verify recursive discovery finds the parent
    6. Document results: pass/fail for each verification point
  - **Files:** No new files — this is a validation task
  - **Acceptance:**
    - Cursor: parent reference loads correctly for both children
    - Claude Code: recursive discovery works (or documented as "not tested — spike validated")
    - Family conventions are followed in generated output
    - Children can be invoked independently without parent (graceful degradation)
  - **Spike reference:** `spikes/nested-skill-discovery.md` already validated the pattern mechanically; this task validates it with real skill content

---

## 🎯 Goals

1. Validate the skill family pattern (ADR-002): parent + children with explicit reference, not automatic inheritance
2. Demonstrate multi-mode decomposition (FR-7): one skill per workflow, not one skill with mode flags
3. Confirm the spike's findings hold in production-style usage
4. Apply the self-sufficient exploration model: explorations are complete artifacts, not scaffolding waiting for expansion

---

## 📐 Design Change: Self-Sufficient Explorations

**Source:** `/discuss` session during Task 9 implementation (2026-04-30)

**Finding:** With conduct mode deprecated (C1-2), the "scaffolding" mental model no longer applies. Explorations should be **self-sufficient artifacts** that stand alone at the exploration level of abstraction.

**Key principle:** Explorations describe *what the problem space looks like* (themes, concerns, who's affected, open questions) without prescribing *what to do about it* (that's research → decision). A self-sufficient exploration supports two exit paths:

1. **Full pipeline:** exploration → research → decision → implementation (for genuine uncertainty)
2. **Short circuit:** exploration → implementation (for bug fixes, support tickets, clear-path work)

**Changes to apply (Tasks 8-9 post-delivery updates):**

| Area | Old (scaffolding) | New (self-sufficient) |
|------|-------------------|----------------------|
| Mental model | Incomplete → needs expansion | Complete at exploration level |
| Status marker | `🔴 Scaffolding (needs expansion)` | No status or `✅ Exploration` |
| Theme depth | ~2-3 thin bullets | ~4-6 context-rich bullets |
| Research topics | Question + Priority only | Question + Priority + Context line |
| Next steps | "Run conduct to expand" | "Review → research, amend, or implement" |
| Output sizing | ~60-80 lines | ~80-120 lines |
| Growth model | Expansion (conduct) | Amendment only (explore-amend) |
| Template placeholders | `<!-- PLACEHOLDER -->` | None — every section complete |

---

## ✅ Completion Criteria

- [x] `explore/SKILL.md` exists as family parent
- [x] `explore/explore-start/SKILL.md` exists with explicit parent reference
- [ ] `explore/explore-amend/SKILL.md` exists with explicit parent reference
- [ ] All three skills pass five-property rubric
- [ ] Self-sufficient exploration reframing applied to Tasks 8-9 deliverables
- [ ] Family pattern validated manually on Cursor (parent reference loads)
- [ ] No `explore-conduct` skill created (C1-2 deprecation)
- [ ] Children can be invoked independently (parent reference is opt-in, not required at runtime)

---

## 🔗 Dependencies

- Group 1 (Foundation): AGENTS.md must exist
- Group 2 (Discuss): pattern established in discuss conversion (rubric application, gotchas, dual-location) is reused here
- Critical: this group is the second go/no-go — if family pattern doesn't work cleanly, Stage 2 (research/, which has 3 children) is at risk

---

**Last Updated:** 2026-04-30
