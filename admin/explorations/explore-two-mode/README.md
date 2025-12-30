# Explore Two-Mode Pattern - Exploration Hub

**Purpose:** Explore enhancement of `/explore` command with two-mode pattern and explicit input sources  
**Status:** 🔴 Exploration  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration document
- **[Research Topics](research-topics.md)** - Research questions to investigate

### Related

- **[/explore Command](../../../.cursor/commands/explore.md)** - Current command implementation
- **[/research Command](../../../.cursor/commands/research.md)** - Pattern source (two-mode)
- **[/transition-plan Command](../../../.cursor/commands/transition-plan.md)** - Recent two-mode implementation
- **[Transition-Plan Two-Mode Feature](../../planning/features/transition-plan-two-mode/README.md)** - Reference workflow
- **[Existing explore-two-mode Feature](../../planning/features/explore-two-mode/)** - Existing planned feature (narrower scope)

### Command Improvement Features (Consolidation Candidates)

- **[explore-two-mode](../../planning/features/explore-two-mode/)** - 🟡 Planned
- **[reflect-two-mode](../../planning/features/reflect-two-mode/)** - 🔴 Needs Evaluation
- **[decision-two-mode](../../planning/features/decision-two-mode/)** - 🟡 Planned

---

## 🎯 Overview

This exploration extends beyond just applying the two-mode pattern to `/explore`. It addresses three interconnected concerns:

| Concern | Description |
|---------|-------------|
| **1. Command Consolidation** | Should `*-two-mode` features be consolidated? Are they features or CI improvements? |
| **2. Topic Unification** | Can `--topic [name] --type feature\|ci\|release` replace `--feature`/`--ci` flags? |
| **3. Explicit Inputs** | What sources should `/explore` accept? (start.txt, reflections, etc.) |

---

## 📊 Status

**Current Phase:** Exploration  
**Next Step:** Conduct research on topics identified in research-topics.md

---

## 🔗 Context

This exploration was triggered by recognizing that:

1. **Proven workflow exists** - `transition-plan-two-mode` established a successful pattern for command improvements
2. **Duplication emerging** - Three similar `*-two-mode` features exist with similar structure
3. **Naming insight** - "Topic" is a natural term for directories under features/ci/releases
4. **Input gap** - `/explore` currently has no explicit input sources unlike `/research --from-explore`

---

**Last Updated:** 2025-12-30

