# ADR-001: Worktree Location and Naming Convention

**Status:** ✅ Accepted  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## Context

We need a consistent approach for creating and naming git worktrees for feature development. The naming must:
- Be predictable and discoverable
- Work well with Cursor's window titles
- Avoid Cursor confirmation prompts
- Enable easy navigation between worktrees

**Related Research:**
- [research-worktree-naming-conventions.md](../../research/worktree-feature-workflow/research-worktree-naming-conventions.md)

**Related Requirements:**
- FR-1: Directory-Branch Name Mirroring
- FR-2: Project-Relative Location
- FR-3: Gitignore Configuration
- NFR-1: Meaningful Names Required
- NFR-2: Type Prefix Convention

---

## Decision

**Use a `worktrees/` directory with names that mirror branch names.**

### Location

```
project-root/
└── worktrees/           # All worktrees here
    ├── feat-feature-a/  # Feature worktree
    ├── feat-feature-b/  # Another feature
    └── fix-bug-123/     # Fix worktree
```

### Naming Convention

| Branch | Worktree Directory |
|--------|-------------------|
| `feat/worktree-feature-workflow` | `worktrees/feat-worktree-feature-workflow` |
| `fix/critical-bug` | `worktrees/fix-critical-bug` |
| `docs/update-readme` | `worktrees/docs-update-readme` |

**Rule:** Replace `/` with `-` in branch name.

### Gitignore

```gitignore
# Git worktrees
worktrees/
```

---

## Consequences

### Positive

- **Predictable mapping:** Branch name → directory name is 1:1
- **Window titles:** Cursor displays directory name, providing instant context
- **No prompts:** `worktrees/` doesn't trigger Cursor confirmation (unlike `.cursor/`)
- **Discoverability:** `git worktree list` shows all active worktrees
- **Clean repo:** Worktrees are gitignored, no clutter

### Negative

- **Manual creation:** No automation for worktree creation (acceptable trade-off)
- **Branch deletion:** Must manually clean up worktrees when branches are deleted

---

## Alternatives Considered

### Alternative 1: `.cursor/worktrees/`

**Description:** Put worktrees under `.cursor/` directory.

**Pros:**
- Hidden from normal file browsing
- Cursor-specific location

**Cons:**
- Triggers Cursor confirmation prompts (discovered in exploration)
- Hidden can make debugging harder

**Why not chosen:** Confirmation prompts disrupt workflow.

---

### Alternative 2: Home directory worktrees

**Description:** Put worktrees in `~/.worktrees/project-name/`

**Pros:**
- Completely outside project
- Shared location for all projects

**Cons:**
- Harder to discover (not project-relative)
- `git worktree list` doesn't show path context
- Breaks mental model of "project contains everything"

**Why not chosen:** Discoverability is worse.

---

### Alternative 3: Arbitrary naming

**Description:** Allow any naming convention.

**Pros:**
- Maximum flexibility

**Cons:**
- No predictability
- Can't derive directory from branch name
- Window titles less meaningful

**Why not chosen:** Predictability is valuable.

---

## Decision Rationale

**Key Factors:**
1. **Cursor integration:** `.cursor/` prompts are disruptive
2. **Discoverability:** `git worktree list` works from any worktree
3. **Predictability:** 1:1 branch→directory mapping
4. **Window titles:** Meaningful names improve context switching

**Research Support:**
- Topic 1 research confirmed `worktrees/` avoids prompts
- Window title importance validated during exploration

---

## Implementation

1. Add `worktrees/` to `.gitignore`
2. Create worktrees with: `git worktree add -b feat/name worktrees/feat-name develop`
3. Commands output `cursor worktrees/feat-name` for easy opening

---

## References

- [Research: Worktree Naming Conventions](../../research/worktree-feature-workflow/research-worktree-naming-conventions.md)
- [Requirements Document](../../research/worktree-feature-workflow/requirements.md)

---

**Last Updated:** 2026-01-09
