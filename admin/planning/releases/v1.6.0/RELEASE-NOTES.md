# Release Notes - v1.6.0

**Version:** v1.6.0  
**Release Date:** 2025-12-XX  
**Status:** 🔴 Draft - Needs Review

---

## 🎉 Highlights

**Experimental Template** - A new template type for safely testing evolving commands before graduating them to the standard template.

This release introduces the **experimental-project** template, enabling teams to test new commands and features in a controlled environment with clear stability indicators and graduation criteria.

**Key additions:**
- 🧪 New `experimental-project` template type
- 🔄 CI drift detection to keep templates in sync
- 📊 Stability indicators (🟢/🟠/🔴) for command maturity
- 📝 Graduation checklist based on ADR-004

---

## ✨ New Features

### Experimental Project Template

A new template type that extends the standard project with support for evolving commands. Use this template when you want to:

- Test new commands before promoting them to stable
- Provide early access to new features
- Collect feedback on experimental functionality

**Usage:**

```bash
./scripts/new-project.sh

# Select option 3: experimental-project
# Acknowledge the stability warning with 'y'
```

**What's Included:**

- All standard-project features
- `/status` command (Evolving tier example)
- Stability indicators documentation
- Graduation checklist
- Feedback collection via GitHub issues

### CI Drift Detection

Automated validation ensures shared files stay in sync between `standard-project` and `experimental-project` templates.

```bash
# Validates template sync
./scripts/validate-template-sync.sh

# Or automatically in CI
# .github/workflows/test.yml includes sync validation
```

**Features:**

- Manifest-based shared file definition
- Clear error messages when drift detected
- Actionable fix instructions
- Comprehensive documentation (`docs/TEMPLATE-SYNC.md`)

### Stability Indicators

A three-tier system for communicating command maturity:

| Indicator | Meaning | Versioning |
|-----------|---------|------------|
| 🟢 **Stable** | Production-ready | Semantic versioning |
| 🟠 **Evolving** | Under development | May change without notice |
| 🔴 **Deprecated** | Scheduled for removal | Migration path provided |

---

## 🔧 Improvements

- **Test Suite Expansion** - 110+ tests (up from 94+)
- **TDD Best Practices** - Updated guidelines for Bats testing
- **Cursor Rules** - Added experimental template documentation

---

## 🐛 Bug Fixes

- **Test Assertions** - Strengthened assertions to catch regressions (PR #50, #51)
- **POSIX Compatibility** - Fixed string comparison in generator script (PR #52)
- **Documentation** - Grammar and formatting improvements

---

## 📚 Documentation

- **EXPERIMENTAL.md** - Guide for experimental features
- **STABILITY-LEVELS.md** - Stability level definitions
- **GRADUATION-CHECKLIST.md** - Criteria for promoting commands
- **TEMPLATE-SYNC.md** - Template synchronization documentation

---

## ⚠️ Breaking Changes

None in this release.

---

## 🔄 Migration Guide

No migration required. Existing projects continue to work without changes.

**To try the experimental template:**

```bash
./scripts/new-project.sh
# Select "experimental-project"
```

---

## 📊 Statistics

| Metric | Value |
|--------|-------|
| PRs Merged | 6 |
| Tests Added/Improved | 26 |
| New Scripts | 1 (`validate-template-sync.sh`) |
| Documentation Files | 4 |
| Fix Batches Completed | 3 |

---

## 🏭 Template Factory Progress

This release advances the **Template Factory** identity (ADR-001):

- **New Template Type** - Experimental template for safe command testing
- **Graduation Process** - Clear criteria for promoting features (ADR-004)
- **Quality Automation** - CI drift detection ensures template consistency

**Graduation Pipeline:**
```
Evolving Command (experimental-project)
    ↓ (meets ADR-004 criteria)
Stable Command (standard-project)
```

---

## 🙏 Acknowledgments

Thanks to all contributors and the Cursor AI assistance that made this release possible!

---

**Full Changelog:** [v1.5.0...v1.6.0](https://github.com/grimm00/dev-infra/compare/v1.5.0...v1.6.0)

