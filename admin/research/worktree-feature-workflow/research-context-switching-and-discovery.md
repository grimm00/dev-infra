# Research: Context Switching and Discovery

**Research Topic:** Worktree Feature Workflow  
**Question:** How to efficiently switch between worktrees and discover what's active?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

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

- [x] Goal 1: Define worktree listing/discovery mechanism
- [x] Goal 2: Establish context switching workflow
- [x] Goal 3: Determine status visibility approach
- [x] Goal 4: Evaluate `/worktree` command value

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

**Sources:**
- [x] Git worktree documentation
- [x] Cursor CLI testing
- [x] Current worktree state analysis
- [x] Exploration insights

---

## 📊 Findings

### Finding 1: Git Worktree List is Comprehensive

`git worktree list` provides all needed discovery information:

```
/Users/cdwilson/Projects/dev-infra                                           726113a [develop]
/Users/cdwilson/Projects/dev-infra/worktrees/feat-explore-two-mode           b8db1e5 [feat/explore-two-mode]
/Users/cdwilson/Projects/dev-infra/worktrees/feat-worktree-feature-workflow  a2e51cd [feat/worktree-feature-workflow]
```

**Shows:**
- Full path to each worktree
- Current commit hash
- Associated branch name

**Porcelain format available for scripting:**
```
git worktree list --porcelain
```

**Source:** Direct testing

**Relevance:** No custom tooling needed for discovery - git provides it.

---

### Finding 2: Cursor CLI Supports Direct Opening

The `cursor` CLI is installed and works:

```bash
cursor /path/to/worktree
```

**Cursor CLI features:**
- Opens path in new window
- `cursor --add <folder>` adds to current window
- Available at `/usr/local/bin/cursor`

**Source:** Direct testing (`which cursor`, `cursor --help`)

**Relevance:** Commands can output copy-paste ready `cursor` commands.

---

### Finding 3: Context Switching is Directory Navigation

With per-window focus, context switching is simply:
1. **Terminal:** `cd /path/to/worktree`
2. **Cursor:** `cursor /path/to/worktree`
3. **Finder/Explorer:** Navigate to directory

**No special tooling needed** - the worktree IS the context.

**Source:** Exploration insights, direct testing

**Relevance:** Keep it simple - don't over-engineer.

---

### Finding 4: Handoff Documents Enable Session Continuity

The `tmp/handoff.md` pattern (already in use) provides:
- Current focus/status
- Key files to reference
- Next actions
- Resume command (`cursor /path/to/worktree`)

This solves the "where was I?" problem across sessions.

**Source:** Current exploration using this pattern

**Relevance:** Simple markdown file > complex tooling.

---

### Finding 5: /worktree Command Value Assessment

| Command Feature | Value | Alternative |
|-----------------|-------|-------------|
| List worktrees | Low | `git worktree list` |
| Create worktree | Medium | `git worktree add ...` |
| Open worktree | Medium | `cursor <path>` |
| Status overview | Low | `git worktree list` |
| Create + scaffold docs | **High** | No alternative |

**The only high-value feature:** Creating worktree AND scaffolding exploration docs together.

**Recommendation:** A `/worktree` command is only worthwhile if it:
1. Creates the worktree
2. Creates the feature branch
3. Scaffolds exploration/research docs
4. Outputs the `cursor` command

Otherwise, the native git + cursor commands suffice.

**Source:** Analysis of use cases

**Relevance:** Avoid building low-value tooling.

---

### Finding 6: Window Title is Primary Identifier

With meaningful worktree names (Topic 1), window titles provide instant context:

```
feat-worktree-feature-workflow — Cursor
feat-explore-two-mode — Cursor
```

No additional status visibility needed - the window title IS the status.

**Source:** Exploration insights

**Relevance:** Reinforces importance of naming (Topic 1).

---

## 🔍 Analysis

**Core insight:** The worktree workflow is already well-supported by native tools:
- `git worktree list` for discovery
- `cursor <path>` for opening
- Window titles for identification
- `tmp/handoff.md` for session continuity

**Don't over-engineer.** The minimal approach:
1. Use native git commands
2. Use cursor CLI
3. Use handoff documents
4. Only build `/worktree` if it adds scaffold value

**Key Insights:**
- [x] Insight 1: `git worktree list` provides complete discovery
- [x] Insight 2: `cursor` CLI enables easy opening
- [x] Insight 3: Context switching is just directory navigation
- [x] Insight 4: Handoff documents solve session continuity
- [x] Insight 5: `/worktree` command only valuable if it scaffolds docs
- [x] Insight 6: Window titles are primary identifiers (ties back to naming)

---

## 💡 Recommendations

- [x] Recommendation 1: Use `git worktree list` for discovery (no custom tool)
- [x] Recommendation 2: Use `cursor <path>` for opening worktrees
- [x] Recommendation 3: Commands creating worktrees should output `cursor` command
- [x] Recommendation 4: Use `tmp/handoff.md` for session continuity
- [x] Recommendation 5: Only build `/worktree` command if it scaffolds exploration docs
- [x] Recommendation 6: Don't over-engineer - native tools are sufficient

---

## 📋 Requirements Discovered

- [x] FR-18: Commands creating worktrees MUST output `cursor <path>` for opening
- [x] FR-19: Handoff documents SHOULD be created in `tmp/handoff.md`
- [x] NFR-9: Context switching SHOULD use native tools (git, cursor CLI)
- [x] NFR-10: Discovery SHOULD use `git worktree list` (no custom tooling)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. All 5 research topics complete - ready for decision phase!

---

**Last Updated:** 2026-01-09
