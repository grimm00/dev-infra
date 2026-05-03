# Decision Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Decision Skill
**Status:** ✅ Expanded
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 1: Audit decision command and classify behavioral instructions
  - **Purpose:** Map `.cursor/commands/decision.md` to ADR-004 tiers before conversion so nothing vague ships in the skill.
  - **Steps:**
    1. Read `decision.md` end-to-end; note path-detection contradictions (Configuration vs Step 3 vs Reference).
    2. Classify each major section and standout instruction as Tier 1 (precise), Tier 2 (mixed), or Tier 3 (vague/problematic) per Topic 8 / ADR-004.
    3. Record interview workflow separately: current command does **not** encode interview-first prose — pull structure from `decisions/decision-interview.md` and design staging notes (Stage 3 Planner).
    4. Write `planning-stage3/artifacts/decision-command-audit.md` with summary table, tier tallies, and “skill actions” (keep / rewrite / omit).
  - **Files:** `planning-stage3/artifacts/decision-command-audit.md` (create)
  - **Acceptance:** Artifact exists; every command section ≥ summary row; explicit note on interview gap and canonical dev-infra decisions path.

- [x] Task 2: Design decision SKILL.md (interview workflow + ADR behavioral contract)
  - **Purpose:** Ship hybrid skill: human interview preflight + procedural ADR scaffolding + behavioral ADR quality bar.
  - **Steps:**
    1. Add `templates/standard-project/.claude/skills/decision/SKILL.md` with YAML frontmatter (`name`, `description`, `disable-model-invocation: true`).
    2. **Workflow:** (0) Decision interview — locate or scaffold `decision-interview.md` under the topic decisions tree; **stop** until human fills priority sections or explicitly waives in chat; (1) research/requirements reads per path table; (2) decision points with **options-not-answers** (2–3 alternatives, tradeoffs, no premature recommendation); (3) hub README; (4) one ADR per decision point using template sections; (5) decisions-summary; (6) update parent decisions README quick links when present; (7) commit guidance **bounded** to project norms (do not require merge-to-develop like the command).
    3. **Behavioral contract:** Observable outputs (filenames, sections), bounded stop conditions, outcome-framed ADR structure, delta-only path rules (fix dev-infra `admin/services/.../decisions/`), failure-aware (missing research, missing interview waiver, ambiguous topic).
    4. **Gotchas:** ≥5 bullets from audit Tier 3/mixed items and path confusion.
    5. Keep `SKILL.md` under 500 lines (ADR-004).
  - **Files:** `templates/standard-project/.claude/skills/decision/SKILL.md` (create)
  - **Acceptance:** Skill is self-contained (FR-8): core flow readable without external commands; interview + ADR contract present; rubric-aligned prose.

- [x] Task 3: Validate decision skill against a recent ADR produced under the command
  - **Purpose:** Static regression vs command-era ADR shape.
  - **Steps:**
    1. Read `admin/services/ai-workflow/features/agentic-workflow-modernization/decisions/adr-001-v1-skill-selection.md`.
    2. Checklist map: Context, Decision, Consequences (+ pos/neg), Alternatives Considered (≥2), Decision Rationale, Requirements Impact, References — skill workflow requires each in ADR output.
    3. Compare interview intent: skill step 0 must reference the same priority surfaces as `decision-interview.md` (Sections 1–3 style), not necessarily verbatim text.
    4. Record **Validation Log** below with **Verdict:** `GO` or `NO-GO` + rationale.
  - **Files:** This task file (Validation Log section)
  - **Acceptance:** Log contains checklist results and a clear GO/NO-GO.

---

## 🎯 Goals

1. Produce the first skill with a structured human-interview workflow
2. Maintain ADR quality — no regression from command-era decisions

---

## ✅ Completion Criteria

- [x] Audit artifact produced with tier classification
- [x] decision SKILL.md in templates with interview workflow + ADR contract
- [x] Five-property rubric passes, gotchas populated
- [x] Validation log with go/no-go verdict

> **Follow-up (Group 2 or cutover):** Extract inline templates (ADR template, hub README, decision-interview scaffold) into `assets/` and add `references/structure.yaml` per the convention established in Group 2. The decision skill was converted before this convention was defined.

---

## 📋 Validation Log

**Date:** 2026-05-02  
**Reference ADR:** `decisions/adr-001-v1-skill-selection.md`

| ADR section | Required by skill? | Present in ADR-001? | Notes |
|-------------|-------------------|---------------------|-------|
| Context | yes | yes | Skill §4 requires Context + research links; ADR-001 matches. |
| Decision | yes | yes | |
| Consequences | yes | yes | ADR uses Positive/Negative lists; skill expects same shape. |
| Alternatives Considered | yes | yes | Two labeled alternatives (A/B) with why-not-chosen. |
| Decision Rationale | yes | partial | No `## Decision Rationale` heading; rationale is embedded in **Decision** and **Context** — acceptable if substance is present; skill still recommends dedicated heading. |
| Requirements Impact | yes | yes | |
| References | yes | yes | |

**Interview coverage:** Skill Workflow §0 maps to `decision-interview.md` (priorities → rationale / ordering). ADR-001 text reflects interview-derived scope (e.g. C1-1, staged roles); static check only.

**Verdict:** GO

**Rationale:** ADR-001 satisfies the skill’s required ADR headings except a dedicated Decision Rationale section (substance present elsewhere). Interview-first step closes the legacy command gap. Live topic run still recommended; no NO-GO blockers for this group deliverable.

---

## 🔗 Dependencies

- Stage 2 complete (go decision logged)
- No dependency on other Stage 3 groups

---

**Last Updated:** 2026-05-02
