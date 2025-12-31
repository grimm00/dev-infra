# Command Distribution - Phase 1: dev-infra Release Artifacts

**Phase:** 1 - dev-infra Release Artifacts  
**Duration:** ~2-3 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** None (first phase)

---

## 📋 Overview

Enable dev-infra GitHub releases to include downloadable command bundles that dev-toolkit can fetch for installation.

**Success Definition:** Release workflow creates `commands-vX.Y.Z.tar.gz` artifact downloadable from GitHub releases.

---

## 🎯 Goals

1. **Understand release workflow** - Review current `.github/workflows/` release configuration
2. **Create command bundle** - Package commands from `templates/standard-project/.cursor/commands/`
3. **Include in releases** - Attach bundle as release artifact

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan command-distribution --expand --phase 1` to add detailed tasks.

### Task Categories

- [ ] **Workflow Analysis** - Review current release workflow
- [ ] **Bundle Script** - Create script to package commands
- [ ] **Release Integration** - Update workflow to include bundle
- [ ] **Testing** - Verify artifact creation

---

## ✅ Completion Criteria

- [ ] Release workflow updated
- [ ] `commands-vX.Y.Z.tar.gz` created during release
- [ ] Artifact downloadable from GitHub release page
- [ ] Artifact format documented

---

## 📦 Deliverables

- Updated release workflow (`.github/workflows/release.yml` or similar)
- Command bundling script (optional, may be inline in workflow)
- Documentation of artifact format

---

## 🔗 Dependencies

### Prerequisites

- None (first phase)

### Blocks

- Phase 2: dt-cursor-install implementation (needs release artifacts)

---

## 📚 Requirements Addressed

| Requirement | Description |
|-------------|-------------|
| NFR-CMD-3 | Release artifacts - dev-infra MUST include commands in releases |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Next Phase: Phase 2](phase-2.md)

---

**Last Updated:** 2025-12-31  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan command-distribution --expand --phase 1`

