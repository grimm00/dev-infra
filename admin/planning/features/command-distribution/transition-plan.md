# Command Distribution - Transition Plan

**Feature:** Command Distribution System  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Source:** [ADR-001: Command Distribution Ownership](../../../decisions/four-arm-architecture/adr-001-command-distribution-ownership.md)  
**Type:** Feature (Cross-Project)

---

## Overview

Transition from the current state (no global command installation mechanism) to the decided architecture (dev-infra as source owner, dev-toolkit as distribution owner via `dt-cursor-install`).

---

## Transition Goals

Based on ADR-001 decision and requirements:

- Implement command distribution without duplicating commands
- Enable global installation to `~/.cursor/commands/`
- Support version pinning, listing, and updates
- Document as a cross-arm standard

---

## Pre-Transition Checklist

- [x] ADR-001 approved
- [x] Requirements documented (FR-CMD-1 through FR-CMD-6)
- [ ] dev-infra release workflow understood
- [ ] dev-toolkit `dt-*` pattern understood

---

## Transition Steps

### Phase 1: dev-infra Release Artifacts

**Goal:** Enable dev-infra releases to include downloadable command bundles.

**Estimated Effort:** 2-3 hours

**Prerequisites:**
- [ ] Understand current release workflow
- [ ] Identify command source location

**Tasks:**
- [ ] Update release workflow to bundle commands
- [ ] Test release artifact creation
- [ ] Document release artifact format

**Deliverables:**
- Updated `.github/workflows/` release workflow
- Command bundle in test release

**Definition of Done:**
- [ ] Release workflow creates `commands-vX.Y.Z.tar.gz`
- [ ] Artifact is downloadable from GitHub release
- [ ] Format documented

**Details:** [phase-1.md](phase-1.md)

---

### Phase 2: dt-cursor-install Implementation

**Goal:** Create the `dt-cursor-install` command in dev-toolkit.

**Estimated Effort:** 4-6 hours

**Prerequisites:**
- [ ] Phase 1 complete (release artifacts available)
- [ ] dev-toolkit repository access

**Tasks:**
- [ ] Implement core installation logic
- [ ] Add `--version` flag support
- [ ] Add `--list` flag support
- [ ] Add `--update` flag support
- [ ] Add `--status` flag support
- [ ] Add to installation documentation
- [ ] Test with dev-infra releases

**Deliverables:**
- `bin/dt-cursor-install` script
- Updated installation docs

**Definition of Done:**
- [ ] `dt-cursor-install` installs latest commands
- [ ] All flags work (`--version`, `--list`, `--update`, `--status`)
- [ ] Installation documented

**Details:** [phase-2.md](phase-2.md)

---

### Phase 3: Documentation & Standard

**Goal:** Document the command distribution pattern as a standard.

**Estimated Effort:** 2-3 hours

**Prerequisites:**
- [ ] Phase 2 complete (command works)

**Tasks:**
- [ ] Create command distribution standard
- [ ] Update user documentation
- [ ] Add to global commands guide

**Deliverables:**
- `admin/planning/standards/command-distribution/` directory
- Updated user documentation

**Definition of Done:**
- [ ] Standard follows OpenAPI pattern (ownership matrix, process requirements)
- [ ] User documentation updated
- [ ] Global commands guide includes `dt-cursor-install`

**Details:** [phase-3.md](phase-3.md)

---

## Post-Transition

- [ ] All phases complete
- [ ] Feature implemented and tested
- [ ] Documentation updated
- [ ] Requirements marked as complete

---

## Definition of Done

- [ ] All 3 phases complete
- [ ] FR-CMD-1 through FR-CMD-6 satisfied
- [ ] NFR-CMD-1 through NFR-CMD-3 satisfied
- [ ] C-CMD-1, C-CMD-2 constraints satisfied
- [ ] Standard documented

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| GitHub API rate limiting | Low | Medium | Use authenticated requests |
| Release workflow complexity | Medium | Low | Test in dry-run first |
| Cross-repo coordination | Medium | Medium | Clear phase dependencies |

---

**Last Updated:** 2025-12-31

