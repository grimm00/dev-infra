# Graduation Process Archive

**Process:** Command Graduation (Experimental → Stable)  
**Created:** v0.5.0 (as part of Template Factory identity)  
**Superseded:** v0.7.0 (by ADR-001: Commands as Guides)  
**Status:** 📦 Archived

---

## 📋 Overview

The graduation process was a system for promoting commands from "experimental" status to "stable" status based on maturity criteria.

**How it worked:**
1. New commands started in experimental template only
2. Commands tracked stability indicators (🟢/🟠/🔴)
3. Graduation checklist verified readiness
4. Graduated commands moved to standard template

---

## 🗂️ Contents

| File | Description |
|------|-------------|
| `adr-004-graduation-process.md` | Original ADR defining the graduation process |
| `graduation-checklist.md` | Template for graduation assessment |
| `research-graduation-criteria.md` | Research on criteria for graduation |

---

## ❓ Why Archived

**Decision:** [ADR-001: Commands as Guides](../../decisions/command-simplification/adr-001-commands-as-guides.md)

The graduation process was superseded because:
1. Commands are AI guidance documents, not CLI tools
2. They don't need the same stability guarantees as software APIs
3. Internal-only usage means no external users to protect
4. The process added overhead without proportional benefit

**New approach:** All templates receive all commands immediately. Commands serve as workflow guides for AI assistants.

---

## 🔗 Related

- [ADR-001: Commands as Guides](../../decisions/command-simplification/adr-001-commands-as-guides.md) - Superseding decision
- [ADR-004: Graduation Process](adr-004-graduation-process.md) - Original decision (superseded)

---

**Archived:** 2025-12-18

