# Research: Release Automation v2 Scope

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** Should v0.5.0's Release Automation v2 proceed as planned, be rescoped, or deferred?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

Should v0.5.0's Release Automation v2 proceed as planned, be rescoped, or deferred? This is an immediate decision point that depends on the identity question.

---

## 🔍 Research Goals

- [x] Goal 1: Review Release Automation v2 planned scope
- [x] Goal 2: Assess alignment with template-centric identity
- [x] Goal 3: Evaluate each phase's value to template users
- [x] Goal 4: Recommend scope for v0.5.0

---

## 📚 Research Methodology

**Sources:**
- [x] Source 1: Release Automation v2 feature plan
- [x] Source 2: Template user needs research
- [x] Source 3: Command maintenance research
- [x] Source 4: Current v0.4.0 capabilities

---

## 📊 Findings

### Finding 1: Current v2 Planned Scope

**From `admin/planning/features/release-automation-v2/feature-plan.md`:**

| Phase | Focus | Effort | Template Value |
|-------|-------|--------|----------------|
| Phase 1 | Tag Creation Automation | 1-2 days | 🔴 Low - dev-infra specific |
| Phase 2 | Version Reference Automation | 2-3 days | 🟡 Medium - some projects need this |
| Phase 3 | Template Integration | 3-5 days | 🟢 High - core template improvement |

**Total Planned Effort:** 6-10 days

### Finding 2: Phase Alignment with Identity

**If dev-infra is a "template factory":**

| Phase | Value Proposition | Alignment |
|-------|-------------------|-----------|
| Phase 1 | Automates dev-infra's own releases | 🔴 Internal tooling |
| Phase 2 | Automates version bumping | 🟡 Both internal and template |
| Phase 3 | Puts release commands in templates | 🟢 Template feature |

**Key Insight:** Phase 1 and 2 primarily benefit dev-infra, not template users.

### Finding 3: What Templates Actually Need

**From Template User Needs research:**

Templates need release-related features for:
1. **CHANGELOG management** - Already in templates via docs patterns
2. **Version tracking** - Varies by project type
3. **Release notes** - Documentation patterns cover this

Templates probably DON'T need:
1. Automated tag creation (most projects use manual tagging)
2. Automated version bumping (creates complexity)
3. Release readiness scripts (dev-infra specific)

### Finding 4: Template Integration (Phase 3) Details

**What Phase 3 would add to templates:**

From phase plan:
- `/release-prep` command integration
- `/release-finalize` command integration
- `/post-release` command integration

**But wait:** These commands are currently dev-infra-only (see research-template-user-needs.md Finding 1). They were intentionally NOT included in templates.

**Reconsideration:** Should these commands go into templates at all?

### Finding 5: Alternative Scoping Options

**Option A: Proceed as Planned**
- Complete all 3 phases
- Effort: 6-10 days
- Risk: Over-engineering templates

**Option B: Phase 3 Only**
- Skip automation (Phase 1-2)
- Focus on template integration
- Effort: 3-5 days
- Risk: Incomplete automation

**Option C: Defer Entirely**
- Focus on template stability
- No new release features
- Effort: 0 days
- Risk: Miss improvement opportunity

**Option D: Internal Only (Phase 1-2)**
- Complete automation for dev-infra
- Don't templatize release commands
- Effort: 3-5 days
- Benefit: Dev-infra improves without template complexity

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Template Integration Conflicts with Identity

If dev-infra should be a "template factory":
- Phase 3 adds complexity to templates
- Release commands are dev-infra-specific by nature
- Most generated projects don't need this level of automation

### Insight 2: Phase 1-2 Are Internal Improvements

Tag and version automation:
- Benefits dev-infra's own release process
- May not belong in templates
- Could remain internal tooling

### Insight 3: The "Graduation" Question

Should release commands graduate to templates?

**Arguments FOR:**
- Consistent with v0.4.0 Release Readiness feature
- Some projects might benefit
- Commands are "guides" not code

**Arguments AGAINST:**
- Already excluded from templates (intentionally)
- Creates maintenance burden
- Most projects don't need meta-project tooling

### Insight 4: Reordering Phases

If we DO proceed, Phase 3 should come LAST:
1. Prove automation works in dev-infra (Phase 1-2)
2. Use it for 1-2 releases
3. THEN decide if it belongs in templates

---

## 💡 Recommendations

**Primary Recommendation: Option D (Internal Only)**

1. ✅ Complete Phase 1 (Tag Automation) - Internal tooling
2. ✅ Complete Phase 2 (Version Automation) - Internal tooling
3. ❌ Skip Phase 3 (Template Integration) - Not aligned with identity

**Rationale:**
- Improves dev-infra's release workflow
- Doesn't add complexity to templates
- Aligns with "template factory" identity
- Can revisit Phase 3 in v0.6.0 if there's demand

**Alternative Recommendation: Option C (Defer)**

If the goal is maximum template focus:
- Defer all Release Automation v2
- Focus v0.5.0 on template quality/stability
- Use v0.4.0 release tooling as-is

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-7:** Release automation should be internal tooling by default
- **FR-8:** Template integration requires explicit graduation decision

### Non-Functional Requirements

- **NFR-5:** Templates should not grow more complex without clear user need
- **NFR-6:** Internal tooling can evolve faster than template features

### Constraints

- **C-1:** v0.5.0 scope must align with template-centric identity
- **C-2:** Template additions require demonstrated user need

---

## 🚀 Next Steps

1. Decide on v0.5.0 scope (recommend Option D)
2. If proceeding: Complete Phase 1-2 as internal tooling
3. Track template integration as separate future consideration

---

**Last Updated:** 2025-12-11

