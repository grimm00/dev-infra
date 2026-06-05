# expected_skills Manifest in Templates

**Feature:** Skill-Template Separation (ADR-001)
**Group:** expected_skills Manifest in Templates
**Status:** ✅ Complete
**Last Updated:** 2026-06-05

---

## 📌 Operating Context

ADR-001 FR-BNDL-2: `.dev-infra.yml` declares skill expectations; templates carry **no bundled copies**. Group 4 introduces the `expected_skills` field, populates both templates, and documents the schema. Group 5 adds proj-cli warn-not-error validation; Group 6 refreshes broader AGENTS.md / stale command prose.

**Identifier convention (Task 15 decision):** **Bare skill directory names** (e.g. `explore`, not `ai-workflow/explore`). Matches global install layout (`~/.cursor/skills/<name>/` or `~/.claude/skills/<name>/`) and Task 19 design notes in Group 5.

**Skill inventory source:** 13 skills formerly bundled under `templates/standard-project/.claude/skills/` (removed PR #107): `commit`, `decision`, `discuss`, `explore`, `handoff`, `int-opp`, `narrative`, `plan-review`, `pre-commit-review`, `reflect`, `research`, `spike`, `write-plan`.

---

## 📝 Tasks

- [x] Task 15: Define `expected_skills` field schema in `.dev-infra.yml`
- [x] Task 16: Populate `expected_skills` in `templates/standard-project/.dev-infra.yml`
- [x] Task 17: Populate `expected_skills` in `templates/learning-project/.dev-infra.yml`
- [x] Task 18: Document the field in template README and `.dev-infra.yml` reference docs

### Task 15: Define `expected_skills` field schema in `.dev-infra.yml`

**Purpose:** Formalize FR-BNDL-2 so templates and proj-cli share one contract.

**Steps:**

1. Create authoritative reference: `docs/DEV-INFRA-YML.md` with:
   - File location (project root `.dev-infra.yml`)
   - Existing metadata fields (`template`, `version`, `created`) from template-metadata research
   - **`expected_skills`** field: type `list[string]`, bare identifiers, sorted alphabetically recommended
   - Validation semantics: proj-cli warns (never errors) when a listed skill is not installed (Group 5 implements)
2. Document bare-name rationale and rejected namespaced alternative in the reference doc.
3. Add `docs/DEV-INFRA-YML.md` to `docs/README.md` Quick Links.

**Files:**

- `docs/DEV-INFRA-YML.md` (new)
- `docs/README.md` (link)

**Acceptance:**

- Schema documents `expected_skills` type, format, and identifier convention
- Bare names chosen and documented with rationale
- Reference doc linked from docs hub

---

### Task 16: Populate `expected_skills` in `templates/standard-project/.dev-infra.yml`

**Purpose:** Ship the manifest in the standard-project template product.

**Steps:**

1. Create `templates/standard-project/.dev-infra.yml` with:
   ```yaml
   template: standard-project
   version: "[DEV_INFRA_VERSION]"
   created: "[CREATED_DATE]"
   expected_skills:
     # 13 entries — alphabetical, bare names (see docs/DEV-INFRA-YML.md)
   ```
2. Populate all 13 skill identifiers from Operating Context inventory.
3. Verify YAML parses: `python3 -c "import yaml; yaml.safe_load(open('templates/standard-project/.dev-infra.yml'))"`

**Files:**

- `templates/standard-project/.dev-infra.yml` (new)

**Acceptance:**

- File exists with `expected_skills` list of 13 bare identifiers
- `template:` matches `standard-project`
- YAML valid

---

### Task 17: Populate `expected_skills` in `templates/learning-project/.dev-infra.yml`

**Purpose:** Mirror standard manifest — learning template uses the same workflow commands/skills (no separate bundled skill tree existed pre-#107).

**Steps:**

1. Create `templates/learning-project/.dev-infra.yml` with `template: learning-project` and the **same** `expected_skills` list as Task 16.
2. Verify YAML parses.

**Files:**

- `templates/learning-project/.dev-infra.yml` (new)

**Acceptance:**

- File exists; `expected_skills` matches standard-project list
- `template:` matches `learning-project`

---

### Task 18: Document the field in template README and `.dev-infra.yml` reference docs

**Purpose:** Orient users and maintainers on manifest purpose and proj-cli behavior.

**Steps:**

1. Add **Project Metadata (`.dev-infra.yml`)** section to both template READMEs:
   - Purpose of the file
   - Link to dev-infra `docs/DEV-INFRA-YML.md` (relative path from generated project context: document as "see dev-infra documentation" or copy reference into project docs if needed — use hub link pattern)
   - Note that skills install globally; `expected_skills` is a manifest, not a bundle
   - Mention proj-cli will warn on missing skills (Group 5)
2. Update `docs/TEMPLATE-FILES.md` — add `.dev-infra.yml` under Configuration Files for both templates.
3. Cross-link: `docs/DEV-INFRA-YML.md` ↔ `docs/TEMPLATE-FILES.md`.

**Files:**

- `templates/standard-project/README.md`
- `templates/learning-project/README.md`
- `docs/TEMPLATE-FILES.md`
- `docs/DEV-INFRA-YML.md` (cross-links from Task 15)

**Acceptance:**

- Both template READMEs describe `.dev-infra.yml` and `expected_skills`
- `docs/TEMPLATE-FILES.md` documents the file
- Cross-links resolve within repo

---

## 🎯 Goals

1. `.dev-infra.yml` declares the skill corpus the template assumes (FR-BNDL-2).
2. Both templates have a populated, accurate `expected_skills` list.
3. The field is documented for users and future maintainers.

---

## ✅ Completion Criteria

- [x] Schema updated and documented
- [x] Both templates' `.dev-infra.yml` files contain the field with realistic entries
- [x] Reference docs updated; cross-linked from template READMEs

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 15: Schema | ✅ Complete | docs/DEV-INFRA-YML.md |
| Task 16: standard-project | ✅ Complete | 13 bare identifiers |
| Task 17: learning-project | ✅ Complete | mirrors standard list |
| Task 18: Documentation | ✅ Complete | READMEs + TEMPLATE-FILES |

---

## 🔗 Dependencies

- Group 2 (Template Cleanup) — populates the manifest only after the bundled skills are gone.
- Group 3 (Manifest Retirement) — runs after; the new manifest replaces the old sync-based approach.

---

**Last Updated:** 2026-06-05
