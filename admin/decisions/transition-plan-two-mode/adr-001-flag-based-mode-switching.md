# ADR-001: Flag-Based Mode Switching Pattern

**Status:** Proposed  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29  
**Research Source:** [research-pattern-analysis.md](../../research/transition-plan-two-mode/research-pattern-analysis.md)

---

## Context

The `/transition-plan` command currently runs in a single pass, producing variable output with no opportunity for human review. We need to decide **how to implement a two-mode pattern**.

**Research Question:** How does the `/research` command implement its two-mode pattern, and what patterns should we adopt?

**Key Research Findings:**

1. `/research` uses **flag-based mode switching** (`--conduct` flag)
2. State is tracked via **document existence + status indicators** (no metadata files)
3. **Incremental progress** is supported via `--topic-num N`
4. **Clear workflow separation** in documentation (separate sections per mode)

---

## Decision

**Adopt flag-based mode switching** for `/transition-plan`, mirroring the `/research` command pattern.

### Mode Switching Design

| Mode | Trigger | Behavior |
|------|---------|----------|
| **Setup Mode** | Default (no flag) | Create scaffolding documents |
| **Expand Mode** | `--expand` flag | Fill in detailed content |

### Incremental Progress Design

| Flag | Purpose | Mirrors |
|------|---------|---------|
| `--phase N` | Expand specific phase | `--topic-num N` in `/research` |
| `--all` | Expand all phases at once | Full conduct in `/research` |

### State Tracking Design

| State | Detection Method |
|-------|------------------|
| Setup complete | Phase files exist |
| Phase needs expansion | Status: `🔴 Scaffolding` |
| Phase expanded | Status: `✅ Expanded` |

**No separate metadata files required.**

---

## Consequences

### Positive

- **Proven pattern:** Mirrors successful `/research` command design
- **Simple implementation:** Flag-based, no complex state management
- **Human review:** Natural pause between setup and expansion
- **Incremental progress:** Expand one phase at a time
- **Clear status:** Document-based tracking is visible to users

### Negative

- **Two-step workflow:** Users must run command twice for full output
- **Learning curve:** Users need to understand two modes

### Neutral

- **Consistent with ecosystem:** Same pattern as `/research --conduct`

---

## Alternatives Considered

### Alternative 1: Metadata Files for State Tracking

**Description:** Use `.transition-state.json` or similar to track progress.

**Pros:**
- Machine-readable state
- Could track more granular progress

**Cons:**
- Hidden state files can get out of sync
- Additional complexity
- Not how `/research` does it

**Why not chosen:** Document-based tracking is simpler and proven.

---

### Alternative 2: Automatic Mode Detection

**Description:** Command automatically detects mode based on document state.

**Pros:**
- No flags needed
- "Smart" behavior

**Cons:**
- Unpredictable behavior
- User loses control
- Harder to understand what will happen

**Why not chosen:** Explicit flags are clearer and give user control.

---

### Alternative 3: Separate Commands

**Description:** Create `/transition-scaffold` and `/transition-expand` commands.

**Pros:**
- Clear separation
- No flag complexity

**Cons:**
- Command proliferation
- Inconsistent with `/research` pattern
- More commands to learn

**Why not chosen:** Flag-based switching is simpler and consistent with existing patterns.

---

## Decision Rationale

The `/research` command has proven that flag-based mode switching works well:

1. **Simple:** One command, one flag
2. **Explicit:** User knows exactly what mode they're in
3. **Consistent:** Mirrors existing `/research --conduct` pattern
4. **Incremental:** `--phase N` allows granular progress

**Research Support:**

| Finding | Application |
|---------|-------------|
| Finding 1: Flag-based mode switching | Use `--expand` flag |
| Finding 2: No metadata for state | Use document existence + status indicators |
| Finding 3: Incremental progress | Use `--phase N` and `--all` |
| Finding 4: Documentation separation | Separate workflow sections |

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-5: Mode Switching via `--expand` | Primary decision |
| FR-6: Phase-Specific Expansion | `--phase N` flag |
| FR-7: Expand All | `--all` flag |
| NFR-4: Document-Based State Tracking | No metadata files |
| NFR-5: Clear Documentation Separation | Separate workflow sections |

---

## Implementation Notes

1. Add `--expand` flag to command
2. Add `--phase N` option for specific phase expansion
3. Add `--all` option for batch expansion
4. Use document existence to detect setup completion
5. Use status indicators (`🔴 Scaffolding` / `✅ Expanded`) in phase documents

---

## References

- [Research: Pattern Analysis](../../research/transition-plan-two-mode/research-pattern-analysis.md)
- [/research Command](../../../.cursor/commands/research.md) - Pattern source
- [Requirements Document](../../research/transition-plan-two-mode/requirements.md)

---

**Last Updated:** 2025-12-29

