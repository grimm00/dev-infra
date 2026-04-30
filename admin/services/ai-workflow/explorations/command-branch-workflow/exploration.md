# Command Branch Workflow - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-10  
**Last Updated:** 2025-12-10

---

## 🎯 What Are We Exploring?

A dedicated workflow for command-related changes that includes:

1. **Branch pattern:** `cmd/*` branch type for all command work
2. **Tracking:** Automatic integration with `admin/planning/ci/command-documentation-maintenance/`
3. **Workflow command:** `/command-update` or `/cmd` to manage the complete workflow

---

## 🤔 Why Explore This?

**Context:**

- We have 40+ Cursor commands in `.cursor/commands/`
- Command updates happen frequently (7 tracked updates since 2025-12-08)
- Current process is manual and inconsistent
- No distinction between documentation-only and code-affecting command changes

**Problems this could solve:**

1. **Consistency** - Standardized branch naming for command work
2. **Automation** - Automatic tracking document creation
3. **Visibility** - Better tracking of command changes over time
4. **Separation** - Clear distinction from `docs/*` and `feat/*` branches

**Opportunity:**

- Streamline command maintenance workflow
- Reduce manual tracking overhead
- Better coordinate command-related changes
- Provide a model for other project types using dev-infra templates

---

## 💡 Initial Thoughts

### Branch Pattern Options

| Pattern | Pros | Cons |
|---------|------|------|
| `cmd/*` | Short, clear | New pattern to learn |
| `command/*` | Explicit | Longer typing |
| `docs/cmd-*` | Uses existing `docs` pattern | Mixed with other docs |
| `chore/cmd-*` | Uses existing `chore` pattern | Semantically incorrect |

**Recommendation:** `cmd/*` - short, distinct, and clear purpose.

### Command Workflow Options

**Option A: Single command for all command work**

```bash
/command-update [command-name] [--new|--fix|--enhance]

# Examples:
/command-update task-phase --fix       # Fix existing command
/command-update my-new-cmd --new       # Create new command
/command-update pr --enhance           # Enhance existing command
```

**Option B: Separate commands for each type**

```bash
/command-new [command-name]            # Create new command
/command-fix [command-name]            # Fix existing command
/command-enhance [command-name]        # Enhance existing command
```

**Option C: Extension of existing workflow**

```bash
# Use existing patterns with command-specific tracking
/task-phase --command [command-name]   # Phase-based command development
/fix-implement --command [command-name] # Fix command issues
```

**Recommendation:** Option A - unified command with flags

### Tracking Document Auto-generation

The workflow command could auto-generate:

1. **Tracking document** in `updates/YYYY-MM-DD-[command-name]-[type].md`
2. **README update** with new entry in Recent Updates
3. **Branch creation** with correct pattern
4. **Commit message template** following conventions

---

## 🔍 Key Questions

- [ ] Question 1: Should `cmd/*` branches follow PR workflow or direct-merge pattern?
- [ ] Question 2: How should command code changes (TDD) vs. documentation-only changes be distinguished?
- [ ] Question 3: Should new commands go through feature planning (`admin/planning/features/`) or just tracking?
- [ ] Question 4: How does this integrate with existing command testing automation plans?
- [ ] Question 5: Should there be a review step for command changes (like Sourcery for PRs)?

---

## 🏗️ Proposed Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│                    /command-update [name] [type]                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │  1. Create cmd/* branch       │
              │     cmd/[name]-[type]         │
              └───────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │  2. Generate tracking doc     │
              │     updates/YYYY-MM-DD-...    │
              └───────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │  3. Open command file         │
              │     .cursor/commands/[name]   │
              └───────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │  4. User makes changes        │
              │     (guided by tracking doc)  │
              └───────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │  5. Commit with template      │
              │     docs(commands): ...       │
              └───────────────────────────────┘
                              │
                              ▼
         ┌────────────────────┴────────────────────┐
         │                                         │
    docs-only?                               code changes?
         │                                         │
         ▼                                         ▼
┌─────────────────┐                      ┌─────────────────┐
│ Direct merge    │                      │ PR workflow     │
│ to develop      │                      │ with review     │
└─────────────────┘                      └─────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │  6. Update tracking README    │
              │     Add to Recent Updates     │
              └───────────────────────────────┘
```

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Investigate branch pattern implications
3. Prototype `/command-update` command
4. Document decision in ADR if proceeding

---

## 📝 Notes

**Integration considerations:**

- This could be a template feature (include in `templates/standard-project/`)
- Could integrate with command testing automation CI/CD improvement
- Should align with existing `docs/*` branch direct-merge pattern for docs-only changes

**Alternative approaches:**

- Continue with current manual workflow (status quo)
- Add automation without new branch pattern
- Create commands but skip branch pattern (just tracking)

---

**Last Updated:** 2025-12-10

