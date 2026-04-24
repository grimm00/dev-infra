# ADR-002: Scaffolding Content Boundaries

**Status:** Proposed  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29  
**Research Source:** [research-scaffolding-design.md](../../research/transition-plan-two-mode/research-scaffolding-design.md)

---

## Context

With the two-mode pattern adopted (ADR-001), we need to decide **what content belongs in scaffolding vs. expansion**.

**Research Question:** What should setup mode scaffolding contain vs. leave empty for expand mode?

**Key Research Findings:**

1. Full phase template is ~300 lines; scaffolding should be ~60-80 lines
2. `/research` command pattern: scaffolding = headers + placeholder structure
3. Current `/transition-plan` tries to do everything at once (the problem)
4. Clear status indicators prevent mode confusion

---

## Decision

**Define clear content boundaries** between scaffolding and expansion:

### Scaffolding Content (~60-80 lines)

| Section | What to Include |
|---------|-----------------|
| **Header** | Phase number, name, status, prerequisites, estimated effort |
| **Overview** | 1-2 sentence summary from source |
| **Goals** | Numbered list extracted from ADR/source |
| **Tasks** | Category headers only, placeholder message |
| **Completion Criteria** | Checklist items from source |
| **Deliverables** | List from source |
| **Dependencies** | Prerequisites and blocks |
| **Related Documents** | Links to other documents |

### Expansion Content (adds ~150-200 lines)

| Section | What Gets Added |
|---------|-----------------|
| **Tasks** | Detailed TDD breakdown (RED → GREEN → REFACTOR) |
| **Code Examples** | Language-specific implementation samples |
| **Testing Commands** | Specific commands to run |
| **Implementation Notes** | Patterns, workflows, tips |
| **Risk Assessment** | Risk/mitigation table |
| **Progress Tracking** | Detailed status checkboxes |

### Status Indicators

```markdown
# Scaffolding State
**Status:** 🔴 Scaffolding (needs expansion)

# Expanded State  
**Status:** ✅ Expanded
```

### Placeholder Messages

```markdown
## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan [topic] --expand --phase [N]` to add detailed TDD tasks.

### Task Categories
- [ ] **[Category 1]** - [Brief description]
```

---

## Consequences

### Positive

- **Reviewable structure:** Human can verify phase breakdown before detail
- **Predictable output:** Simpler scaffolding = more consistent results
- **Clear boundaries:** No ambiguity about what goes where
- **Right-sized documents:** ~60-80 lines is quick to review
- **Guided workflow:** Placeholders tell users what to do next

### Negative

- **Two templates needed:** Scaffolding template + expansion logic
- **Potential inconsistency:** Must maintain both template versions

### Neutral

- **Mirrors `/research` pattern:** Same scaffolding philosophy

---

## Alternatives Considered

### Alternative 1: Full Template Always

**Description:** Create full ~300 line documents in setup mode.

**Pros:**
- Single template to maintain
- Complete output immediately

**Cons:**
- Variable AI output quality
- No human review opportunity
- Defeats purpose of two-mode pattern

**Why not chosen:** This is the current problem we're solving.

---

### Alternative 2: Minimal Headers Only

**Description:** Scaffolding creates only section headers, no content at all.

**Pros:**
- Very simple scaffolding
- Maximum flexibility

**Cons:**
- Too minimal to review meaningfully
- Loses valuable extracted content (goals, criteria)
- Can't verify phase breakdown

**Why not chosen:** Some content (goals, dependencies) is valuable for review.

---

### Alternative 3: Variable Scaffolding Depth

**Description:** Let users choose scaffolding depth via flags.

**Pros:**
- Maximum flexibility
- Users can customize

**Cons:**
- Complexity for users
- More code to maintain
- Inconsistent outputs

**Why not chosen:** Simplicity and consistency are more valuable.

---

## Decision Rationale

The content boundary was chosen based on:

1. **Reviewability:** Goals and dependencies are essential for verifying phase structure
2. **Predictability:** Simpler scaffolding produces more consistent output
3. **Right-sizing:** ~60-80 lines is quick to review but meaningful
4. **TDD separation:** Detailed task ordering is complex and benefits from focused expansion

**Research Support:**

| Finding | Application |
|---------|-------------|
| Finding 1: Template is ~300 lines | Scaffolding should be ~60-80 lines |
| Finding 2: `/research` pattern | Headers + placeholders for structure |
| Finding 3: Minimum viable definition | Goals, criteria, deps in scaffolding |
| Finding 4: Clear mode indicators | Status markers in header |
| Finding 5: Current problem | Don't do task detail in scaffolding |

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-8: Scaffolding Template | ~60-80 lines with defined sections |
| FR-9: Status Indicators | `🔴 Scaffolding` / `✅ Expanded` |
| FR-10: Placeholder Messages | Guidance in empty sections |
| NFR-6: Scaffolding Consistency | Simpler structure = predictable |
| NFR-7: Scaffolding Size Limit | ~60-80 lines target |

---

## Implementation Notes

### Scaffolding Template Structure

```markdown
# [Feature] - Phase [N]: [Name]

**Phase:** [N] - [Name]  
**Duration:** [Estimate]  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** [From source]

---

## 📋 Overview
[1-2 sentences from ADR/source]

## 🎯 Goals
1. **[Goal 1]** - [From source]
2. **[Goal 2]** - [From source]

## 📝 Tasks
> ⚠️ **Scaffolding:** Run expansion to add detailed TDD tasks.
### Task Categories
- [ ] **[Category 1]** - [Brief]

## ✅ Completion Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

## 📦 Deliverables
- [Deliverable 1]

## 🔗 Dependencies
### Prerequisites
- [Previous phase]

## 🔗 Related Documents
- [Links]

---
**Status:** 🔴 Scaffolding
```

**Target:** ~60-80 lines

---

## References

- [Research: Scaffolding Design](../../research/transition-plan-two-mode/research-scaffolding-design.md)
- [Phase Document Template](../../../docs/PHASE-DOCUMENT-TEMPLATE.md)
- [ADR-001: Flag-Based Mode Switching](adr-001-flag-based-mode-switching.md)
- [Requirements Document](../../research/transition-plan-two-mode/requirements.md)

---

**Last Updated:** 2025-12-29

