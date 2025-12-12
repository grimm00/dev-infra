# Dev-Infra Identity & Focus - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 What Are We Exploring?

The fundamental question: **What should dev-infra be?**

Currently, dev-infra is trying to be three things:

### 1. Laboratory (Workflow Experimentation)
- Experimenting with release automation
- Creating new commands for AI agents
- Testing CI/CD improvements
- Building tooling for our own development

### 2. Factory (Template Production)
- Producing templates for other projects
- Maintaining template quality
- Ensuring templates are stable and useful
- The actual `templates/` directory

### 3. Reference Implementation (Dogfooding)
- Using what we build to build it
- Proving patterns work in practice
- Eating our own dog food

**The Problem:** These goals create feedback loops that multiply complexity.

---

## 🤔 Why Explore This?

### Immediate Triggers

1. **Planning Confusion:** Difficulty deciding if improvements belong in `features/`, `ci/`, or internal tooling
2. **Scope Creep:** Every workflow idea becomes a multi-phase feature with template integration
3. **Maintenance Burden:** 15+ commands, extensive documentation, high overhead
4. **Identity Crisis:** Is tag automation a CI improvement? A feature? Internal tooling?

### Deeper Questions

1. **Value Delivery:** Are we delivering value to template users, or optimizing our own workflow?
2. **Sustainability:** Can we maintain this complexity long-term?
3. **Focus:** What would dev-infra look like if it only focused on template quality?

---

## 💡 Initial Thoughts

### The Maturity Lifecycle Model

Not everything should become a template feature. There should be a graduation process:

```
IDEA → EXPERIMENT → PROVEN → TEMPLATE
```

**Current state:** We treat every idea as needing planning, phases, and template integration immediately.

**Better state:** Ideas should prove themselves in dev-infra before being templatized.

### Template-Centric vs Workflow-Centric

**Workflow-Centric (Current):**
```
"How can we improve our development workflow?"
└── New feature idea
└── Plan it
└── Build it
└── Also put it in templates
```

**Template-Centric (Proposed):**
```
"What do template users need?"
└── Identify template gap
└── Build minimal solution
└── Use it for 1-2 releases
└── If valuable, templatize
└── If not, keep as dev-infra-only
```

### The Layers of Complexity

1. **Code** - Scripts, actual functionality (`scripts/*.sh`)
2. **AI Commands** - Guides for agents, not hard-coded (`.cursor/commands/*.md`)
3. **Templates** - What gets generated for users (`templates/`)
4. **Dev-infra Workflow** - How we develop dev-infra itself

Each layer has different maintenance models and value propositions.

### Potential Organizational Changes

**Option 1: Separate Internal from Template**
```
admin/planning/
├── internal/              # Dev-infra-only improvements
│   └── workflow-experiments/
├── features/              # Things that WILL become template features
└── templates/             # Template-specific planning
```

**Option 2: Graduation Process**
- Explicit criteria for when something moves from internal to template
- Time-boxed experimentation (use for 1-2 releases before templatizing)
- Smaller, more stable template command set

**Option 3: Focus Shift**
- De-emphasize workflow optimization
- Prioritize template quality and stability
- Accept some manual steps as acceptable

---

## 🔍 Key Questions

- [ ] **Identity:** Should dev-infra be primarily a template factory?
- [ ] **Scope:** What is the minimum dev-infra needs to be an excellent template factory?
- [ ] **Commands:** Which commands are essential for templates vs dev-infra-only?
- [ ] **Graduation:** What criteria should determine when something becomes a template feature?
- [ ] **Organization:** How should we restructure planning to reflect the chosen identity?
- [ ] **Maintenance:** How do we reduce overhead while maintaining quality?

---

## 🎭 The Peculiarity of Dev-Infra

### Meta-Project Challenge

Dev-infra is a **meta-project** - improvements to its own workflow become features in the templates it produces. This creates unique challenges:

1. **No Clear Line:** Workflow improvement ≈ Template feature
2. **Self-Referential:** We use our templates' patterns to build the templates
3. **AI Commands:** Guides for agents that can be templatized, but aren't "code"

### The Tag Automation Example

Tag automation was explored because:
1. It's a gap in **our own workflow** (dev-infra internal)
2. It would be valuable in **templates** (user feature)
3. It involves **CI/CD workflow** (infrastructure)
4. It integrates with **AI commands** (guides for agents)

**Where does it belong?** All four places, which is the problem.

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Consider if this exploration should lead to:
   - An ADR (Architecture Decision Record)
   - A restructuring chore
   - A new project philosophy document
3. Decide if v1.5.0 should proceed as planned or be rescoped

---

## 📝 Notes

### From the v1.4.0 Post-Release Discussion

> "I have a hard time figuring out how to handle certain features and improvements. Should enhancements be tracked in ci, or should that topic remain the hub for improvements on that feature?"

This question reveals the organizational confusion stemming from unclear identity.

### From the Restructuring Discussion

> "There's also the extra layer of AI commands, which are guides for agents that aren't actually hard-coded commands, so there's differentiation between code and guides there."

Commands are a unique artifact type - they're documentation that functions as code for AI agents. This creates a maintenance model that doesn't fit traditional software patterns.

### The Templatizer Insight

> "It seems like I need to maybe use dev-infra as a templatizer more so than handling so many development ideas at once."

This suggests focusing on **output quality** (templates) rather than **process optimization** (workflow).

---

**Last Updated:** 2025-12-11

