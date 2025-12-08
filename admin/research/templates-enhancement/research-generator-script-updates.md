# Research: Generator Script Updates

**Research Topic:** Templates Enhancement  
**Question:** How should `new-project.sh` be updated to include new structures? What validation is needed?  
**Status:** 🔴 Research  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 🎯 Research Question

How should `new-project.sh` be updated to include new structures? What validation is needed?

---

## 🔍 Research Goals

- [ ] Goal 1: Understand current generator script functionality
- [ ] Goal 2: Identify what new structures need to be included
- [ ] Goal 3: Determine validation requirements
- [ ] Goal 4: Identify testing needs

---

## 📚 Research Methodology

**Sources:**
- [ ] Source 1: Current `scripts/new-project.sh` implementation
- [ ] Source 2: Template structure analysis
- [ ] Source 3: Validation script analysis
- [ ] Source 4: Command integration requirements

---

## 📊 Findings

### Finding 1: Current Generator Script Functionality

**Finding:** `new-project.sh` currently:
- Copies template directory
- Customizes project files (README.md, start.txt)
- Initializes git repository
- Creates GitHub repository (optional)

**Source:** `scripts/new-project.sh` code analysis

**Relevance:** Script already handles template copying, just needs to ensure new structures are included.

---

### Finding 2: New Structures to Include

**Finding:** New structures that need to be included:
- `.cursor/commands/` directory with all 17 commands
- `docs/maintainers/planning/ci/` directory
- `docs/maintainers/planning/explorations/` directory
- `docs/maintainers/research/` directory
- `docs/maintainers/decisions/` directory

**Source:** Template enhancement analysis

**Relevance:** Generator script needs to ensure these directories are copied from templates.

---

### Finding 3: Validation Requirements

**Finding:** Validation script should check:
- Commands directory exists and has files
- CI/CD directory structure exists
- Exploration/research/decision directories exist
- Required README.md files exist

**Source:** Validation requirements analysis

**Relevance:** Validation script needs updates to check new structures.

---

### Finding 4: Testing Needs

**Finding:** Generator script needs testing for:
- New directory structures are copied
- Commands are included
- CI/CD structure is included
- Exploration/research/decision structure is included

**Source:** Testing requirements analysis

**Relevance:** Test suite needs updates to validate new structures.

---

## 🔍 Analysis

**Key Insights:**

- [ ] Insight 1: Generator script already copies templates - new structures just need to be in templates
- [ ] Insight 2: No script changes needed if templates include new structures
- [ ] Insight 3: Validation script needs updates to check new structures
- [ ] Insight 4: Test suite needs updates to validate new structures

**Script Updates:**
- Minimal changes needed - script copies templates as-is
- Validation script needs updates
- Test suite needs updates

---

## 💡 Recommendations

- [ ] Recommendation 1: No generator script changes needed - templates include new structures
- [ ] Recommendation 2: Update validation script to check new structures
- [ ] Recommendation 3: Update test suite to validate new structures
- [ ] Recommendation 4: Document new structures in generator script comments

---

## 📋 Requirements Discovered

- [ ] Requirement 1: Templates must include all new structures
- [ ] Requirement 2: Validation script must check new structures
- [ ] Requirement 3: Test suite must validate new structures
- [ ] Requirement 4: Generator script documentation must be updated

---

## 🚀 Next Steps

1. Ensure templates include all new structures
2. Update validation script to check new structures
3. Update test suite to validate new structures
4. Update generator script documentation

---

**Last Updated:** 2025-12-07

