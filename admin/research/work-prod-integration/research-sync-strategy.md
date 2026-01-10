# Research: Sync Strategy

**Research Topic:** Work-prod Integration  
**Question:** How should local registry sync with work-prod? Push on create? Periodic? Manual?  
**Status:** ✅ Complete  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 🎯 Research Question

How should local registry sync with work-prod? Push on create? Periodic? Manual?

---

## 🔍 Research Goals

- [x] Goal 1: Evaluate when projects should be registered (on create, on push, manually)
- [x] Goal 2: Design conflict handling between local and remote
- [x] Goal 3: Decide if sync should be automatic or explicit
- [x] Goal 4: Determine source of truth (local, remote, or per-project)

---

## 📚 Research Methodology

**Approach:** Research sync patterns for distributed state management.

**Sources:**
- [x] Git's sync model (push/pull pattern)
- [x] Cloud CLI patterns (AWS, gcloud)
- [x] Offline-first application patterns

---

## 📊 Findings

### Finding 1: Git Model - Explicit Push/Pull

Git's model:
1. Work locally (commits are local)
2. Explicitly push when ready to share
3. Explicitly pull to get remote changes

This gives user full control and works offline.

**Source:** Git distributed model

**Relevance:** Proven model for local-first with remote backup.

---

### Finding 2: Automatic vs Manual Sync

| Approach | Pros | Cons |
|----------|------|------|
| Auto-sync on create | Zero friction | Requires network, surprising |
| Manual sync | User control, works offline | Extra step |
| Background sync | Best of both | Complex, may conflict |

For single-user CLI tool, manual sync is simplest and most predictable.

**Source:** Industry patterns analysis

**Relevance:** Manual sync is appropriate for dev-infra.

---

### Finding 3: Source of Truth Hierarchy

Three-layer model:

1. **Per-project `.dev-infra.yml`** - Authoritative for project metadata
2. **Local registry** - Index of all projects on this machine
3. **Work-prod** - Cloud backup and cross-machine visibility

Source of truth order: Per-project > Local > Remote

**Source:** Internal analysis

**Relevance:** Clear hierarchy prevents conflicts.

---

### Finding 4: Conflict Resolution Strategy

Since dev-infra is single-user:
- Conflicts are rare (same person on different machines)
- Local always wins (user's current context is authoritative)
- Work-prod is backup/sync, not authority

Strategy: **Last-write wins** with local preference.

**Source:** Simplicity analysis for single-user context

**Relevance:** Simple conflict strategy is sufficient.

---

## 🔍 Analysis

**Sync Trigger Options:**

| Trigger | When | Command |
|---------|------|---------|
| On project create | Automatic | `new-project.sh` |
| Manual push | User-initiated | `dev-infra push` |
| Manual pull | User-initiated | `dev-infra pull` |

**Recommended approach:**
- On create: Add to local registry only (instant, offline)
- Manual push: Sync local registry to work-prod
- Manual pull: Sync work-prod to local registry

**Key Insights:**
- [x] Insight 1: Local-first with manual sync is best
- [x] Insight 2: Per-project metadata is source of truth
- [x] Insight 3: Work-prod is backup/visibility layer, not authority
- [x] Insight 4: Last-write-wins is sufficient for single user

---

## 💡 Recommendations

- [x] Recommendation 1: Local-first - add to registry immediately, work-prod sync is separate
- [x] Recommendation 2: Explicit push command: `dev-infra sync push`
- [x] Recommendation 3: Explicit pull command: `dev-infra sync pull`
- [x] Recommendation 4: Last-write-wins for conflicts (local preference)

---

## 📋 Requirements Discovered

- [x] FR-11: Add to local registry on project creation (automatic)
- [x] FR-12: Manual push command to sync to work-prod
- [x] FR-13: Manual pull command to sync from work-prod
- [x] FR-14: Last-write-wins conflict resolution
- [x] NFR-5: All operations must work offline (work-prod is optional)

---

## 🚀 Next Steps

1. Design sync command interface
2. Implement local registry operations first
3. Add work-prod sync as enhancement

---

**Last Updated:** 2025-12-19
