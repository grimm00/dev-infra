# Discuss Command Audit — Tier Classification

**Task:** Task 5 of Stage 1 (Discuss Conversion)
**Date:** 2026-04-30
**Source:** `.cursor/commands/discuss.md` (267 lines)
**Reference:** Topic 8 (Behavioral Contracts), Spike B (`spikes/discuss-skill/SKILL.md`, 143 lines)

---

## Tier Definitions (from Topic 8, Finding 1)

| Tier | Description | Rubric Properties Met |
|------|-------------|----------------------|
| **Tier 1** | Precise — outcome-based, testable | All 5: observable, bounded, outcome-framed, delta-only, failure-aware |
| **Tier 2** | Mixed — directional but unverifiable | 3-4 properties |
| **Tier 3** | Vague/Problematic — persona-based, untestable | 0-2 properties |

---

## Behavioral Instruction Inventory

### Section: Behavior Rules (lines 54-69)

| # | Instruction | Tier | Properties | Notes |
|---|-------------|------|------------|-------|
| B1 | "DO NOT create, modify, or delete any files" | **T1** | Observable, bounded, outcome-framed, delta-only, failure-aware | Binary constraint, clear |
| B2 | "DO NOT update requirements, findings, recommendations, or status documents" | **T1** | All 5 | Specific file types enumerated |
| B3 | "DO NOT append themes to explorations or topics to research" | **T1** | All 5 | Specific actions enumerated |
| B4 | "DO NOT commit anything" | **T1** | All 5 | Binary |
| B5 | "DO read any files needed for informed responses" | **T1** | All 5 | Observable action |
| B6 | "DO reference specific findings, requirements, or documents by name/number" | **T1** | Observable, bounded, outcome-framed, delta-only | Observable in output |
| B7 | "DO challenge assumptions, identify gaps, and offer analysis" | **T2** | Outcome-framed, delta-only | "Challenge" and "gaps" have no stopping rule; not bounded |
| B8 | "DO suggest what actions the user might take after the discussion" | **T1** | All 5 | Observable in output |
| B9 | "Treat every user message as a thought to engage with, not a directive to implement" | **T1** | All 5 | Core interaction rule, precise |

### Section: Workflow — Starting a Discussion (lines 75-85)

| # | Instruction | Tier | Properties | Notes |
|---|-------------|------|------------|-------|
| W1 | "Loads relevant context (exploration, research, requirements)" | **T1** | All 5 | Procedural, sources listed |
| W2 | "Acknowledges the discussion mode (no artifacts will be modified)" | **T1** | All 5 | Observable in output |
| W3 | "Responds to the user's thought with analysis, drawing on loaded context" | **T2** | Outcome-framed, delta-only | "Analysis" is undefined; no quality bar |
| W4 | "Continues the conversation as long as the user wants" | **T1** | All 5 | Clear stopping rule (user ends it) |

### Section: Workflow — During the Discussion (lines 89-101)

| # | Instruction | Tier | Properties | Notes |
|---|-------------|------|------------|-------|
| D1 | "Reference specific documents and findings when relevant" | **T1** | Observable, bounded, outcome-framed, delta-only | Observable in output |
| D2 | "Play devil's advocate when the user seems to be confirming their own bias" | **T3** | Outcome-framed (partial) | Persona role + subjective trigger ("seems to be"); no stopping rule; encourages manufactured disagreement |
| D3 | "Identify connections the user might not have seen" | **T3** | Delta-only | Unbounded scope; no stopping rule; "might not have seen" is unknowable |
| D4 | "Note when a thought seems significant enough to capture formally" | **T3** | Delta-only (partial) | "Seems significant enough" is entirely subjective; no criteria |
| D5 | "Keep track of key discussion points throughout the conversation" | **T2** | Observable, outcome-framed | "Key" is undefined; no criteria for what qualifies |

### Section: Why This Exists (lines 7-17)

| # | Instruction | Tier | Properties | Notes |
|---|-------------|------|------------|-------|
| E1 | "The AI engages substantively with full project context" | **T2** | Delta-only | "Substantively" undefined; no quality bar |

### Section: Common Scenarios (lines 166-223)

| # | Instruction | Tier | Properties | Notes |
|---|-------------|------|------------|-------|
| S1 | "Reads Topic 3 findings, analyzes the concern, presents tradeoffs" | **T1** | All 5 | Concrete: read, analyze, present |
| S2 | "Reads current exploration themes... Engages with the question" | **T2** | Observable, outcome-framed | "Engages with" is vague |
| S3 | "Analyzes the distribution of feature sizes... Responds with data" | **T1** | All 5 | Concrete: analyze + respond with data |
| S4 | "Reads the specific document, analyzes each approach, presents structured comparison" | **T1** | All 5 | Concrete: read, analyze, present comparison |

### Section: Tips — Best Practices (lines 244-249)

These are user-facing tips, not agent behavioral instructions. Excluded from tier classification.

---

## Summary

| Tier | Count | % | Instructions |
|------|-------|---|-------------|
| **Tier 1** | 13 | 65% | B1-B6, B8-B9, W1-W2, W4, D1, S1, S3, S4 |
| **Tier 2** | 5 | 25% | B7, W3, D5, E1, S2 |
| **Tier 3** | 3 | 15% | D2, D3, D4 |
| **Total** | 21 | | (excluding procedural steps and user-facing tips) |

---

## Tier 3 Instructions — Required Rewrites

These must be elevated to Tier 1 or removed during conversion (Task 6).

### D2: "Play devil's advocate when the user seems to be confirming their own bias"

**Problems:** Persona role ("devil's advocate" is a character to play, not a behavior to exhibit). Subjective trigger ("seems to be confirming bias" has no observable criteria). Encourages manufactured disagreement over genuine analysis.

