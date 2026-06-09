# Plan Review — Skill-Template Separation (Group 4)

**Feature:** skill-template-separation  
**Planning root:** `admin/services/meta/features/skill-template-separation/planning/`  
**Status:** ✅ Ready  
**Reviewed:** 2026-06-05  
**Scope:** Group 4 only (Tasks 15–18)

---

## 📋 Plan Structure

- [x] Implementation plan found and parseable
- [x] Group 4 task file exists (`tasks/04-expected-skills-manifest.md`)
- [x] Checkbox census: Groups 1–3 complete (14/25); Group 4 pending (0/4)
- [x] Prior group PR #108 merged to `develop` (2026-06-04); post-PR docs landed in `cc5d82d`

---

## 📝 Task Group Review

### Group 4: expected_skills Manifest in Templates (Tasks 15–18)

- **Header status:** Scaffolding — expansion required in this cycle
- **Task count:** 4 (within 2–8 band)
- **Descriptions:** Schema → populate standard → populate learning → document
- **Dependencies section:** Groups 2–3 complete; `.dev-infra.yml` files do not yet exist in templates (greenfield for this group)

---

## 🔗 Dependency Validation

- [x] Group 2 prerequisite satisfied (bundled skills/commands removed from templates)
- [x] Group 3 prerequisite satisfied (template-sync-manifest retired; CI green on `develop`)
- [x] Group 5 correctly deferred — proj-cli validation requires manifest field from Group 4 first
- [x] No circular dependencies

---

## 🔄 Consistency Check

- [x] Plan ↔ Status progress counts align (14/25, Group 4 next)
- [x] Task 16 bullet list matches former bundled skill dirs from PR #107 (13 skills under `.claude/skills/`)
- [x] Learning template had commands only (no bundled skills tree) — Task 17 should mirror standard list for workflow parity
- [x] `new-project.sh` does not yet substitute `.dev-infra.yml` placeholders — acceptable; file ships as template artifact until proj-cli/generator work

---

## 🔴 Blockers

*(none)*

---

## 🟡 Warnings

- **Template README stale prose:** Both template READMEs still describe commands under `.cursor/commands/` — broader refresh deferred to Group 6; Group 4 adds `.dev-infra.yml` / `expected_skills` section only.
- **Identifier convention open in scaffold:** Task 15 must record bare-name vs namespaced choice before Group 5 implements lookup.

---

## ✅ Readiness Assessment

**Verdict:** ✅ Ready to execute Group 4 on `feat/skill-template-separation-04-expected-skills-manifest`.

**Next:** Expand task file → define schema + `docs/DEV-INFRA-YML.md` → add template `.dev-infra.yml` files → document in template READMEs and `docs/TEMPLATE-FILES.md`.
