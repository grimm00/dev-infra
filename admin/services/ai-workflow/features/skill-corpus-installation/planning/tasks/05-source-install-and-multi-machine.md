# Source Install & Multi-Machine (Tier 2)

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Source Install & Multi-Machine (Tier 2)
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 14: One-command `git clone` + `./install.sh` flow
  - The repo is self-contained: clone, run installer, working corpus (FR-INST-5, Tier 2).

- [ ] Task 15: Fresh-machine validation
  - End-to-end test of the multi-machine scenario (the Linux-box case that motivated this) — ideally on a clean environment or container.

- [ ] Task 16: Replace the proj-cli install-guidance placeholder
  - ADR-001 Task 21 shipped placeholder text "until ADR-002 lands"; point it at the real corpus repo + installer instructions.

---

## 🎯 Goals

1. A second machine goes from clone → one command → working corpus.
2. The ADR-001 placeholder install path is retired in favor of real guidance.

---

## ✅ Completion Criteria

- [ ] `clone → install` produces a working setup from scratch
- [ ] Fresh-machine scenario validated
- [ ] proj-cli install-guidance updated (placeholder removed)

---

## 🔗 Dependencies

- Group 4 (installer script) — Tier 2 wraps `install.sh`.
- Cross-repo: the proj-cli text update lives in the proj-cli repo (as in ADR-001 Group 5).

---

**Last Updated:** 2026-06-09
