# Template Restructure Research Hub

**Purpose:** Research and analysis for template structure improvements  
**Status:** 🔴 Research Phase  
**Last Updated:** 2025-01-27

---

## 📋 Quick Links

### Core Research Documents
- **[Template Generation Testing Automation](template-generation-testing-automation/README.md)** - Research on automating template generation testing (🔴 Research)
- **[Templates Enhancement](templates-enhancement/README.md)** - Research on template enhancements (🔴 Research)
- **[Comprehensive Analysis](template-restructure-comprehensive-analysis.md)** - ⭐ **START HERE** - Deep analysis combining internal best practices with external guidance
- **[Template Structure Options](template-structure-options.md)** - As-is vs proposed comparison
- **[Pre-ADR Proposal](0001-template-restructure-proposal.md)** - Initial proposal document

### Supporting Materials
- **[Structure Snapshots](structure-snapshots/)** - Current state tree diagrams
  - [Main Dev-Infra Project](structure-snapshots/dev-infra-main.tree.txt) - Complete project structure with all files
  - [Admin Structure](structure-snapshots/admin.tree.txt) - Admin directory structure
  - [Regular Project Template](structure-snapshots/regular-project.tree.txt) - Complete template structure with all files
  - [Learning Project Template](structure-snapshots/learning-project.tree.txt) - Complete template structure with all files

### Proposed Structure Snapshots
- **[Proposed Standard Project](structure-snapshots/standard-project-proposed.tree.txt)** - Proposed structure after restructure (admin/ → docs/maintainers/, renamed to standard-project)
- **[Proposed Learning Project](structure-snapshots/learning-project-proposed.tree.txt)** - Proposed structure after restructure (admin/ → docs/maintainers/)

---

## 🎯 Research Overview

This research evaluates the current template structure against:
- **Internal Best Practices:** Hub-and-spoke documentation patterns from `docs/BEST-PRACTICES.md`
- **External Industry Standards:** Documentation structure best practices, maintainer vs user doc separation
- **Current State:** Actual structure snapshots and usage patterns

### Key Research Questions

1. How should maintainer documentation be organized in templates?
2. Should templates use `admin/` or `docs/maintainers/` for maintainer docs?
3. What is the optimal naming for project templates?
4. How can we best combine internal best practices with external conventions?

---

## 📊 Research Findings Summary

### Current Issues Identified

1. **Mixed Audience:** `admin/` name doesn't clearly indicate maintainer/planning docs
2. **Naming Ambiguity:** "regular-project" is vague; "standard-project" is clearer
3. **Inconsistent Signals:** Templates mix maintainer and user-facing content
4. **Template Clarity:** Users may not understand `admin/` is for their own project planning

### Proposed Solution

**Hybrid Approach:** Combine internal hub-and-spoke patterns with external conventions

- **Templates:** Use `docs/maintainers/` instead of `admin/` for maintainer docs
- **Main Repo:** Keep `admin/` for now (established, working well)
- **Naming:** Rename `regular-project` → `standard-project`
- **Structure:** Maintain hub-and-spoke pattern within maintainer docs

### Key Benefits

- ✅ Clear audience separation (users vs maintainers)
- ✅ Industry-standard location (`docs/` universally recognized)
- ✅ Maintains internal hub-and-spoke best practices
- ✅ Better naming and clearer purpose

---

## 📚 Research Documents

### 1. Comprehensive Analysis
**File:** `template-restructure-comprehensive-analysis.md`

**Contents:**
- Executive summary
- Core principles analysis
- Current state deep dive
- External best practices research
- Proposed structure with detailed rationale
- Comparison tables (current vs proposed)
- Migration strategy outline

**Status:** ✅ Complete - Primary research document

### 2. Template Structure Options
**File:** `template-structure-options.md`

**Contents:**
- As-is vs proposed comparison
- Pros/cons analysis
- Open questions
- Next steps

**Status:** ✅ Complete - Quick reference

### 3. Pre-ADR Proposal
**File:** `0001-template-restructure-proposal.md`

**Contents:**
- Motivation and problem statement
- Options considered
- Evaluation criteria
- Proposed direction
- Migration notes

**Status:** ✅ Complete - Initial proposal

### 4. Structure Snapshots
**Directory:** `structure-snapshots/`

**Current State:**
- Tree diagrams of current structures with complete file listings
- Main dev-infra project structure (complete with all directories and files)
- Admin directory structure
- Regular project template structure (complete with all files)
- Learning project template structure (complete with all files)

**Proposed State:**
- Standard project proposed structure (shows admin/ → docs/maintainers/ migration)
- Learning project proposed structure (shows admin/ → docs/maintainers/ migration)

**Status:** ✅ Complete - Baseline and proposed structures documented

---

## 🎯 Research Methodology

### Sources Analyzed

**Internal:**
- `docs/BEST-PRACTICES.md` - Internal best practices guide
- `admin/notes/examples/hub-and-spoke-documentation-best-practices.md` - Hub-and-spoke pattern
- Current template structures
- Main repository structure

**External:**
- Industry documentation structure best practices
- Maintainer vs user documentation separation patterns
- Template structure best practices
- Open-source project documentation patterns

### Analysis Approach

1. **Current State:** Captured structure snapshots and analyzed existing patterns
2. **Best Practices:** Reviewed internal guidelines and external standards
3. **Gap Analysis:** Identified issues and opportunities
4. **Solution Design:** Proposed hybrid approach combining best of both
5. **Rationale:** Provided detailed justification for each decision

---

## ✅ Research Status

### Completed
- ✅ Structure snapshots captured
- ✅ Internal best practices analyzed
- ✅ External research conducted
- ✅ Comprehensive analysis document created
- ✅ Comparison and rationale documented
- ✅ Migration strategy outlined

### Pending Approval
- ⏳ Stakeholder review of comprehensive analysis
- ⏳ Decision on proposed structure
- ⏳ ADR creation upon approval
- ⏳ Implementation planning

---

## 🚀 Next Steps

1. **Review:** Stakeholders review comprehensive analysis
2. **Decision:** Approve or refine proposed structure
3. **ADR:** Create Architecture Decision Record
4. **Plan:** Develop detailed implementation plan
5. **Implement:** Execute restructure in release branch

---

## 📚 Related Documentation

- [Best Practices Guide](../../docs/BEST-PRACTICES.md) - Internal best practices
- [Hub-and-Spoke Guide](../notes/examples/hub-and-spoke-documentation-best-practices.md) - Pattern documentation
- [Template Usage Guide](../../docs/TEMPLATE-USAGE.md) - How templates are used

---

**Last Updated:** 2025-01-27  
**Status:** 🔴 Research Complete - Awaiting Approval  
**Primary Document:** [Comprehensive Analysis](template-restructure-comprehensive-analysis.md)


