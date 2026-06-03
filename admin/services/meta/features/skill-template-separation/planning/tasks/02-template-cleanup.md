# Template Cleanup

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Template Cleanup
**Status:** ✅ Complete
**Last Updated:** 2026-06-03

---

## 📌 Operating Context

ADR-001 (FR-OWN-2, FR-BNDL-1): templates must not ship authoritative skill/command/agent copies. On `develop` after PR #106, both `templates/standard-project` and `templates/learning-project` still contain `.claude/skills/` (standard only) and `.cursor/commands/`. This group deletes those trees and locks the absence in with Bats tests.

**Out of scope here:** `scripts/template-sync-manifest.txt` retirement and README/doc prose updates (Groups 3 and 6). Expect `validate-template-sync` CI to fail until Group 3 removes manifest entries.

---

## 📝 Tasks

- [x] Task 6: Audit current template tree for skill/command/agent residue
- [x] Task 7: Remove `templates/standard-project/.claude/skills/` if present
- [x] Task 8: Remove `templates/standard-project/.cursor/commands/` if present
- [x] Task 9: Remove any agent files from `templates/`
- [x] Task 10: Update template validation tests to confirm absence

### Task 6: Audit current template tree for skill/command/agent residue

**Purpose:** Produce a committed inventory before deletion so reviewers can see what was removed.

**Steps:**

1. From repo root, list bundled-tooling paths:
   ```bash
   find templates -type d \( -path '*/.claude/skills*' -o -path '*/.cursor/commands*' -o -path '*/.agents*' -o -path '*/.cursor/agents*' \) 2>/dev/null | sort
   find templates -name '*.agent.md' 2>/dev/null | sort
   ```
2. Record counts:
   ```bash
   find templates/standard-project/.claude/skills -type f | wc -l
   find templates/standard-project/.cursor/commands -type f | wc -l
   find templates/learning-project/.cursor/commands -type f | wc -l
   ```
3. Confirm no `.agents/` or `*.agent.md` under `templates/` (expect zero).
4. Append inventory summary to this task section or commit message body (paths + file counts).

**Files:**

- This file (audit notes in commit message)

**Acceptance:**

- Inventory lists `templates/standard-project/.claude/skills/`, both templates' `.cursor/commands/`, and zero agent artifacts
- No unexpected paths (e.g. repo-root `.claude/` — that lives outside templates and is not touched)

---

### Task 7: Remove `templates/standard-project/.claude/skills/` if present

**Purpose:** Delete the standard-project skill corpus copy from the template product.

**Steps:**

1. Verify directory exists: `test -d templates/standard-project/.claude/skills`
2. Remove the tree:
   ```bash
   git rm -r templates/standard-project/.claude/skills
   ```
3. If `.claude/` is empty, remove it: `rmdir templates/standard-project/.claude 2>/dev/null || true` (only if empty; do not force-remove non-empty parent)
4. Verify: `test ! -d templates/standard-project/.claude/skills`

**Files:**

- Deleted: `templates/standard-project/.claude/skills/**`

**Acceptance:**

- `git status` shows deletions tracked
- `find templates/standard-project/.claude/skills` returns nothing

---

### Task 8: Remove `templates/standard-project/.cursor/commands/` if present

**Purpose:** Delete Cursor command copies from the standard-project template.

**Steps:**

1. Verify: `test -d templates/standard-project/.cursor/commands`
2. Remove:
   ```bash
   git rm -r templates/standard-project/.cursor/commands
   ```
3. Prune empty `.cursor/` if applicable (same as Task 7)
4. Verify absence

**Files:**

- Deleted: `templates/standard-project/.cursor/commands/**`

**Acceptance:**

- No `templates/standard-project/.cursor/commands/` in tree or index

---

### Task 9: Remove any agent files from `templates/`

**Purpose:** Ensure no agent definitions ship in templates (including learning-project commands tree and stray agents).

**Steps:**

1. Re-run agent hunt (expect zero agents):
   ```bash
   find templates -name '*.agent.md' -o -path '*/.agents/*' 2>/dev/null
   ```
2. Remove learning-project commands (bundled tooling, same as standard):
   ```bash
   git rm -r templates/learning-project/.cursor/commands
   ```
3. Prune empty `templates/learning-project/.cursor/` if empty
4. Final sweep: no `*.agent.md`, no `.agents/` under `templates/`

**Files:**

- Deleted: `templates/learning-project/.cursor/commands/**`

**Acceptance:**

- Both templates lack `.cursor/commands/`
- Zero agent files under `templates/`

---

### Task 10: Update template validation tests to confirm absence

**Purpose:** Prevent re-bundling via CI (TDD: tests fail before deletion, pass after).

**Steps:**

1. **RED** — Add `tests/unit/template-bundled-tooling.bats` asserting:
   - `templates/standard-project/.claude/skills` does not exist
   - `templates/standard-project/.cursor/commands` does not exist
   - `templates/learning-project/.cursor/commands` does not exist
   - No `*.agent.md` under `templates/`
   - Run `bats tests/unit/template-bundled-tooling.bats` — expect fail before Task 7–9 deletions
2. **GREEN** — After deletions, same tests pass
3. Update `tests/unit/new-project.bats`:
   - Replace "includes all commands" tests with assertions that generated projects **lack** `.cursor/commands` and `.claude/skills`
   - Keep structure tests that only need `docs/`, `backend/`, etc.
   - Remove or narrow `[ -d "$TEST_STANDARD_DIR/.cursor" ]` if `.cursor` dir is fully gone
4. Run:
   ```bash
   bats tests/unit/template-bundled-tooling.bats tests/unit/new-project.bats
   ```
5. Smoke: `./scripts/new-project.sh` non-interactive in tmpdir — verify no bundled tooling dirs

**Files:**

- New: `tests/unit/template-bundled-tooling.bats`
- Modified: `tests/unit/new-project.bats`

**Acceptance:**

- Bats absence tests pass
- `new-project.bats` no longer expects bundled commands/skills in generated output
- `./scripts/new-project.sh` produces project without `.cursor/commands` or `.claude/skills`

---

## 🎯 Goals

1. Templates carry zero authoritative skill/command/agent copies (FR-OWN-2, FR-BNDL-1).
2. Validation tests prevent re-bundling regressions.

---

## ✅ Completion Criteria

- [x] Template trees verified clean of bundled tooling
- [x] Bats tests added asserting absence; scoped unit tests pass
- [x] Generated project (via `./scripts/new-project.sh`) contains no skills/commands/agents

## 📋 Audit Record (Task 6, 2026-06-03)

| Path | Files removed |
|------|----------------|
| `templates/standard-project/.claude/skills/` | 41 |
| `templates/standard-project/.cursor/commands/` | 20 |
| `templates/learning-project/.cursor/commands/` | 21 |
| `*.agent.md` / `.agents/` under `templates/` | 0 |

Empty `.claude/` and `.cursor/` parent dirs pruned where applicable.

---

## 🔗 Dependencies

- Group 1 (Branch Setup) — merged via PR #106 on `develop`.

---

**Last Updated:** 2026-06-03
