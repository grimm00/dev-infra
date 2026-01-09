# Research: Worktree Naming Conventions

**Research Topic:** Worktree Feature Workflow  
**Question:** What naming conventions and locations work best for manually-created worktrees?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

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

- [x] Goal 1: Determine optimal naming pattern for worktree directories
- [x] Goal 2: Understand relationship between directory names and branch names
- [x] Goal 3: Verify Cursor compatibility with manual worktrees
- [x] Goal 4: Define discoverability mechanism for active worktrees

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
- [x] Git worktree documentation (official)
- [x] Cursor/VS Code worktree behavior (tested directly)
- [x] Community practices and patterns
- [x] Web search: worktree naming conventions

---

## 📊 Findings

### Finding 1: Industry Pattern - Mirror Branch Names

The most common pattern is to make worktree directory names mirror branch names with slashes replaced by hyphens. This creates a 1:1 mapping:

| Branch Name | Directory Name |
|-------------|----------------|
| `feat/login-page` | `feat-login-page` |
| `bugfix/issue-123` | `bugfix-issue-123` |
| `hotfix/v1.2.3` | `hotfix-v1.2.3` |

**Source:** Web search: git worktree naming conventions (docs.worktreewise.com, microsoft.github.io, compilenrun.com)

**Relevance:** This pattern is intuitive - you can infer the branch from the directory and vice versa. Window titles display the directory name, so meaningful names provide context.

---

### Finding 2: Dedicated Directory Pattern

Best practice is to organize worktrees in a dedicated directory (e.g., `wip/`, `worktrees/`) and add it to `.gitignore`. This:
- Keeps the repository clean
- Prevents tracking worktree directories
- Provides a predictable location

Common patterns:
- `wip/<branch-name>/` - "work in progress"
- `worktrees/<branch-name>/` - explicit purpose
- `trees/<branch-name>/` - shorter

**Source:** Web search: claude-plugins.dev, microsoft.github.io

**Relevance:** Our `worktrees/` directory follows this pattern. Adding to `.gitignore` prevents accidental commits.

---

### Finding 3: Git Worktree List Provides Discoverability

The `git worktree list` command shows all active worktrees:

```
/Users/cdwilson/Projects/dev-infra                                           726113a [develop]
/Users/cdwilson/Projects/dev-infra/worktrees/feat-explore-two-mode           9e880b7 [feat/explore-two-mode]
/Users/cdwilson/Projects/dev-infra/worktrees/feat-worktree-feature-workflow  1c7d8a9 [feat/worktree-feature-workflow]
```

This provides:
- Full path to each worktree
- Current commit hash
- Associated branch name

**Source:** Direct testing with `git worktree list`

**Relevance:** Built-in discoverability eliminates need for manual documentation. Scripts can parse this output.

---

### Finding 4: Cursor Works Well with Manual Worktrees

Direct testing confirms:
- Cursor opens manual worktrees correctly
- Window title shows the directory name (e.g., "feat-worktree-feature-workflow")
- Each worktree is treated as an independent project
- AI context is scoped to the worktree (good for focused work)

**Key discovery:** Using `worktrees/` (not `.cursor/worktrees/`) avoids confirmation prompts.

**Source:** Direct testing with Cursor IDE

**Relevance:** Manual worktrees provide better naming (meaningful vs Cursor's random 3-letter codes like `wxw`, `eik`).

---

### Finding 5: Type Prefixes Aid Categorization

Using type prefixes in branch/directory names helps categorization:
- `feat-*` / `feature-*` - new features
- `fix-*` / `bugfix-*` - bug fixes
- `hotfix-*` - urgent production fixes
- `docs-*` - documentation
- `chore-*` - maintenance

This aligns with conventional commit prefixes and Git Flow patterns.

**Source:** Web search: compilenrun.com, geeksforgeeks.org

**Relevance:** Type prefixes provide immediate context about the work type without reading docs.

---

### Finding 6: Avoid Generic Names

Names like `temp`, `test`, or `wip` should be avoided. They:
- Don't convey purpose
- Can be confusing with multiple worktrees
- Make window titles meaningless

Instead, use descriptive names that convey the feature or issue.

**Source:** Web search: microsoft.github.io

**Relevance:** Window titles are primary identifiers when using per-window focus.

---

## 🔍 Analysis

Based on the findings, the optimal naming convention is:

**Directory Name = Branch Name with `/` replaced by `-`**

| Component | Convention | Example |
|-----------|------------|---------|
| Location | `worktrees/` (project-relative) | `worktrees/feat-login-auth` |
| Naming Pattern | `<type>-<name>` | `feat-worktree-feature-workflow` |
| Branch Mapping | 1:1 with directory | `feat/worktree-feature-workflow` ↔ `feat-worktree-feature-workflow` |
| Discoverability | `git worktree list` | Built-in |

**Key Insights:**
- [x] Insight 1: Directory names should mirror branch names for predictability
- [x] Insight 2: Type prefixes (`feat-`, `fix-`, etc.) provide immediate context
- [x] Insight 3: `worktrees/` location avoids Cursor prompts and keeps repo clean
- [x] Insight 4: `git worktree list` provides built-in discoverability
- [x] Insight 5: Window titles display directory name, reinforcing meaningful naming

---

## 💡 Recommendations

- [x] Recommendation 1: Use `worktrees/` directory for all worktrees (project-relative)
- [x] Recommendation 2: Name directories to mirror branch names (`feat/foo` → `feat-foo`)
- [x] Recommendation 3: Use type prefixes for categorization (`feat-`, `fix-`, `docs-`, etc.)
- [x] Recommendation 4: Add `worktrees/` to `.gitignore`
- [x] Recommendation 5: Use `git worktree list` for discoverability (no manual docs needed)
- [x] Recommendation 6: Commands should output `cursor <path>` for easy opening

---

## 📋 Requirements Discovered

- [x] FR-1: Worktree directories MUST be named to mirror branch names (slash → hyphen)
- [x] FR-2: Worktrees MUST be created in `worktrees/` directory (project-relative)
- [x] FR-3: The `worktrees/` directory MUST be added to `.gitignore`
- [x] FR-4: Commands creating worktrees SHOULD output `cursor <path>` for easy opening
- [x] NFR-1: Directory names MUST be meaningful (no generic names like `temp`, `wip`)
- [x] NFR-2: Directory names SHOULD use type prefixes matching branch type

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. Continue with Topic 2: Self-Contained Feature Branches

---

**Last Updated:** 2026-01-09
