# Research: Worktree Naming Conventions

**Research Topic:** Worktree Feature Workflow  
**Question:** What naming conventions and locations work best for manually-created worktrees?  
**Status:** 🔴 Research  
**Priority:** 🔴 High  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

What naming conventions and locations work best for manually-created worktrees?

**Sub-questions:**
- What naming pattern? `feat-<name>` vs `<feature-name>` vs `<type>-<name>`?
- Should directory name mirror branch name (e.g., `feat-foo` ↔ `feat/foo`)?
- How does naming affect window title identification?
- How to list/document active worktrees?
- Does Cursor work well with manual worktrees?

---

## 🔍 Research Goals

- [ ] Goal 1: Determine optimal naming pattern for worktree directories
- [ ] Goal 2: Understand relationship between directory names and branch names
- [ ] Goal 3: Verify Cursor compatibility with manual worktrees
- [ ] Goal 4: Define discoverability mechanism for active worktrees

---

## 💡 Pre-Research Insights

These insights were captured during exploration:

> `worktrees/` directory (project-relative) avoids Cursor confirmation prompts that `.cursor/worktrees/` triggers.

> Window titles become the primary identifier when using per-window focus - reinforces importance of meaningful names.

**Current worktree (this feature):**
- Branch: `feat/worktree-feature-workflow`
- Directory: `worktrees/feat-worktree-feature-workflow`
- Pattern used: `<type>-<name>` mirroring branch (minus slash)

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Git worktree documentation (official)
- [ ] Cursor/VS Code worktree behavior
- [ ] Community practices and patterns
- [ ] Web search: worktree naming conventions

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
