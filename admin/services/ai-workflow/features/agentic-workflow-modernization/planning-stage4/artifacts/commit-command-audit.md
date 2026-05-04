# Audit: `commit` command → commit skill conversion

**Source:** `.cursor/commands/commit.md` (~312 lines)
**Feature:** agentic-workflow-modernization / Stage 4 — Group 2 — Task 4
**Date:** 2026-05-03
**Rubric:** five-property skill contract (*Observable*, *Bounded*, *Outcome-framed*, *Delta-only*, *Failure-aware*) — aligned with Stage 4 prior audits.

---

## Executive summary

| Finding | Detail |
|---------|--------|
| Primary value | **Second half of review-then-commit** — verifies staged snapshot, confirms draft message from review artifacts or session, executes `git commit`, optionally deletes transient review folder. |
| Shape | **Procedural.** Almost entirely git/session/file operations plus human confirmation gates. |
| Discovery modes | (a) Same-session context from **pre-commit-review**; (b) explicit `review-{desc}-DATE` folder; (c) auto-detect newest `review-*` across artifact bases aligned with **`pre-commit-review/references/structure.yaml`**. |
| Downstream coupling | **Depends on artifact contract** exported by **`pre-commit-review`** — `summary.md` (`## Draft Commit Message`), optional `diff.patch`, folder dirname pattern — **not** on review skill implementation details. Legacy `/review` naming in command prose maps to **`pre-commit-review`** in skills. |

---

## Coupling to pre-commit-review (explicit)

| Coupling dimension | Commit command behavior | Skill manifestation |
|--------------------|-------------------------|---------------------|
| Same-session context | Uses draft message + paths already in conversation | SKILL: prioritize session variables; delta-only cite “see prior workflow” vs re-reading unchanged files unnecessarily |
| Cross-session artifact | Reads `summary.md` from matched `review-*` folder | SKILL: **`references/structure.yaml`** declares required upstream filenames relative to **`../pre-commit-review/references/structure.yaml`** artifact contract |
| Auto-detect | `ls -dt` pattern across bases | SKILL: procedural steps mirror **`pre-commit-review`** `review_roots.*.artifact_base_dir` enumeration order for consistency |

---

## Procedural vs behavioral classification

| Region / topic | Procedural | Behavioral | Notes |
|----------------|------------|------------|-------|
| Configuration — artifact paths | ● | | Must stay synchronized with **`pre-commit-review`** YAML |
| Usage / examples | ● | | |
| §1 Find review context (a–c) | ● | ● | Choosing among multiple folders when ambiguous prompts user |
| §2 Read `summary.md` | ● | ● | Parsing sections; respecting `--message` override |
| §3 Verify staged files | ● | ● | Warn on emptiness vs summary drift |
| §4 Confirm + commit | ● | ● | **Always confirm** commit message |
| §5 Delete review folder | ● | | `--no-delete` escape hatch |
| §6 Show result | ● | | |
| Integration prose | ● | ● | Narrates optimal same-session vs cross-session |
| Scenarios | ● | ● | |
| Tips / Important | ● | ● | Conventional-commit reminder — light behavioral |

**Approximate instruction share**

| Bucket | Share |
|--------|-------|
| Procedural | **~80%** |
| Behavioral | **~20%** |

---

## Five-property check (command as-is → skill expectation)

| Property | Pass? | Gap / remediation for skill |
|----------|-------|------------------------------|
| **Observable** | Yes | Outcomes = commit hash + retained/deleted folder state; SKILL lists exit states |
| **Bounded** | Mostly | SKILL must define stop when zero folders / unstaged mismatch after bounded retries |
| **Outcome-framed** | Yes | Commit + cleanup is clear terminal state |
| **Delta-only** | Yes | No large pasted templates unlike review; SKILL references **`pre-commit-review`** assets instead duplicating templates |
| **Failure-aware** | Partial | COMMAND warns unstaged → SKILL **Gotchas** for stale review folder + branch drift |

---

## Decomposition recommendation (Task 5)

1. SKILL at `templates/standard-project/.claude/skills/commit/SKILL.md` — workflow sections mirroring command **Process**.
2. **`references/structure.yaml`** — declares **dependency link** on **`pre-commit-review/references/structure.yaml`** (`upstream_review_contract`) plus commit-specific options (`--no-delete`, `--message`).
3. **No `assets/`** — commit produces git objects + optional cleanup only.
