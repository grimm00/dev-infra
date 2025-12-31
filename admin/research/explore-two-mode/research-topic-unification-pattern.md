# Research: Topic Unification Pattern

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** How should `--topic [name] --type` pattern work across commands?  
**Status:** 🔴 Research  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 🎯 Research Question

How should `--topic [name] --type` pattern work across commands?

**Context:** Currently commands use `--feature`, `--ci`, or implicit type detection. A unified pattern could simplify usage and provide consistent UX across all commands.

---

## 🔍 Research Goals

- [ ] Goal 1: Audit current commands for type-specific flags (`--feature`, `--ci`, `--topic`)
- [ ] Goal 2: Define mapping from `--type` to directory paths
- [ ] Goal 3: Determine interaction with auto-detection (when no type specified)
- [ ] Goal 4: Evaluate if `--topic` should replace positional arguments

---

## 📚 Research Methodology

**Sources:**
- [ ] Current command implementations audit
- [ ] Directory structure mapping analysis
- [ ] Transition-plan command review (uses `--feature`, `--type`)
- [ ] Research command review (uses `--from-explore`, `--topic`)

**Sub-questions to investigate:**
- What commands currently use type-specific flags (`--feature`, `--ci`)?
- What would the mapping from `--type` to directory path look like?
- How does this interact with auto-detection (when no type specified)?
- Should `--topic` replace the positional argument in commands?

---

## 📊 Findings

### Finding 1: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]

---

### Finding 2: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]

---

## 🔍 Analysis

[Analysis of findings]

**Key Insights:**
- [ ] Insight 1: [Description]
- [ ] Insight 2: [Description]

---

## 💡 Recommendations

- [ ] Recommendation 1: [Description]
- [ ] Recommendation 2: [Description]

---

## 📋 Requirements Discovered

[Any requirements discovered during this research]

- [ ] Requirement 1: [Description]
- [ ] Requirement 2: [Description]

---

## 🚀 Next Steps

1. Conduct research with `/research explore-two-mode --conduct --topic-num 2`
2. Document findings
3. Update requirements

---

**Last Updated:** 2025-12-30

