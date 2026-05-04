# Decision Two-Mode Pattern - Feature Plan

**Feature:** Apply Two-Mode Pattern to /decision  
**Priority:** 🟢 Low  
**Status:** 🟡 Planned  
**Created:** 2025-12-30  
**Source:** reflection-transition-plan-two-mode-2025-12-29.md

---

## 📋 Overview

Refactor `/decision` to use Setup + Expand pattern for ADR creation. This provides ADR scaffolding for review before detailed content is generated.

**Current State:**
- `/decision` creates full ADR in single pass
- No intermediate review checkpoint
- ADR structure may need adjustment after generation

**Target State:**
- Setup mode creates ADR scaffolding
- Expand mode fills in detailed content
- Human review between modes
- Consistent with other two-mode commands

---

## 🎯 Success Criteria

- [ ] `/decision [topic]` creates ADR scaffolding
- [ ] `/decision --expand [topic]` fills scaffolding with details
- [ ] ADR scaffolding includes structure but not full analysis
- [ ] Consistent UX with `/transition-plan` and `/explore`
- [ ] Documentation updated

---

## 📅 Implementation Phases

### Phase 1: Design (~1 hour)

**Goals:**
- Define ADR scaffolding vs expand content boundaries
- Identify what goes in scaffolding vs detailed sections

**Tasks:**
1. Review `/transition-plan` two-mode implementation
2. Define ADR scaffolding content (Context, Decision placeholder, Alternatives placeholder)
3. Define expand content (full analysis, consequences, implementation notes)
4. Document content boundaries

---

### Phase 2: Implementation (~2 hours)

**Goals:**
- Implement two-mode pattern in `/decision` command
- Update documentation

**Tasks:**
1. Update `/decision` command with setup mode (default)
2. Add `--expand` flag for detail expansion
3. Update command documentation
4. Test workflow

---

## ⚠️ Prerequisites

**Blocking:**
- `/explore` two-mode pattern must be complete first
- Learnings from `/explore` should inform this implementation

---

## 🔗 Related

- **Pattern Source:** `/transition-plan` command
- **Prerequisite:** `/explore` two-mode pattern

---

**Last Updated:** 2025-12-30

