# Installer Script

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Installer Script
**Status:** 🟠 In Progress (Task 11 ✅ — `install.sh` core + Bats in `agentic-ocean` `feat/installer-script`)
**Last Updated:** 2026-06-10

---

## 📌 Operating Context

This is the **code** group — `install.sh` + Bats tests in the **`agentic-ocean`** repo.
It consumes the Group 3 contract (`installer.yaml` schema + the live
`~/.config/agentic-ocean/installer.yaml`) and makes `clone → install` real.

**Workflow:** per the 2026-06-09 correction, this lands `feat/* → PR → develop` in
`agentic-ocean` (it's code, gets CI + review) — not direct to main.

**Cohort:** scripts/tooling → for each capability, write the **Bats** test first, then the
script, then integrate. Task 15 is the consolidated suite, but write each test alongside
its capability (don't save all testing for the end).

**Two decisions that attach to this group:**

1. **YAML parsing with minimal deps (Task 11).** ADR-002's Tier-2 goal is a
   *self-contained* `install.sh` (bash + `ln`, no heavy prereqs). The `installer.yaml`
   schema is deliberately simple — so the choice is: (a) a constrained-format parser in
   `awk`/`grep` over the known `sources`/`links` shape (keeps it dependency-free), or
   (b) require `yq` with a presence check + actionable error. **Recommend (a)** to honor
   self-containment; if (b), the dep is the thing mise would later provision.
2. **mise (parked).** Decision stands: self-contained `install.sh` is the entrypoint;
   mise is an **optional later layer** (a `mise.toml` task that calls `install.sh` +
   provisions deps). Not in scope for Group 4 unless you revisit it.

---

## 📝 Tasks

### Task 11: Implement `install.sh` (core install)

**Purpose:** The self-contained installer — read the mapping, create per-item symlinks
idempotently (FR-INST-1/6, NFR-INST). Symlink mode (Group 1 GO).

**Flow (Bats-first):**

1. **Test:** fixture `installer.yaml` + fixture corpus dirs → assert `install.sh` creates
   the expected symlinks; assert a second run is a no-op (idempotent).
2. **Config resolution:** look up `$XDG_CONFIG_HOME/agentic-ocean/installer.yaml` then
   `~/.config/agentic-ocean/installer.yaml`; clear error if missing.
3. **Parse** the mapping (per the dep decision above — constrained `awk` parser recommended).
4. **Link:** for each `source × kind × entry`, symlink `<target>/<entry>` →
   `<root>/<kind>/<entry>` (expand `~`). Idempotent: if the link already points correctly,
   skip; honor schema **collision=error** when a target entry exists pointing elsewhere or
   is a real file (unless `--force`, Task 13).

**Files:** `agentic-ocean/install.sh`; `agentic-ocean/tests/*.bats`.

**Acceptance:** reads both sources from config, creates per-item symlinks, idempotent
re-run, errors clearly on missing config and on collisions.

---

### Task 12: Implement uninstall

**Purpose:** Reversibility (FR-INST-3) — remove installer-created symlinks, leave the
corpora and unrelated entries untouched (`stow -D` equivalent).

**Flow (Bats-first):**

1. **Test:** after install, uninstall → assert mapped symlinks gone, corpus dirs intact,
   unrelated entries in the target dirs untouched; uninstall twice = no error.
2. **Implement** an uninstall path (`install.sh --uninstall` or `uninstall.sh`): for each
   mapped entry, remove the target **only if** it's a symlink pointing into a known corpus
   root. Never delete real files or non-managed entries.

**Files:** `agentic-ocean/install.sh` (uninstall path); tests.

**Acceptance:** removes only installer-created links; corpus + unrelated entries intact;
idempotent.

---

### Task 13: Standard flags

**Purpose:** Repo script standards — `--dry-run`, `--force`, `--verbose`.

**Flow (Bats-first):**

1. **Test:** `--dry-run` makes **no** filesystem changes (assert no links created);
   `--force` replaces an existing conflicting target; `--verbose` emits per-action detail.
2. **Implement** arg parsing + thread the flags through install/uninstall.

**Files:** `install.sh`; tests.

**Acceptance:** each flag behaves; `--dry-run` is provably side-effect-free; `--force`
overrides the collision error from Task 11.

---

### Task 14: "No core→personal references" check (ADR-001 invariant)

**Purpose:** Enforce the invariant at install — a **core** artifact must never depend on
something living only in the **personal** repo (else a core-only clone breaks silently).

**Flow (Bats-first):**

1. **Define the heuristic concretely** (and document its scope): scan core corpus files
   (`skills/`, `commands/`, `agents/` under the core source) for references to the
   **identifiers/paths of personal-only entries** (entry names present in the personal
   source but not core). This is a name/path grep, not full semantic analysis — document
   what it does and doesn't catch.
2. **Test:** a fixture where a core file names a personal-only item → check **fails**
   (error by default; `--force`/`--warn-only` downgrades to warning); clean corpora pass.
3. **Integrate:** run the check after both sources resolve, before/around linking.

**Files:** `install.sh` (lint step); tests; brief note in `docs/installer-schema.md`.

**Acceptance:** install errors (or warns under override) on a core→personal reference,
naming the offending file; clean corpora pass; heuristic scope documented.

---

### Task 15: Bats test suite (consolidation)

**Purpose:** The complete, CI-runnable suite — formalizes the per-task tests + the cross-cutting cases.

**Flow:**

1. Fixtures: temp corpus dirs (core + personal) + a fixture `installer.yaml`; temp editor
   target dirs (no touching the real `~/.cursor/`).
2. Cases: install creates links · idempotent re-run · uninstall removes links + corpus
   intact · `--dry-run` no changes · **collision=error** · **core→personal lint fires** ·
   copy-mode fallback **(only if copy-mode is implemented — else mark N/A; symlink is v1)**.
3. Wire into the repo's CI (`.github/workflows/ci.yml`).

**Files:** `agentic-ocean/tests/*.bats`; CI wiring.

**Acceptance:** suite green locally + in CI; covers the cases above (copy-mode case
conditional on whether copy-mode ships in v1).

---

## 🎯 Goals

1. A self-contained, idempotent, reversible `install.sh` ships in the core repo (Tier 2 ready).
2. The ADR-001 core→personal invariant is enforced at install.

---

## ✅ Completion Criteria

- [x] `install.sh` creates the multi-source mapped links idempotently — Bats: create/idempotency/collision/missing-config (4 pass); yq-based parse
- [ ] Uninstall removes links, leaves corpora intact
- [ ] Standard flags implemented (`--dry-run` side-effect-free)
- [ ] Core→personal reference check enforced at install (ADR-001 invariant), scope documented
- [ ] Bats suite passes locally + in CI (install / uninstall / idempotency / collision / lint)
- [ ] YAML-parse dependency decision recorded (constrained parser vs `yq`)

---

## 🔗 Dependencies

- Group 1 ✅ — symlink mode (copy-mode is the documented contingency, not v1 default).
- Group 3 ✅ — `installer.yaml` schema + live config the script reads.
- Lands in `agentic-ocean` via `feat/* → PR → develop` (corpus repo CI runs the Bats suite).

---

**Last Updated:** 2026-06-09
