# Artifact Emission Strategy — Abstraction Levels for Skills

**Source:** /discuss session — question prompted by external agent response on directory structure and AI tooling (2026-04-24)
**Target:** dev-infra skill architecture (beyond directory structure)
**Status:** 🔴 Not Started
**Priority:** MEDIUM (post-v1 skill conversion)
**Effort:** HIGH (affects skill design contract)
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

---

## Problem Statement

The directory restructure int-opp addresses *where files go*. This int-opp addresses a deeper question: **should the files exist at all?**

Currently every dev-infra workflow command emits artifacts to specific paths with specific filenames. This is **Level 1 (raw file paths, opinionated placement)** in the abstraction spectrum. The directory restructure improves L1 but doesn't leave L1.

An external agent framed the spectrum for AI tools that emit artifacts:

| Level | Description | Example |
|-------|-------------|---------|
| **L0** | No artifacts | `/discuss` — chat-only, user decides what to capture |
| **L1** | Raw file paths, opinionated placement | Most dev-infra commands today |
| **L2** | Logical grouping with placement guidance | "Here's a research finding. Save it under your research conventions." |
| **L3** | Intent and dependency declaration | "This feature produced: requirements doc, research summary, N decisions. How do you want them filed?" |
| **L4** | Project-aware adaptive placement | Skill detects conventions and conforms |

Dev-infra sits almost entirely at L1. `/discuss` is our only L0 example — and notably, it's one of the most-used commands in practice because it doesn't impose artifacts.

---

## Why This Matters

**For dev-infra as its own dogfooding project:** artifact-heavy is fine. We use these artifacts as real documentation, the process IS the product, and granular persistence helps us see how the pipeline works.

**For dev-infra as a template for adopters:** artifact-heavy may be excessive. The agentic-workflow-modernization feature produced **40+ artifacts** for one feature. An adopter running `/explore` → `/research` → `/decision` → `/design` on their own feature would get the same volume — potentially more noise than signal.

**For other agents interoperating with dev-infra skills:** the opinionated placement becomes an implicit contract. Agent A creates `admin/research/[topic]/topic-1.md`. Agent B expects `research/auto-detection/findings.md`. Neither is wrong, but the structure becomes shared mutable state that was never explicitly negotiated.

**Existence proof of the lighter approach:** `/discuss` has zero artifact output and works well. The thinking happens in chat. The user decides what (if anything) gets promoted. The command is among the most-used in real practice. This suggests L0 is viable for thinking-heavy workflows, and L2/L3 could work for others.

---

## Essential vs Incidental Artifacts

Not all artifacts are created equal. Some are genuinely valuable persistence; others are scaffolding that could live in chat or be derived on demand.

### Likely Essential (keep as artifacts)

- **ADRs** — capture irreversible decisions for future readers; the canonical use case for persistent files
- **Narrative** — the arc of thinking; essential for learning-driven development and PR descriptions
- **Consolidated requirements** — contract between thinking and implementation
- **Decision interview answers** — captures human priorities before agent analysis; auditable record

### Possibly Incidental (could be chat, derived, or opt-in)

- **Topic-by-topic research documents** — could be chat conversations that feed a consolidated summary
- **Exploration theme files** — transient organizing, often discarded after research
- **Hub READMEs** — navigation that could be auto-generated
- **decisions-summary.md** — derivable from ADRs
- **v1-scope.md** — synthesis regenerable from interview + ADRs
- **Research summary** — derivable from topic documents (which may themselves be incidental)

This is not a final classification — it's a starting point for research within this int-opp.

---

## Proposed Approach

### Principle 1: Separate content generation from placement

The skill is an authority on *what content to produce* (thinking, analysis, decisions). The project is an authority on *where things go*. Skills should emit content with placement guidance, not file writes with hardcoded paths.

### Principle 2: L0 where possible, L2/L3 where artifacts are needed

Commands that are primarily thinking work (e.g., exploration, research conduct) should default to L0 — emit to chat, offer to capture. Commands that produce irreversible decisions (e.g., /decision) may default to L2/L3 — emit a structured artifact and ask where it goes.

### Principle 3: Explicit opt-in for artifact emission

Rather than "skill runs, artifact appears," the pattern becomes:

```
Skill runs → emits content to chat → user reviews → user explicitly chooses to save
                                                    ↓
                                    Options: save as new / merge into existing / discard
```

This matches `/discuss`'s proven pattern and gives the user control over what becomes permanent.

### Principle 4: Distinguish dev-infra dogfooding from adopter defaults

