# Work-Prod Opportunities

**Purpose:** Track learnings and improvement opportunities from work-prod project  
**Type:** Application (Work Product Tracking Tool)  
**Status:** ✅ Active  
**Created:** 2025-12-15  
**Last Updated:** 2025-12-15

---

## 📋 Quick Links

### Learnings

- **[Learnings Hub](learnings/README.md)** - Learnings from work-prod development
- **[Command Inventory](learnings/command-inventory.md)** - Current state of commands in both projects
- **[Documentation Structure Gaps](learnings/documentation-structure-gaps.md)** - Analysis of docs/maintainers structure gaps

### Improvements

- **[Improvements Hub](improvements/README.md)** - Improvements for work-prod
- **[Command Sync Opportunities](improvements/command-sync-opportunities.md)** - Commands to sync from dev-infra

---

## 🎯 Overview

Work-prod is a work product tracking application built using dev-infra templates. It serves as a proving ground for dev-infra patterns and commands.

**Project Context:**

- **Type:** Full-stack Application (Flask + Preact)
- **Technology Stack:** Python/Flask backend, Preact frontend, SQLite database
- **Purpose:** Track work products, projects, and productivity
- **Status:** Active Development

---

## 🔄 Relationship to Dev-Infra

Work-prod uses commands originally developed in dev-infra. The flow is:

```
Dev-Infra (Template Factory)
        │
        ├── Develops commands
        ├── Tests patterns
        ├── Graduates to templates
        │
        ▼
Work-Prod (Application Project)
        │
        ├── Uses template commands
        ├── Provides feedback
        └── Informs improvements
```

**Current State:**

| Metric | Value |
|--------|-------|
| Dev-Infra Commands | 23 |
| Work-Prod Commands | 14 |
| Missing in Work-Prod | 9 |

---

## 📊 Summary

**Learnings Documents:** 2  
**Improvement Documents:** 1  
**Status:** ✅ Active

---

**Last Updated:** 2025-12-16

