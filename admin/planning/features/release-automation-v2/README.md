# Release Automation v2

**Purpose:** Complete the release automation system by eliminating remaining manual steps  
**Status:** 🟡 Planned  
**Priority:** 🔴 High  
**Target:** v1.5.0  
**Last Updated:** 2025-12-11

---

## 📋 Quick Links

### Planning Documents

- **[Feature Plan](feature-plan.md)** - Overview, goals, and success criteria
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress and immediate actions
- **[Phase 1: Tag Creation Automation](phase-1.md)** - Auto-create tags on release PR merge (🟡 Planned)
- **[Phase 2: Version Reference Automation](phase-2.md)** - Auto-update version references (🟡 Planned)
- **[Phase 3: Template Integration](phase-3.md)** - Add release commands to templates (🟡 Planned)

### Related

- **[v1.4.0 Retrospective](../../releases/v1.4.0/retrospective.md)** - Source of these improvements
- **[v1.4.0 Reflection](../../notes/reflections/reflection-v1.4.0-release-cycle-2025-12-11.md)** - Detailed analysis
- **[Release Readiness Feature](../release-readiness/README.md)** - v1.4.0 foundation (✅ Complete)

---

## 🎯 Overview

v1.4.0 introduced the Release Readiness system with automation for release assessment, but discovered several manual steps remain:

1. **Tag Creation** - Manual `git tag` and `git push` required
2. **Version References** - Manual scanning and updating of version numbers
3. **Template Gap** - Release automation only works in dev-infra, not generated projects

**Release Automation v2** closes these gaps to achieve **zero-manual releases**.

---

## 📊 Current vs. Target State

| Step | v1.4.0 (Current) | v1.5.0 (Target) |
|------|------------------|-----------------|
| Assessment | ✅ Automated | ✅ Automated |
| CHANGELOG | ✅ Automated | ✅ Automated |
| Release Notes | ✅ Automated | ✅ Automated |
| Version References | ❌ Manual scan/update | ✅ Automated |
| Release Branch | ✅ Automated | ✅ Automated |
| Release PR | ✅ Automated | ✅ Automated |
| **Tag Creation** | ❌ Manual | ✅ Automated |
| **Template Support** | ❌ Dev-infra only | ✅ All projects |

---

## 📅 Phase Overview

| Phase | Name | Effort | Priority |
|-------|------|--------|----------|
| 1 | Tag Creation Automation | 2-4 hours | 🔴 High |
| 2 | Version Reference Automation | 3-5 hours | 🔴 High |
| 3 | Template Integration | 8-13 hours | 🟡 Medium |
| **Total** | | **13-22 hours (2-3 days)** | |

---

## 🎯 Success Criteria

- [ ] Tags automatically created when release PRs merge to main
- [ ] Version references automatically updated by `/release-finalize`
- [ ] Generated projects include release automation
- [ ] Zero manual steps in release workflow
- [ ] v1.5.0 released using the new automation

---

## 🔗 Dependencies

**Builds On:**
- Release Readiness (v1.4.0) - Scripts and commands
- Command System (15+ commands) - Workflow automation
- Template System - Project generation

**Enables:**
- Future releases with zero manual intervention
- Template users get full release automation
- Consistent release process across all projects

---

**Last Updated:** 2025-12-11  
**Status:** 🟡 Planned  
**Next:** Begin Phase 1 - Tag Creation Automation

