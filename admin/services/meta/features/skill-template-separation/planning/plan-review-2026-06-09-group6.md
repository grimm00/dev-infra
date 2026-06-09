# Plan Review — Skill-Template Separation (Group 6)

**Feature:** skill-template-separation  
**Planning root:** `admin/services/meta/features/skill-template-separation/planning/`  
**Status:** ✅ Ready  
**Reviewed:** 2026-06-09  
**Scope:** Group 6 only (Tasks 23–25) — final group  

---

## 📋 Plan Structure

- [x] Implementation plan found and parseable
- [x] YAML frontmatter valid (`task_count: 25`, `groups`, `tasks_files`)
- [x] Group 6 task file exists (`tasks/06-documentation-and-supersession.md`)
- [x] Checkbox census: 22/25 complete post-PR #110
- [x] No orphan global task IDs

---

## 📝 Task Group Review

### Group 6: Documentation & Supersession (Tasks 23–25)

- **Header status:** 🔴 Scaffolding — needs expansion (expected before Step 1)
- **Task count:** 3 (within 2–8 range)
- **Descriptions:** Supersede global-command-distribution → update AGENTS.md → cross-link ADR-001
- **Dependencies section:** Group 5 prerequisite satisfied (PR #110 merged)

---

## 🔗 Dependency Validation

- [x] Groups 1–5 complete before Group 6 execution
- [x] ADR-001 implementation real (manifest, proj-cli validation, template cleanup) — not just declared
- [x] No circular dependencies
- [x] Final group closes Definition of Done (ADR acceptance + feature complete)

---

## 🔄 Consistency Check

- [x] Plan ↔ Status progress counts align (22/25 after Group 5 closeout)
- [x] Tasks 19–22 checked in implementation-plan
- [x] Stale AGENTS.md line identified ("Authoritative template copies live in `templates/standard-project/`")
- [x] Stale template-sync prose in AGENTS.md (manifest retired PR #108)
- [x] PR #109 deferred item `PR109-Overall-#2` flagged for Group 6 sweep

---

## 🔴 Blockers

*(none)*

---

## 🟡 Warnings

- **No feature hub README on develop** — only exploration hub exists; Task 25 may need a curated feature hub under `admin/services/meta/features/skill-template-separation/README.md`.
- **ADR acceptance is Group 6 deliverable** — `adr-001-separation-model.md` still 🔴 Proposed; flip to ✅ Accepted when tasks complete.

---

## 💡 Recommendations

- Supersession note on `global-command-distribution/README.md` — one line, preserve provenance (do not delete).
- AGENTS.md: replace bundled-corpus language with external corpus + `expected_skills` manifest pattern; remove template-sync-manifest references.
- four-arm-architecture hub: link ADR-001 (skill-template-separation) as the extension resolving "what ships where."

---

## ✅ Readiness Assessment

**Verdict:** ✅ Ready for Group 6 expansion and execution.

All implementation groups merged. Documentation sweep is the remaining work; docs-only — markdown/link validation sufficient.

---

**Reviewed by:** group-cycle agent  
**Next:** Expand `tasks/06-documentation-and-supersession.md`, then execute Tasks 23–25
