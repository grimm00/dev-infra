# Dev-Infra Identity & Focus - Exploration

**Status:** 🟠 Active Exploration (v2)  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-18

---

## 🎯 What Are We Exploring?

The fundamental question: **What should dev-infra be?**

### v2 Refinement (2025-12-18)

After completing the command simplification (v0.7.0) and migrating to 0.x.x versioning, we have new clarity:

**Key Realization:** There are no external users yet. The only user is the creator, and what's learned from using these templates informs further development. This changes everything.

**New Focus:** Infrastructure management for multiple scenarios, not pleasing a broad developer audience.

---

## 🎯 The Four Scenarios

### Scenario 1: New Projects (Primary)

**Need:** Projects that need an easily recognizable and familiar structure with workflow and pattern guidance.

**Current Support:** ✅ `./scripts/new-project.sh` generates from templates

**Opportunity:** Enhanced - tagging, better customization

---

### Scenario 2: External Project Sync (New)

**Need:** Projects NOT generated with dev-infra that want to adopt structure/patterns.

**Current Support:** ❌ None

**Approach Options:**
- "Scaffolding mode" - Add structure to existing project
- "Best effort" script - Compare and suggest additions
- "Adoption guide" - Manual checklist for migration

**Complexity:** High - must handle arbitrary existing structures

---

### Scenario 3: Dev-Infra Project Updates (New)

**Need:** Projects generated with dev-infra that need to sync new files/folders.

**Current Support:** ⚠️ Partial (template-sync validates, but doesn't update)

**Approach Options:**
- Automatic sync (triggered by version bump or manually)
- CLI patterns (`dev-infra sync`, `dev-infra update`)
- Diff-based update (show what changed, let user apply)

**Key Questions:**
- How to handle customizations in generated projects?
- What files should sync vs stay local?
- How to handle breaking structure changes?

---

### Scenario 4: Template Tagging (New)

**Need:** Each template needs metadata to help dev-infra and other dev-infra projects understand what kind of project it is.

**Current Support:** ❌ None

**Approach:**
- `.dev-infra.yml` or similar config file in generated projects
- Tags like: `template: standard-project`, `version: 0.7.0`, `type: application`
- Enables smart sync, version tracking, compatibility checks

---

## 🤔 Why This Shift?

### What We Learned

1. **Single User Reality**
   - No external users to satisfy
   - No need for complex graduation processes (removed in v0.7.0)
   - Can iterate quickly based on personal learnings

2. **Learning Loop**
   - Using templates reveals gaps
   - Gaps inform template improvements
   - Improvements enable better projects
   - Better projects reveal more gaps

3. **Infrastructure vs Features**
   - Less focus on "features for developers"
   - More focus on "infrastructure for project management"
   - The value is in structure and guidance, not tooling

---

## 💡 Initial Thoughts

### Template Metadata System

```yaml
# .dev-infra.yml (in generated projects)
template: standard-project
version: 0.7.0
created: 2025-12-18
last_sync: 2025-12-18

# What files to sync automatically
sync:
  always:
    - .cursor/commands/
    - .gitignore
  ask:
    - docs/maintainers/planning/
  never:
    - README.md
    - backend/
    - frontend/

# Project-specific overrides
customizations:
  - removed: .cursor/commands/status.md  # User removed intentionally
```

### Sync CLI Concept

```bash
# Check what's new in dev-infra
dev-infra status

# Sync specific files/patterns
dev-infra sync --commands  # Just commands
dev-infra sync --structure # Just directory structure
dev-infra sync --all       # Everything syncable

# Adopt dev-infra in existing project
dev-infra adopt --template standard-project --dry-run
dev-infra adopt --template standard-project --apply
```

### Version Compatibility Matrix

| Project Version | Dev-Infra Version | Sync Status |
|-----------------|-------------------|-------------|
| 0.6.0 | 0.7.0 | ⚠️ Breaking changes - manual review |
| 0.7.0 | 0.7.0 | ✅ In sync |
| 0.7.0 | 0.8.0 | 🔄 Updates available |

---

## 🔍 Key Questions

### Identity
- [x] Should dev-infra be primarily a template factory? **YES - decided in ADR-001**
- [ ] Should it also be an infrastructure manager? **Exploring**

### Sync System
- [ ] What's the minimum viable sync system?
- [ ] How to handle conflicts/customizations?
- [ ] Should sync be automatic or always manual?

### Template Metadata
- [ ] What metadata is essential?
- [ ] Where should it live? (`.dev-infra.yml`, `package.json`, etc.)
- [ ] How to handle version migrations?

### External Adoption
- [ ] Is "adopt existing project" worth the complexity?
- [ ] Or just focus on new projects + updates?

---

## 🎭 Identity Clarification

### What Dev-Infra IS (Confirmed)

1. **Template Factory** - Produces project templates
2. **Infrastructure Manager** - Helps projects stay in sync (exploring)
3. **Pattern Library** - Encodes workflow patterns in commands

### What Dev-Infra is NOT

1. ~~Feature Platform~~ - Not trying to build features for broad audiences
2. ~~Workflow Optimizer~~ - Not optimizing for complex scenarios
3. ~~Multi-User System~~ - Single user (for now), can scale later

---

## 🚀 Next Steps

1. **Research:** Investigate sync system approaches
2. **Prototype:** Simple `.dev-infra.yml` metadata file
3. **Decision:** ADR for sync system approach
4. **Implementation:** Minimum viable sync in v0.8.0 or v0.9.0

---

## 📝 Historical Notes

### v1 Exploration (2025-12-11)

The original exploration identified three identities:
1. Laboratory (Workflow Experimentation)
2. Factory (Template Production)
3. Reference Implementation (Dogfooding)

**Resolution:** v0.7.0 simplified to "Template Factory" with "Commands as Guides" philosophy.

### From v0.7.0 Command Simplification

- Removed experimental template
- All templates get all commands
- Graduation process archived
- ADR-001: Commands as Guides established

---

**Last Updated:** 2025-12-18
