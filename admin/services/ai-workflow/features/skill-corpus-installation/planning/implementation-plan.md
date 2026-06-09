---
task_count: 19
groups:
  - name: "Symlink Loading Spike"
    file: "tasks/01-symlink-loading-spike.md"
    tasks: [1, 2, 3]
  - name: "Corpus Repository Structure"
    file: "tasks/02-corpus-repository-structure.md"
    tasks: [4, 5, 6]
  - name: "Installer Mapping & XDG Config"
    file: "tasks/03-installer-mapping-and-xdg-config.md"
    tasks: [7, 8, 9]
  - name: "Installer Script"
    file: "tasks/04-installer-script.md"
    tasks: [10, 11, 12, 13]
  - name: "Source Install & Multi-Machine (Tier 2)"
    file: "tasks/05-source-install-and-multi-machine.md"
    tasks: [14, 15, 16]
  - name: "Documentation & ADR Acceptance"
    file: "tasks/06-documentation-and-adr-acceptance.md"
    tasks: [17, 18, 19]
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
- A 5-minute spike confirms Cursor loads skills through symlinks before any build (C-INST-1)
- The corpus repository is established and the global corpus migrated into it
- An `installer.yaml` mapping + `~/.config/ai-workflow/` config home are defined (XDG-correct)
- A self-contained, idempotent, reversible `install.sh` ships in the corpus repo (Tier 2)
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
- [ ] Task 4: Define the corpus repo layout (`skills/`, `commands/`, `agents/`) and name
- [ ] Task 5: Initialize the corpus repo and migrate the global corpus into it
- [ ] Task 6: Add corpus README + independent versioning conventions

### Installer Mapping & XDG Config
- [ ] Task 7: Define the `installer.yaml` mapping schema (editor paths → corpus subdirs)
- [ ] Task 8: Establish `~/.config/ai-workflow/` config home + example mapping
- [ ] Task 9: Document XDG config vs corpus-project separation (Theme 10)

### Installer Script
- [ ] Task 10: Implement `install.sh` (read mapping, create symlinks, idempotent)
- [ ] Task 11: Implement uninstall (remove symlinks, leave corpus intact)
- [ ] Task 12: Add standard flags (`--dry-run`, `--force`, `--verbose`)
- [ ] Task 13: Bats tests (install, uninstall, idempotency, copy-fallback)

### Source Install & Multi-Machine (Tier 2)
- [ ] Task 14: One-command `git clone` + `./install.sh` flow
- [ ] Task 15: Fresh-machine validation (end-to-end Linux-box scenario)
- [ ] Task 16: Replace the proj-cli install-guidance placeholder (ADR-001 Task 21) with real instructions

### Documentation & ADR Acceptance
- [ ] Task 17: Author install/uninstall + multi-machine guide
- [ ] Task 18: Cross-link from skill-template-separation + four-arm-architecture; note Tier 3 deferred
- [ ] Task 19: Move ADR-002 status 🔴 Proposed → ✅ Accepted

---

## ✅ Definition of Done

- [ ] All 19 tasks complete
- [ ] Spike outcome recorded with a go/no-go on symlinks (Group 1)
- [ ] Corpus repo exists with the migrated corpus and a versioning convention
- [ ] `install.sh` is idempotent, reversible, and Bats-tested
- [ ] A fresh-machine `clone → install` produces a working corpus (multi-machine story proven)
- [ ] proj-cli install-guidance points at the real corpus + installer (ADR-001 Task 21 placeholder retired)
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
- **Corpus repo reference:** [corpus-repo-reference.md](corpus-repo-reference.md) — what the corpus repo is/contains/excludes (anchors Group 2)
- **Related exploration:** [skill-package-controller](../../../explorations/skill-package-controller/exploration.md) — the controller consumes the XDG config this installer establishes

---

**Last Updated:** 2026-06-09
