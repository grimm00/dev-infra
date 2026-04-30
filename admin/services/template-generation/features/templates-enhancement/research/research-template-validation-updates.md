# Research: Template Validation Updates

**Research Topic:** Templates Enhancement  
**Question:** How should `validate-templates.sh` be updated to validate new structures? What checks are needed?  
**Status:** 🔴 Research  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 🎯 Research Question

How should `validate-templates.sh` be updated to validate new structures? What checks are needed?

---

## 🔍 Research Goals

- [ ] Goal 1: Understand current validation script functionality
- [ ] Goal 2: Identify validation checks needed for new structures
- [ ] Goal 3: Determine validation organization
- [ ] Goal 4: Identify validation best practices

---

## 📚 Research Methodology

**Sources:**
- [ ] Source 1: Current `scripts/validate-templates.sh` implementation
- [ ] Source 2: New structures analysis
- [ ] Source 3: Validation requirements
- [ ] Source 4: Testing patterns

---

## 📊 Findings

### Finding 1: Current Validation Script Functionality

**Finding:** `validate-templates.sh` currently checks:
- Template directory structure
- README.md files present
- Documentation links valid
- Required directories exist

**Source:** `scripts/validate-templates.sh` code analysis

**Relevance:** Validation script has good foundation, needs extension for new structures.

---

### Finding 2: Validation Checks Needed

**Finding:** New validation checks needed:
- Commands directory exists and has files
- CI/CD directory structure exists
- Exploration/research/decision directories exist
- Required README.md files exist
- Command files are valid markdown
- Template structure matches expected pattern

**Source:** New structures analysis

**Relevance:** Validation script needs these checks added.

---

### Finding 3: Validation Organization

**Finding:** Validation should be organized by structure type:
- Template structure validation
- Commands validation
- CI/CD structure validation
- Exploration/research/decision validation

**Source:** Validation best practices

**Relevance:** Validation script should be organized by structure type.

---

### Finding 4: Validation Best Practices

**Finding:** Validation should:
- Check structure completeness
- Validate file presence
- Check file format
- Report errors clearly

**Source:** Current validation script patterns

**Relevance:** New validation checks should follow same patterns.

---

## 🔍 Analysis

**Key Insights:**

- [ ] Insight 1: Validation script needs extension, not rewrite
- [ ] Insight 2: New validation checks should follow existing patterns
- [ ] Insight 3: Validation should be organized by structure type
- [ ] Insight 4: Validation should report errors clearly

---

## 💡 Recommendations

- [ ] Recommendation 1: Add validation checks for commands directory
- [ ] Recommendation 2: Add validation checks for CI/CD structure
- [ ] Recommendation 3: Add validation checks for exploration/research/decision structure
- [ ] Recommendation 4: Organize validation by structure type

---

## 📋 Requirements Discovered

- [ ] Requirement 1: Validation script must check commands directory
- [ ] Requirement 2: Validation script must check CI/CD structure
- [ ] Requirement 3: Validation script must check exploration/research/decision structure
- [ ] Requirement 4: Validation must be organized and clear

---

## 🚀 Next Steps

1. Add validation checks for new structures
2. Organize validation by structure type
3. Test validation script with new structures
4. Update validation documentation

---

**Last Updated:** 2025-12-07

