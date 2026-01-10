# Command Distribution - Transition Plan

**Feature:** Command Distribution System  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Source:** [Four-Arm Architecture ADRs](../../../decisions/four-arm-architecture/README.md) (ADR-001, ADR-002, ADR-003)  
**Type:** Feature (Cross-Project)

---

## Overview

Transition from the current state (no global command installation mechanism) to the decided architecture (dev-infra as source owner, dev-toolkit as distribution owner via `dt-cursor-install`).

---

## Transition Goals

Based on Four-Arm Architecture ADRs (ADR-001, ADR-002, ADR-003) and requirements:

- Implement command distribution without duplicating commands
- Enable global installation to `~/.cursor/commands/`
- Support version pinning, listing, and updates
- Document as a cross-arm standard (following OpenAPI pattern)
- Validate all integrations remain optional
- Document configuration patterns (XDG compliance)

---

## Pre-Transition Checklist

- [x] ADR-001 approved (Command Distribution Ownership)
- [x] ADR-002 approved (Contract Coordination Strategy)
- [x] ADR-003 approved (Integration Architecture)
- [x] Requirements documented (FR-CMD-*, FR-SC-*, FR-IP-*, NFR-IP-*)
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

### Phase 4: Integration Validation

**Goal:** Validate integration architecture meets ADR-003 requirements.

**Estimated Effort:** 2-3 hours

**Prerequisites:**
- [ ] Phase 2 complete (dt-cursor-install implemented)
- [ ] Phase 3 complete (standard documented)

**Tasks:**
- [ ] Verify all integrations remain optional
- [ ] Test graceful degradation scenarios
- [ ] Document XDG configuration patterns
- [ ] Create integration guidelines

**Deliverables:**
- Integration validation checklist
- Configuration guidelines document

**Definition of Done:**
- [ ] All tools work standalone without other arms
- [ ] Graceful error handling when integrations unavailable
- [ ] XDG configuration pattern documented
- [ ] Integration guidelines published

**Details:** [phase-4.md](phase-4.md)

---

## Post-Transition

- [ ] All phases complete
- [ ] Feature implemented and tested
- [ ] Documentation updated
- [ ] Requirements marked as complete

---

## Definition of Done

- [ ] All 4 phases complete
- [ ] FR-CMD-1 through FR-CMD-6 satisfied (ADR-001)
- [ ] NFR-CMD-1 through NFR-CMD-3 satisfied (ADR-001)
- [ ] C-CMD-1, C-CMD-2 constraints satisfied (ADR-001)
- [ ] FR-SC-4 satisfied - Standards pattern extension (ADR-002)
- [ ] NFR-IP-1 through NFR-IP-4 satisfied (ADR-003)
- [ ] C-IP-1, C-IP-2 constraints satisfied (ADR-003)
- [ ] Standard documented
- [ ] Integration guidelines documented

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| GitHub API rate limiting | Low | Medium | Use authenticated requests |
| Release workflow complexity | Medium | Low | Test in dry-run first |
| Cross-repo coordination | Medium | Medium | Clear phase dependencies |

---

**Last Updated:** 2025-12-31

