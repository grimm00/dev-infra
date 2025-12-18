# ADR-001: Commands as Guides - Simplifying Command Distribution

**Status:** ✅ Accepted  
**Created:** 2025-12-17  
**Supersedes:** [ADR-004: Graduation Process](../dev-infra-identity-and-focus/adr-004-graduation-process.md)

---

## Context

Dev-infra established a graduation process (ADR-004) to gate when "experimental" commands could be added to the standard template. This created:

- **Experimental template** - Contained `/status` and future experimental commands
- **Standard template** - Only "proven" commands
- **Graduation checklist** - Time-based criteria for promotion
- **Stability levels** - 🟢 Stable, 🟠 Experimental, 🔴 Deprecated

### The Problem

This structure assumed:
1. Commands are like software products requiring maturity gates
2. External users would choose between stable/experimental templates
3. Graduation overhead provides quality assurance value

### The Reality

1. **Commands are AI guides** - Markdown instructions that guide Cursor AI assistants
2. **Internal use only** - Only projects controlled by the maintainer use these
3. **No external users** - No public users making stable vs experimental choices
4. **Overhead without value** - Graduation checklists don't improve command quality

---

## Decision

**Remove graduation process and distribute all commands to all templates.**

### Key Changes

1. **All templates get all commands** - No stable/experimental distinction
2. **Remove experimental-project template** - Merge into standard-project
3. **Archive graduation structure** - No checklists, stability levels, or time gates
4. **Keep dev-infra internal commands** - Release automation stays internal

### Command Classification (New)

| Category | Count | Distribution |
|----------|-------|--------------|
| **Template Commands** | 19 | All templates (standard, learning) |
| **Dev-Infra Internal** | 4 | dev-infra repository only |

**Template Commands (19):**
- `/cursor-rules`, `/decision`, `/explore`, `/fix-implement`, `/fix-plan`
- `/fix-review`, `/int-opp`, `/post-pr`, `/pr`, `/pr-validation`
- `/pre-phase-review`, `/reflect`, `/reflection-artifacts`, `/research`
- `/status`, `/task-improvement`, `/task-phase`, `/task-release`, `/transition-plan`

**Dev-Infra Internal (4):**
- `/address-review` - dev-infra review workflow
- `/post-release` - template release automation
- `/release-finalize` - template release automation
- `/release-prep` - template release automation

---

## Consequences

### Positive

- **Simpler** - Two template types instead of three
- **Faster** - No graduation process delays
- **Clearer** - Commands are guides, not products
- **Less maintenance** - No sync manifest for stable/experimental split

### Negative

- **Breaking change** - Existing experimental-project users need awareness
- **Loss of maturity signal** - No visible "experimental" warning on new commands

### Mitigations

- Experimental-project users: existing repos continue working, just use standard for new projects
- New commands: document in release notes, iterate quickly based on feedback

---

## Implementation

### Files Removed

| File | Reason |
|------|--------|
| `templates/experimental-project/` | Merged into standard |
| `templates/*/docs/STABILITY-LEVELS.md` | No stability levels |
| `templates/*/docs/GRADUATION-CHECKLIST.md` | No graduation |
| `templates/*/docs/EXPERIMENTAL.md` | No experimental distinction |

### Files Updated

| File | Change |
|------|--------|
| `templates/standard-project/.cursor/commands/status.md` | Added |
| `templates/learning-project/.cursor/commands/status.md` | Added |
| `scripts/new-project.sh` | 2 template types only |
| `scripts/template-sync-manifest.txt` | Simplified |
| `.cursor/rules/main.mdc` | Updated command docs |

### ADRs Superseded

| ADR | Status |
|-----|--------|
| `adr-004-graduation-process.md` | Superseded by this ADR |

---

## Rationale

**From the maintainer (2025-12-17):**

> "I realize that all projects should have access to all commands, no matter the maturity. These commands aren't really commands, but guides, and so far, only internal projects (all orchestrated by me and those I give permission to) really use these."

The graduation process was solving a problem that doesn't exist for internal tooling.

---

## References

- [chat-log-2025-12-17-proj-cli-command-sync.md](../../planning/notes/chat-log-2025-12-17-proj-cli-command-sync.md) - Context
- [ADR-004: Graduation Process](../dev-infra-identity-and-focus/adr-004-graduation-process.md) - Superseded

---

**Last Updated:** 2025-12-17


