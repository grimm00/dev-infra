# Research: Command Distribution Ownership

**Research Topic:** Four-Arm Architecture  
**Question:** Where should global Cursor command installation live - dev-infra or dev-toolkit?  
**Priority:** 🔴 High  
**Status:** ✅ Complete  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31  
**Completed:** 2025-12-31

---

## 🎯 Research Question

Where should global Cursor command installation live - dev-infra or dev-toolkit?

**Context:** The "Global Command Distribution" research assumed dev-infra would handle installation. With dev-toolkit's existing install infrastructure (`install.sh`, `dt-*` command pattern), this needs reconsideration.

---

## 🔍 Research Goals

- [x] Goal 1: Evaluate dev-toolkit's existing installation infrastructure for command distribution
- [x] Goal 2: Determine the optimal ownership model for command source vs. distribution
- [x] Goal 3: Design versioning relationship between dev-toolkit and dev-infra commands
- [x] Goal 4: Decide whether to create a `dt-cursor-install` command

---

## 📚 Research Methodology

**Sources investigated:**
- [x] Review dev-toolkit's current `install.sh` implementation
- [x] Review dev-infra's current command source structure
- [x] Review global command distribution prior research
- [x] Analyze industry patterns for source vs distribution separation

---

## 📊 Findings

### Finding 1: dev-toolkit Has Mature Installation Infrastructure

**Description:** dev-toolkit already has a well-designed installation system:

```bash
# install.sh capabilities:
- Global vs local installation modes
- Symlink creation in /usr/local/bin
- Config directory management (~/.dev-toolkit)
- Dependency checking (git, gh)
- Clear dt-* command naming pattern
- Help documentation
```

**Current commands:** `dt-config`, `dt-git-safety`, `dt-install-hooks`, `dt-review`, `dt-setup-sourcery`, `dt-sourcery-parse`

**Source:** dev-toolkit `install.sh` (214 lines) and `bin/` directory (6 commands)

**Relevance:** dev-toolkit already has the infrastructure pattern needed for command distribution. Adding Cursor command installation would fit naturally into this existing system.

---

### Finding 2: dev-infra is the Canonical Command Source

**Description:** dev-infra maintains the authoritative source of all 19 Cursor AI workflow commands:

```
templates/standard-project/.cursor/commands/
├── cursor-rules.md    ├── fix-implement.md   ├── post-pr.md
├── decision.md        ├── fix-plan.md        ├── pr-validation.md
├── explore.md         ├── fix-review.md      ├── pr.md
├── int-opp.md         ├── pre-phase-review.md├── reflect.md
├── reflection-artifacts.md ├── research.md   ├── status.md
├── task-improvement.md ├── task-phase.md     ├── task-release.md
└── transition-plan.md
```

**Source:** dev-infra templates directory structure

**Relevance:** Commands are part of dev-infra's core value proposition as the "Template Factory + Contract Hub". They should remain sourced from dev-infra.

---

### Finding 3: Global Commands Already Validated

**Description:** The existing global command distribution research validated that:

| Fact | Status |
|------|--------|
| Global commands work from `~/.cursor/commands/` | ✅ Confirmed |
| Project commands override global commands | ✅ Confirmed |
| Clean isolation (agent unaware of global when project exists) | ✅ Confirmed |
| Global rules from `~/.cursor/rules/` | ❌ Does NOT work |

**Source:** [global-command-distribution research-summary.md](../global-command-distribution/research-summary.md)

**Relevance:** The technical mechanism for global commands is proven. The question is purely about which project owns the installation process.

---

### Finding 4: Source vs Distribution is Industry Standard

**Description:** Industry patterns consistently separate source ownership from distribution:

| Example | Source Owner | Distribution Owner |
|---------|-------------|-------------------|
| npm packages | Package authors | npm CLI |
| Rust tools | rust-lang org | rustup installer |
| VS Code extensions | Extension authors | VS Code marketplace |
| Oh My Zsh plugins | Plugin authors | Oh My Zsh framework |
| Homebrew formulas | Formula maintainers | Homebrew CLI |

**Key insight:** The source owner defines what gets distributed. The distribution owner handles how it gets installed.

**Relevance:** This separation is well-established. dev-infra should own command source, dev-toolkit should own command installation.

---

### Finding 5: User Insight Aligns with Industry Pattern

**Description:** User insight from exploration (2025-12-22):

> "The ability to provide commands that we've developed for Cursor over time seems more like something that would be installed with dev-toolkit than be a part of infrastructure management."

This insight correctly identifies:
- Commands as "things to install" (distribution concern)
- dev-toolkit as an installer (not dev-infra)
- Separation of source (dev-infra) from installation (dev-toolkit)

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

