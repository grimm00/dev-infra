# Template Restructure: Comprehensive Analysis & Recommendation

**Purpose:** Deep analysis combining internal best practices with external guidance to propose optimal template structure  
**Status:** 🔴 Research Phase  
**Created:** 2025-01-27  
**Last Updated:** 2025-01-27

---

## 📋 Executive Summary

This document analyzes the current template structure against:
- **Internal Best Practices:** `docs/BEST-PRACTICES.md` and `admin/notes/examples/hub-and-spoke-documentation-best-practices.md`
- **External Industry Standards:** Documentation structure best practices, maintainer vs user doc separation
- **Current State:** Structure snapshots in `admin/research/structure-snapshots/`

**Key Finding:** Current templates mix maintainer-facing documentation (`admin/`) with user-facing content, creating confusion about audience and purpose. A restructure aligning with hub-and-spoke principles and clear audience separation will improve discoverability and maintainability.

---

## 🎯 Core Principles (From Internal Best Practices)

### Hub-and-Spoke Documentation Pattern

**From `docs/BEST-PRACTICES.md`:**
- Every major directory needs a README.md hub
- Hub files serve as entry points with quick links
- Spoke documents are focused (< 400 lines, single purpose)
- Progressive disclosure: README → Plan → Phases → Analysis

**From `admin/notes/examples/hub-and-spoke-documentation-best-practices.md`:**
- Clear entry point (README.md) with quick links
- Focused documents (one purpose each)
- Separation of planning from results
- Archive, don't delete (preserve history)

### Audience Separation

**From External Best Practices:**
- Understand your audience: tailor documentation to technical proficiency
- Maintainer docs vs user docs should be clearly separated
- User-facing docs in `docs/` (conventional location)
- Maintainer-facing docs need clear location and purpose

---

## 📊 Current State Analysis

### Main Repository Structure

```
admin/
├── feedback/          # External review feedback (Sourcery, Bugbot)
├── notes/             # Planning notes and examples
├── planning/          # Feature planning, releases, CI/CD
│   ├── features/      # User-facing features
│   ├── releases/      # Release management
│   └── ci/            # CI/CD infrastructure
└── research/          # Decision documentation
```

**Observations:**
- ✅ Well-organized hub-and-spoke structure
- ✅ Clear separation of concerns (feedback, planning, research)
- ✅ Consistent with internal best practices
- ⚠️ Location name `admin/` may imply administrative-only content (but contains planning/features)

### Regular Project Template Structure

```
templates/regular-project/
├── admin/             # Maintainer docs (planning, features)
│   └── planning/
│       └── features/
├── backend/           # Backend application
├── docs/              # User documentation
├── frontend/          # Frontend application
├── scripts/           # Automation
└── tests/             # Testing
```

**Issues Identified:**
1. **Mixed Audience:** `admin/` contains maintainer docs but name suggests administrative-only
2. **Inconsistent with Main Repo:** Main repo uses `admin/` for maintainer docs, but templates should guide users
3. **Template Clarity:** Users may not understand `admin/` is for their own project planning
4. **Naming Ambiguity:** "regular-project" is vague; "standard-project" is clearer

### Learning Project Template Structure

```
templates/learning-project/
├── admin/             # Learning management (notes, planning, research)
│   ├── notes/
│   ├── planning/
│   └── research/
├── practice-apps/     # Hands-on practice
├── reference/         # Quick reference
└── stage*-*/          # Learning stages
```

**Issues Identified:**
1. **Same Mixed Audience Issue:** `admin/` name doesn't clearly indicate maintainer/planning docs
2. **Learning-Specific Context:** Learning projects may benefit from different structure than standard projects

---

## 🔍 External Best Practices Analysis

### Documentation Structure Patterns

**Industry Standard:**
- `docs/` folder is universally recognized for user-facing documentation
- Maintainer/developer docs often in separate locations:
  - `docs/maintainers/` or `docs/contributing/` (common in open source)
  - `.github/` for GitHub-specific maintainer docs
  - `admin/` less common, often implies system administration

**Audience Separation:**
- **User Docs:** How to use the software, API references, guides
- **Maintainer Docs:** Planning, decisions, feedback, internal processes

**Template Best Practices:**
- Templates should surface only essential structure
- Remove operational directories that aren't part of the template
- Clear naming that indicates purpose

