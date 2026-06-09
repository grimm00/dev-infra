# Plan Review — Skill Corpus Installation

**Feature:** Skill Corpus Installation (ADR-002)
**Planning root:** `admin/services/ai-workflow/features/skill-corpus-installation/planning/`
**Status:** 🟡 Needs Work
**Reviewed:** 2026-06-09
**Scope:** Group 2 (Corpus Repository Structure) — with cross-group ripple from ADR-001

---

## 📋 Plan Structure

- [x] Implementation plan found and parseable
- [x] YAML frontmatter valid (`task_count: 19`, 6 `groups`, `tasks_files` aligned)
- [x] Every referenced task group file exists on disk
- [x] Checkbox census matches `task_count` (19)
- [x] No orphan global task IDs (1–19 partitioned across 6 groups)

Structural integrity is sound. The issues below are **content** gaps, not frontmatter/parity defects.

---

## 📝 Task Group Review

### Group 2: Corpus Repository Structure (Tasks 4–6)

- **Header status:** 🔴 Scaffolding
- **Task count:** 3 (within 2–8)
- **Descriptions:** Scaffolding-level (expected pre-expansion), **but materially stale** vs decisions landed after the plan was scaffolded
- **Dependencies section:** Present, but inaccurate (see Warnings)

The group predates ADR-001 (corpus split) and the proj-cli-nightly bootstrap intent. As written it would execute the *wrong* shape.

---

## 🔗 Dependency Validation

- [x] No circular dependencies
- [x] Cross-group references point to earlier groups
- [~] External prerequisites: **now documented + satisfied** — bootstrapping via proj-cli nightly requires (a) proj-cli `develop` carrying the `expected_skills` validation (PR #31 **MERGED to develop 2026-06-09**) and (b) dev-infra `develop` carrying the skill-template-separation template changes (all merged). Both hold. Not yet written into the plan.
- [x] Prerequisite groups complete (Group 1 ✅)

---

## 🔄 Consistency Check

- [x] Plan ↔ Status counts align (3/19, Group 1 ✅ Complete)
- [x] Plan ↔ Task titles align (no phantom tasks)
- [x] Frontmatter `groups[].tasks` matches markdown numbering

---

## 🔴 Blockers

1. **Group 2 assumes ONE corpus repo; ADR-001 (Accepted) mandates TWO.** Tasks 4–6 say "the corpus repo" (singular). [ADR-001](../decisions/adr-001-corpus-repo-split-model.md) requires a **core** repo (`ai-workflow`) and a **personal** repo (`ai-workflow-personal`), with the inventory split by the boundary test. Executing Group 2 as written would build the wrong structure and contradict an accepted decision. *(Faithful-execution blocker.)*
2. **Migration target is wrong (Task 5).** Task 5 says migrate `~/.claude/skills/` — but the [corpus reference](corpus-repo-reference.md) inventory found `~/.claude/skills/` **empty** (corpus is Cursor-only for v1). Task 5 also doesn't split core vs personal or guarantee `update-pr-description` lands in **core** (dependency-forced per ADR-001).

---

## 🟡 Warnings

1. **Bootstrap method unspecified → should be proj-cli nightly.** Task 5 ("Initialize the corpus repo") implies a bare `git init`. Intent (2026-06-09) is to **generate** the repo(s) via `proj-cli` against **develop/nightly** (both repos as dev-infra-generated projects), dogfooding the unreleased template + `expected_skills` validation. Needs an explicit task.
2. **Group 2 Dependencies note is inaccurate.** It claims Group 1 "informs nothing structural here." False on two counts: Group 1's GO sets symlink mode (informs the installer), and ADR-001 now drives Group 2's structure. Rewrite on expansion.
3. **Sizing after fixes.** Reflecting two repos + proj-cli bootstrap likely grows Group 2 from 3 → ~5 tasks (still ≤ 8).

---

## 💡 Recommendations (cross-group ripple from ADR-001 + nightly bootstrap)

The two-repo decision and proj-cli bootstrap ripple beyond Group 2. Proposed task changes (to apply via `write-plan` — not done in this review):

- **Group 2 (Corpus Repository Structure):** rework to —
  - Task 4: define layout/name for **both** core + personal repos (boundary test from ADR-001).
  - **New task:** bootstrap each repo via `proj-cli` on **develop/nightly** (pin/record the dev-infra + proj-cli commit shas used).
  - Task 5: migrate + **split** the inventory (core = general/durable **or** depended-on-by-core incl. `update-pr-description`; personal = `apprentice-*`, `ticket-*`, `capture-discussion`); drop the empty `~/.claude/skills/`.
  - Task 6: README/versioning **per repo**; mark personal repo private.
- **Group 3 (Installer Mapping):** `installer.yaml` must map **two** source repos (multi-source; ADR-002 FR-INST-2). Task 7 currently implies one.
- **Group 4 (Installer Script):** **add** the **"no core→personal references" check** at install (ADR-001 invariant + Requirements Impact).
- **Group 5 (Source Install & Multi-Machine):** `clone → install` now clones **two** repos, one **private** — account for the private-repo auth/clone step in the multi-machine flow.

These additions change `task_count` and group `tasks[]` partitions → a frontmatter-parity update across the plan + affected group files. Recommend doing it as a deliberate `write-plan` pass (setup-level re-partition or targeted expands), not piecemeal.

---

## ✅ Readiness Assessment

**Overall:** 🟡 Needs Work — Group 2 is **not ready to execute** until it reflects the two-repo split (ADR-001) and the proj-cli-nightly bootstrap. The plan's structural integrity (parity) is fine; the content is stale relative to decisions landed after scaffolding.

**Action Items:**

- [ ] Re-partition/expand Group 2 for two repos + proj-cli-nightly bootstrap + inventory split
- [ ] Propagate two-repo implications to Groups 3 (multi-source mapping), 4 (core→personal lint), 5 (private-repo clone)
- [ ] Record the nightly pin (dev-infra + proj-cli develop shas) used for generation
- [ ] Re-run a quick parity check after the re-partition (task_count + group tasks[])

---

**Last Updated:** 2026-06-09