**Relevance:** User intuition aligns perfectly with industry best practices for source/distribution separation.

---

## 🔍 Analysis

### Source vs Distribution Ownership Model

```
┌─────────────────────────────────────────────────────────────────────┐
│                        dev-infra                                     │
│                   (Command Source Owner)                             │
│                                                                      │
│  Responsibilities:                                                   │
│  • Define command content and behavior                               │
│  • Version commands with releases                                    │
│  • Include commands in templates                                     │
│  • Document command usage                                            │
│                                                                      │
│  Output: templates/standard-project/.cursor/commands/                │
│          GitHub releases with command files                          │
└─────────────────────────┬───────────────────────────────────────────┘
                          │
                          │ releases (tagged versions)
                          ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        dev-toolkit                                   │
│                  (Command Distribution Owner)                        │
│                                                                      │
│  Responsibilities:                                                   │
│  • Install commands to ~/.cursor/commands/                           │
│  • Manage command versions                                           │
│  • Handle updates and rollbacks                                      │
│  • Provide dt-cursor-install command                                 │
│                                                                      │
│  New command: dt-cursor-install                                      │
│  Usage: dt-cursor-install [--version v0.7.0] [--list] [--update]    │
└─────────────────────────────────────────────────────────────────────┘
```

### Why dev-toolkit Should Own Distribution

1. **Existing Infrastructure:** `install.sh`, symlink management, `dt-*` pattern
2. **User Expectation:** "Install tools" is dev-toolkit's purpose
3. **Separation of Concerns:** dev-infra generates, dev-toolkit installs
4. **Maintenance Simplicity:** One installer codebase, not two
5. **Versioning Clarity:** dev-toolkit can pin to specific dev-infra releases

### Versioning Model

```
dev-infra v0.8.0
    └── commands v0.8.0 (implicit - commands versioned with release)

dev-toolkit v0.2.0
    └── dt-cursor-install
        └── --version flag to specify dev-infra release
        └── Defaults to latest stable dev-infra release
```

**Key Insights:**
- [x] Insight 1: Source ownership (dev-infra) and distribution ownership (dev-toolkit) are separate concerns
- [x] Insight 2: dev-toolkit's existing infrastructure is perfectly suited for command distribution
- [x] Insight 3: User intuition aligned with industry best practices
- [x] Insight 4: Commands should be versioned with dev-infra releases, not separately

---

## 💡 Recommendations

- [x] **Recommendation 1:** dev-infra should remain the **source owner** of all Cursor AI commands
- [x] **Recommendation 2:** dev-toolkit should become the **distribution owner** via new `dt-cursor-install` command
- [x] **Recommendation 3:** `dt-cursor-install` should pull from dev-infra releases (tagged versions)
- [x] **Recommendation 4:** Default to latest stable release, allow explicit version pinning
- [x] **Recommendation 5:** Do NOT add installation scripts to dev-infra (keep it focused on source)

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-CMD-1:** dev-toolkit MUST provide a `dt-cursor-install` command
- [x] **FR-CMD-2:** `dt-cursor-install` MUST copy commands to `~/.cursor/commands/`
- [x] **FR-CMD-3:** `dt-cursor-install` MUST support version pinning via `--version` flag
- [x] **FR-CMD-4:** `dt-cursor-install` MUST support listing available versions via `--list`
- [x] **FR-CMD-5:** `dt-cursor-install` MUST support updating to latest via `--update`
- [x] **FR-CMD-6:** `dt-cursor-install` SHOULD default to latest stable dev-infra release

### Non-Functional Requirements

- [x] **NFR-CMD-1:** Installation MUST work offline if commands already cached
- [x] **NFR-CMD-2:** Installation MUST NOT require dev-infra repository to be cloned
- [x] **NFR-CMD-3:** dev-infra MUST include commands in GitHub releases as downloadable artifacts

### Constraints

- [x] **C-CMD-1:** Commands MUST NOT be duplicated across dev-infra and dev-toolkit
- [x] **C-CMD-2:** dev-toolkit MUST NOT modify command content (source owner is dev-infra)

---

## 🔗 Related Research

- **[Global Command Distribution](../global-command-distribution/README.md)** - Technical validation of global commands
- **[Integration Points](research-integration-points.md)** - How dev-toolkit ↔ dev-infra communicate
- **[Shared Contracts](research-shared-contracts.md)** - Commands as a form of shared contract

---

## 🚀 Next Steps

1. ~~Conduct web research on distribution patterns~~ ✅
2. ~~Review dev-toolkit's installation infrastructure~~ ✅
3. ~~Document findings and make recommendations~~ ✅
4. **Create ADR** for command distribution ownership decision
5. **Plan implementation** of `dt-cursor-install` in dev-toolkit

---

**Last Updated:** 2025-12-31
