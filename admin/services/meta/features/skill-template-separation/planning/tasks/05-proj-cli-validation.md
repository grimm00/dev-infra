# proj-cli Validation

**Feature:** Skill-Template Separation (ADR-001)
**Group:** proj-cli Validation
**Status:** ✅ Complete
**Last Updated:** 2026-06-09

---

## 📌 Operating Context

ADR-001 FR-BNDL-3: `proj-cli` validates `expected_skills` from `.dev-infra.yml` with **warn-not-error** semantics (NFR-BNDL-1). Group 4 shipped the manifest in both templates (PR #109). Implementation lives in the **proj-cli** repository (`src/proj/skills.py`, hooked from `commands/projects/create.py` after template copy + optional git init).

**Design decisions (Task 19):**

| Question | Decision |
|----------|----------|
| Where in setup flow? | `proj create --template` path, **after** `create_from_template` + optional `init_git`, **before** registry/API sync — same non-fatal tier as git-init failure |
| What is "installed"? | Directory exists at `~/.cursor/skills/<name>/` **or** `~/.claude/skills/<name>/` (bare identifiers per Group 4) |
| ADR-003 lookup chain? | **Out of scope** for v1 — flat global paths only until ADR-003 lands |
| Blocking behavior? | Never — warnings only; exit code stays 0 |

**Companion repo:** `proj-cli` branch `feat/skill-template-separation-expected-skills-validation` — Tasks 20–21 implementation + tests.

---

## 📝 Tasks

- [x] Task 19: Design `proj-cli` `expected_skills` validation step (warn-not-error)
- [x] Task 20: Implement validation logic in `proj-cli` setup flow
- [x] Task 21: Add install-guidance message text pointing to the corpus
- [x] Task 22: Test graceful degradation (generated project works without skills installed)

### Task 19: Design `proj-cli` `expected_skills` validation step (warn-not-error)

**Purpose:** Lock integration contract before implementation (FR-BNDL-3).

**Steps:**

1. Document hook point: post-create, pre-registry in `create.py` template branch.
2. Document installed check: presence under `DEFAULT_SKILL_ROOTS` (cursor + claude).
3. Document warn-not-error parity with git-init failure handling.
4. Record decisions in Operating Context table above.

**Files:**

- `admin/services/meta/features/skill-template-separation/planning/tasks/05-proj-cli-validation.md` (this file)
- `docs/DEV-INFRA-YML.md` (validation behavior section — already drafted in Group 4)

**Acceptance:**

- Hook point, installed definition, and non-blocking semantics documented
- ADR-003 deferred explicitly

---

### Task 20: Implement validation logic in `proj-cli` setup flow

**Purpose:** FR-BNDL-3 — read manifest, check installs, warn on gaps.

**TDD Flow:**

1. **RED** — `tests/unit/test_skills.py`: parse `.dev-infra.yml`, detect missing skills, no-op when file absent.
2. **GREEN** — `src/proj/skills.py`:
   - `load_expected_skills(project_path)`
   - `is_skill_installed(name, skill_roots=...)`
   - `find_missing_skills(project_path)`
   - `warn_missing_expected_skills(project_path, console)`
3. **GREEN** — Hook in `src/proj/commands/projects/create.py` after git init.
4. **REFACTOR** — Re-export `warn_missing_expected_skills` from `commands/projects/__init__.py` for test patching.

**Files (proj-cli repo):**

- `src/proj/skills.py` (new)
- `src/proj/commands/projects/create.py`
- `src/proj/commands/projects/__init__.py`
- `tests/unit/test_skills.py`
- `tests/create/test_expected_skills.py`

**Acceptance:**

- Reads `expected_skills` from generated `.dev-infra.yml`
- Warns per missing skill; never raises or changes exit code
- Unit + CLI tests pass: `pytest tests/unit/test_skills.py tests/create/test_expected_skills.py`

---

### Task 21: Add install-guidance message text pointing to the corpus

**Purpose:** Orient users when skills are missing (placeholder until ADR-002).

**Steps:**

1. Add `CORPUS_INSTALL_GUIDANCE` constant in `src/proj/skills.py`:
   - Global install paths (`~/.cursor/skills/<name>/`, `~/.claude/skills/<name>/`)
   - Corpus is separate product (ADR-001 reference)
   - ADR-002 automated install pending
2. Print guidance via `console.print("[dim]...[/dim]")` after missing-skill list.
3. Assert guidance text in unit/CLI tests.

**Files (proj-cli repo):**

- `src/proj/skills.py`

**Acceptance:**

- Warning block lists missing identifiers + install guidance
- Guidance mentions ADR-002 placeholder
- Tests assert guidance string present when skills missing

---

### Task 22: Test graceful degradation (generated project works without skills installed)

**Purpose:** NFR-BNDL-1 — dev-infra generation path works with zero skills installed.

**Steps:**

1. Add Bats suite `tests/unit/expected-skills-graceful-degradation.bats`:
   - Generate standard-project via `new-project.sh --non-interactive` into temp dir
   - Assert exit 0
   - Assert `.dev-infra.yml` exists with `expected_skills:` key
   - Assert no `.claude/skills` or `.cursor/commands` under generated tree
   - Assert `README.md` contains orientation text (docs orient agents without skills)
2. Run: `bats tests/unit/expected-skills-graceful-degradation.bats`

**Files (dev-infra repo):**

- `tests/unit/expected-skills-graceful-degradation.bats` (new)

**Acceptance:**

- Generation succeeds with no global skills manipulation required
- Manifest present; bundled tooling absent; README orients user

---

## 🎯 Goals

1. `proj-cli` validates `expected_skills` and warns on missing entries (FR-BNDL-3).
2. Missing skills never block project setup (NFR-BNDL-1: graceful degradation).
3. Users get clear install guidance.

---

## ✅ Completion Criteria

- [x] Validation step implemented and unit-tested
- [x] Graceful-degradation test scenario passes
- [x] Install-guidance text reviewed and merged

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 19: Design | ✅ Complete | Operating Context table |
| Task 20: Implement | ✅ Complete | proj-cli `skills.py` + create hook |
| Task 21: Guidance | ✅ Complete | `CORPUS_INSTALL_GUIDANCE` |
| Task 22: Graceful degradation | ✅ Complete | dev-infra Bats (4 tests) |

---

## 🔗 Dependencies

- Group 4 (expected_skills Manifest) — merged PR #109; `.dev-infra.yml` field exists in both templates.

---

**Last Updated:** 2026-06-09
