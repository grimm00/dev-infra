# Spike Workflow Framework

**Source:** dev-toolkit dt-workflow v1 exploration  
**Status:** 🟡 Ready for Integration  
**Last Updated:** 2026-02-13  
**Priority:** HIGH - Fast-track across all projects

---

## 🧪 What is a Spike?

A **spike** is a time-boxed experiment to answer a specific technical question or reduce risk. Unlike research (which investigates options), a spike **builds something minimal** to validate assumptions.

**Key characteristics:**

| Characteristic | Description |
|----------------|-------------|
| **Time-boxed** | 2-4 hours maximum |
| **Throwaway mindset** | Code may be discarded |
| **Learning-focused** | Output is knowledge, not production code |
| **Question-driven** | Clear success criteria before starting |

---

## 🔄 When to Spike vs Research

| Situation | Use Spike | Use Research |
|-----------|-----------|--------------|
| Architectural decision with high commitment | ✅ | |
| User-facing UX that needs to be "felt" | ✅ | |
| Technical uncertainty ("can it even work?") | ✅ | |
| Comparing known options | | ✅ |
| Investigating best practices | | ✅ |
| Low-risk, well-understood path | | ✅ |

---

## 📊 Spike Determination Framework

During exploration, assess each topic against this risk matrix:

| Risk Level | Determination | Rationale |
|------------|---------------|-----------|
| 🔴 HIGH | **Spike first** | Hard to pivot once committed |
| 🟠 MEDIUM-HIGH | **Consider spike** | Benefits from hands-on validation |
| 🟡 MEDIUM | Research only | Depends on other decisions |
| 🟢 LOW | Research only | Clear path, low risk |

### Exploration Output Template

Add this section to exploration documents:

```markdown
## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| [Topic 1] | 🔴 HIGH | Yes | [Why it needs validation] |
| [Topic 2] | 🟠 MEDIUM-HIGH | Consider | [Why it might benefit] |
| [Topic 3] | 🟢 LOW | No | [Why research is sufficient] |
```

---

## 📋 Spike Workflow

### Step 1: Identify Candidates (During Exploration)

Flag topics that need spikes based on risk assessment above.

### Step 2: Define Success Criteria (Before Starting)

```markdown
## Spike: [Topic Name]

**Time box:** 2 hours

**Questions to answer:**
1. Can [specific thing] work?
2. Does [approach] feel right?
3. What's the [performance/complexity/UX]?

**Success looks like:**
- [ ] Built minimal [thing] that demonstrates [capability]
- [ ] Answered questions above with evidence
- [ ] Documented what surprised us
```

### Step 3: Execute (Time-Boxed)

1. **Set a timer** (2-4 hours)
2. **Build the minimum** to answer your questions
3. **Don't polish** - throwaway mindset
4. **Stop when timer ends** - even if incomplete

### Step 4: Document Learnings

```markdown
## Spike Learnings: [Topic Name]

**Date:** YYYY-MM-DD
**Duration:** X hours

### What Was Validated

| Question | Result | Confidence |
|----------|--------|------------|
| [Q1] | ✅/⚠️/❌ [Result] | High/Medium/Low |

### What We Learned

1. [Key learning 1]
2. [Key learning 2]

### Surprises / New Questions

- [Unexpected finding that changes our thinking]
- [New question revealed by implementation]

### Go/No-Go

**Recommendation:** [Proceed / Pivot / Need more investigation]

**Rationale:** [Why this recommendation]
```

---

## 🔄 Integration with Explore → Research → Decision

```
┌──────────────┐
│   /explore   │ ← Identifies spike candidates
└──────┬───────┘
       │
       ▼
┌──────────────┐     ┌──────────────┐
│ Spike first? │────▶│    /spike    │ ← Time-boxed experiment
│  (if HIGH    │     │  (2-4 hrs)   │
│   risk)      │     └──────┬───────┘
└──────┬───────┘            │
       │                    │ Learnings inform
       ▼                    ▼
┌──────────────┐     ┌──────────────┐
│  /research   │◀────│   Continue   │
│ (if needed)  │     │  or pivot?   │
└──────┬───────┘     └──────────────┘
       │
       ▼
┌──────────────┐
│  /decision   │ ← Decisions backed by spike have HIGH confidence
└──────────────┘
```

**Note:** Spikes and research are iterative. A spike may reveal new questions requiring research, and research may identify areas that benefit from a spike.

---

## 👥 Why Spikes Matter

### For Senior Developers

