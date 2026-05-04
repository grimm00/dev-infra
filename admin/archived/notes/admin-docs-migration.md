# Admin Docs Migration to docs/maintainers/

**Purpose:** Document the plan to migrate admin documentation to `docs/maintainers/` structure  
**Status:** 🟡 Planned  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 📋 Overview

Dev-infra currently uses `admin/` directory for project management documentation, while templates use `docs/maintainers/` structure. This document tracks the plan to migrate admin docs to match the template structure for consistency.

---

## 🎯 Goals

1. **Consistency** - Align dev-infra structure with template structure
2. **Template Alignment** - Templates already use `docs/maintainers/` structure
3. **Standardization** - Single structure pattern across all projects

---

## 📊 Current State

**Current Structure (dev-infra):**
```
admin/
├── planning/
│   ├── features/
│   ├── ci/
│   └── releases/
├── feedback/
│   ├── sourcery/
│   └── bugbot/
├── research/
├── decisions/
└── notes/
```

**Target Structure (matching templates):**
```
docs/maintainers/
├── planning/
│   ├── features/
│   ├── ci/
│   └── releases/
├── feedback/
│   ├── sourcery/
│   └── bugbot/
├── research/
├── decisions/
└── notes/
```

---

## 🔄 Migration Plan

### Phase 1: Update Command Documentation

**Status:** 🟠 In Progress

- [x] Update `/pr-validation` command to note current location
- [ ] Update `/post-pr` command to note current location
- [ ] Update `/pr` command to note current location
- [ ] Update other commands that reference admin paths

### Phase 2: Create Migration Script

**Status:** 🔴 Not Started

- [ ] Create migration script to move files
- [ ] Update all internal references
- [ ] Update documentation links
- [ ] Test migration on branch

### Phase 3: Execute Migration

**Status:** 🔴 Not Started

- [ ] Create migration branch
- [ ] Run migration script
- [ ] Update all references
- [ ] Test template generation
- [ ] Create PR for review

### Phase 4: Update Templates

**Status:** 🔴 Not Started

- [ ] Verify templates already use `docs/maintainers/`
- [ ] Update template documentation if needed
- [ ] Test template generation

---

## 📝 Notes

**Current Feedback Location:**
- Dev-infra: `admin/feedback/sourcery/pr##.md`
- Templates: `docs/maintainers/feedback/sourcery/pr##.md`

**Commands Updated:**
- `/pr-validation` - Notes current location and future migration

**Impact:**
- Commands will need path detection updates
- All internal references need updating
- Documentation links need updating

---

## 🔗 Related

- [Template Structure](../../templates/standard-project/docs/maintainers/)
- [Command Documentation](../../.cursor/commands/)

---

**Last Updated:** 2025-12-07  
**Status:** 🟡 Planned  
**Next:** Continue updating command documentation, then create migration script