**Spike B rewrite:** "Prioritize intellectual honesty over agreeableness: if you see a logical gap, an unstated assumption, or an argument that doesn't hold — name it specifically. Don't manufacture disagreement, but don't suppress genuine concerns."

**Rubric assessment of rewrite:** Observable (name the gap specifically), bounded (only when a gap exists), outcome-framed (name it, not role-play), failure-aware ("don't manufacture disagreement"). **Tier 1.**

### D3: "Identify connections the user might not have seen"

**Problems:** Unbounded scope (how many connections? which connections?). "Might not have seen" is unknowable — the agent can't determine what the user has and hasn't noticed.

**Spike B rewrite:** "Surface connections and gaps."

**Rubric assessment of rewrite:** Still Tier 2 — lacks a stopping rule. Improvement: "After responding to the user's point, note at most 2 connections to related work (explorations, research findings, or decisions) if they are directly relevant."

**Recommended rewrite:** "When responding, cite up to 2 connections to related explorations, research findings, or decisions — only when directly relevant to the user's point. Don't stretch for tangential links."

### D4: "Note when a thought seems significant enough to capture formally"

**Problems:** "Seems significant enough" is entirely subjective. No criteria for significance. No stopping rule.

**Spike B rewrite:** "Track significance: note aloud when a thought seems worth promoting to a formal artifact, but do not promote it — the user decides."

**Rubric assessment of rewrite:** Still Tier 2 — "seems worth promoting" remains subjective. Improvement needs observable triggers.

**Recommended rewrite:** "When the user articulates a new concern, identifies a gap in existing research, or proposes a concrete change — note it as potentially worth capturing via `/explore --amend`, `/int-opp`, or `/research --add-topic`. Do not act on it; the user decides."

---

## Tier 2 Instructions — Recommended Improvements

These are functional but could be tightened for Task 6.

### B7: "DO challenge assumptions, identify gaps, and offer analysis"

**Issue:** "Challenge" and "gaps" have no scope boundary. Could apply to everything.

**Recommended rewrite:** "When the user makes a claim, check it against loaded context. If the context contradicts or complicates the claim, say so with a specific citation."

### W3: "Responds to the user's thought with analysis, drawing on loaded context"

**Issue:** "Analysis" is undefined.

**Recommendation:** Fold into Tier 1 instructions; the specific behavioral rules (B5-B9, D1) already cover what "analysis" means in practice. Remove as standalone instruction.

### D5: "Keep track of key discussion points throughout the conversation"

**Issue:** "Key" is undefined.

**Recommendation:** Drop as standalone instruction. The summary template (lines 107-129) already provides the structure for tracking points. If `--summary` is requested, the agent naturally needs to have tracked them.

### E1: "The AI engages substantively with full project context"

**Issue:** "Substantively" is undefined.

**Recommendation:** Remove. This is marketing language in the "Why This Exists" section, not a behavioral instruction. The actual behavioral rules (B5-B9) define what "substantive engagement" means.

### S2: "Engages with the question"

**Issue:** Vague.

**Recommendation:** Remove or replace with specific behavior from the scenario. The scenario already specifies: "Reads current exploration themes, research requirements, dev-toolkit patterns" (Tier 1 procedural action).

---

## Content Classification for Conversion

| Content Block | Lines | Destination | Notes |
|---------------|-------|-------------|-------|
| Why This Exists | 7-17 | SKILL.md body (condensed) | Motivation, not behavioral |
| Configuration / Context Sources | 20-31 | SKILL.md body (Context Loading) | Procedural |
| Usage / Options | 35-50 | SKILL.md body (Options table) | Procedural |
| Behavior Rules (DO/DON'T) | 54-69 | SKILL.md body (Absolute Constraints) | Core behavioral contract |
| Workflow — Starting | 73-85 | SKILL.md body (workflow) | Procedural + 1 behavioral |
| Workflow — During | 87-101 | SKILL.md body (Active Behavior) | Highest behavioral density — 3 Tier 3 rewrites needed |
| Workflow — Ending / Summary | 103-131 | SKILL.md body (Summary) | Template, procedural |
| Integration / Position | 135-163 | Remove or condense to 1 line | Navigation, not behavioral |
| Common Scenarios (4) | 166-223 | Remove | Examples; spike draft omits them. Conventions in AGENTS.md cover project context. |
| Tips | 227-249 | Remove or fold into When to Use / When NOT | User-facing tips, not agent instructions |
| Reference / Related Commands | 253-267 | SKILL.md body (Related Skills) | Navigation, keep minimal |

**Estimated conversion:** 267 lines → ~140-150 lines (matching spike B's 143 lines)

---

## Cross-Reference: Spike B Discuss Skill

The spike at `spikes/discuss-skill/SKILL.md` (143 lines) already addressed the three Tier 3 instructions partially. Task 6 should use the spike as a starting point and apply the tighter rewrites recommended above for D3 and D4.

| Spike Section | Lines | Assessment |
|---------------|-------|------------|
| Frontmatter (description) | 1-10 | Good: routing only, triggers defined |
| Role section | 12-38 | Contains remaining Tier 2 language ("Surface connections and gaps") — tighten |
| Absolute Constraints | 40-53 | Clean Tier 1 |
| Context Loading | 55-74 | Procedural, clean |
| Options | 76-84 | Clean |
| Active Behavior | 86-93 | Contains D2/D3/D4 rewrites — assess against rubric, tighten D3/D4 |
| Summary | 95-121 | Template, clean |
| When to Use / NOT | 123-137 | Clean |
| Related Skills | 139-143 | Clean |

---

**Last Updated:** 2026-04-30
