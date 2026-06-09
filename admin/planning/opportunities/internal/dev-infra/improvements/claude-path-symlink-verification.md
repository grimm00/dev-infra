# Claude (`~/.claude/`) Path Symlink Verification

**Source:** /discuss session — skill-corpus-installation C-INST-1 spike review (2026-06-09)
**Target:** skill corpus repo / installer (ADR-002), beyond v1
**Status:** 🔴 Not Started
**Priority:** MEDIUM (gates multi-editor support; not v1)
**Effort:** LOW (a second 5-minute probe, mirroring the Cursor spike)
**Confidence:** ⚠️ Unknown — Claude Code is a different application with its own skill-scanning code path; the Cursor result does not transfer.
**Created:** 2026-06-09
**Last Updated:** 2026-06-09

---

## Problem Statement

The C-INST-1 spike (`admin/services/ai-workflow/features/skill-corpus-installation/planning/spike-c-inst-1-findings.md`) verified that **Cursor 3.7.19** discovers, reads, invokes, and live-reflects skills through a symlink (`~/.cursor/skills/spike-probe → /tmp/...`). That GO is the basis for adopting symlink mode as the installer's primary mechanism.

But ADR-002 frames the corpus as **"multi-editor ready from day one"**, and the symlink result is proven for **exactly one** of the two editors it names. The `~/.claude/skills/` path was **not** probed. Claude Code is a separate application — whether it follows symlinks during skill discovery is a distinct, unverified question. The spike's "primary mechanism" claim is therefore accurate **for Cursor** and unproven for Claude.

---

## Proposed Solution

Run a mirror of the Cursor spike against the Claude path when the corpus repo begins serving Claude:

1. Symlink a throwaway skill into `~/.claude/skills/` (same `spike-probe` fixture pattern).
2. In a fresh Claude Code session, confirm discovery + read-through + invocation.
3. Confirm live-edit reflection (the FR-DEV-1 differentiator) with a sentinel value, as the Cursor spike did.
4. Record a Claude-specific go/no-go + Claude version. If no-go, the copy-mode contingency (already documented in the spike findings) applies to the Claude path only.

---

## V1 Implication

V1 is **Cursor-only** (decided 2026-06-09). The skill-corpus-installation plan stays scoped to Cursor; this verification is explicitly out of v1 and lives here rather than as a v1 plan task. When multi-editor support becomes real (a second editor actually in use — the same "second consumer" trigger ADR-002 uses for Tier 3), promote this to a task in the corpus-installation plan (or its successor).

---

## Related

- [Spike findings: C-INST-1](../../../../../services/ai-workflow/features/skill-corpus-installation/planning/spike-c-inst-1-findings.md) — the Cursor GO this defers from
- [ADR-002: Installation & Distribution Architecture](../../../../../services/meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md) — "multi-editor ready from day one"
- [skill-package-controller exploration](../../../../../services/ai-workflow/explorations/skill-package-controller/exploration.md) — Theme 5: Cursor-specific install "doesn't generalize"

---

**Last Updated:** 2026-06-09
