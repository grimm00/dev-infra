# ADR-004: Scaffolding Boundaries for /explore

**Status:** Proposed  
**Created:** 2026-01-10  
**Last Updated:** 2026-01-10

---

## Context

The two-mode pattern requires clear boundaries between Setup Mode output (scaffolding) and Conduct Mode output (expanded). Without clear boundaries:
- Users don't know when to stop in Setup Mode
- Output varies unpredictably
- Inconsistency with other two-mode commands

Research identified that `/transition-plan` established successful boundaries in ADR-002 that should apply to `/explore`.

**Related Research:**
- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Scaffolding Boundaries Research](../../research/explore-two-mode/research-scaffolding-boundaries.md)

**Related Requirements:**
- FR-SB-1: Setup Mode MUST produce ~60-80 lines
- FR-SB-2: Setup Mode MUST create research-topics.md
- FR-SB-3: Conduct Mode MUST expand to ~200-300 lines
- FR-SB-4: Scaffolding MUST include placeholder guidance

**Related ADRs:**
- [transition-plan-two-mode ADR-002](../../decisions/transition-plan-two-mode/adr-002-scaffolding-content-boundaries.md)

---

## Decision

**Apply transition-plan-two-mode scaffolding boundaries to /explore.**

### Setup Mode (~60-80 lines)

**Creates:**
```
explorations/[topic]/
├── README.md           (~20 lines) - Hub with quick links
├── exploration.md      (~40-50 lines) - Scaffolding with placeholders
└── research-topics.md  (~20-30 lines) - Prioritized questions
```

**exploration.md Structure:**
```markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 🎯 What We're Exploring

[2-3 sentence summary extracted from input]

---

## 🔍 Initial Themes

### Theme 1: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

### Theme 2: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

---

## ❓ Key Questions

1. [Question extracted from input]
2. [Question extracted from input]

---

## 🚀 Next Steps

Run `/explore [topic] --conduct` to expand this exploration.
```

### Conduct Mode (~200-300 lines)

**Expands:**
- Themes with detailed analysis, connections, implications
- Questions with context, sub-questions, research approach
- Initial thoughts with evidence, concerns, opportunities
- research-topics.md with full descriptions and priority rationale

**Status Update:**
```markdown
**Status:** ✅ Expanded
```

---

## Consequences

### Positive

- **Predictable Output:** Users know what to expect from each mode
- **Quick Review:** Setup produces scannable scaffolding
- **Consistency:** Matches transition-plan-two-mode pattern
- **Clear Guidance:** Placeholders show what conduct mode will add

### Negative

- **Constraint on AI:** Must stop at ~80 lines even with more input
- **Potential Truncation:** Rich input may be summarized heavily in Setup

---

## Alternatives Considered

### Alternative 1: No Size Constraints

**Description:** Let AI determine appropriate output length.

**Pros:**
- Flexible based on input complexity
- No artificial truncation

**Cons:**
- Unpredictable output
- May over-produce in Setup (defeating purpose)
- Inconsistent with other commands

**Why not chosen:** Boundaries are key to two-mode value proposition.

---

### Alternative 2: Different Boundaries (Shorter/Longer)

**Description:** Use different line counts (e.g., 30-40 / 100-150).

**Pros:**
- Could optimize for exploration specifically

**Cons:**
- Breaks consistency with transition-plan-two-mode
- Arbitrary without research support
- Learning curve for users

**Why not chosen:** Consistency with existing pattern more valuable than optimization.

---

### Alternative 3: Token-Based Boundaries

**Description:** Use token counts instead of line counts.

**Pros:**
- More precise for AI
- Language-agnostic

**Cons:**
- Less intuitive for users
- Harder to verify
- Line counts work fine in practice

**Why not chosen:** Line counts are user-friendly and validated by transition-plan-two-mode.

---

## Decision Rationale

**Key Factors:**
1. **Proven Pattern:** transition-plan-two-mode boundaries work well
2. **User Expectations:** Consistent sizes across commands
3. **Review Efficiency:** Scaffolding is quick to scan
4. **Placeholder Guidance:** Users know what conduct mode adds

**Research Support:**
- Finding 4: Scaffolding pattern from ADR-002 applies
- Insight 5: ADR-002 scaffolding pattern applies (~60-80 lines setup)
- NFR-SB-1: Predictable output sizes

---

## Requirements Impact

**Requirements Addressed:**
- FR-SB-1: Scaffolding Size (~60-80 lines) ✅
- FR-SB-2: Research Topics Creation ✅
- FR-SB-3: Conduct Mode Expansion (~200-300 lines) ✅
- FR-SB-4: Placeholder Guidance ✅
- NFR-SB-1: Predictable Output ✅
- NFR-SB-2: Structural Consistency ✅

**Requirements Refined:**
- None; requirements validated as-is

---

## References

- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Scaffolding Boundaries Research](../../research/explore-two-mode/research-scaffolding-boundaries.md)
- [Requirements Document](../../research/explore-two-mode/requirements.md)
- [transition-plan-two-mode ADR-002](../../decisions/transition-plan-two-mode/adr-002-scaffolding-content-boundaries.md)

---

**Last Updated:** 2026-01-10
