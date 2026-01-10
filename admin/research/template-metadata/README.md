# Template Metadata System - Research Hub

**Purpose:** Research metadata system for dev-infra generated projects  
**Status:** ✅ Complete  
**Created:** 2025-12-18  
**Last Updated:** 2025-12-18

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings ⭐
- **[Requirements](requirements.md)** - 13 FRs, 6 NFRs discovered
- **[Research Documents](#research-documents)** - Individual research documents

### Research Documents

| Priority | Topic | Document | Status |
|----------|-------|----------|--------|
| 🔴 High | File Format | [research-file-format.md](research-file-format.md) | ✅ Complete |
| 🔴 High | Essential Fields | [research-essential-fields.md](research-essential-fields.md) | ✅ Complete |
| 🟡 Medium | File Location | [research-file-location.md](research-file-location.md) | ✅ Complete |
| 🟡 Medium | Migration Strategy | [research-migration-strategy.md](research-migration-strategy.md) | ✅ Complete |

---

## 🎯 Research Overview

This research supports the template metadata system, which is foundational to enabling:

1. **Template sync** - Push updates to generated projects
2. **Version tracking** - Know what version a project was generated from
3. **Customization tracking** - Know what files have been customized
4. **Project identification** - Match projects to templates

**Main Question:** What metadata should dev-infra projects carry to enable sync and version tracking?

**Source:** [Dev-Infra Identity & Focus Exploration v2](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

## 📊 Key Decisions

| Question | Answer |
|----------|--------|
| File Format | YAML (`.dev-infra.yml`) |
| Essential Fields | `template`, `version`, `created` |
| Location | Project root (dotfile) |
| Migration | Manual for v1, init command for v2 |

---

## 🚀 Next Steps

1. Use `/decision template-metadata --from-research` to create ADR
2. Implement metadata in upcoming release
3. Update `new-project.sh` to generate metadata file

---

## 🔗 Related

- [Dev-Infra Identity Exploration v2](../../explorations/dev-infra-identity-and-focus/exploration.md)
- [Research Topics](../../explorations/dev-infra-identity-and-focus/research-topics.md)

---

**Last Updated:** 2025-12-18
