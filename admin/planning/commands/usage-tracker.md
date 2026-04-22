# Command Usage Tracker

**Purpose:** Track command usage for graduation assessment  
**Related:** [ADR-004: Graduation Process](../../decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md)  
**Status:** ✅ Active  
**Last Updated:** 2025-12-16

---

## 📋 Overview

This document tracks command usage in dev-infra to support graduation decisions. Per ADR-004, commands need "demonstrated use" before graduating to templates.

**Graduation Threshold:** ≥3 successful uses recommended before graduation consideration.

---

## 📊 Usage Summary

### Tier 1 - Essential Commands

| Command | Uses | Last Use | Success Rate | Graduation Status |
|---------|------|----------|--------------|-------------------|
| `/pr` | 15+ | 2025-12-15 | ~95% | ✅ Graduated |
| `/task-phase` | 20+ | 2025-12-15 | ~95% | ✅ Graduated |
| `/fix-plan` | 8+ | 2025-12-15 | 100% | ✅ Graduated |
| `/fix-implement` | 8+ | 2025-12-15 | 100% | ✅ Graduated |
| `/reflect` | 6+ | 2025-12-15 | 100% | ✅ Graduated |

### Tier 2 - Valuable Commands

| Command | Uses | Last Use | Success Rate | Graduation Status |
|---------|------|----------|--------------|-------------------|
| `/explore` | 3+ | 2025-12-10 | 100% | ✅ Graduated |
| `/research` | 3+ | 2025-12-10 | 100% | ✅ Graduated |
| `/decision` | 4+ | 2025-12-11 | 100% | ✅ Graduated |
| `/pre-phase-review` | 5+ | 2025-12-15 | 100% | ✅ Graduated |
| `/pr-validation` | 10+ | 2025-12-15 | ~90% | ✅ Graduated |
| `/post-pr` | 10+ | 2025-12-15 | 100% | ✅ Graduated |

### Tier 3 - Advanced Commands

| Command | Uses | Last Use | Success Rate | Graduation Status |
|---------|------|----------|--------------|-------------------|
| `/transition-plan` | 3+ | 2025-12-11 | 100% | ✅ Graduated |
| `/reflection-artifacts` | 2 | 2025-12-07 | 100% | ⚠️ Needs more use |
| `/int-opp` | 6+ | 2025-12-16 | 100% | ✅ Graduated |
| `/address-review` | 3+ | 2025-12-15 | 100% | ✅ Graduated |
| `/task-release` | 2 | 2025-12-15 | 100% | ⚠️ Needs more use |
| `/cursor-rules` | 1 | 2025-12-15 | 100% | ❌ Not ready |
| `/fix-review` | 3+ | 2025-12-15 | 100% | ✅ Graduated |

### Internal Commands (Not for Templates)

| Command | Uses | Last Use | Notes |
|---------|------|----------|-------|
| `/release-prep` | 2 | 2025-12-15 | Dev-infra only |
| `/release-finalize` | 2 | 2025-12-15 | Dev-infra only |
| `/post-release` | 2 | 2025-12-15 | Dev-infra only |
| `/status` | 1 | 2025-12-10 | Dev-infra only |
| `/task-improvement` | 3+ | 2025-12-08 | Dev-infra only |

---

## 📝 Detailed Usage Log

### Recent Usage (Last 7 Days)

| Date | Command | Context | Result | Evidence |
|------|---------|---------|--------|----------|
| 2026-04-22 | `/int-opp` | PR body generation primitive (from /discuss on `/pr` vs `update-pr-description` skill) | ✅ Success | pr-body-generation-primitive.md |
| 2025-12-16 | `/reflect` | Work-prod integration reflection | ✅ Success | new doc created |
| 2025-12-16 | `/int-opp` | Work-prod docs gap analysis | ✅ Success | commit 5df0bd9 |
| 2025-12-16 | `/int-opp` | Documentation structure learnings | ✅ Success | new doc created |
| 2025-12-15 | `/cursor-rules` | Update all rules | ✅ Success | v0.6.0 release |
| 2025-12-15 | `/reflect` | Experimental template | ✅ Success | reflection doc |
| 2025-12-15 | `/fix-implement` | Quick wins batch | ✅ Success | PR #52 |
| 2025-12-15 | `/fix-implement` | Test assertions batch | ✅ Success | PR #51 |
| 2025-12-15 | `/fix-implement` | Test assertions batch | ✅ Success | PR #50 |
| 2025-12-15 | `/fix-plan` | Test assertion improvements | ✅ Success | batch files |
| 2025-12-15 | `/fix-review` | Deferred issues analysis | ✅ Success | report |
| 2025-12-15 | `/post-pr` | Phase 4 direct merge | ✅ Success | docs updated |
| 2025-12-15 | `/task-phase` | Exp. Template Phase 4 | ✅ Success | 6 tasks |
| 2025-12-15 | `/address-review` | Phase 4 gaps | ✅ Success | phase doc |
| 2025-12-15 | `/pre-phase-review` | Phase 4 | ✅ Success | review doc |
| 2025-12-15 | `/release-finalize` | v0.6.0 | ✅ Success | PR #53 |
| 2025-12-15 | `/post-release` | v0.6.0 | ✅ Success | cleanup done |

---

## 🎯 Commands Needing More Testing

Commands below graduation threshold (< 3 uses):

| Command | Current Uses | Gap | Priority |
|---------|-------------|-----|----------|
| `/cursor-rules` | 1 | 2 more needed | HIGH - v0.7.0 |
| `/task-release` | 2 | 1 more needed | MEDIUM |
| `/reflection-artifacts` | 2 | 1 more needed | LOW |

**Next Actions:**
- Use `/cursor-rules` during next rule update cycle
- Use `/task-release` if v0.7.0 has release tasks
- Use `/reflection-artifacts` after next major feature

---

## 📋 How to Update This Tracker

**After successful command use:**

1. **Update Usage Summary table:**
   - Increment "Uses" count
   - Update "Last Use" date
   - Update "Success Rate" if failure occurred

2. **Add to Detailed Usage Log:**
   ```markdown
   | YYYY-MM-DD | `/command` | Context description | ✅ Success | Evidence link |
   ```

3. **Check Graduation Status:**
   - If uses ≥ 3 and no recent failures → Consider for graduation
   - Update "Graduation Status" column

**Commit message:**
```
docs(commands): update usage tracker - /[command-name]
```

---

## 🔗 Related

- [ADR-003: Command Strategy](../../decisions/dev-infra-identity-and-focus/adr-003-command-strategy.md)
- [ADR-004: Graduation Process](../../decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md)
- [Commands Planning Hub](README.md)

---

**Last Updated:** 2025-12-16

