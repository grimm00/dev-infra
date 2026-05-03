# Audit: `decision` command → skill conversion

**Source:** `.cursor/commands/decision.md` (632 lines)  
**Feature:** agentic-workflow-modernization / Stage 3 Group 1  
**Date:** 2026-05-02  
**Tier definitions:** ADR-004 — Tier 1 precise, Tier 2 mixed (rewrite for five-property rubric), Tier 3 vague/problematic (rewrite or remove).

---

## Executive summary

| Finding | Detail |
|---------|--------|
| Interview gap | The command text does **not** describe a pre-decision human interview. The interview pattern lives in project research (`decisions/decision-interview.md`) and design/staging intent (ADR-001: decision = hybrid + interview). The skill must **add** Workflow step 0 explicitly. |
| Path inconsistency | **Configuration** (lines 13–16) claims Dev-Infra decisions live under `admin/decisions/[topic]/`, while **Step 3** and **Reference** (617–618) use `admin/services/[service]/features/[topic]/decisions/`. The skill should treat **Step 3 + Reference** as canonical for dev-infra feature decisions. |
| Commit workflow | Step 7 prescribes a full docs-branch merge to `develop`. That is **Tier 3** for a portable template skill: violates bounded/outcome framing for arbitrary repos. Skill should give **commit message shape + stop**, not enforce internal dev-infra git policy. |
| Hybrid split | Steps 1–2 are judgment-heavy (decision point identification) → **Behavioral contract**. Steps 3–6 are template/file scaffolding → **Workflow**. ADR-004 § “Separate workflow from behavioral contract” applies. |

---

## Section-by-section classification

| Location / topic | Tier | Rationale (rubric sketch) | Skill action |
|------------------|------|---------------------------|--------------|
| Title + tagline | 1 | Observable output (ADRs) | Keep |
| Path Detection — Dev-Infra (admin/decisions…) | **3** | Conflicts with later steps; unobservable “which repo shape” without correction | **Replace** with canonical `admin/services/[service]/features/[topic]/decisions/` |
| Path Detection — template / project-wide | 1 | Clear paths | Keep |
| Topic detection (`--topic`, sanitize) | 2 | Bounded if flags documented | Keep, clarify |
| Workflow overview diagram | 2 | Omits interview; “Identifies decision points” under-specified | Extend in skill |
| Usage / options | 1 | | Keep |
| Step 1 — Identify research source | 1 | Clear file globs and checklists | Keep |
| Step 2 — Identify decision points | 2 | Open-ended questions; needs observable outputs in skill | Rewrite in behavioral contract |
| Step 3 — Create decisions hub | 2 | Template-heavy Tier 1; location auto-detect **contradicts** Configuration | Unify paths; keep structure |
| Step 4 — Create ADR documents | 1 | Section template is explicit | Keep as checklist of required ADR headings |
| Step 5 — decisions-summary | 1 | | Keep |
| Step 6 — Update parent decisions README | 2 | dev-infra vs template paths differ (`admin/decisions/README.md` vs `docs/...`) | Keep with resolution table |
| Step 7 — Commit and push | **3** | Assumes docs-only branch workflow + merge to `develop` | Replace with “suggest commit; follow project policy” |
| Integration / scenarios / tips | 2 | Useful but some references `/transition-plan` only | Neutral “planning handoff” wording |
| Reference/footer | 1 | Paths match Step 3 for dev-infra | Keep canonical row as single source of truth |

---

## Consolidated tier tallies (behavioral + procedural chunks)

| Tier | Count (approx. blocks) | Notes |
|------|------------------------|-------|
| Tier 1 | 14 | Path tables (corrected), file templates, checklists, usage |
| Tier 2 | 8 | Decision-point extraction, tips, integration narrative |
| Tier 3 | 3 | Wrong dev-infra root in Configuration; prescriptive merge-to-develop; optional ambiguity on “auto-detect from research source” without stop condition |

---

## Interview workflow (external to command text)

**Source:** `admin/services/ai-workflow/features/agentic-workflow-modernization/decisions/decision-interview.md`

| Element | Role in skill |
|---------|----------------|
| “How to Use This File” | Sets tone: short answers, skip ok, no wrong answers — encode as **stop / resume** behavior |
| Section 1 UX priorities | Surfaces command usage / friction **before** technical ADR drafting |
| Section 2+ constraints / instincts | Shapes **ordering** of decision clusters and acceptable tradeoffs |
| Pattern | **Phase start signal** (named in narrative.md): skill reads or scaffolds `decision-interview.md` adjacent to topic hub before heavy analysis |

---

## Five-property check (command-wide)

| Property | Pass? | Gap |
|----------|-------|-----|
| Observable | Partial | “Identify decision points” needs concrete outputs listed |
| Bounded | Partial | No explicit stop when research missing; Step 7 unbounded git process |
| Outcome-framed | Mostly | Templates are outcome-framed; meta-instructions sometimes persona-like |
| Delta-only | Partial | Long duplicated markdown samples — skill should reference structure not paste 400 lines |
| Failure-aware | Weak | Little on conflicting path rules or empty research |

---

## Skill design decisions (from audit)

1. **Single SKILL.md** under 500 lines: summarize ADR/hub templates by section list + one short example block, not full paste.
2. **Interview** is mandatory path with escape hatch: user may type explicit waiver (“proceed without interview”).
3. **Options-not-answers:** align with decision-science refactor narrative; behavioral contract enforces 2–3 alternatives before recording a Decision section.
4. **Planning handoff:** mention `write-plan` / transition-plan as a **separate** invocation after ADRs (template may not have write-plan until Group 2 — use neutral “planning skill or project convention”).

---

**Last Updated:** 2026-05-02
