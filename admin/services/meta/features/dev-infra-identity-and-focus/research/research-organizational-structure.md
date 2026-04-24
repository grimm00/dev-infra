# Research: Organizational Structure

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** How should we restructure planning to reflect a template-centric identity?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

How should we restructure planning to reflect a template-centric identity? Current structure (`features/`, `ci/`, scattered) creates confusion about where things belong.

---

## 🔍 Research Goals

- [x] Goal 1: Analyze current planning structure
- [x] Goal 2: Identify organizational confusion points
- [x] Goal 3: Propose structure aligned with template-centric identity
- [x] Goal 4: Define placement rules for different work types

---

## 📊 Findings

### Finding 1: Current Planning Structure

```
admin/planning/
├── features/                    # Feature development
│   ├── release-readiness/       # ✅ Complete
│   └── release-automation-v2/   # 🟠 In Progress
├── ci/                          # CI/CD improvements
│   ├── multi-environment-testing/
│   ├── release-distribution/
│   ├── command-documentation-maintenance/
│   └── command-testing-automation/
├── releases/                    # Release management
│   ├── v0.4.0/
│   └── PROCESS.md
└── opportunities/              # Learnings from projects
    ├── external/
    └── internal/
```

### Finding 2: Confusion Points

**Where does tag automation belong?**
- CI/CD? (It's automation)
- Features? (It's a capability)
- Internal tooling? (It's for dev-infra only)

**Where do command improvements belong?**
- Features? (Commands are features)
- CI? (Command docs under ci/command-documentation-maintenance)
- Separate category? (Commands are unique)

**Where does template work belong?**
- Features? (Template changes are features)
- Separate templates/ directory?
- Mixed with other features?

### Finding 3: The Real Categories

**Analysis reveals 3 natural categories:**

| Category | Definition | Examples |
|----------|------------|----------|
| **Template Features** | Work that affects `templates/` | Command additions, structure changes |
| **Internal Tooling** | Dev-infra-only improvements | Release automation, validation scripts |
| **CI/CD Infrastructure** | Shared infrastructure | Testing workflows, Docker images |

### Finding 4: Proposed Structure (Template-Centric)

```
admin/planning/
├── templates/                   # Template-bound work
│   ├── features/               # Template features
│   │   ├── command-set-v2/     # Essential commands refinement
│   │   └── workflow-guides/    # User documentation
│   └── maintenance/            # Template upkeep
│       ├── sync-tracking/      # Template sync status
│       └── graduation/         # Graduation decisions
├── internal/                    # Dev-infra-only work
│   ├── tooling/                # Internal tools
│   │   ├── release-automation-v2/
│   │   └── validation-improvements/
│   └── workflow/               # Dev-infra workflow
│       └── command-experiments/
├── ci/                          # CI/CD (both internal and template)
│   ├── workflows/              # GitHub Actions
│   └── testing/                # Test infrastructure
├── releases/                    # Release management (unchanged)
└── opportunities/              # Learnings (unchanged)
```

### Finding 5: Alternative - Minimal Change

Instead of restructuring, add explicit categorization:

```markdown
# Feature Plan

**Category:** 🎯 Template Feature | 🔧 Internal Tooling | ⚙️ CI/CD
```

**Benefits:**
- No migration needed
- Explicit categorization
- Gradual adoption

**Drawbacks:**
- Confusion persists at directory level
- Relies on document metadata

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Structure Should Reflect Identity

If dev-infra is a "template factory":
- Template work should be prominent
- Internal tooling should be secondary
- Clear separation prevents confusion

### Insight 2: Migration Has Cost

Restructuring requires:
- Moving existing documents
- Updating cross-references
- Re-learning navigation
- Potential broken links

### Insight 3: Incremental Approach Is Safer

Recommended approach:
1. Add categorization metadata NOW
2. New work follows new structure
3. Migrate old work gradually
4. Full restructure in v2.0?

---

## 💡 Recommendations

**Option A: Full Restructure**
- High effort (1-2 days)
- Clear result
- Breaking change

**Option B: Metadata + New Structure for New Work**
- Low effort
- Gradual improvement
- No breaking change

**Recommendation: Option B (Metadata First)**

1. Add category metadata to existing plans
2. New features go in `admin/planning/templates/features/`
3. New internal tools go in `admin/planning/internal/tooling/`
4. Evaluate full restructure after v0.5.0

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-11:** All planning documents must have explicit category
- **FR-12:** Template features must be in template-specific location

### Non-Functional Requirements

- **NFR-9:** Structure changes should be incremental
- **NFR-10:** Template work should be visually prominent

---

## 🚀 Next Steps

1. Add category metadata to existing plans
2. Create `admin/planning/templates/` structure
3. Use new structure for v0.5.0 work

---

**Last Updated:** 2025-12-11

