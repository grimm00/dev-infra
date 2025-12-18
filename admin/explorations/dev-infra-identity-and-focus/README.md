# Dev-Infra Identity & Focus - Exploration Hub

**Purpose:** Explore what dev-infra should be and how to organize its development  
**Status:** ✅ Transitioned  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration of identity questions
- **[Research Topics](research-topics.md)** - Research questions to investigate

---

## 🎯 Overview

Dev-infra has grown organically and is now serving multiple purposes that create complexity and confusion:

1. **Laboratory** - Where we experiment with workflow ideas
2. **Factory** - Where we produce templates for other projects
3. **Reference Implementation** - Using what we build to build it

This exploration examines whether dev-infra should focus primarily on being a **template factory** rather than a workflow experimentation platform.

---

## 📊 Context

**Trigger:** During v0.4.0 post-release reflection, realized:
- Every improvement to dev-infra's workflow could become a template feature
- But not every experiment should go into templates
- There's confusion about what belongs in `features/` vs `ci/` vs internal tooling
- Commands are guides for AI agents, not hard-coded functionality - different maintenance model
- High overhead for tracking improvements that may not deliver template value

**Key Insight:** "I need to use dev-infra as a templatizer more so than handling so many development ideas at once"

---

## 📊 Status

**Current Phase:** ✅ Transitioned  
**Research:** [admin/research/dev-infra-identity-and-focus/](../../research/dev-infra-identity-and-focus/)  
**Decisions:** [admin/decisions/dev-infra-identity-and-focus/](../../decisions/dev-infra-identity-and-focus/)  
**Transition:** [admin/decisions/dev-infra-identity-and-focus/transition-plan.md](../../decisions/dev-infra-identity-and-focus/transition-plan.md)  
**Outcome:** Identity established, v0.5.0 rescoped to internal tooling only

---

**Last Updated:** 2025-12-11

