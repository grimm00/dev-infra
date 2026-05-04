# Integration validation — Group 2 (commit + handoff)

**Feature:** Agentic Workflow Modernization — Stage 4
**Tasks covered:** Task 8
**Date:** 2026-05-03

---

## Review ↔ Commit declared coupling

| Check | Result |
|-------|--------|
| `commit/references/structure.yaml` includes `upstream_review_contract.skill_id = pre-commit-review` | ✅ |
| Relative pointer `../pre-commit-review/references/structure.yaml` resolves within `templates/standard-project/.claude/skills/` | ✅ |
| `consumes_review_artifacts.required_files` lists `summary.md` consistent with **`pre-commit-review/references/structure.yaml`** `required_artifacts` | ✅ |
| `artifact_bases_must_match_upstream: true` encodes positional parity with reviewer roots | ✅ |
| SKILL prose references behavioral STOP boundary remains in **pre-commit-review** — commit does **not** restage | ✅ verified by absence of staging instructions |

Residual coordination rule: renaming keys in reviewer YAML mandates paired commit SKILL + YAML update (documented mutual Gotcha).

---

## Handoff standalone rubric (five-property sanity)

| Property | Evidence |
|----------|----------|
| Observable | Output path + deterministic template population |
| Bounded | Explicit detection order + bounded glob search resume |
| Outcome-framed | Written `handoff-*.md` artifact |
| Delta-only | Template extracted to **`assets/handoff-template.md`** |
| Failure-aware | Resume mode enumerates ambiguity + STOP guidance |

---

## FR-8 self-containment (Stage 4 trio)

| Skill | Self-contained? | Notes |
|-------|------------------|-------|
| pre-commit-review | Yes | assets + YAML (Group 1) |
| commit | Yes + pointer | Cross-skill dependency is **declarative file reference**, not command stub |
| handoff | Yes | No command archive dependency |

---

## Cross-skill ordering sanity

Expected human/agent pipeline: `pre-commit-review → (pause) → commit → (optional) handoff`

Handoff may run without review/commit (independent) — matches planning dependency notes.

---

**Verdict:** ✅ Integration checks satisfied for Tasks 4–8 scope.
