# Transition-Plan Two-Mode Pattern - Research Hub

**Purpose:** Research for redesigning `/transition-plan` command with setup + expand modes  
**Status:** 🟡 In Progress  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research
- **[Exploration Source](../../explorations/transition-plan-two-mode/README.md)** - Original exploration

### Research Documents

| # | Research Topic | Priority | Status | Document |
|---|----------------|----------|--------|----------|
| 1 | Two-Mode Pattern Analysis | 🔴 High | ✅ Complete | [research-pattern-analysis.md](research-pattern-analysis.md) |
| 2 | Scaffolding Content Design | 🔴 High | ✅ Complete | [research-scaffolding-design.md](research-scaffolding-design.md) |
| 3 | TDD Detection Logic | 🟡 Medium | 🔴 Not Started | [research-tdd-detection.md](research-tdd-detection.md) |
| 4 | Expansion State Tracking | 🟡 Medium | 🔴 Not Started | [research-expansion-tracking.md](research-expansion-tracking.md) |
| 5 | Global Command Versioning | 🟢 Low | 🔴 Not Started | [research-global-versioning.md](research-global-versioning.md) |
| 6 | Command Structure Refactoring | 🔴 High | ✅ Complete | [research-command-structure.md](research-command-structure.md) |

---

## 🎯 Research Overview

This research supports redesigning the `/transition-plan` command to use a two-mode pattern:

1. **Setup Mode (default):** Creates scaffolding (transition-plan.md, phase-N.md headers)
2. **Expand Mode (`--expand`):** Fills in detail with TDD task ordering

**Why This Matters:**

- **First fully-utilized global command** from dev-infra
- **Addresses real problems:** Variable output, inconsistent TDD ordering, no human review opportunity
- **Follows proven pattern:** Same as `/research` + `--conduct`

**Research Topics:** 6 topics (3 High, 2 Medium, 1 Low priority)  
**Status:** 🟡 In Progress

---

## 📊 Research Status

**Progress:** 3/6 topics complete (all High-priority complete ✅)

| Priority | Topics | Status |
|----------|--------|--------|
| 🔴 High | Pattern Analysis, Scaffolding Design, Command Structure | ✅ 3/3 |
| 🟡 Medium | TDD Detection, Expansion Tracking | 🔴 0/2 |
| 🟢 Low | Global Versioning | 🔴 0/1 |

---

## 🚀 Next Steps

**All High-priority topics complete!** You can now:

1. **Make decisions:** `/decision transition-plan-two-mode --from-research`
2. **Or continue with Medium/Low priority research:**
   - `/research transition-plan-two-mode --conduct --topic-num 3` (TDD Detection)
   - `/research transition-plan-two-mode --conduct --topic-num 4` (Expansion Tracking)
   - `/research transition-plan-two-mode --conduct --topic-num 5` (Global Versioning)

---

**Last Updated:** 2025-12-29

