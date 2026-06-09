# Source Install & Multi-Machine (Tier 2)

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Source Install & Multi-Machine (Tier 2)
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 16: One-command `git clone` + `./install.sh` flow
  - Clone **both** repos — core (public) + personal (private) — and run the installer (FR-INST-5, Tier 2). Handle private-repo auth (SSH/token) in the flow.

- [ ] Task 17: Fresh-machine validation
  - End-to-end test of the two-repo multi-machine scenario (the Linux-box case), including the private clone — ideally on a clean environment or container.

- [ ] Task 18: Replace the proj-cli install-guidance placeholder
  - skill-template-separation's Group 5 shipped placeholder install-guidance text "until ADR-002 lands"; point it at the real corpus repos + installer instructions.

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