- **Dev-infra internal use:** artifact-heavy stays fine (and dogfoods the full structure)
- **Template defaults for adopters:** artifact-lite is better (less noise, more trust in the adopter's conventions)
- **Adopter customization:** projects should be able to configure artifact emission per skill

---

## Spectrum Examples (applied to dev-infra skills)

### `/discuss` — already L0

No change needed. Current behavior is the target pattern.

### `/research --conduct` — currently L1, could be L2

**Current:** Creates `admin/research/[topic]/topic-N.md` with specific structure, updates hub README, updates research summary.

**L2 alternative:**
```
Research Output — Topic N: [Title]

[Full research content in chat]

This produced:
  - Topic findings (long-form analysis)
  - Requirements discovered (3 new FRs)

Save options:
  [s] Save as new topic file under your research conventions
  [m] Merge findings into existing research summary
  [c] Capture requirements only (add to requirements.md)
  [n] No save — I just wanted the analysis
```

### `/decision` — currently L1, could be L3

**Current:** Creates interview + ADRs + summary + hub README in one directory.

**L3 alternative:** After the decision process, emits a structured declaration:
```
Decision session produced:
  - 5 ADRs (accepted)
  - 1 decision summary (derived from ADRs)
  - Interview transcript (already saved)

Placement options:
  [default] admin/decisions/[topic]/  (current dev-infra convention)
  [custom] Specify a different location
  [chat] Don't persist to disk
```

### `/narrative` — could stay L1 (essential artifact)

Narrative is a first-class deliverable — it's the story of the work. L1 is appropriate. But the *act of emitting* could still be opt-in ("Ready to write the narrative? Here it is — save to `admin/narratives/[topic]/narrative.md`?").

---

## Connection to Earlier Insights

This int-opp extends two previous threads:

1. **Tool injection vs framework marriage** (from feature-first directory restructure int-opp) — the capstone observation that dev-infra should produce tools, not impose structure. This int-opp takes it further: **don't just avoid imposing directory structure — avoid imposing artifact emission**.

2. **Explicit Over Implicit (CP-1)** from agentic-workflow-modernization v1-scope — applies here too. The current pattern is implicit (skill runs, files appear). The proposed pattern is explicit (skill offers, user chooses).

---

## Relationship to Directory Restructure

The directory restructure is still valid and should proceed as planned. It fixes a real problem at L1 (where artifacts go when they exist). This int-opp is a follow-on concern about *whether the artifacts should exist at the current volume at all*.

**Sequencing:**

1. **Now:** Directory restructure (service/feature/phase) — fixes L1 placement
2. **Post-v1:** This int-opp — move skills toward L2/L3 where appropriate
3. **Future:** Adopter-facing templates ship with artifact-lite defaults

Doing the restructure first doesn't preclude this evolution — in fact, it creates cleaner L1 that makes the L2/L3 transition easier.

---

## Research Needed

Before implementation, open questions:

1. **Which artifacts are essential?** The "likely essential" list above needs validation. Could narratives be regenerated from ADRs + commit history instead? Is the interview transcript essential or just helpful?
2. **What does an L2/L3 skill template look like?** The dual-location pattern (FR-21) already separates skill description from body. A similar pattern might separate skill content from placement.
3. **How do skills communicate "here's what I produced"?** Structured output format? YAML manifest? Chat message with clear sections?
4. **What's the adopter configuration story?** A per-project `.dev-infra-config.yaml` that declares artifact preferences per skill? Matches the Helm-style config rendering int-opp from earlier.
5. **How does this interact with session resume?** Current session resume relies on reading artifacts. If artifacts are sparser, resume needs a different mechanism (journal? commit log? status file?).

---

## Why MEDIUM Priority (Not HIGH)

- Not a blocker for v1 skill conversion
- Current artifact-heavy approach works for dev-infra's own use
- Adopter-facing concerns only materialize when adoption begins
- Restructure is the immediate need; this can follow

**Recommended timing:** After v1 skill conversion completes and we have 1-2 adopter projects using the templates. At that point we'll have real feedback on "is this too many artifacts?" and can calibrate the spectrum.

---

## Risks and Caveats

1. **Original framework was about code artifacts.** Documentation/planning artifacts are different — they're more like notebooks than code. The comparison holds but isn't perfect.
2. **Agentic-workflow-modernization is atypically artifact-heavy.** It's the feature that dogfoods the full pipeline. Normal features produce fewer artifacts. Sample of one.
3. **Artifact-lite risks losing traceability.** Dev-infra's value proposition partly depends on the artifact trail (narratives, ADRs, requirements). Going too lite loses that. The balance matters.
4. **L3/L4 require UI/UX work.** "Ask the user where to save" needs a good interaction pattern. Today's terminal + chat may not be ideal for prompted placement.

---

## Related

- [feature-first-directory-structure.md](feature-first-directory-structure.md) — Fixes L1 placement
- [skill-config-rendering.md](skill-config-rendering.md) — Helm-style values for per-environment skill config; related pattern
- [CP-1 in v1-scope](../../../../decisions/agentic-workflow-modernization/v1-scope.md) — Explicit over implicit principle
- [Tool injection capstone](feature-first-directory-structure.md#capstone-tool-injection-vs-framework-marriage) — Dev-infra as factory, not framework

---

**Last Updated:** 2026-04-24
