# Documentation & Supersession

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Documentation & Supersession
**Status:** ✅ Complete
**Last Updated:** 2026-06-09

---

## 📌 Operating Context

Final group — closes ADR-001 acceptance and the 25-task implementation plan. All code paths (template cleanup, manifest, proj-cli validation) are merged (PRs #106–#110). This group is documentation-only: supersede the December 2025 `global-command-distribution` feature, refresh stale AGENTS.md prose, cross-link ADR-001 from architecture hubs, and accept ADR-001.

---

## 📝 Tasks

- [x] Task 23: Mark `global-command-distribution` feature README as superseded by ADR-001
- [x] Task 24: Update dev-infra AGENTS.md / docs to reflect template minimalism + manifest pattern
- [x] Task 25: Cross-link ADR-001 from four-arm-architecture and skill-template-separation hubs

---

## 🎯 Goals

1. Old feature documentation reflects its supersession.
2. Project conventions (AGENTS.md) reflect the new template philosophy.
3. The four-arm-architecture's distribution story is closed by ADR-001's reference.
4. ADR-001 formally accepted; feature marked complete.

---

## ✅ Completion Criteria

- [x] `global-command-distribution/README.md` annotated as superseded
- [x] dev-infra AGENTS.md updated; review confirms accuracy
- [x] Cross-references in place from four-arm-architecture and the feature hub
- [x] ADR-001 accepted; 25/25 tasks complete

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 23: Supersede global-command-distribution | ✅ Complete | Supersession callout + link |
| Task 24: Update AGENTS.md | ✅ Complete | Manifest pattern; sync retired |
| Task 25: Cross-link + ADR acceptance | ✅ Complete | Feature hub + four-arm link |

---

## 🔗 Dependencies

- Group 5 (proj-cli Validation) — merged PR #110.

---

**Last Updated:** 2026-06-09
