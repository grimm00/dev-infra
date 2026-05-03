# Review Skill

**Feature:** Agentic Workflow Modernization — Stage 4
**Group:** Review Skill
**Status:** ✅ Expanded
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [x] **Task 1: Audit review command and classify behavioral instructions**

  **Purpose:** Decompose `.cursor/commands/review.md` so the SKILL conversion separates deterministic staging from judgment-heavy review guidance and records rubric readiness.

  **Steps:**
  1. Read `templates/standard-project/.cursor/commands/review.md` end-to-end.
  2. Build a classification table: **procedural** (git operations, paths, artifact layout) vs **behavioral** (what to scrutinize in diffs, tone of summary, STOP / no-commit rule).
  3. Map each major section (Configuration, Usage, Process 1–5, Integration, Scenarios, Tips) to Stage 4 five-property obligations (*Observable*, *Bounded*, *Outcome-framed*, *Delta-only*, *Failure-aware*).
  4. Flag content that belongs in **`assets/`** (summary template already extracted in Task 2) vs inline SKILL prose.
  5. Write `planning-stage4/artifacts/review-command-audit.md` using the Stage 3 audit pattern (exec summary tables + five-property gap column).

  **Files:** `templates/standard-project/.cursor/commands/review.md` (source only); **output:** `planning-stage4/artifacts/review-command-audit.md`

  **Acceptance:** Audit artifact exists; procedural vs behavioral split is explicit; five-property gaps have remediation notes for Task 2–3.

- [ ] **Task 2: Convert review to SKILL.md (hybrid: procedural staging + behavioral diff analysis)**

  **Purpose:** Deliver a first-class **review** skill that preserves the review-then-commit pause and path detection while moving long template bodies out of the SKILL into `assets/` and declaring outputs in `references/structure.yaml`.

  **Steps:**
  1. Create `templates/standard-project/.claude/skills/review/SKILL.md` with frontmatter (`name`, `description`, `disable-model-invocation`) aligned to sibling skills.
  2. Encode **Configuration** (three path layouts + auto-detection + `.gitignore` warning) and **Process** steps 1–5 from the command, using imperative checklists.
  3. Move the **summary.md** scaffold into `assets/summary-template.md`; SKILL references the file path instead of pasting the full template (delta-only).
  4. Add **Behavioral Contract** subsections: presentation bundle (summary, draft message, stats, folder path); **explicit STOP — do not commit**; integration with `/commit`.
  5. Author `references/structure.yaml`: schema_version, `skill: review`, path detection roots, artifact folder pattern, required files (`summary.md`, `diff.patch`) with roles.
  6. Add **Gotchas** mirroring command “Tips / Important” (unintended files, `--scope`, secret exclusion).

  **Files:**  
  - `templates/standard-project/.claude/skills/review/SKILL.md`  
  - `templates/standard-project/.claude/skills/review/assets/summary-template.md`  
  - `templates/standard-project/.claude/skills/review/references/structure.yaml`

  **Acceptance:** Files exist on disk; STOP / never auto-commit appears verbatim in SKILL; path rules match audit; YAML declares outputs usable by downstream **commit** skill.

- [ ] **Task 3: Validate review skill against review artifact patterns**

  **Purpose:** Close the loop between audit expectations and delivered SKILL/`structure.yaml` so Group 2 (commit coupling) starts from an accurate contract.

  **Steps:**
  1. Re-run five-property checklist against `SKILL.md` + `structure.yaml` (not the archived command): each property **Pass / Gap** with cites to headings or YAML keys.
  2. Verify `references/structure.yaml` file list matches SKILL workflow (artifact names, relative roles, detection paths).
  3. Confirm STOP / no-commit language is duplicated in **Behavioral Contract** (and reiterated in Gotchas if needed).
  4. Append a **Validation (Task 3)** subsection to `planning-stage4/artifacts/review-command-audit.md` linking rubric rows to SKILL sections.

  **Files:** `planning-stage4/artifacts/review-command-audit.md` (append); optional edits to `SKILL.md` / `structure.yaml` if validation finds drift.

  **Acceptance:** Validation subsection present; mismatches resolved or escalated explicitly; Tasks 1–3 checkboxes marked complete.

---

## 🎯 Goals

1. Produce a hybrid skill that preserves the review-then-commit pause as an explicit behavioral contract
2. Extract the summary.md template into `assets/` per Stage 3 convention
3. Declare review's output shape in `structure.yaml` so commit can reference it

---

## ✅ Completion Criteria

- [x] Audit artifact produced
- [ ] review SKILL.md passes five-property rubric
- [ ] `assets/` and `references/structure.yaml` present and accurate
- [ ] "Never auto-commit" behavioral contract preserved

---

## 🔗 Dependencies

- None (Group 1 — first group in Stage 4)
- Inherits conventions from Stage 3: `assets/` + `references/structure.yaml`, five-property rubric, archival path

---

**Last Updated:** 2026-05-03