- **Reduces commitment risk** on architectural decisions
- **Validates UX** before building full feature
- **Surfaces unknown unknowns** early

### For Junior Developers

Spikes are especially valuable as time-boxed "can it work?" sessions:

- **Removes pressure** to build something perfect
- **Makes failure safe** ("I couldn't figure it out" is valid)
- **Prevents rabbit holes** (timer enforces stopping)
- **Structured permission** to experiment

### For Teams

- **Aligns understanding** before major investment
- **Creates evidence** for decision-making
- **Builds shared vocabulary** around technical options

---

## 🤖 Meta-Learnings: Agentic Coding

These insights emerged from the dt-workflow exploration and apply broadly to AI-assisted development.

### The Discovery Problem

**Insight:** Rapid agentic implementation can rob you of the discovery phase.

When AI writes code quickly:
- You don't struggle with edge cases (miss learning)
- You don't explore alternatives (miss options)
- You don't build intuition (miss deep understanding)
- You get a working thing without knowing why it works

**Mitigation strategies:**

1. **Use spikes first** - Build minimal versions yourself
2. **Review AI code line-by-line** - Don't just accept
3. **Deliberately break things** - See what happens
4. **Document your understanding** - Force articulation
5. **Question architectural choices** - Ask "why this way?"

### The Ownership Problem

**Insight:** It's harder to maintain code you didn't write.

When AI generates substantial code:
- Mental model is incomplete
- Debugging is harder (don't know intentions)
- Modifications are risky (don't know implications)

**Mitigation strategies:**

1. **Smaller increments** - Fewer lines, more understanding
2. **Test-first** - Write tests yourself, then AI implements
3. **Architecture yourself** - You design, AI fills in
4. **Refactor to understand** - Touch every line eventually

### When Agentic Coding Works Well

- **Boilerplate** - Repetitive code with clear patterns
- **Exploration** - "Show me how this might work"
- **Research** - Gathering options and trade-offs
- **Refactoring** - Applying known patterns

### When Agentic Coding Needs Caution

- **Architecture** - High-commitment decisions
- **Novel problems** - No established pattern
- **Core business logic** - You need deep understanding
- **Security-critical** - Must verify every line

---

## 📝 Cursor Rules Integration

To add spike workflow to a project's Cursor rules, add to `workflow.mdc`:

```markdown
## 🧪 Spike Workflow

### What is a Spike?

A **spike** is a time-boxed experiment to answer a specific technical question or reduce risk. Unlike research (which investigates options), a spike **builds something minimal** to validate assumptions.

**Key characteristics:**
- **Time-boxed:** 2-4 hours maximum
- **Throwaway mindset:** Code may be discarded
- **Learning-focused:** Output is knowledge, not production code
- **Question-driven:** Clear success criteria before starting

### Spike Determination Framework

During exploration, assess each topic:

| Risk Level | Determination | Rationale |
|------------|---------------|-----------|
| 🔴 HIGH | **Spike first** | Hard to pivot once committed |
| 🟠 MEDIUM-HIGH | **Consider spike** | Benefits from hands-on validation |
| 🟡 MEDIUM | Research only | Depends on other decisions |
| 🟢 LOW | Research only | Clear path, low risk |

### When to Spike vs Research

| Situation | Use Spike | Use Research |
|-----------|-----------|--------------|
| Architectural decision with high commitment | ✅ | |
| User-facing UX that needs to be "felt" | ✅ | |
| Technical uncertainty ("can it even work?") | ✅ | |
| Comparing known options | | ✅ |
| Investigating best practices | | ✅ |
| Low-risk, well-understood path | | ✅ |
```

---

## 🚀 Implementation Checklist

- [ ] Add spike determination section to `/explore` command output
- [ ] Create `/spike` command (or alias to explore → research → decision)
- [ ] Update `workflow.mdc` with spike workflow section
- [ ] Add meta-learnings to developer documentation
- [ ] Update explore templates with risk assessment table

---

## 🔗 Related

- **[Helm-Charts Lightweight Commands](../helm-charts/lightweight-commands.md)** - Mentions spike commands
- **Source:** dev-toolkit `feat/dt-workflow` branch
- **Original Documents:**
  - `admin/learnings/spike-workflow-portable.md`
  - `admin/learnings/dt-workflow-v1-learnings.md`

---

**Last Updated:** 2026-02-13  
**Status:** 🟡 Ready for Integration  
**Next:** Integrate into explore command and workflow rules
