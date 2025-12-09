# Phase 3: Assessment Structure

**Feature:** Release Readiness  
**Phase:** 3  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 2 Complete  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-09

---

## 🎯 Overview

Implement the hybrid checklist format for release readiness assessments. This phase connects the automation from Phase 2 with the standards from Phase 1 to generate a comprehensive assessment document.

**Success Definition:**
- A script exists to generate a filled-in assessment markdown file
- The generated file follows the standard template
- Automated checks pre-fill status (✅/❌)
- Manual sections are clearly marked for human review

---

## 🥅 Goals

1. Create assessment generation logic
2. Implement summary section with overall status calculation
3. Structure detailed evidence sections
4. Output a complete `RELEASE-READINESS.md` file

---

## 🏗️ Tasks

### 1. Implement Assessment Generator (TDD)

- [x] **RED:** Write test for generating the full markdown document structure
- [x] **GREEN:** Implement markdown generation in `scripts/check-release-readiness.sh` (or separate gen script)
- [x] **REFACTOR:** Separate logic for template filling

### 2. Implement Summary Calculation (TDD)

- [ ] **RED:** Write test for calculating "Overall Readiness" based on blocking criteria status
- [ ] **GREEN:** Add logic to determine if release is Ready, Needs Review, or Not Ready
- [ ] **REFACTOR:** Clarify logic for non-blocking vs blocking failures

### 3. Implement Evidence Sections (TDD)

- [ ] **RED:** Write test for including command output/logs in evidence sections
- [ ] **GREEN:** Capture validation details and embed in markdown (details/summary tags)
- [ ] **REFACTOR:** Ensure readable formatting

---

## ✅ Completion Criteria

- [ ] Script generates a valid markdown file
- [ ] Generated file matches Phase 1 template structure
- [ ] Automated results are correctly mapped to checklist items
- [ ] Summary accurately reflects readiness state

---

## 📦 Deliverables

- Assessment generation functionality
- Generated assessment examples

---

## 🔗 Related Documents

- [Feature Plan](../feature-plan.md)
- [Phase 2: Automation Approach](../phase-2.md)
- [Research: Assessment Structure](../../../../research/release-readiness/research-assessment-structure.md)

