# Command Inventory - Dev-Infra vs Work-Prod

**Purpose:** Complete inventory of commands across projects  
**Date:** 2025-12-15  
**Status:** ✅ Complete

---

## 📊 Summary

| Metric | Count |
|--------|-------|
| **Dev-Infra Commands** | 23 |
| **Work-Prod Commands** | 14 |
| **Shared Commands** | 14 |
| **Dev-Infra Only** | 9 |
| **Standard Template** | 18 |
| **Experimental Template** | 19 |

---

## ✅ Commands in Both Projects (14)

These commands exist in both dev-infra and work-prod:

| Command | Purpose | Category |
|---------|---------|----------|
| `/cursor-rules` | Manage Cursor AI rules | Workflow |
| `/fix-implement` | Implement fix batches | Fix Management |
| `/fix-plan` | Create fix plans from reviews | Fix Management |
| `/fix-review` | Review deferred issues | Fix Management |
| `/int-opp` | Capture internal opportunities | Documentation |
| `/post-pr` | Post-merge documentation | PR Workflow |
| `/pr` | Create pull requests | PR Workflow |
| `/pr-validation` | Validate PRs (testing, review) | PR Workflow |
| `/pre-phase-review` | Review phase plans before implementation | Planning |
| `/reflect` | Project reflection and suggestions | Documentation |
| `/reflection-artifacts` | Generate reflection artifacts | Documentation |
| `/task-phase` | Implement phase tasks with TDD | Implementation |
| `/task-release` | Implement release tasks | Release |
| `/transition-plan` | Create phase plans from ADRs | Planning |

---

## 🔴 Commands in Dev-Infra Only (9)

These commands exist in dev-infra but NOT in work-prod:

### Internal Tooling (4) - Not for Templates

Per ADR-002 (Template Factory identity), these are dev-infra internal tooling:

| Command | Purpose | Why Internal |
|---------|---------|--------------|
| `/address-review` | Address pre-phase review gaps | Dev-infra planning workflow |
| `/post-release` | Post-release cleanup | Dev-infra release process |
| `/release-finalize` | Finalize release documents | Dev-infra release process |
| `/release-prep` | Prepare release documents | Dev-infra release process |

### Exploration/Research (3) - Candidates for Sync

| Command | Purpose | Template Status |
|---------|---------|-----------------|
| `/decision` | Create ADR documents | In standard template |
| `/explore` | Start exploration workflow | In standard template |
| `/research` | Research workflow | In standard template |

### Evolving Commands (1) - Experimental Only

| Command | Purpose | Template Status |
|---------|---------|-----------------|
| `/status` | Centralized status tracking | Experimental template only |

### New Commands (1) - Recent Addition

| Command | Purpose | Template Status |
|---------|---------|-----------------|
| `/task-improvement` | CI/CD improvement implementation | In standard template |

---

## 📦 Template Command Distribution

### Standard Template (18 commands)

All stable commands for production projects:

```
cursor-rules, decision, explore, fix-implement, fix-plan, 
fix-review, int-opp, post-pr, pr, pr-validation, 
pre-phase-review, reflect, reflection-artifacts, research,
task-improvement, task-phase, task-release, transition-plan
```

### Experimental Template (19 commands)

Standard + evolving commands for testing:

```
Standard 18 + status
```

### Dev-Infra Internal (4 commands)

Not included in templates:

```
address-review, post-release, release-finalize, release-prep
```

---

## 🔄 Recent Command Changes (Dec 2025)

### New Commands Created

| Command | Created | Notes |
|---------|---------|-------|
| `/release-prep` | 2025-12-10 | Release preparation orchestration |
| `/release-finalize` | 2025-12-11 | Release document finalization |
| `/post-release` | 2025-12-11 | Post-release cleanup |
| `/address-review` | 2025-12-10 | Address pre-phase review gaps |
| `/status` | 2025-12-08 | Centralized status tracking (Evolving) |
| `/task-improvement` | 2025-12 | CI/CD improvement implementation |

### Commands Updated

| Command | Update | Date |
|---------|--------|------|
| `/pr-validation` | Manual testing guide enforcement | 2025-12-15 |
| `/transition-plan` | TDD task ordering guidance | 2025-12-15 |
| `/task-phase` | Branch validation, auto-status | 2025-12-09 |
| `/pr` | Branch detection, worktree awareness | 2025-12-09 |
| `/fix-implement` | PR status check | 2025-12-09 |
| `/reflect` | Centralized reflection location | 2025-12-08 |
| `/research` | Web search encouragement | 2025-12 |

---

## 🎯 Gap Analysis for Work-Prod

### High Priority - Should Sync

| Command | Reason | Action |
|---------|--------|--------|
| `/decision` | ADR creation is useful | Sync from standard template |
| `/explore` | Exploration workflow | Sync from standard template |
| `/research` | Research workflow | Sync from standard template |
| `/task-improvement` | CI/CD improvements | Sync from standard template |

### Medium Priority - Consider

| Command | Reason | Action |
|---------|--------|--------|
| `/status` | Useful but evolving | Wait for graduation or sync from experimental |

### Low Priority - Dev-Infra Internal

| Command | Reason | Action |
|---------|--------|--------|
| `/address-review` | Dev-infra workflow | Keep internal |
| `/post-release` | Dev-infra releases | Keep internal |
| `/release-finalize` | Dev-infra releases | Keep internal |
| `/release-prep` | Dev-infra releases | Keep internal |

---

## 📈 Command Updates Work-Prod Should Get

These are updates made to commands that work-prod already has but may be outdated:

| Command | Update | Impact |
|---------|--------|--------|
| `/pr-validation` | Manual testing guide enforcement | Better PR reviews |
| `/transition-plan` | TDD task ordering | Better phase planning |
| `/task-phase` | Branch validation | Fewer wrong-branch commits |
| `/pr` | Branch detection | Fewer PR creation errors |
| `/fix-implement` | PR status check | Correct fix workflow |
| `/reflect` | Centralized location | Better reflection organization |

---

## 🔗 Related

- **[Command Sync Opportunities](../improvements/command-sync-opportunities.md)** - Action plan for syncing
- **[Dev-Infra Template Commands](.cursor/commands/)** - Source commands
- **[Standard Template](templates/standard-project/.cursor/commands/)** - Template commands

---

**Last Updated:** 2025-12-15

