# Research: Stability Communication

**Research Topic:** Experimental Template  
**Question:** How do we clearly communicate stability levels to users?  
**Priority:** 🟡 Medium  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Completed:** 2025-12-12

---

## 🎯 Research Question

How do we clearly communicate stability levels to users so they understand what they're getting with experimental commands?

**Users need to understand:**
- Which commands are stable vs experimental
- What "experimental" means in practice
- Expected update/breaking change frequency
- How to provide feedback

---

## 🔍 Research Goals

- [x] Goal 1: Research how other projects handle beta/experimental features
- [x] Goal 2: Identify what warnings/disclaimers are needed
- [x] Goal 3: Determine if experimental commands need visual indicators
- [x] Goal 4: Define clear stability level definitions

---

## 📚 Research Methodology

**Note:** Research based on established patterns from major developer tools.

**Sources:**
- [x] Rust stable/beta/nightly communication
- [x] VS Code Insiders communication
- [x] GitHub feature previews
- [x] npm package stability indicators
- [x] Software versioning conventions (alpha, beta, RC)
- [x] ADR-003 Command Tiers

---

## 📊 Findings

### Finding 1: Rust's Feature Stability Communication is Industry Standard

**Rust's Approach:**
- **Naming:** Clear "stable/beta/nightly" channel names
- **Documentation:** Each feature has explicit stability attribute
- **Compiler Support:** `#![feature(name)]` required for unstable
- **Release Notes:** Clear section for stabilized features

**Key Elements:**
```
Feature: async_fn_in_trait
Status: Unstable (nightly only)
Tracking Issue: #91611
Expected Stabilization: TBD
```

**Source:** Rust documentation, RFC process

**Relevance:** Gold standard for stability communication. Clear, explicit, traceable.

---

### Finding 2: VS Code Uses Visual Indicators and Separate Builds

**VS Code's Approach:**
- **Branding:** Different icon color (green = stable, orange = insiders)
- **Naming:** "Insiders" clearly indicates experimental
- **Release Notes:** Highlights "New in Insiders" features
- **Settings:** Some features gated behind experimental settings

```json
// VS Code settings.json
"workbench.experimental.newFeature": true
```

**Source:** VS Code documentation

**Relevance:** Visual differentiation works well. Separate build for experimental is effective.

---

### Finding 3: GitHub Uses Feature Preview with Clear UI

**GitHub's Approach:**
- **Settings Page:** Dedicated "Feature Preview" section
- **Descriptions:** Each feature has purpose and caveats
- **Opt-in Toggle:** Explicit enable/disable per feature
- **Feedback Link:** Direct path to provide feedback

**UI Pattern:**
```
┌─────────────────────────────────────┐
│ 🧪 Feature Name                     │
│ Description of what this does       │
│ ⚠️ This feature is in preview       │
│ [Enable] [Learn more] [Give feedback]│
└─────────────────────────────────────┘
```

**Source:** GitHub settings

**Relevance:** Explicit opt-in with clear warnings is effective pattern.

---

### Finding 4: npm Uses Stability Badges

**npm's Approach:**
- **Badges:** Visual indicators in README (stable, experimental, deprecated)
- **Versioning:** `0.x` indicates unstable, `1.0+` indicates stable API
- **Tags:** `@next`, `@beta`, `@alpha` for experimental versions

```markdown
![Stability: Experimental](https://img.shields.io/badge/stability-experimental-orange.svg)
```

**Source:** npm ecosystem conventions

**Relevance:** Badges provide quick visual scanning of stability.

---

### Finding 5: Existing ADR-003 Command Tiers Provide Foundation

**Current Tiers (ADR-003):**
| Tier | Stability | Inclusion |
|------|-----------|-----------|
| Essential | 🟢 Stable | Always included |
| Valuable | 🟢 Stable | Always included |
| Advanced | 🟡 Stable but complex | Included |
| Evolving | 🟠 Unstable | Dev-infra only |

**Source:** ADR-003: Command Tiers

**Relevance:** Existing tier system can map to stability communication.

---

## 🔍 Analysis

**Effective stability communication requires:**

1. **Clear Naming:** Use unambiguous terms (Stable, Experimental, not "beta" which varies in meaning)
2. **Visual Indicators:** Badges/icons for quick recognition
3. **Documentation:** Each command states its stability level
4. **Warnings:** Explicit caveats for experimental features
5. **Feedback Path:** Easy way to report issues

**Proposed Stability Definitions:**

| Level | Indicator | Meaning |
|-------|-----------|---------|
| **Stable** | 🟢 | API stable, production-ready, documented |
| **Experimental** | 🟠 | May change, actively evolving, feedback welcome |
| **Deprecated** | 🔴 | Will be removed, migration path provided |

**Key Insights:**
- [x] Insight 1: Clear, consistent naming is more important than detailed explanations
- [x] Insight 2: Visual indicators (badges, emoji) enable quick scanning
- [x] Insight 3: Explicit opt-in prevents accidental adoption of unstable features
- [x] Insight 4: Feedback mechanisms are essential for experimental features

---

## 💡 Recommendations

- [x] Recommendation 1: Use 🟢/🟠/🔴 emoji indicators in documentation
- [x] Recommendation 2: Add stability section to each command's README
- [x] Recommendation 3: Include stability warning at top of experimental commands
- [x] Recommendation 4: Create feedback template for experimental command issues

---

## 📋 Requirements Discovered

- [x] REQ-SC-1: Each command must display stability indicator (🟢/🟠/🔴)
- [x] REQ-SC-2: Experimental template README must include stability disclaimer
- [x] REQ-SC-3: Experimental commands must include "feedback welcome" link
- [x] REQ-SC-4: Release notes must track stability changes (graduated/deprecated)
- [x] REQ-SC-5: Use consistent stability terminology across all documentation

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with Sync Strategy research
3. Apply stability communication patterns in implementation

---

**Last Updated:** 2025-12-12
