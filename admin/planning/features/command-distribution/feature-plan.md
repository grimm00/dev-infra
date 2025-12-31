# Command Distribution - Feature Plan

**Feature:** Command Distribution System  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Priority:** High  
**Source:** [Four-Arm Architecture ADRs](../../../decisions/four-arm-architecture/README.md) (ADR-001, ADR-002, ADR-003)

---

## 📋 Overview

Implement a command distribution system that separates source ownership (dev-infra) from distribution ownership (dev-toolkit) for Cursor AI commands.

**Decision:** dev-infra remains the source owner of Cursor AI commands. dev-toolkit becomes the distribution owner via `dt-cursor-install`.

---

## 🎯 Success Criteria

- [ ] dev-infra releases include command bundle artifact (`commands-vX.Y.Z.tar.gz`)
- [ ] dev-toolkit provides `dt-cursor-install` command
- [ ] Users can install commands globally to `~/.cursor/commands/`
- [ ] Version pinning works (`--version` flag)
- [ ] Version listing works (`--list` flag)
- [ ] Update command works (`--update` flag)
- [ ] Command distribution standard documented
- [ ] All integrations verified as optional
- [ ] Configuration patterns documented

---

## 📅 Implementation Phases

### Phase 1: dev-infra Release Artifacts (~2-3 hrs)

**Goal:** Enable dev-infra releases to include downloadable command bundles.

**Deliverables:**
- Updated release workflow (CI)
- Command bundle in releases

**Tasks:**
- [ ] Update release workflow to bundle commands
- [ ] Test release artifact creation
- [ ] Document release artifact format

---

### Phase 2: dt-cursor-install Implementation (~4-6 hrs)

**Goal:** Create the `dt-cursor-install` command in dev-toolkit.

**Deliverables:**
- `bin/dt-cursor-install` script
- Installation documentation

**Tasks:**
- [ ] Implement core installation logic
- [ ] Add `--version` flag support
- [ ] Add `--list` flag support
- [ ] Add `--update` flag support
- [ ] Add `--status` flag support
- [ ] Add to installation documentation
- [ ] Test with dev-infra releases

---

### Phase 3: Documentation & Standard (~2-3 hrs)

**Goal:** Document the command distribution pattern as a standard.

**Deliverables:**
- `admin/planning/standards/command-distribution/` standard
- Updated user documentation

**Tasks:**
- [ ] Create command distribution standard (follow OpenAPI pattern)
- [ ] Update user documentation
- [ ] Add to global commands guide

---

### Phase 4: Integration Validation (~2-3 hrs)

**Goal:** Validate integration architecture meets ADR-003 requirements.

**Deliverables:**
- Integration validation checklist
- Configuration guidelines document

**Tasks:**
- [ ] Verify all integrations remain optional
- [ ] Test graceful degradation scenarios
- [ ] Document XDG configuration patterns
- [ ] Create integration guidelines

---

## 🔗 Dependencies

### Prerequisites

- dev-infra release workflow exists (✅ already in place)
- dev-toolkit has `dt-*` command pattern (✅ already in place)
- GitHub API access for release fetching

### Cross-Project Coordination

| Project | Changes Needed |
|---------|---------------|
| **dev-infra** | Phase 1 - Release workflow changes |
| **dev-toolkit** | Phase 2 - New command implementation |
| **dev-infra** | Phase 3 - Documentation |

---

## ⚠️ Constraints

- **C-CMD-1:** Commands MUST NOT be duplicated (source in dev-infra only)
- **C-CMD-2:** dev-toolkit MUST NOT modify command content
- **NFR-CMD-2:** Installation MUST NOT require cloning dev-infra

---

## 📚 Related Documents

- **[ADR-001](../../../decisions/four-arm-architecture/adr-001-command-distribution-ownership.md)** - Architecture decision
- **[Requirements](../../../research/four-arm-architecture/requirements.md)** - FR-CMD-1 through FR-CMD-6
- **[Research](../../../research/four-arm-architecture/research-command-distribution-ownership.md)** - Supporting research

---

**Last Updated:** 2025-12-31

