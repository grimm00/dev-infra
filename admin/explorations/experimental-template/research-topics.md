# Research Topics - Experimental Template

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11  
**Target:** v1.6.0

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before deciding on experimental template implementation.

---

### Research Topic 1: User Demand

**Question:** Do template users actually want access to experimental/evolving commands?

**Why:** No point building if nobody wants it

**Sub-questions:**
- What percentage of users would opt-in?
- What experimental features would be most valuable?
- Are users comfortable with instability?

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 2: Implementation Approach

**Question:** Which approach is best: separate template, flag, or addon system?

**Why:** Significantly different implementation complexity

**Sub-questions:**
- What are the maintenance implications of each?
- How does each affect the generator script?
- Which provides best user experience?

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 3: Stability Communication

**Question:** How do we clearly communicate stability levels to users?

**Why:** Users need to understand what they're getting

**Sub-questions:**
- How do other projects handle beta/experimental features?
- What warnings/disclaimers are needed?
- Should experimental commands have visual indicators?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 4: Sync Strategy

**Question:** How do we keep experimental template in sync with standard?

**Why:** Drift creates maintenance burden

**Sub-questions:**
- Should experimental extend standard (inheritance)?
- How do we detect when they drift?
- What's the update workflow?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 5: Graduation Path

**Question:** How do commands graduate from experimental to standard?

**Why:** Need clear process for promotion

**Sub-questions:**
- What criteria for graduation?
- Who decides when to promote?
- How do we notify users of changes?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

## 🎯 Research Workflow

1. Complete identity transition first (blocking)
2. Use `/research experimental-template --from-explore experimental-template` to conduct research
3. Research will create documents in `admin/research/experimental-template/`
4. After research complete, use `/decision experimental-template --from-research` to make decisions

---

## ⏸️ Blocked Until

- [ ] Identity transition complete
- [ ] v1.5.0 released
- [ ] Command tiers implemented

---

**Last Updated:** 2025-12-11

