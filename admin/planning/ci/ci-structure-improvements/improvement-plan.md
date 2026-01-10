# CI Structure Improvements - Improvement Plan

**Improvement:** CI Folder Structure & Organization  
**Priority:** 🟡 Medium  
**Effort:** 🟡 Moderate (can be bundled with major release)  
**Status:** 🔴 Not Started  
**Created:** 2025-12-30  
**Source:** reflection-template-sync-drift-fix-2025-12-30.md

---

## 📋 Overview

This improvement plan consolidates several related CI organization suggestions from the template-sync-drift-fix reflection. These improvements are candidates for bundling with a major release rather than separate PRs.

**Key Insight:** Simple organizational fixes don't always need their own PRs - they can be bundled with larger releases for efficiency.

---

## 🎯 Improvement Goals

### 1. CI Fix vs Improvement Classification

**Issue:** No clear guidance on when to classify CI work as "improvement" vs "fix".

**Solution:** Add classification guidance to CI README:

| Classification | Criteria | Structure |
|----------------|----------|-----------|
| **Fix** | < 1 hour, single PR, resolves bug | Simple tracking in release notes |
| **Improvement** | > 1 hour, new capability, multi-PR | Full hub directory |

**Effort:** 🟢 Quick (15 min)

### 2. CI Fixes Subdirectory (Optional)

**Issue:** Simple fixes (< 1 hour) currently get full hub-and-spoke structure.

**Solution:** Create `ci/fixes/` subdirectory for simple fixes with single-file documentation.

**Note:** This may be lower priority - consider whether simple fixes should just be tracked in release notes/changelogs rather than having their own documentation.

**Effort:** 🟢 Quick (30 min)

### 3. CI Folder Organization (Future)

**Issue:** 14 directories with varying complexity, status, and relevance.

**Possible Structure:**
```
ci/
├── active/              # Currently in progress
├── planned/             # Approved but not started
├── completed/           # Historical reference
├── fixes/               # Quick fixes (simpler structure)
└── README.md            # Status overview
```

**Note:** This is a larger restructure that should be considered as part of the broader project restructure that's still pending.

**Effort:** 🟠 Significant (2-3 hrs)

---

## 📊 Bundling Strategy

### Why Bundle with Major Release?

1. **Efficiency:** Simple org changes don't justify separate PRs
2. **Coherence:** Organizational changes make sense together
3. **Pending Restructure:** Major project restructure is still planned

### Candidates for Bundling

**High Priority (Quick Wins):**
- [ ] Add CI classification guidance to README (~15 min)

**Medium Priority (Consider for Release):**
- [ ] Create `ci/fixes/` subdirectory (~30 min)
- [ ] Update CI README with status indicators

**Lower Priority (Defer to Major Restructure):**
- [ ] Full CI folder reorganization
- [ ] Umbrella categories for related CI work
- [ ] Archive completed items to `completed/`

---

## 🔗 Relationship to Project Restructure

**Context:** A major project restructure is still pending for dev-infra.

**Implications:**
- CI folder reorganization should align with broader restructure
- Don't invest heavily in temporary organizational structures
- Consider CI improvements as input to overall restructure design

**Recommendation:** 
1. Implement quick classification guidance now
2. Defer structural changes to align with project restructure
3. Document current pain points as input to restructure planning

---

## 📈 Implementation Approach

### Immediate (Can Do Now)
- [x] Add classification guidance to `admin/planning/ci/README.md` ✅ (2025-12-30)

### Bundle with Next Release
- [ ] Create `ci/fixes/` if valuable (evaluate during release)
- [ ] Update status indicators in CI README

### Defer to Project Restructure
- [ ] Full CI folder reorganization
- [ ] Umbrella categories
- [ ] Archive structure

---

## ✅ Definition of Done

**Minimum Viable:**
- [x] CI README has classification guidance ✅ (2025-12-30)
- [x] Contributors know when to use full hub vs simple tracking ✅

**Full Implementation (if bundled):**
- [ ] `ci/fixes/` subdirectory created (if valuable)
- [ ] CI README updated with current status
- [ ] Structure documented for contributors

---

## 🔗 Related Documents

- **[CI Hub](../README.md)** - Current CI planning hub
- **[Reflection](../../notes/reflections/reflection-template-sync-drift-fix-2025-12-30.md)** - Source reflection
- **[Improvement Learnings](../../opportunities/internal/dev-infra/learnings/template-sync-drift-fix/improvement-learnings.md)** - Detailed analysis

---

**Last Updated:** 2025-12-30  
**Next:** Implement classification guidance; evaluate bundling with next release

