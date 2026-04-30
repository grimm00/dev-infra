# ADR-001: Two-Mode Pattern for /explore

**Status:** Proposed  
**Created:** 2026-01-10  
**Last Updated:** 2026-01-10

---

## Context

The `/explore` command currently operates as a single-mode command that creates exploration documents. Other commands (`/research`, `/transition-plan`) have successfully adopted a two-mode pattern:

- **Setup Mode:** Creates lightweight scaffolding for human review
- **Conduct/Expand Mode:** Fills in detailed content after human approval

Research identified that `/explore` would benefit from this same pattern, allowing users to:
1. Quickly organize thoughts into themes (Setup)
2. Deeply explore after validating the direction (Conduct)

**Related Research:**
- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Cross-Command Consistency](../../research/explore-two-mode/research-cross-command-consistency.md)

**Related Requirements:**
- FR-CC-1: `/explore` MUST use `--conduct` flag
- FR-SB-1: Setup Mode MUST produce ~60-80 lines
- FR-SB-3: Conduct Mode MUST expand to ~200-300 lines

---

## Decision

**Adopt the two-mode pattern for `/explore` using `--conduct` flag.**

### Setup Mode (Default)
```
/explore [topic]
```
- Organizes raw thoughts into themed sections
- Extracts questions from unstructured input
- Creates `research-topics.md` with prioritized questions
- Output: ~60-80 lines of scaffolding
- Status: `🔴 Scaffolding (needs expansion)`

### Conduct Mode
```
/explore [topic] --conduct
```
- Expands scaffolding with detailed exploration
- Adds analysis, connections, implications
- Refines research topics with context
- Output: ~200-300 lines
- Status: `✅ Expanded`

---

## Consequences

### Positive

- **Consistency:** Aligns with `/research` and `/transition-plan` patterns
- **Human Review Gate:** Setup creates checkpoint before investment
- **Predictable Output:** Clear size expectations for each mode
- **Learnable:** Users familiar with other two-mode commands will understand immediately

### Negative

- **Additional Step:** Users must run command twice for full exploration
- **Command Complexity:** More flags to document and maintain

---

## Alternatives Considered

### Alternative 1: Single Mode (Current State)

**Description:** Keep `/explore` as single-mode command that produces full output.

**Pros:**
- Simpler command interface
- No additional flags needed

**Cons:**
- No human review checkpoint
- Inconsistent with other commands
- May over-invest in wrong directions

**Why not chosen:** Two-mode pattern has proven valuable in other commands; consistency matters.

---

### Alternative 2: Use `--expand` Flag

**Description:** Use `--expand` instead of `--conduct` to match `/transition-plan`.

**Pros:**
- Matches transition-plan naming

**Cons:**
- `/research` uses `--conduct` for similar semantics
- "Conduct" better describes exploration activity

**Why not chosen:** `/explore` is semantically closer to `/research` (investigating) than `/transition-plan` (planning).

---

## Decision Rationale

**Key Factors:**
1. **Proven Pattern:** Two-mode works well for `/research` and `/transition-plan`
2. **Semantic Match:** "Conduct" aligns with exploration/investigation semantics
3. **Human Review:** Setup mode provides natural checkpoint
4. **Consistency:** All exploration/research commands use `--conduct`

**Research Support:**
- Finding 6: Use `--conduct` flag for `/explore` (matches `/research` semantics)
- Insight 7: `--conduct` for research-style, `--expand` for planning-style

---

## Requirements Impact

**Requirements Addressed:**
- FR-CC-1: Conduct Flag ✅
- FR-CC-2: Status Indicator Pattern ✅
- NFR-SB-2: Structural Consistency ✅

**Requirements Refined:**
- None; requirements validated as-is

---

## References

- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Cross-Command Consistency Research](../../research/explore-two-mode/research-cross-command-consistency.md)
- [Requirements Document](../../research/explore-two-mode/requirements.md)
- [transition-plan-two-mode ADR-002](../../decisions/transition-plan-two-mode/adr-002-scaffolding-content-boundaries.md) (precedent)

---

**Last Updated:** 2026-01-10
