# Research: Multi-machine Sync

**Research Topic:** Work-prod Integration  
**Question:** How to sync local registries across machines via work-prod?  
**Status:** ✅ Complete  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 🎯 Research Question

How to sync local registries across machines via work-prod?

---

## 🔍 Research Goals

- [x] Goal 1: Evaluate if work-prod can serve as source of truth
- [x] Goal 2: Design handling for projects existing on one machine but not another
- [x] Goal 3: Decide what `dev-infra list` shows (all work-prod or local only)
- [x] Goal 4: Design "clone from work-prod" workflow if needed

---

## 📚 Research Methodology

**Approach:** Research multi-machine sync patterns for developer tools.

**Sources:**
- [x] Dotfiles sync patterns
- [x] 1Password CLI cross-machine model
- [x] VS Code Settings Sync

---

## 📊 Findings

### Finding 1: Local vs Remote Registry Views

Two views of project registry:

| View | Contents | Use Case |
|------|----------|----------|
| Local | Projects on this machine | Day-to-day operations |
| Remote | All registered projects | Discovery, cross-machine |

`dev-infra list` should show local by default, with flag for remote.

**Source:** UX analysis

**Relevance:** Clear separation of local vs remote state.

---

### Finding 2: Projects Exist on One Machine, Not Another

Scenario: Project created on Machine A, user moves to Machine B.

Options:
1. **Pull metadata only** - Registry knows about project, but no local files
2. **Clone project** - Full git clone to get files
3. **Mark as "remote only"** - Show in list but not accessible

**Recommendation:** Pull metadata, show in list as "not local", user can clone manually.

**Source:** UX analysis

**Relevance:** Metadata sync is separate from code sync.

---

### Finding 3: Work-prod as Discovery Layer

Work-prod provides:
- List of all projects across machines
- Metadata for discovery/search
- NOT the actual project files

Think of it like a "project index" not "project storage".

**Source:** Architecture analysis

**Relevance:** Work-prod is registry, not file storage.

---

### Finding 4: Sync Flow

```
Machine A:                    Work-prod:                    Machine B:
┌─────────┐                  ┌─────────┐                   ┌─────────┐
│ Local   │  ──push──▶       │ Remote  │       ◀──pull──  │ Local   │
│ Registry│                  │ Registry│                   │ Registry│
└─────────┘                  └─────────┘                   └─────────┘
     │                                                           │
     ▼                                                           ▼
┌─────────┐                                               ┌─────────┐
│ Project │  (git push/clone for actual files)            │ Project │
│ Files   │                                               │ Files   │
└─────────┘                                               └─────────┘
```

Registry sync is separate from file sync (handled by git).

**Source:** Architecture design

**Relevance:** Clear separation of concerns.

---

## 🔍 Analysis

**Command Design:**

| Command | Behavior |
|---------|----------|
| `dev-infra list` | Show local projects only |
| `dev-infra list --all` | Show local + remote (not-local marked) |
| `dev-infra sync push` | Push local registry to work-prod |
| `dev-infra sync pull` | Pull work-prod registry to local |
| `dev-infra status` | Show sync status (local vs remote diff) |

**Key Insights:**
- [x] Insight 1: Work-prod is registry index, not file storage
- [x] Insight 2: Local list by default, remote with flag
- [x] Insight 3: Projects not on machine show as "not local"
- [x] Insight 4: File sync handled by git, not dev-infra

---

## 💡 Recommendations

- [x] Recommendation 1: `list` shows local by default, `--all` includes remote
- [x] Recommendation 2: Mark remote-only projects clearly
- [x] Recommendation 3: Don't try to clone files - leave that to git
- [x] Recommendation 4: `status` command shows sync state

---

## 📋 Requirements Discovered

- [x] FR-18: `list` shows local projects by default
- [x] FR-19: `list --all` shows local + remote projects
- [x] FR-20: Remote-only projects clearly marked in list
- [x] FR-21: `status` command shows sync state
- [x] NFR-8: Registry sync is metadata only (not file sync)

---

## 🚀 Next Steps

1. Design list command with local/all flag
2. Design status command for sync state
3. Clear UX for remote-only projects

---

**Last Updated:** 2025-12-19
