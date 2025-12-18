# Command Simplification - Detailed Plan

**Purpose:** Implementation details for removing graduation overhead  
**Status:** 🟠 In Progress  
**Created:** 2025-12-17

---

## 📋 Context

### Why This Change

From chat-log-2025-12-17-proj-cli-command-sync.md:

> "I realize that all projects should have access to all commands, no matter the maturity. These commands aren't really commands, but guides, and so far, only internal projects (all orchestrated by me and those I give permission to) really use these."

### Key Insights

1. **Commands are AI guides** - Markdown instructions that guide AI assistants, not CLI tools
2. **Internal use only** - Only projects controlled by the maintainer use these
3. **No external users** - No public users choosing "stable" vs "experimental"
4. **Graduation overhead** - Time gates and checklists don't provide value

---

## 🎯 Goals

1. **Simplify** - Remove unnecessary complexity
2. **Unify** - All projects get all commands
3. **Clarify** - Document commands-as-guides philosophy
4. **Maintain** - Keep dev-infra internal tooling separate

---

## 📊 Current vs Proposed

### Current State

```
dev-infra/.cursor/commands/ (23 commands)
├── 18 "stable" commands → standard-project + experimental-project
├── 4 "internal" commands → dev-infra only
└── 1 "experimental" command → experimental-project only

Templates:
├── standard-project (18 commands)
├── experimental-project (19 commands) - has /status
└── learning-project (18 commands)
```

### Proposed State

```
dev-infra/.cursor/commands/ (23 commands)
├── 19 "template" commands → ALL templates
└── 4 "internal" commands → dev-infra only

Templates:
├── standard-project (19 commands) - includes /status
├── learning-project (19 commands) - includes /status
└── experimental-project (deprecated/merged)
```

---

## 📝 Implementation Details

### Phase 1: ADR & Documentation

**Create:** `admin/decisions/command-simplification/adr-001-commands-as-guides.md`

**Key points:**
- Commands are AI guidance, not CLI tools
- Internal projects only - no public users
- Graduation process was over-engineering
- All templates get all commands

**Update:** `admin/decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md`

- Add superseded header pointing to new ADR
- Mark status as "Superseded"

### Phase 2: Template Updates

**Add to standard-project:**
```
templates/standard-project/.cursor/commands/status.md
```

**Add to learning-project:**
```
templates/learning-project/.cursor/commands/status.md
```

**Update:** `scripts/template-sync-manifest.txt`
```
# Add status.md to stable commands
.cursor/commands/status.md

# Remove note about experimental-only
```

**Remove from experimental-project:**
```
docs/STABILITY-LEVELS.md
docs/GRADUATION-CHECKLIST.md
docs/EXPERIMENTAL.md
```

### Phase 3: Template Consolidation (Decision Required)

**Option A: Merge experimental → standard**
- Remove `templates/experimental-project/`
- Update `scripts/new-project.sh` to offer 2 types
- Update CI scripts
- Migration guide for existing users

**Option B: Keep experimental, same commands**
- Keep as template option
- Same command set as standard
- Different README messaging (more experimental-friendly)

### Phase 4: CI & Validation

**Update:** `scripts/validate-template-sync.sh`
- Remove experimental-specific validation
- Or update to validate all templates have same commands

**Update:** CI workflows
- Remove experimental-specific testing (if any)
- Ensure all templates validated equally

---

## 🗂️ Files Changed

### New Files

| File | Purpose |
|------|---------|
| `admin/decisions/command-simplification/adr-001-commands-as-guides.md` | New ADR |
| `admin/planning/features/command-simplification/README.md` | Feature hub |
| `admin/planning/features/command-simplification/feature-plan.md` | This file |

### Modified Files

| File | Change |
|------|--------|
| `admin/decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md` | Mark superseded |
| `templates/standard-project/.cursor/commands/status.md` | Add |
| `templates/learning-project/.cursor/commands/status.md` | Add |
| `scripts/template-sync-manifest.txt` | Add status.md, update comments |
| `.cursor/rules/main.mdc` | Update command documentation |

### Deleted/Archived Files

| File | Action |
|------|--------|
| `templates/experimental-project/docs/STABILITY-LEVELS.md` | Delete |
| `templates/experimental-project/docs/GRADUATION-CHECKLIST.md` | Delete |
| `templates/experimental-project/docs/EXPERIMENTAL.md` | Delete |
| `templates/experimental-project/` (optional) | Delete if merging |

---

## ⚠️ Breaking Changes

### For experimental-project users

If we merge templates:
- Existing `experimental-project` based repos keep working
- New projects use `standard-project`
- Migration: None required (files don't change)

### For graduation workflow

- `/status` no longer "experimental"
- No graduation checklist to fill out
- No stability indicators to update

---

## 📅 Timeline

| Phase | Estimated Effort | Priority |
|-------|------------------|----------|
| Phase 1: ADR | 30 min | High |
| Phase 2: Template Updates | 1 hour | High |
| Phase 3: Template Consolidation | 2 hours | Medium |
| Phase 4: CI Updates | 30 min | Medium |

**Total:** ~4 hours

---

## 🔗 Related

- [README](README.md) - Feature hub
- [chat-log-2025-12-17-proj-cli-command-sync.md](../../notes/chat-log-2025-12-17-proj-cli-command-sync.md) - Context
- [ADR-004](../../../decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md) - Superseded ADR

---

**Last Updated:** 2025-12-17


