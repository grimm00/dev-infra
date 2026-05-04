# Explore Two-Mode Pattern - Feature Plan

**Feature:** Apply Two-Mode Pattern to /explore  
**Priority:** 🔴 High  
**Status:** 🟡 Planned  
**Created:** 2025-12-30  
**Source:** reflection-transition-plan-two-mode-2025-12-29.md

---

## 📋 Overview

Refactor `/explore` to use Setup + Conduct pattern, mirroring `/research` and `/transition-plan`. This provides a natural human review checkpoint before detailed exploration begins.

**Current State:**
- `/explore` produces variable output sizes
- No intermediate review checkpoint
- Output can be overwhelming

**Target State:**
- Setup mode creates scaffolding (~60-80 lines)
- Conduct mode fills details (~200-300 lines)
- Human review between modes
- Predictable, consistent output

---

## 🎯 Success Criteria

- [ ] `/explore [topic]` creates exploration scaffolding
- [ ] `/explore --conduct [topic]` fills scaffolding with details
- [ ] Status indicator shows `🔴 Scaffolding` → `✅ Expanded`
- [ ] Output sizes are predictable (~60-80 lines setup, ~200-300 conduct)
- [ ] Consistent UX with `/research` and `/transition-plan`
- [ ] Documentation updated with new workflow

---

## 📅 Implementation Phases

### Phase 1: Exploration & Research (~1 hour)

**Goals:**
- Define scaffolding vs conduct content boundaries
- Identify structural mapping from `/research --conduct`
- Document design decisions

**Tasks:**
1. Review `/research` two-mode implementation
2. Identify 1:1 structural mapping for `/explore`
3. Define what goes in scaffolding vs conduct
4. Create ADR if significant decisions needed

**Deliverables:**
- Content boundary documentation
- Structural mapping table
- ADR (if needed)

---

### Phase 2: Implementation (~2 hours)

**Goals:**
- Implement two-mode pattern in `/explore` command
- Update documentation
- Test workflow

**Tasks:**
1. Update `/explore` command with setup mode (default)
2. Add `--conduct` flag for detail expansion
3. Add status indicators (`🔴 Scaffolding`, `✅ Expanded`)
4. Update command documentation
5. Test in dev-infra project
6. Copy to global commands location

**Deliverables:**
- Updated `/explore` command
- Documentation updates
- Tested workflow

---

## 🔗 Related

- **Pattern Source:** `/research` command (has `--conduct` mode)
- **Recent Implementation:** `/transition-plan` two-mode pattern
- **Learnings:** `admin/planning/opportunities/internal/dev-infra/learnings/transition-plan-two-mode/`

---

## 🚀 Next Steps

1. Create exploration for `/explore` two-mode pattern
2. Research scaffolding vs conduct content boundaries
3. Create ADRs if needed
4. Implement following transition-plan pattern

---

**Last Updated:** 2025-12-30

