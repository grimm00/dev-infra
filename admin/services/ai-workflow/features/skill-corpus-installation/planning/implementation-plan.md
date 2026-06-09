---
task_count: 21
groups:
  - name: "Symlink Loading Spike"
    file: "tasks/01-symlink-loading-spike.md"
    tasks: [1, 2, 3]
  - name: "Corpus Repository Structure"
    file: "tasks/02-corpus-repository-structure.md"
    tasks: [4, 5, 6, 7]
  - name: "Installer Mapping & XDG Config"
    file: "tasks/03-installer-mapping-and-xdg-config.md"
    tasks: [8, 9, 10]
  - name: "Installer Script"
    file: "tasks/04-installer-script.md"
    tasks: [11, 12, 13, 14, 15]
  - name: "Source Install & Multi-Machine (Tier 2)"
    file: "tasks/05-source-install-and-multi-machine.md"
    tasks: [16, 17, 18]
  - name: "Documentation & ADR Acceptance"
    file: "tasks/06-documentation-and-adr-acceptance.md"
    tasks: [19, 20, 21]
tasks_files:
  - "tasks/01-symlink-loading-spike.md"
  - "tasks/02-corpus-repository-structure.md"
  - "tasks/03-installer-mapping-and-xdg-config.md"
  - "tasks/04-installer-script.md"
  - "tasks/05-source-install-and-multi-machine.md"
  - "tasks/06-documentation-and-adr-acceptance.md"
---
# Implementation Plan — Skill Corpus Installation (ADR-002)

**Status:** 🔴 Not Started
**Created:** 2026-06-09
**Last Updated:** 2026-06-09
**Source:** [ADR-002: Installation & Distribution Architecture](../../../../meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md)

---

## 📋 Overview

Implements ADR-002 — gives the skill corpus (separated into its own product by ADR-001) a real installation mechanism so skills/commands/agents appear at editor paths (`~/.cursor/skills/`, `~/.claude/skills/`, etc.) without manual copying, and so a second machine can go from `git clone` → one command → working. Adopts a **symlink farm** (GNU Stow pattern): corpus lives at a project path, config lives at `~/.config/ai-workflow/`, an installer creates symlinks from editor paths into the corpus. This is the work that closes the gap ADR-001 left open — proj-cli currently warns about missing skills but ships only a placeholder install path (ADR-001 Task 21).

**Key Changes:**
- A 5-minute spike confirms Cursor loads skills through symlinks before any build (C-INST-1) ✅ GO
- **Two** corpus repos are established per ADR-001 (core + personal), bootstrapped via `proj-cli` on develop/nightly, and the global corpus is migrated + split into them
- An `installer.yaml` **multi-source** mapping + `~/.config/ai-workflow/` config home are defined (XDG-correct)
- A self-contained, idempotent, reversible `install.sh` ships in the core repo (Tier 2), enforcing the no-core→personal-dependency invariant
- The proj-cli install-guidance placeholder is replaced with real corpus + installer instructions
- Tier 3 (plugin marketplace publish) stays explicitly deferred until an external audience exists

---

## 🎯 Goals

1. **Verify before build** — confirm Cursor loads symlinked skills (or define the copy-mode fallback) before committing to the symlink farm.
2. **Corpus has a home** — the skill corpus lives in its own versioned repository, not as untracked global files.
3. **Zero-friction iteration (Tier 1)** — editing a skill in the corpus is immediately live in the editor (FR-DEV-1).
4. **One-command multi-machine (Tier 2)** — `git clone` + `./install.sh` produces a working setup on a fresh machine (the Linux-box scenario).
5. **Reversible & idempotent** — install/uninstall are safe to re-run and leave the corpus untouched (FR-INST-3, NFR-INST).
6. **ADR-001 gap closed** — proj-cli's install-guidance points at the real corpus + installer, not a placeholder.

---

## 📝 Implementation Plan

### Symlink Loading Spike
- [x] Task 1: Build a minimal symlink test fixture (symlink one skill into an editor path)
- [x] Task 2: Verify Cursor loads the symlinked skill in a live session; record go/no-go
- [x] Task 3: Define the copy-mode fallback if symlink discovery fails

