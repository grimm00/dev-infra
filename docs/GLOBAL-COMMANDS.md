# Global Commands Installation Guide

**Purpose:** Reference for installing dev-infra commands globally  
**Global Location:** `~/.cursor/commands/`  
**Last Updated:** 2025-12-30

---

## 📋 Overview

Dev-infra commands can be installed globally for use across all projects. Commands are copied from `dev-infra/.cursor/commands/` to `~/.cursor/commands/`.

**Future:** dev-toolkit will automate this installation process.

---

## 🎯 Command Tiers

Commands are organized by importance and use case. Install based on your workflow needs.

### Tier 1: Core Workflow (Essential)

The explore → research → decision → transition-plan flow.

| Command | Purpose | Priority |
|---------|---------|----------|
| `explore.md` | Start explorations, identify research topics | 🔴 High |
| `research.md` | Conduct structured research (two-mode) | 🔴 High |
| `decision.md` | Create ADRs from research | 🔴 High |
| `transition-plan.md` | Create feature plans from ADRs (two-mode) | 🔴 High |
| `reflect.md` | Project reflections and suggestions | 🔴 High |
| `reflection-artifacts.md` | Extract artifacts from reflections | 🟡 Medium |

**Install command:**
```bash
cp dev-infra/.cursor/commands/{explore,research,decision,transition-plan,reflect,reflection-artifacts}.md ~/.cursor/commands/
```

---

### Tier 2: PR & Fix Workflow

Pull request creation and fix management.

| Command | Purpose | Priority |
|---------|---------|----------|
| `pr.md` | Create pull requests | 🔴 High |
| `pr-validation.md` | Validate PRs before merge | 🟡 Medium |
| `post-pr.md` | Post-merge documentation updates | 🟡 Medium |
| `fix-plan.md` | Create fix batches from reviews | 🟡 Medium |
| `fix-implement.md` | Implement fix batches | 🟡 Medium |

**Install command:**
```bash
cp dev-infra/.cursor/commands/{pr,pr-validation,post-pr,fix-plan,fix-implement}.md ~/.cursor/commands/
```

---

### Tier 3: Task Implementation

Phase and task implementation workflows.

| Command | Purpose | Priority |
|---------|---------|----------|
| `task-phase.md` | Implement feature phase tasks (TDD) | 🔴 High |
| `task-improvement.md` | Implement CI/CD improvements | 🟡 Medium |
| `pre-phase-review.md` | Review phase plans before implementation | 🟡 Medium |
| `address-review.md` | Address gaps from pre-phase review | 🟡 Medium |

**Install command:**
```bash
cp dev-infra/.cursor/commands/{task-phase,task-improvement,pre-phase-review,address-review}.md ~/.cursor/commands/
```

---

### Tier 4: Supporting Commands

Additional workflow support.

| Command | Purpose | Priority |
|---------|---------|----------|
| `status.md` | Project status overview | 🟡 Medium |
| `int-opp.md` | Internal opportunity capture | 🟢 Low |
| `fix-review.md` | Review deferred fixes across PRs | 🟢 Low |
| `cursor-rules.md` | Cursor rules management | 🟢 Low |

**Install command:**
```bash
cp dev-infra/.cursor/commands/{status,int-opp,fix-review,cursor-rules}.md ~/.cursor/commands/
```

---

### Tier 5: Dev-Infra Specific

Commands primarily for dev-infra template development. Generally not needed globally.

| Command | Purpose | Notes |
|---------|---------|-------|
| `release-prep.md` | Release preparation | Dev-infra releases |
| `release-finalize.md` | Release finalization | Dev-infra releases |
| `post-release.md` | Post-release updates | Dev-infra releases |
| `task-release.md` | Release task implementation | Dev-infra releases |

---

## 🔧 Installation

### Install All Commands

```bash
cp dev-infra/.cursor/commands/*.md ~/.cursor/commands/
```

### Install by Tier

```bash
# Tier 1 only (essential)
cp dev-infra/.cursor/commands/{explore,research,decision,transition-plan,reflect,reflection-artifacts}.md ~/.cursor/commands/

# Tier 1 + 2 (full workflow)
cp dev-infra/.cursor/commands/{explore,research,decision,transition-plan,reflect,reflection-artifacts,pr,pr-validation,post-pr,fix-plan,fix-implement}.md ~/.cursor/commands/
```

### Verify Installation

```bash
ls ~/.cursor/commands/
```

---

## 📊 Current Global Status

Track which commands are installed globally:

| Command | Global | Version | Last Updated |
|---------|--------|---------|--------------|
| `transition-plan.md` | ✅ | Two-mode | 2025-12-30 |
| `status.md` | ✅ | - | - |
| Others | ❌ | - | - |

---

## 🔄 Syncing Updates

When commands are updated in dev-infra, re-copy to global:

```bash
# Sync specific command
cp dev-infra/.cursor/commands/transition-plan.md ~/.cursor/commands/

# Sync all
cp dev-infra/.cursor/commands/*.md ~/.cursor/commands/
```

**Future:** dev-toolkit will provide `dt-sync-commands` or similar.

---

## 🔗 Related

- **[Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md)** - How to adapt commands for different projects
- **[dev-toolkit](../../dev-toolkit/)** - Future automated installation

---

**Last Updated:** 2025-12-30

