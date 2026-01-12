# Feature Transition Plan - Explore Two-Mode Enhancement

**Feature:** Explore Two-Mode Enhancement  
**Status:** 🔴 Not Started  
**Created:** 2026-01-10  
**Source:** [ADRs](../../../decisions/explore-two-mode/)  
**Type:** Feature

---

## Overview

Enhance the `/explore` command with:
1. Two-mode pattern (Setup + Conduct) per ADR-001
2. Multiple input sources (raw text, start.txt, reflections) per ADR-002
3. Lazy worktree integration per ADR-003
4. Consistent scaffolding boundaries per ADR-004

This positions `/explore` as the entry point for the ideation pipeline, transforming unstructured thoughts into structured exploration.

---

## Transition Goals

Based on [decisions-summary.md](../../../decisions/explore-two-mode/decisions-summary.md):

- [ ] Implement two-mode pattern with `--conduct` flag
- [ ] Support raw text as primary input source
- [ ] Add `--from-start` and `--from-reflect` flags
- [ ] Integrate lazy worktree creation on conduct mode
- [ ] Maintain ~60-80 lines setup, ~200-300 lines conduct
- [ ] Update templates with enhanced command
- [ ] Document command pipeline position

---

## Pre-Transition Checklist

- [x] ADRs created and reviewed
- [x] Requirements documented (24 FRs, 13 NFRs)
- [x] Research complete (7 topics)
- [ ] Phase breakdown approved
- [ ] Resources allocated

---

## Phase Summary

| Phase | Name | Focus | Effort | ADR |
|-------|------|-------|--------|-----|
| 1 | Command Structure | Two-mode pattern, `--conduct` flag | ~2 hours | ADR-001, ADR-004 |
| 2 | Input Sources | Raw text, `--from-start`, `--from-reflect` | ~2 hours | ADR-002 |
| 3 | Worktree Integration | Lazy creation, `--worktree`, `--no-worktree` | ~1.5 hours | ADR-003 |
| 4 | Template & Documentation | Template sync, docs, pipeline docs | ~1.5 hours | All |

**Total Estimated Effort:** ~7 hours

---

## Transition Steps

### Phase 1: Command Structure

**Goal:** Implement two-mode pattern with `--conduct` flag and scaffolding boundaries.

**Estimated Effort:** ~2 hours

**Prerequisites:**
- [x] ADR-001 (Two-Mode Pattern) approved
- [x] ADR-004 (Scaffolding Boundaries) approved

**Tasks:**
- [ ] Update explore.md with Setup Mode (default)
- [ ] Add `--conduct` flag for expansion
- [ ] Create exploration scaffolding template (~60-80 lines)
- [ ] Create conduct expansion template (~200-300 lines)
- [ ] Add status indicators (`🔴 Scaffolding` → `✅ Expanded`)
- [ ] Update exploration directory structure

**Deliverables:**
- Updated `.cursor/commands/explore.md`
- Scaffolding and conduct templates

**Definition of Done:**
- [ ] `/explore [topic]` creates scaffolding
- [ ] `/explore [topic] --conduct` expands scaffolding
- [ ] Status indicators show correctly
- [ ] Output sizes within bounds

---

### Phase 2: Input Sources

**Goal:** Support multiple input sources with raw text as primary.

**Estimated Effort:** ~2 hours

**Prerequisites:**
- [ ] Phase 1 complete
- [x] ADR-002 (Input Sources) approved

**Tasks:**
- [ ] Add raw text input handling (inline, file)
- [ ] Add `--from-start` flag for start.txt
- [ ] Add `--from-reflect` flag for reflections
- [ ] Implement theme organization from unstructured input
- [ ] Implement question extraction from input

**Deliverables:**
- Input source handling in explore.md
- Theme organization logic
- Question extraction logic

**Definition of Done:**
- [ ] `/explore "raw thoughts..."` works
- [ ] `/explore --from-start` reads start.txt
- [ ] `/explore --from-reflect [file]` reads reflections
- [ ] Themes and questions extracted from input

---

### Phase 3: Worktree Integration

**Goal:** Implement lazy worktree creation on conduct mode.

**Estimated Effort:** ~1.5 hours

**Prerequisites:**
- [ ] Phase 1 complete
- [x] ADR-003 (Worktree Integration) approved

**Tasks:**
- [ ] Add worktree prompt on `--conduct`
- [ ] Add `--worktree` flag for automatic creation
- [ ] Add `--no-worktree` flag to skip prompt
- [ ] Integrate with `scripts/worktrees.sh`
- [ ] Update command documentation

**Deliverables:**
- Worktree integration in explore.md
- Updated worktrees.sh (if needed)

**Definition of Done:**
- [ ] `/explore --conduct` prompts for worktree
- [ ] `/explore --conduct --worktree` creates automatically
- [ ] `/explore --conduct --no-worktree` skips prompt
- [ ] Worktree created follows naming convention

---

### Phase 4: Template & Documentation

**Goal:** Update templates and documentation.

**Estimated Effort:** ~1.5 hours

**Prerequisites:**
- [ ] Phase 1-3 complete

**Tasks:**
- [ ] Update standard-project template explore.md
- [ ] Update learning-project template explore.md
- [ ] Update template-sync-manifest.txt
- [ ] Create shared Two-Mode Pattern documentation
- [ ] Document command pipeline position
- [ ] Update CHANGELOG.md

**Deliverables:**
- Updated template commands
- Two-Mode Pattern documentation
- Pipeline documentation

**Definition of Done:**
- [ ] Templates have updated explore.md
- [ ] Template sync validates
- [ ] Documentation complete
- [ ] CHANGELOG updated

---

## Post-Transition

- [ ] Feature complete and tested
- [ ] All templates updated
- [ ] Documentation complete
- [ ] PR created and reviewed
- [ ] Merged to develop

---

## Definition of Done

- [ ] All 4 phases complete
- [ ] All 24 functional requirements addressed
- [ ] All 13 non-functional requirements addressed
- [ ] Templates updated and synced
- [ ] Documentation complete
- [ ] Tests passing (template validation)

---

## References

- [ADR-001: Two-Mode Pattern](../../../decisions/explore-two-mode/adr-001-two-mode-pattern.md)
- [ADR-002: Input Sources](../../../decisions/explore-two-mode/adr-002-input-sources.md)
- [ADR-003: Worktree Integration](../../../decisions/explore-two-mode/adr-003-worktree-integration.md)
- [ADR-004: Scaffolding Boundaries](../../../decisions/explore-two-mode/adr-004-scaffolding-boundaries.md)
- [Requirements](../../../research/explore-two-mode/requirements.md)
- [Research Summary](../../../research/explore-two-mode/research-summary.md)

---

**Last Updated:** 2026-01-10