### Corpus Repository Structure
- [ ] Task 4: Define layout + names for **both** core (`ai-workflow`) and personal (`ai-workflow-personal`) repos; classify the inventory via the ADR-001 boundary test
- [ ] Task 5: Bootstrap both repos via `proj-cli` on **develop/nightly**; pin the dev-infra + proj-cli develop SHAs used
- [ ] Task 6: Migrate + **split** the global corpus (core = general/durable or depended-on-by-core incl. `update-pr-description`; personal = `apprentice-*`, `ticket-*`, `capture-discussion`)
- [ ] Task 7: Per-repo README + versioning; mark the personal repo private

### Installer Mapping & XDG Config
- [ ] Task 8: Define the `installer.yaml` **multi-source** mapping schema (two source repos → editor paths)
- [ ] Task 9: Establish `~/.config/ai-workflow/` config home + example mapping (core + personal blocks)
- [ ] Task 10: Document XDG config vs corpus-project separation (Theme 10)

### Installer Script
- [ ] Task 11: Implement `install.sh` (read multi-source mapping, create symlinks, idempotent)
- [ ] Task 12: Implement uninstall (remove symlinks, leave corpora intact)
- [ ] Task 13: Add standard flags (`--dry-run`, `--force`, `--verbose`)
- [ ] Task 14: Implement the **"no core→personal references" check** at install (ADR-001 invariant)
- [ ] Task 15: Bats tests (install, uninstall, idempotency, copy-fallback, core→personal lint)

### Source Install & Multi-Machine (Tier 2)
- [ ] Task 16: One-command `git clone` + `./install.sh` flow — clones **both** repos (core public + personal private), handles private-repo auth
- [ ] Task 17: Fresh-machine validation (two-repo, private clone — end-to-end Linux-box scenario)
- [ ] Task 18: Replace the proj-cli install-guidance placeholder (ADR-001 Task 21) with real instructions

### Documentation & ADR Acceptance
- [ ] Task 19: Author install/uninstall + multi-machine guide
- [ ] Task 20: Cross-link from skill-template-separation + four-arm-architecture; note Tier 3 deferred + Claude int-opp
- [ ] Task 21: Move ADR-002 status 🔴 Proposed → ✅ Accepted

---

## ✅ Definition of Done

- [ ] All 21 tasks complete
- [ ] Spike outcome recorded with a go/no-go on symlinks (Group 1) ✅
- [ ] **Two** corpus repos exist (core + personal) per ADR-001, bootstrapped via proj-cli nightly with the pinned SHAs recorded
- [ ] Inventory split correctly (core incl. `update-pr-description`; personal incl. `apprentice-*`/`ticket-*`); no core→personal dependency
- [ ] `install.sh` is idempotent, reversible, multi-source, Bats-tested, and enforces the core→personal check
- [ ] A fresh-machine `clone → install` (both repos, private auth handled) produces a working corpus
- [ ] proj-cli install-guidance points at the real corpus + installer (ADR-001/skill-template-separation Task 21 placeholder retired)
- [ ] ADR-002 status moved 🔴 Proposed → ✅ Accepted
- [ ] CI/CD passing

---

## 🔗 Related

> ADR-002/003 were authored under the `skill-template-separation` (meta) feature and
> curated to develop alongside this plan. Their research artifacts live on the
> `docs/skill-template-separation-research` branch and may not resolve on develop.

- **Source ADR:** [ADR-002: Installation & Distribution Architecture](../../../../meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md)
- **Predecessor:** [ADR-001: Skill-Template Separation Model](../../../../meta/features/skill-template-separation/decisions/adr-001-separation-model.md) — completed; this plan closes its deferred installation gap
- **Downstream (separate plan):** [ADR-003: Per-Repo Profile Schema](../../../../meta/features/skill-template-separation/decisions/adr-003-per-repo-profile-schema.md) — its `~/.config/ai-workflow/repos/` symlink is installed by ADR-002's installer, but its schema/migration work gets its own implementation plan
- **Feature decision:** [ADR-001: Corpus Repository Split Model](../decisions/adr-001-corpus-repo-split-model.md) — core + personal two-repo split (shapes Group 2)
- **Corpus repo reference:** [corpus-repo-reference.md](corpus-repo-reference.md) — what the corpus repo is/contains/excludes (anchors Group 2)
- **Related exploration:** [skill-package-controller](../../../explorations/skill-package-controller/exploration.md) — the controller consumes the XDG config this installer establishes

---

**Last Updated:** 2026-06-09
