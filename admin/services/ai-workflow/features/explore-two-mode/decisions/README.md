# Explore Two-Mode Enhancement - Decisions Hub

**Purpose:** Architecture decisions for enhancing `/explore` with two-mode pattern  
**Status:** 🔴 Proposed  
**Created:** 2026-01-10  
**Last Updated:** 2026-01-10

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/explore-two-mode/README.md)** - Related research
- **[Requirements](../../research/explore-two-mode/requirements.md)** - Requirements document

### ADR Documents

- **[ADR-001: Two-Mode Pattern](adr-001-two-mode-pattern.md)** - Adopt Setup + Conduct pattern for `/explore`
- **[ADR-002: Input Sources](adr-002-input-sources.md)** - Support raw text, start.txt, and reflections
- **[ADR-003: Worktree Integration](adr-003-worktree-integration.md)** - Lazy worktree creation on conduct mode
- **[ADR-004: Scaffolding Boundaries](adr-004-scaffolding-boundaries.md)** - Size constraints for setup vs conduct output

---

## 🎯 Decisions Overview

This topic addresses enhancing the `/explore` command to:
1. Follow the proven two-mode pattern (Setup + Conduct)
2. Accept multiple input sources including raw unstructured text
3. Integrate with the worktree feature workflow
4. Maintain consistent scaffolding boundaries with other two-mode commands

**Decision Points:** 4 decisions  
**Status:** 🔴 Proposed

---

## 📊 Decision Status

| Decision | Status | ADR |
|----------|--------|-----|
| Two-Mode Pattern | 🔴 Proposed | [adr-001-two-mode-pattern.md](adr-001-two-mode-pattern.md) |
| Input Sources | 🔴 Proposed | [adr-002-input-sources.md](adr-002-input-sources.md) |
| Worktree Integration | 🔴 Proposed | [adr-003-worktree-integration.md](adr-003-worktree-integration.md) |
| Scaffolding Boundaries | 🔴 Proposed | [adr-004-scaffolding-boundaries.md](adr-004-scaffolding-boundaries.md) |

---

## 🚀 Next Steps

1. Review ADR documents
2. Approve or modify decisions
3. Use `/transition-plan --from-adr` to transition to planning

---

**Last Updated:** 2026-01-10
