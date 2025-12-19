# Requirements - Template Metadata System

**Source:** Research on template metadata system  
**Status:** Final  
**Created:** 2025-12-18  
**Last Updated:** 2025-12-18

---

## 📋 Overview

This document captures requirements discovered during research on the template metadata system.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Comment Support

**Description:** Metadata file format must support inline comments for documentation and explanation.

**Source:** [research-file-format.md](research-file-format.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-2: Grep-Parseable Essential Fields

**Description:** Essential fields should be parseable without external dependencies (flat key-value structure).

**Source:** [research-file-format.md](research-file-format.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### FR-3: Template Type Field

**Description:** Metadata must include template type (standard-project, learning-project).

**Source:** [research-essential-fields.md](research-essential-fields.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-4: Version Field

**Description:** Metadata must include dev-infra version used for generation.

**Source:** [research-essential-fields.md](research-essential-fields.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-5: Creation Timestamp

**Description:** Metadata should include creation timestamp.

**Source:** [research-essential-fields.md](research-essential-fields.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-6: Sync Rule Configuration (Future)

**Description:** Metadata should support sync rule configuration (always, ask, never lists).

**Source:** [research-essential-fields.md](research-essential-fields.md)

**Priority:** Low (v2)

**Status:** 🔴 Deferred

---

### FR-7: Root Location

**Description:** Metadata file must be located at project root.

**Source:** [research-file-location.md](research-file-location.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-8: Standard Filename

**Description:** Metadata file must have a recognizable name (`.dev-infra.yml`).

**Source:** [research-file-location.md](research-file-location.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Git Tracked

**Description:** Metadata file must be tracked in git (not ignored).

**Source:** [research-file-location.md](research-file-location.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-10: Auto-Generate for New Projects

**Description:** New projects must automatically include metadata file.

**Source:** [research-migration-strategy.md](research-migration-strategy.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-11: Migration Documentation

**Description:** Migration documentation must be provided for existing projects.

**Source:** [research-migration-strategy.md](research-migration-strategy.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-12: Unknown Version Support

**Description:** Metadata schema must support "unknown" version for migrated projects.

**Source:** [research-migration-strategy.md](research-migration-strategy.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-13: Migrated Field

**Description:** Optional `migrated` field should indicate retrofit date for pre-metadata projects.

**Source:** [research-migration-strategy.md](research-migration-strategy.md)

**Priority:** Low

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Human Editable

**Description:** Format should be human-editable with standard text editors.

**Source:** [research-file-format.md](research-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Industry Standard Format

**Description:** Format should be familiar to developers (YAML is industry standard).

**Source:** [research-file-format.md](research-file-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-3: Extensible Schema

**Description:** Metadata schema must be extensible for future fields.

**Source:** [research-essential-fields.md](research-essential-fields.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-4: Minimal Essential Fields

**Description:** Essential fields should fit in under 5 lines for simplicity.

**Source:** [research-essential-fields.md](research-essential-fields.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-5: Consistent Location

**Description:** Location must be consistent across all template types.

**Source:** [research-file-location.md](research-file-location.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-6: No Special Tools for Migration

**Description:** Migration process must not require special tools (just text editor).

**Source:** [research-migration-strategy.md](research-migration-strategy.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Bash Tooling

**Description:** Dev-infra uses bash scripts. Metadata parsing must work with bash-available tools (yq, grep, sed).

**Source:** Dev-infra architecture

---

### C-2: Single User Context

**Description:** Currently single user; can make pragmatic decisions that wouldn't scale to many users.

**Source:** [Dev-Infra Identity Exploration v2](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

## 💭 Assumptions

### A-1: Single User Context

**Description:** Dev-infra currently has a single user (creator). Metadata system can be simpler and more opinionated.

**Source:** [Dev-Infra Identity Exploration v2](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

### A-2: Bash Script Ecosystem

**Description:** Dev-infra uses bash scripts for tooling. YAML with yq is acceptable dependency.

**Source:** Current dev-infra patterns

---

### A-3: Small Project Count

**Description:** Few existing projects need migration; manual process is acceptable.

**Source:** [research-migration-strategy.md](research-migration-strategy.md)

---

## 📊 Requirements Summary

| Category | Count | High Priority |
|----------|-------|---------------|
| Functional | 13 | 5 |
| Non-Functional | 6 | 3 |
| Constraints | 2 | - |
| Assumptions | 3 | - |

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Documents](README.md)
- [Dev-Infra Identity Exploration](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

## 🚀 Next Steps

1. Create ADR document based on these requirements
2. Use `/decision template-metadata --from-research` to formalize decisions
3. Implement in upcoming release

---

**Last Updated:** 2025-12-18
