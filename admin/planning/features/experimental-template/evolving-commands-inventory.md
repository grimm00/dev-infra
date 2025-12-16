# Evolving Commands Inventory

**Purpose:** Track commands that will be included in experimental template  
**Status:** 🟡 Draft  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12

---

## 📋 Overview

This document inventories commands for the experimental template, identifying which commands are currently "Internal" (dev-infra only) and could be exposed to experimental template users.

**Reference:** ADR-003: Command Strategy - Tiered Approach for Templates

---

## 🎯 Current Command Distribution

### Standard Template (18 commands)

Based on ADR-003, the standard template includes:

**Tier 1 - Essential (5 commands):**
| Command | Stability |
|---------|-----------|
| `/pr` | 🔴 Very Stable |
| `/task-phase` | 🔴 Very Stable |
| `/fix-plan` | 🔴 Very Stable |
| `/fix-implement` | 🔴 Very Stable |
| `/reflect` | 🔴 Very Stable |

**Tier 2 - Valuable (6 commands):**
| Command | Stability |
|---------|-----------|
| `/explore` | 🟡 Stable |
| `/research` | 🟡 Stable |
| `/decision` | 🟡 Stable |
| `/pre-phase-review` | 🟡 Stable |
| `/pr-validation` | 🟡 Stable |
| `/post-pr` | 🟡 Stable |

**Tier 3 - Advanced (7 commands):**
| Command | Stability |
|---------|-----------|
| `/transition-plan` | 🟢 Evolving |
| `/reflection-artifacts` | 🟢 Evolving |
| `/int-opp` | 🟢 Evolving |
| `/address-review` | 🟢 Evolving |
| `/task-release` | 🟢 Evolving |
| `/cursor-rules` | 🟢 Evolving |
| `/fix-review` | 🟢 Evolving |

---

### Dev-Infra Only Commands (5 commands)

**Internal - Not Currently in Templates:**

| Command | Purpose | Candidate for Experimental? |
|---------|---------|---------------------------|
| `/release-prep` | Release preparation | 🟡 Maybe - Team releases? |
| `/release-finalize` | Finalize releases | 🟡 Maybe - Team releases? |
| `/post-release` | Post-release tasks | 🟡 Maybe - Team releases? |
| `/status` | Project status check | 🟢 Yes - Generally useful |
| `/task-improvement` | CI/CD improvements | 🟠 Unlikely - Dev-infra specific |

---

## 🧪 Experimental Template - Proposed Additions

### Definite Additions

| Command | Reason | Risk Level |
|---------|--------|------------|
| `/status` | Generally useful for any project | Low |

### Candidate Additions (Need Discussion)

| Command | Reason | Risk Level | Decision |
|---------|--------|------------|----------|
| `/release-prep` | Teams may do releases | Medium | TBD |
| `/release-finalize` | Teams may do releases | Medium | TBD |
| `/post-release` | Teams may do releases | Medium | TBD |

### Not Adding

| Command | Reason |
|---------|--------|
| `/task-improvement` | Specific to dev-infra CI/CD patterns |

---

## 📊 Experimental Template Command Count

| Category | Count | Source |
|----------|-------|--------|
| Standard Template (all) | 18 | Copied from standard |
| New Evolving Commands | 1+ | `/status` definitely, others TBD |
| **Total** | **19+** | |

---

## ✅ Implementation Decision

**For v1.6.0 Phase 1:**

1. **Start minimal:** Add only `/status` as Evolving command
2. **Document clearly:** Mark as 🟠 Experimental in command header
3. **Evaluate:** After v1.6.0, assess if release commands should be added

**Rationale:**
- Lower risk with minimal additions
- `/status` is non-destructive (read-only)
- Release commands need more evaluation (team workflows vary)
- Can always add more in v1.7.0

---

## 🔄 Future Considerations

**Commands to potentially add in v1.7.0+:**

1. Release workflow commands (if team demand emerges)
2. Any new commands developed in dev-infra
3. Commands that graduate from "highly experimental" to "ready for testing"

---

## 🔗 Related

- **ADR-003:** [Command Strategy](../../decisions/dev-infra-identity-and-focus/adr-003-command-strategy.md)
- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Phase 1:** [phase-1.md](phase-1.md)

---

**Last Updated:** 2025-12-12

