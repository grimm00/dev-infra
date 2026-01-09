# Research: Context Switching and Discovery

**Research Topic:** Worktree Feature Workflow  
**Question:** How to efficiently switch between worktrees and discover what's active?  
**Status:** 🔴 Research  
**Priority:** 🟡 Medium  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

How to efficiently switch between worktrees and discover what's active?

**Sub-questions:**
- How to enhance `git worktree list` output?
- What's the best way to switch between worktrees in Cursor?
- How to see what's being worked on across worktrees?
- Should there be a `/worktree` command?
- How to integrate `cursor` CLI for automatic opening?

---

## 🔍 Research Goals

- [ ] Goal 1: Define worktree listing/discovery mechanism
- [ ] Goal 2: Establish context switching workflow
- [ ] Goal 3: Determine status visibility approach
- [ ] Goal 4: Evaluate `/worktree` command value

---

## 💡 Pre-Research Insights

**Per-window focus is optimal:**
> One feature = one mental context. Cursor AI works best with focused workspace.

**Window titles as identifiers:**
> Window titles become primary identifiers when using per-window focus.

**`cursor` CLI integration opportunity:**
```bash
cursor /path/to/worktree
```

**Potential command output:**
```
✅ Worktree created: feat-explore-two-mode

To open in new Cursor window:
cursor worktrees/feat-explore-two-mode
```

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Git worktree documentation
- [ ] Cursor/VS Code CLI documentation
- [ ] Multi-worktree development patterns
- [ ] Web search: git worktree workflow productivity

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

1. Conduct research using web search
2. Fill in findings
3. Update summary and requirements

---

**Last Updated:** 2026-01-09
