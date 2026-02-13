# Workflow Simplification - Exploration Hub

**Status:** ✅ Expanded
**Created:** 2026-02-13
**Expanded:** 2026-02-13

---

## 📋 Quick Links

- **[Exploration](exploration.md)** - Main exploration document (4 themes, detailed analysis)
- **[Research Topics](research-topics.md)** - 5 topics to investigate (ordered by research priority)

---

## 🎯 Overview

Exploring whether the current feature/phase/task hierarchy and command structure should be simplified now that the spike workflow creates stronger decisions and the draft PR workflow reduces PRs to 1 per feature.

**Core hypothesis:** The transition plan should become the single planning artifact between `/decision` and implementation, replacing the current 3-5 file feature plan structure. `/task-phase` should be simplified to `/task`.

---

## 🔍 Themes

| Theme | Key Finding |
|-------|-------------|
| Decision command value shift | Spike workflow transforms `/decision` from performative to substantial |
| Feature/phase/task hierarchy | Draft PR workflow makes per-phase documents and PRs unnecessary |
| `/task-phase` naming | Command interface implies rigidity that doesn't match actual workflow |
| Transition plan gravity | Becomes the key artifact between decision and implementation |

---

## 🧪 Spike Candidates

| Topic | Risk | Recommendation |
|-------|------|----------------|
| `/task-phase` → `/task` rename | MEDIUM-HIGH | Consider spike if research raises concerns about flat task model |

---

## 🚀 Next Steps

1. Run `/research workflow-simplification --from-explore workflow-simplification` to investigate topics
2. Start with Topic 5 (Command Dependency Analysis) to understand refactoring scope
3. After research, run `/decision workflow-simplification --from-research` to make decisions

---

## 🔗 Related

- **[Spike Workflow Framework](../../planning/opportunities/external/dev-toolkit/spike-workflow-framework.md)** - Catalyst
- **[Worktree Feature Workflow](../../docs/WORKTREE-WORKFLOW.md)** - Draft PR workflow
- **[Reflection: Workflow Evolution](../../planning/notes/reflections/reflection-new-commands-workflow-evolution-2026-02-13.md)** - Review posture shift

---

**Last Updated:** 2026-02-13