---

## 💡 Proposed Structure: Hybrid Approach

### Principle: Combine Internal Hub-and-Spoke with External Conventions

**Key Decisions:**
1. **Templates:** Use `docs/maintainers/` instead of `admin/` for maintainer docs
2. **Main Repo:** Keep `admin/` for now (established, working well)
3. **Naming:** Rename `regular-project` → `standard-project` (clearer purpose)
4. **Cleanup:** Remove non-template operational directories

### Proposed Template Structure

#### Standard Project Template

```
templates/standard-project/
├── docs/
│   ├── README.md              # 📍 HUB - User documentation entry point
│   ├── guides/                # User guides
│   ├── api/                   # API documentation
│   └── maintainers/           # 📍 HUB - Maintainer docs entry point
│       ├── README.md          # Maintainer hub with quick links
│       ├── planning/          # Feature planning, releases
│       │   ├── features/      # User-facing features
│       │   ├── releases/      # Release management
│       │   └── ci/            # CI/CD infrastructure
│       ├── decisions/         # Architecture decisions (ADRs)
│       ├── feedback/          # External review feedback
│       └── archived/          # Historical documentation
├── backend/
├── frontend/
├── scripts/
└── tests/
```

**Benefits:**
- ✅ Clear separation: `docs/` for users, `docs/maintainers/` for maintainers
- ✅ Follows external convention (`docs/` is standard)
- ✅ Maintains hub-and-spoke pattern within maintainers
- ✅ Users see `docs/` first (their entry point)
- ✅ Maintainers have dedicated space with clear purpose

#### Learning Project Template

```
templates/learning-project/
├── docs/
│   ├── README.md              # 📍 HUB - Learning documentation
│   └── maintainers/           # 📍 HUB - Learning management
│       ├── README.md          # Maintainer hub
│       ├── planning/          # Learning path planning
│       ├── notes/             # Learning notes
│       └── research/          # Learning research
├── practice-apps/
├── reference/
└── stage*-*/
```

**Benefits:**
- ✅ Consistent structure with standard-project
- ✅ Learning-specific maintainer docs clearly separated
- ✅ Maintains hub-and-spoke pattern

---

## 📈 Comparison: Current vs Proposed

### Current Structure Issues

| Issue | Impact | Severity |
|-------|--------|----------|
| `admin/` name ambiguity | Users may not understand it's for their planning | Medium |
| Mixed audience signals | Unclear who docs are for | Medium |
| Inconsistent with industry | `docs/` is standard for user docs | Low |
| "regular-project" naming | Vague, doesn't indicate purpose | Low |
| Operational dirs in templates | Noise for template consumers | Low |

### Proposed Structure Benefits

| Benefit | Impact | Priority |
|---------|--------|----------|
| Clear audience separation | Users vs maintainers clearly distinguished | High |
| Industry-standard location | `docs/` universally recognized | Medium |
| Maintains hub-and-spoke | Internal best practices preserved | High |
| Better naming | "standard-project" is clearer | Medium |
| Cleaner templates | Only essential structure | Medium |

---

## 🎯 Detailed Rationale

### 1. Why `docs/maintainers/` Instead of `admin/`?

**Rationale:**
- **External Convention:** `docs/` is the standard location for documentation
- **Audience Clarity:** `docs/maintainers/` clearly indicates maintainer-facing content
- **Progressive Discovery:** Users naturally look in `docs/` first
- **Consistency:** Both user and maintainer docs under same parent (`docs/`)
- **Industry Alignment:** Matches patterns in major open-source projects

**Counter-argument (Keep `admin/`):**
- Main repo already uses `admin/` (consistency)
- `admin/` is shorter
- Established pattern in this project

**Decision:** Use `docs/maintainers/` in templates because:
1. Templates guide new projects (should follow industry standards)
2. Clearer for users discovering the structure
3. Main repo can evolve separately if needed

### 2. Why Keep `admin/` in Main Repo?

**Rationale:**
- **Established Pattern:** Already working well, extensive structure
- **Low Risk:** Main repo is internal, templates are external-facing
- **Gradual Evolution:** Can migrate later if needed
- **Different Context:** Main repo is the template source, not a template itself

### 3. Why Rename `regular-project` → `standard-project`?

