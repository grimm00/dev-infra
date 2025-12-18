# Release Notes - v0.7.0

**Release Date:** 2025-12-18  
**Release Type:** Minor (Breaking Changes)  
**Status:** ✅ Released

---

## 🎯 Release Highlights

### Command Simplification

All templates now receive all 19 workflow commands. The graduation process has been removed in favor of treating commands as AI guides rather than CLI tools.

### Version Migration

Project versioning migrated from 1.x.x to 0.x.x to better reflect the project's exploratory development stage.

---

## ⚠️ Breaking Changes

### Template Changes

- **Removed:** `experimental-project` template (functionality merged into standard-project)
- **Changed:** All templates now have all commands (no graduation gates)
- **Superseded:** ADR-004 (Graduation Process) replaced by ADR-001 (Commands as Guides)

### Version Scheme Change

All version numbers changed from 1.x.x to 0.x.x:

| Old | New |
|-----|-----|
| 1.6.0 | 0.6.0 |
| 1.5.0 | 0.5.0 |
| 1.4.0 | 0.4.0 |
| 1.3.0 | 0.3.0 |
| 1.2.0 | 0.2.0 |
| 1.1.0 | 0.1.1 |
| 1.0.0 | 0.1.0 |

---

## ✨ New Features

### Commands as Guides (ADR-001)

- All 19 workflow commands now available in all templates
- Commands are AI guidance, not CLI tools
- No graduation process - all commands are guides

### Template Simplification

- 2 template types: `standard-project` and `learning-project`
- Generator script updated for 2 templates
- Template sync validation updated

---

## 📊 Statistics

- **Files Changed:** 169
- **Tests:** 173 passing
- **Template Types:** 2 (down from 3)
- **Commands per Template:** 19 (all templates equal)

---

## 🔗 Related

- [ADR-001: Commands as Guides](../../../decisions/command-simplification/adr-001-commands-as-guides.md)
- [CHANGELOG](../../../../CHANGELOG.md)

---

**Last Updated:** 2025-12-18

