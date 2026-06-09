# Corpus Repository Structure

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Corpus Repository Structure
**Status:** 🟠 In Progress (Task 4 ✅ — see `corpus-classification.md`)
**Last Updated:** 2026-06-09

---

## 📌 Operating Context

Group 2 establishes the **two** corpus repos decided in [ADR-001](../decisions/adr-001-corpus-repo-split-model.md)
and migrates the authored corpus into them. Work spans repos: the planning/record lives
in dev-infra, but the repos themselves are created and populated **outside** dev-infra
(generated via proj-cli). This session drives both.

**Cohort:** tooling (proj-cli generation, migration) + docs (per-repo READMEs). Not TDD —
each task is *do → verify* with explicit acceptance checks.

**Inputs already settled:**
- Inventory + exclusions: [`corpus-repo-reference.md`](../corpus-repo-reference.md) (19 skills / 22 commands / 3 agents under `~/.cursor/`; excludes `skills-cursor/` built-ins and Claude plugins).
- Boundary test (ADR-001): **core** if general-purpose/durable **or** depended-on-by-core; else **personal**. Invariant: no core→personal deps.
- Nightly prerequisite (satisfied): proj-cli `develop` has `expected_skills` validation (#31 merged 2026-06-09); dev-infra `develop` has the template changes.

---

## 📝 Tasks

### Task 4: Define layout + names + classify the inventory

**Purpose:** Produce the concrete core/personal classification and the repo layout before
generating anything, so Tasks 5–6 are mechanical.

**Steps:**

1. Repo names: **core = `ai-workflow`**, **personal = `ai-workflow-personal`** (confirm or override).
2. Layout for each: `skills/`, `commands/`, `agents/` (+ `install.sh` lands in core at Group 4).
3. Apply the ADR-001 boundary test to every inventory item; produce a **classification table** (each skill/command/agent → core | personal + reason). Anchor cases:
   - `update-pr-description` → **core** (depended on by `group-cycle.agent`).
   - `apprentice-*`, `ticket-*`, `capture-discussion` → **personal** (context-coupled/expirable).
   - The agents (`group-cycle.agent`, `group-cycle-work.agent`, `research-orchestrator/`) and the 22 commands → classify each; commands invoked by core agents are core.
4. **Dependency sweep:** for each core candidate, grep its body for references to any personal-classified item. Any hit → either the dependency is core (reclassify up) or the reference is removed. Record that the no-core→personal invariant holds.

**Files:**

- `planning/corpus-classification.md` (new) — the classification table + dependency-sweep result. (Or append a section to `corpus-repo-reference.md`.)

**Acceptance:**

- Every inventory item classified core | personal with a reason.
- Dependency sweep shows zero core→personal references (or reclassifications recorded).
- `update-pr-description` is in core.

---

### Task 5: Bootstrap both repos via proj-cli (develop/nightly)

**Purpose:** Generate `ai-workflow` and `ai-workflow-personal` as proj-cli-generated
projects using the unreleased template + validation, reproducibly.

**Steps:**

1. Verify proj-cli is on **develop** (carries `expected_skills` validation, #31) and dev-infra templates are at develop. Record both **commit SHAs** (the "nightly pin").
2. Generate the **core** repo: `proj create` (or the repo's documented invocation) for `ai-workflow` at its chosen location (e.g. `~/Projects/ai-workflow/`).
3. Generate the **personal** repo: same for `ai-workflow-personal`.
4. Confirm each generated project's structure (`admin/`, `docs/maintainers/`, CI, `.dev-infra.yml`) and that generation succeeded with the expected_skills validation behaving as warn-not-error.
5. Note: corpus repos may be over-scaffolded vs a flat skills collection — capture any structure to trim as a follow-up rather than fighting the generator now.

**Files:**

- (External) the two new repos.
- `planning/corpus-classification.md` or a bootstrap note — record the nightly SHAs + the proj-cli invocation used.

**Acceptance:**

- Both repos exist, generated via proj-cli on develop.
- Nightly SHAs (dev-infra + proj-cli) recorded for reproducibility.
- Generated structure verified; expected_skills validation ran (warn-not-error).

---

### Task 6: Migrate + split the global corpus

**Purpose:** Move the authored corpus out of untracked `~/.cursor/` into the two repos
per the Task 4 classification, making it tracked source.

**Steps:**

1. Copy core-classified `skills/ commands/ agents/` from `~/.cursor/` into `ai-workflow/`; copy personal-classified items into `ai-workflow-personal/`.
2. Exclude the non-corpus dirs (`~/.cursor/skills-cursor/` built-ins, Claude plugins). The empty `~/.claude/skills/` is a no-op — drop it from any migration script.
3. Verify counts reconcile against the Task 4 classification (no item dropped or duplicated).
4. Re-run the dependency sweep on the *materialized* repos: confirm no core file references a personal-only path.
5. Commit each repo. Do **not** delete the `~/.cursor/` originals yet — the installer (Group 4) will symlink editor paths → repo, then originals are removed during install validation (Group 5).

**Files:**

- (External) populated `skills/ commands/ agents/` in both repos.

**Acceptance:**

- Every classified item lives in the correct repo as tracked source.
- Counts reconcile with Task 4; core→personal invariant re-verified on disk.
- `~/.cursor/` originals left intact pending installer cutover.

---

### Task 7: Per-repo README + versioning; mark personal private

**Purpose:** Make each repo a self-describing product and lock down the personal one.

**Steps:**

1. Author `README.md` in each repo: what it is, what's in it, install pointer (forward-ref to `install.sh`/Group 6 docs), and the core/personal boundary (per ADR-001).
2. Define independent versioning per repo (ADR-001/ADR-002: corpus releases on its own cadence, not dev-infra's).
3. Set the **personal** repo's remote visibility to **private**; core can be public-ish per its audience.
4. Cross-link both back to this feature's ADR-001 for provenance.

**Files:**

- (External) `README.md` + versioning note in each repo.

**Acceptance:**

- Both repos have READMEs describing contents + boundary + install pointer.
- Versioning convention documented per repo.
- Personal repo is private on the remote.

---

## 🎯 Goals

1. Both corpus repos exist (core + personal) per ADR-001, generated consistently via proj-cli nightly.
2. The global corpus is migrated and correctly split, with the core→personal invariant intact.
3. Each repo is a self-describing, independently-versioned product; personal is private.

---

## ✅ Completion Criteria

- [x] Classification table produced; `update-pr-description` in core; no core→personal deps — `corpus-classification.md`
- [ ] Both repos bootstrapped via proj-cli nightly; SHAs pinned/recorded
- [ ] Inventory migrated + split correctly; counts reconcile; `~/.cursor/` originals intact pending cutover
- [ ] Per-repo README + versioning; personal repo private

---

## 🔗 Dependencies

- Group 1 (spike) ✅ — GO sets symlink mode (informs Groups 3–4).
- [ADR-001](../decisions/adr-001-corpus-repo-split-model.md) — the two-repo split + boundary test this group implements.
- **External (satisfied):** proj-cli `develop` carries `expected_skills` validation (#31 merged 2026-06-09); dev-infra `develop` carries the template changes.
- Feeds Group 3 (mapping targets the two repos' subdirs) and Group 4 (installer symlinks them, then originals are removed).

---

**Last Updated:** 2026-06-09
