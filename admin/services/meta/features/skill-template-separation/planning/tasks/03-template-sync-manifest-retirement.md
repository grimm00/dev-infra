# Template-Sync-Manifest Retirement

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Template-Sync-Manifest Retirement
**Status:** ✅ Expanded
**Last Updated:** 2026-06-04

---

## 📌 Operating Context

PR #107 removed bundled `.cursor/commands/` and `.claude/skills/` from both templates. `scripts/template-sync-manifest.txt` still lists those paths, so `validate-template-sync` fails on `develop` (expected until this group lands). ADR-001 FR-BNDL-4: retire the manifest-based sync mechanism entirely — not shrink to `.sourcery.yaml` only.

**Out of scope:** `docs/TEMPLATE-SYNC.md` and `AGENTS.md` prose updates (Group 6).

---

## 📝 Tasks

- [ ] Task 11: Audit `scripts/template-sync-manifest.txt` for remaining valid entries
- [ ] Task 12: Remove or repurpose the manifest file
- [ ] Task 13: Remove or update `scripts/validate-template-sync.sh`
- [ ] Task 14: Remove related CI workflow steps that consume the manifest

### Task 11: Audit `scripts/template-sync-manifest.txt` for remaining valid entries

**Purpose:** Document why every manifest entry is obsolete before deletion (reviewer artifact).

**Steps:**

1. List active (non-comment) manifest lines:
   ```bash
   grep -v '^[[:space:]]*#' scripts/template-sync-manifest.txt | grep -v '^[[:space:]]*$'
   ```
2. For each path, verify absence under both templates:
   ```bash
   for p in $(grep -v '^#' scripts/template-sync-manifest.txt | grep -v '^$'); do
     test -e "templates/standard-project/$p" && echo "STILL EXISTS standard: $p"
     test -e "templates/learning-project/$p" && echo "STILL EXISTS learning: $p"
   done
   ```
3. Record audit conclusion in commit message:
   - 20× `.cursor/commands/*` — removed in PR #107 (invalid)
   - `.sourcery.yaml` — still present and identical, but manifest mechanism retired per ADR-001 (no shrink-to-residual)

**Acceptance:**

- Audit confirms zero manifest paths exist under `templates/`
- Decision recorded: full retirement (delete manifest), not minimal residual manifest

---

### Task 12: Remove or repurpose the manifest file

**Purpose:** Eliminate the obsolete manifest (FR-BNDL-4).

**Steps:**

1. Delete manifest:
   ```bash
   git rm scripts/template-sync-manifest.txt
   ```
2. Grep repo for stale references (note hits for Group 6; fix only blocking scripts/CI in this group):
   ```bash
   rg 'template-sync-manifest' --glob '!admin/**'
   ```

**Files:**

- Deleted: `scripts/template-sync-manifest.txt`

**Acceptance:**

- File absent from tree and index
- No CI/workflow still requires the file

---

### Task 13: Remove or update `scripts/validate-template-sync.sh`

**Purpose:** Remove the validator that enforced obsolete sync rules.

**Steps:**

1. Delete script and dedicated Bats suite:
   ```bash
   git rm scripts/validate-template-sync.sh
   git rm tests/unit/validate-template-sync.bats
   ```
2. Search for invocations outside CI (informational; Group 6 may clean historical planning docs):
   ```bash
   rg 'validate-template-sync' .
   ```
3. Run remaining unit tests:
   ```bash
   bats tests/unit/*.bats
   ```

**Files:**

- Deleted: `scripts/validate-template-sync.sh`, `tests/unit/validate-template-sync.bats`

**Acceptance:**

- Script and Bats file gone
- `bats tests/unit/*.bats` passes locally
- No workflow step still invokes the script (Task 14)

---

### Task 14: Remove related CI workflow steps that consume the manifest

**Purpose:** Restore green `develop` CI by removing the failing `quick-checks` step.

**Steps:**

1. Edit `.github/workflows/test.yml` — remove the `Validate Template Sync` step (lines ~79–80).
2. Confirm no other workflow invokes the script:
   ```bash
   rg 'validate-template-sync' .github/
   ```
3. Optional local sanity (if Docker test image available): run `bats tests/unit/*.bats`; full CI verified on PR.

**Files:**

- `.github/workflows/test.yml`

**Acceptance:**

- `rg validate-template-sync .github/` returns no matches
- PR CI `quick-checks` no longer runs dead validation
- After merge to `develop`, next Run Tests on `develop` should pass `quick-checks` (load-bearing outcome)

---

## 🎯 Goals

1. `template-sync-manifest.txt` and `validate-template-sync.sh` no longer enforce sync that doesn't exist (FR-BNDL-4).
2. CI does not fail or run dead validation steps.

---

## ✅ Completion Criteria

- [ ] Manifest file removed or minimized to its remaining purpose
- [ ] Validation script removed or updated; `scripts/README.md` reflects the change
- [ ] CI workflows green without the dead steps

---

## 🔗 Dependencies

- Group 2 (Template Cleanup) — merged PR #107; bundled command trees removed.

---

**Last Updated:** 2026-06-04
