# Explore Two-Mode Enhancement - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 🎯 What Are We Exploring?

Enhancement of the `/explore` command with three interconnected improvements:

1. **Two-Mode Pattern** - Setup + Conduct modes (like `/research` and `/transition-plan`)
2. **Explicit Input Sources** - Accept `start.txt`, reflections, and other sources
3. **Topic Unification** - Generalize `--topic [name] --type` pattern across commands

Additionally, we're exploring:

4. **Command Improvement Organization** - Consolidate `*-two-mode` features and determine if they belong in features/ or ci/

---

## 🤔 Why Explore This?

### Problems Addressed

| Problem | Impact |
|---------|--------|
| **Variable output** | `/explore` produces inconsistent document sizes |
| **No human review checkpoint** | Can't review structure before detailed exploration |
| **No input sources** | Unlike `/research --from-explore`, explore has no `--from-*` options |
| **Scattered command improvements** | Multiple `*-two-mode` features with duplicate structure |
| **Inconsistent flag naming** | `--feature` vs `--ci` vs `--topic` varies across commands |

### Opportunities

1. **Leverage proven patterns** - Apply successful transition-plan-two-mode workflow
2. **Bootstrap from existing context** - `start.txt` provides excellent project initialization context
3. **Consolidate planning** - Single "command-two-mode-pattern" improvement
4. **Standardize vocabulary** - "Topic" as universal term for planning directories

---

## 💡 Initial Thoughts

### On Two-Mode Pattern

The `/research` command pioneered two-mode:
- **Setup Mode (default):** Creates document structure
- **Conduct Mode (`--conduct`):** Fills in content

For `/explore`, this could be:
- **Setup Mode:** Create exploration scaffolding (~60-80 lines)
- **Conduct Mode (`--conduct`):** Detailed exploration (~200-300 lines)

### On Input Sources

Potential input sources for `/explore`:

| Source | Use Case | Priority |
|--------|----------|----------|
| `start.txt` | New project initialization | 🔴 High |
| Reflection documents | Explore suggestions from reflections | 🟡 Medium |
| Feature plans | Extract sub-explorations | 🟢 Low |
| ADR documents | Explore follow-up decisions | 🟢 Low |

**start.txt** is the most natural fit because:
- Dev-infra staple for project initialization
- Contains problem statement, scope, preferences
- Natural starting point for exploration

### On Topic Unification

Current state:
```
/research --from-explore [name]  # uses "explore name"
/transition-plan --feature [name]  # uses "feature name"
/transition-plan --type ci  # uses "type"
```

Proposed unified pattern:
```
/command --topic [name] --type feature|ci|release|exploration
```

This maps to directories:
- `--type feature` → `admin/planning/features/[topic]/`
- `--type ci` → `admin/planning/ci/[topic]/`
- `--type release` → `admin/planning/releases/[topic]/`
- `--type exploration` → `admin/explorations/[topic]/`

### On Command Improvement Organization

Current scattered structure:
```
admin/planning/features/
├── explore-two-mode/
├── reflect-two-mode/
├── decision-two-mode/
└── transition-plan-two-mode/  # complete ✅
```

Options to consider:

**Option A: Keep as Features**
- They are feature improvements to the command system
- Templates receive these commands
- Follows current pattern

**Option B: Move to CI**
- They're internal tooling improvements
- Not directly user-facing
- CI folder already cluttered though

**Option C: Consolidate into Single Feature**
```
admin/planning/features/command-two-mode-pattern/
├── README.md
├── feature-plan.md
├── transition-plan/  # ✅ Complete
├── explore/          # 🟡 Planned
├── decision/         # 🟡 Planned
└── reflect/          # 🔴 Needs Evaluation
```

**Option D: Create Commands Improvement Category**
```
admin/planning/commands/
├── improvements/
│   ├── two-mode-pattern/
│   │   ├── transition-plan/ ✅
│   │   ├── explore/ 🟡
│   │   └── ...
│   └── input-sources/
│       └── explore-inputs/
└── usage-tracker.md  # already exists here
```

---

## 🔍 Key Questions

- [ ] Question 1: Should `*-two-mode` features be consolidated, and if so, what structure?
- [ ] Question 2: Are command improvements "features" or "internal tooling/CI"?
- [ ] Question 3: What should the `--topic --type` pattern look like across commands?
- [ ] Question 4: What input sources should `/explore` accept beyond `start.txt`?
- [ ] Question 5: Should scaffolding size be consistent (~60-80 lines) across all two-mode commands?
- [ ] Question 6: How do we handle existing `explore-two-mode` feature plan during consolidation?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research explore-two-mode --from-explore explore-two-mode` to conduct research
3. After research, use `/decision explore-two-mode --from-research` to make decisions

---

## 📝 Notes

### Observation from Recent Work

The `transition-plan-two-mode` feature demonstrated:
- ~3 hours actual effort (estimated 4-6)
- Clear 4-phase structure worked well
- ADRs valuable for complex decisions
- Learnings capture essential for future commands

### Existing Feature Plan Overlap

The `admin/planning/features/explore-two-mode/` feature plan focuses narrowly on two-mode pattern. This exploration is broader, covering:
- Input sources (not in existing plan)
- Topic unification (not in existing plan)
- Consolidation (not in existing plan)

Should decide whether to:
1. Expand the existing feature to cover all concerns
2. Create separate explorations/features for each concern
3. Archive existing feature and create new consolidated approach

---

**Last Updated:** 2025-12-30

