# Research Topics - Dev-Infra Identity & Focus (v2)

**Purpose:** List of research topics/questions to investigate  
**Status:** 🟡 Active Research  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-22

---

## 📋 Research Topics

### Research Topic 1: Template Metadata System

**Question:** What metadata should dev-infra projects carry to enable sync and version tracking?

**Why:** Without metadata, we can't know what version a project was generated from or what sync rules apply.

**Priority:** High

**Status:** 🟡 Research Created → [admin/research/template-metadata/](../../research/template-metadata/README.md)

**Sub-questions:**
- What file format? (YAML, JSON, TOML)
- What information is essential vs nice-to-have?
- How to handle migration from projects without metadata?
- Where should the file live? (root, `.dev-infra/`, etc.)

---

### Research Topic 2: Sync System Architecture

**Question:** How should dev-infra sync updates to generated projects?

**Why:** Currently no way to push template improvements to existing projects.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Push vs pull model?
- Granularity: file-level, directory-level, or pattern-level?
- How to handle conflicts with user customizations?
- CLI tool vs script vs manual process?

**Options to explore:**
1. **Diff-based:** Show differences, user applies
2. **Merge-based:** Attempt automatic merge, flag conflicts
3. **Replace-based:** Replace syncable files entirely
4. **Checklist-based:** Generate checklist, user follows

---

### Research Topic 3: Customization Preservation

**Question:** How do we preserve intentional customizations during sync?

**Why:** Users will customize generated projects. Sync shouldn't destroy their work.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- How to detect intentional vs accidental changes?
- Should users mark files as "do not sync"?
- Should we track what was synced vs what was customized?
- How do other tools handle this? (e.g., Yeoman, create-react-app eject)

---

### Research Topic 4: External Project Adoption

**Question:** Is it worth supporting "adopt dev-infra in existing project"?

**Why:** Could expand dev-infra's usefulness, but may be complex.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- What's the complexity vs value trade-off?
- Could we do "scaffold mode" that's non-destructive?
- Should we just provide a migration guide instead?
- What existing projects would benefit? (work-prod, proj-cli, etc.)

---

### Research Topic 5: Version Compatibility

**Question:** How should we handle version compatibility between dev-infra and generated projects?

**Why:** Breaking changes in templates could affect many projects.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Semantic versioning for templates?
- How to communicate breaking changes?
- Should old projects auto-upgrade or stay at version?
- Migration scripts for major versions?

---

## 🏁 Resolved Topics

### ~~Research Topic 6: CLI vs Script Approach~~

**Question:** Should sync be a dedicated CLI tool or bash scripts?

**Resolution:** Use proj-cli. The existing proj-cli project (Python/Typer) already has:
- Work-prod API integration
- XDG-compliant configuration
- Rich terminal output
- Extensible command structure

New commands will be added to proj-cli:
- `proj new` - Create project from dev-infra template
- `proj sync` - Sync template updates
- `proj adopt` - Adopt dev-infra in existing project

**Status:** ✅ Resolved (2025-12-22)

**See:** [proj-cli-architecture exploration](https://github.com/grimm00/proj-cli/blob/develop/docs/maintainers/planning/explorations/proj-cli-architecture/exploration.md)

---

### ~~Research Topic: Graduation Process~~

**Question:** What criteria should determine when something becomes a template feature?

**Resolution:** Superseded by ADR-001 (Commands as Guides). No graduation - all templates get all commands.

**Status:** ✅ Resolved (2025-12-18)

---

### ~~Research Topic: Template Types~~

**Question:** How many template types should dev-infra support?

**Resolution:** Two types: `standard-project` and `learning-project`. Experimental template removed in v0.7.0.

**Status:** ✅ Resolved (2025-12-18)

---

## 🎯 Research Workflow

1. Use `/research [topic] --from-explore dev-infra-identity-and-focus` to conduct research
2. Research will create documents in `admin/research/dev-infra-identity-and-focus/`
3. After research complete, use `/decision [topic] --from-research` to make decisions

---

## 📊 Priority Matrix

| Topic | Priority | Complexity | Value | Status |
|-------|----------|------------|-------|--------|
| Template Metadata | High | Low | High | 🟡 Research Created |
| Sync System | High | High | High | 🔴 Not Started |
| Customization | High | Medium | High | 🔴 Not Started |
| External Adoption | Medium | High | Medium | 🔴 Not Started |
| Version Compat | Medium | Medium | Medium | 🔴 Not Started |
| ~~CLI vs Script~~ | ~~Low~~ | ~~Low~~ | ~~Low~~ | ✅ Resolved |

**Recommended Order:**
1. Template Metadata (foundational) - in progress
2. Sync System (depends on metadata)
3. Customization (depends on sync)
4. Version Compatibility (can parallelize)
5. External Adoption (optional, deferred)

**Note:** CLI vs Script resolved - using proj-cli as the CLI layer.

---

**Last Updated:** 2025-12-22