**Rationale:**
- **Clarity:** "standard" indicates a standard/typical project structure
- **Purpose:** Better describes the template's intent
- **Naming Convention:** More descriptive than "regular"
- **Industry Alignment:** "standard" is commonly used in templates

**Impact:**
- Requires updating `scripts/new-project.sh` (line 651: `template_type="regular-project"`)
- Low risk, single reference point

### 4. Why Remove Operational Directories?

**Rationale:**
- **Template Clarity:** Templates should show structure, not operational artifacts
- **User Focus:** Users don't need `migrations/` or `project-index/` in template
- **Cleaner Surface:** Less noise, clearer purpose
- **Best Practice:** Templates should be minimal and focused

**Note:** These directories may be created by users as needed, but shouldn't be in the template.

---

## 🔄 Migration Strategy (Future Implementation)

### Phase 1: Template Restructure
1. Rename `templates/regular-project/` → `templates/standard-project/`
2. Move `admin/` → `docs/maintainers/` in both templates
3. Create hub READMEs in `docs/maintainers/` following hub-and-spoke pattern
4. Remove operational directories (`migrations/`, `project-index/` if present)
5. Update `scripts/new-project.sh` to reference `standard-project`

### Phase 2: Documentation Updates
1. Update template READMEs to reflect new structure
2. Update `docs/BEST-PRACTICES.md` with new structure examples
3. Create migration guide for existing projects (if needed)

### Phase 3: Main Repo Consideration (Optional, Future)
1. Evaluate moving main repo `admin/` → `docs/maintainers/`
2. Consider impact on existing workflows
3. Make decision based on team preference

---

## 📊 Alignment Check

### Internal Best Practices Alignment

| Principle | Current | Proposed | Status |
|-----------|---------|----------|--------|
| Hub-and-spoke pattern | ✅ Yes | ✅ Yes | Maintained |
| Focused documents | ✅ Yes | ✅ Yes | Maintained |
| Progressive disclosure | ✅ Yes | ✅ Yes | Maintained |
| Clear entry points | ⚠️ Partial | ✅ Yes | Improved |
| Audience separation | ❌ No | ✅ Yes | Improved |

### External Best Practices Alignment

| Practice | Current | Proposed | Status |
|----------|---------|----------|--------|
| `docs/` for user docs | ✅ Yes | ✅ Yes | Maintained |
| Clear maintainer doc location | ⚠️ Partial | ✅ Yes | Improved |
| Industry-standard naming | ⚠️ Partial | ✅ Yes | Improved |
| Minimal template structure | ⚠️ Partial | ✅ Yes | Improved |

---

## 🎯 Recommendation

### Primary Recommendation: Implement Proposed Structure

**Rationale:**
1. **Combines Best of Both:** Internal hub-and-spoke + external conventions
2. **Clear Audience Separation:** Users vs maintainers clearly distinguished
3. **Industry Alignment:** Follows standard documentation patterns
4. **Maintains Internal Patterns:** Hub-and-spoke structure preserved
5. **Low Risk:** Templates are external-facing, main repo unchanged

### Implementation Priority

1. **High Priority:**
   - Move `admin/` → `docs/maintainers/` in templates
   - Create hub READMEs following hub-and-spoke pattern
   - Rename `regular-project` → `standard-project`

2. **Medium Priority:**
   - Remove operational directories from templates
   - Update documentation to reflect new structure

3. **Low Priority (Future):**
   - Consider main repo `admin/` → `docs/maintainers/` migration
   - Evaluate additional structure improvements

---

## 📚 References

### Internal Documents
- `docs/BEST-PRACTICES.md` - Internal best practices guide
- `admin/notes/examples/hub-and-spoke-documentation-best-practices.md` - Hub-and-spoke pattern guide
- `admin/research/structure-snapshots/` - Current structure snapshots

### External Research
- Industry documentation structure best practices
- Maintainer vs user documentation separation patterns
- Template structure best practices

---

## ✅ Next Steps

1. **Review & Approval:** Get stakeholder approval for proposed structure
2. **Create ADR:** Document decision in Architecture Decision Record format
3. **Implementation Plan:** Create detailed implementation plan with phases
4. **Testing:** Test template generation with new structure
5. **Documentation:** Update all relevant documentation

---

**Last Updated:** 2025-01-27  
**Status:** 🔴 Research Complete - Awaiting Approval  
**Next:** Create ADR and implementation plan upon approval

