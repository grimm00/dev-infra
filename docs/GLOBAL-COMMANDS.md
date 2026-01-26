# Global Commands Installation Guide

**Purpose:** Reference for installing dev-infra commands globally  
**Global Location:** `~/.cursor/commands/`  
**Last Updated:** 2025-12-31

---

## 📋 Overview

Dev-infra commands can be installed globally for use across all projects. Commands are installed to `~/.cursor/commands/` using one of three methods:

1. **dt-cursor-install** (Recommended) - Automated installation via dev-toolkit
2. **Manual Download** - Download from dev-infra releases
3. **From Template** - Commands included when creating new projects

---

## 🚀 Installation

### Using dt-cursor-install (Recommended)

If you have [dev-toolkit](https://github.com/grimm00/dev-toolkit) installed:

```bash
# Install latest commands
dt-cursor-install

# Install specific version
dt-cursor-install --install v0.8.0

# Check installed version
dt-cursor-install --status

# Update to latest
dt-cursor-install --update

# List available versions
dt-cursor-install --list
```

### Manual Installation

Download and extract from dev-infra releases:

```bash
# Download specific version
VERSION="0.8.0"
curl -L -o "commands-v${VERSION}.tar.gz" \
  "https://github.com/grimm00/dev-infra/releases/download/v${VERSION}/commands-v${VERSION}.tar.gz"

# Create directory
mkdir -p ~/.cursor/commands

# Extract
tar -xzf "commands-v${VERSION}.tar.gz" -C ~/.cursor --strip-components=1

# Verify
ls ~/.cursor/commands/
```

### From Template (Project Creation)

When creating a new project with dev-infra templates:

```bash
./scripts/new-project.sh my-project
```

Commands are automatically included in `.cursor/commands/`.

---

## 🔄 Version Tracking

Installed version is tracked in `~/.dev-toolkit/cursor-commands-version`.

```bash
# Check installed version
cat ~/.dev-toolkit/cursor-commands-version
```

---

## ⬆️ Updating Commands

```bash
# Check for updates
dt-cursor-install --status

# Update to latest
dt-cursor-install --update
```

---

## 🔄 Command Pipeline

Commands follow a natural progression from exploration to implementation:

### Ideation Pipeline

`/explore` is the **entry point** for the ideation pipeline:

```
/explore [topic]              ← Setup: scaffolding
    ↓ human review
/explore [topic] --conduct    ← Conduct: full exploration
    ↓
/research --from-explore      ← Research: investigate topics
    ↓
/decision --from-research     ← Decisions: create ADRs
    ↓
/transition-plan --from-adr   ← Planning: create phases
    ↓
/task-phase 1 1               ← Implementation: execute phases
```

**Key Points:**

- `/explore` is the **only command handling unstructured input** (raw ideas, brain dumps)
- Natural entry point for new ideas before they're structured
- Human review gate between setup and conduct modes
- Subsequent commands receive structured input from previous stages

**Two-Mode Pattern:**

`/explore` uses the [two-mode pattern](TWO-MODE-PATTERN.md):
- **Setup Mode** (default): Creates lightweight scaffolding (~60-80 lines)
- **Conduct Mode** (`--conduct`): Full exploration (~200-300 lines)

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

## 🔧 Install by Tier (From Local Clone)

If you have dev-infra cloned locally, you can install specific tiers:

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

## 🔗 Related

- **[Command Distribution Standard](../admin/planning/standards/command-distribution/README.md)** - Process standard
- **[Command Bundle Format](COMMAND-BUNDLE-FORMAT.md)** - Bundle specification
- **[Command Adaptation Pattern](COMMAND-ADAPTATION-PATTERN.md)** - How to adapt commands for different projects
- **[dev-toolkit](https://github.com/grimm00/dev-toolkit)** - Automated installation tool

---

**Last Updated:** 2025-12-31

