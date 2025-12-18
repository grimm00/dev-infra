# Experimental Template - Exploration

**Status:** ✅ Decisions Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-12  
**Target:** v0.6.0  
**Research:** [admin/research/experimental-template/](../../research/experimental-template/)  
**Decisions:** [admin/decisions/experimental-template/](../../decisions/experimental-template/)  
**Next:** `/transition-plan --from-adr` when ready to implement

---

## 🎯 What Are We Exploring?

A new template type ("experimental-project" or "bleeding-edge-project") that includes commands and features not yet stable enough for the standard template.

**The Idea:**

| Template | Commands Included | Stability |
|----------|------------------|-----------|
| **standard-project** | Essential + Valuable + Advanced | 🟢 Stable |
| **experimental-project** | Standard + Evolving | 🟡 May change |

---

## 🤔 Why Explore This?

### Problem

With ADR-003 (Command Tiers), we've established that:
- Standard templates should have stable commands
- Dev-infra has commands being actively developed
- Users who want latest features can't get them from templates

### Opportunity

An experimental template would:
1. Give power users access to latest features
2. Provide a testing ground for new commands
3. Create a graduation path: Experimental → Standard
4. Reduce pressure to rush stability

---

## 💡 Initial Thoughts

### Approach 1: Separate Template

```
templates/
├── standard-project/    # Stable commands
├── learning-project/    # Educational focus
└── experimental-project/ # Bleeding edge (NEW)
```

**Pros:**
- Clear separation
- Easy to understand
- No impact on standard template

**Cons:**
- Third template to maintain
- More generator complexity
- Sync challenges

### Approach 2: Template Flag

```bash
./scripts/new-project.sh my-project --experimental
```

**Pros:**
- Single template with options
- Less maintenance
- Incremental approach

**Cons:**
- More complex generator
- Harder to explain
- Mixed stability in one template

### Approach 3: Command Addon System

```bash
./scripts/new-project.sh my-project
# Then separately:
./scripts/add-experimental-commands.sh
```

**Pros:**
- Standard template stays clean
- User opts in explicitly
- Upgrade path clear

**Cons:**
- Two-step process
- New script to maintain
- May confuse users

---

## 🔍 Key Questions

- [ ] **User Need:** Do users actually want experimental commands?
- [ ] **Maintenance:** Can we maintain a third template type?
- [ ] **Stability:** How do we communicate stability clearly?
- [ ] **Graduation:** How do commands move from experimental → standard?
- [ ] **Sync:** How do we keep experimental in sync with standard?

---

## 🚀 Next Steps

1. **Complete identity transition** (current focus)
2. **Implement v0.5.0** (Release Automation v2 internal)
3. **Return to this exploration** for v0.6.0
4. Use `/research experimental-template --from-explore` to investigate

---

## 📝 Notes

### Connection to Identity Decision

This exploration directly implements the "template factory" identity:
- Standard template = stable product
- Experimental template = beta product
- Clear product tiers for users

### Potential v0.6.0 Scope

If this exploration leads to a feature:
- Generator updates (`new-project.sh`)
- New template directory
- Command tier integration
- Documentation updates
- Template validation tests

---

**Last Updated:** 2025-12-11

