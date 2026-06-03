# Dev-Infra Learnings — Research Artifact Lifecycle

**Project:** Dev-Infra
**Topic:** Research artifact lifecycle — read-symmetric structure vs. asymmetric usage
**Date:** 2026-06-03
**Last Updated:** 2026-06-03

---

## 📋 Overview

Surfaced during the skill-template-separation feature work: the user observed they have **never gone back to re-read their own research topic files** after producing them. That single empirical observation is data about how research artifacts actually function in the workflow, and it points at a structural mismatch — the artifacts are produced and stored as if they'll be read symmetrically (each topic an independent durable document), but they're used asymmetrically (produced once, rarely re-read, possibly referenced by an agent during downstream decisions).

This learning captures the observation, the reframe under consideration, and the questions that need to be answered before any change to `/research` can be designed. It is not yet a proposal — it is a flagged gap with the disambiguating questions written down so the next person to look at this (likely future-me) doesn't have to re-derive them.

---

## 💡 Unexpected Discoveries

### Research topic files appear to be write-only artifacts for the author

**Finding:** Across multiple features using `/research`, the user has never re-read their own topic files top-to-bottom after the research session that produced them. The artifacts are produced, the synthesis happens in the user's head during production, and the files then sit unread on disk. The value capture is the act of producing them, not the act of consulting them later. This is a meaningful signal because the entire schema (per-topic files, hub README, status indicators, cross-references) is designed assuming consultation is a primary use case.

**How to leverage:** Do not treat this as a defect to fix yet — treat it as evidence about what the artifacts are actually *for*. Three failure modes are conflated in "never went back," and they have different fixes:

1. **Never re-read top-to-bottom by the author.** Almost certainly true, probably true of most authored docs. If this is the whole story, topic files are write-only; optimize for cheap production, don't pay re-readability costs.
2. **Never referenced at all in downstream decisions.** Much stronger claim. If true, the failure is findability or framing, not format — and a "tarball" model would make it *worse*, not better.
3. **Never read by the author but read by agents on the author's behalf** when chaining `/research` → `/decision` → `/task`. Different format requirements: what an agent can extract, not what is pleasant to skim.

These three have different fixes. Do not pick a format change before naming which one is true.

### The schema already half-articulated the missing piece

**Finding:** The deleted scaffolds from PR #103 (cleared as part of skill-template-separation Group 1) included a `research-summary.md` slot alongside the topic files. The original design intuited that topics need a synthesizing companion. What it did not decide was whether the summary is **additive** (a sibling, optional read, leaves topics as primary) or **subtractive** (the primary read surface, topics demoted to audit trail). The "tarball + digestible artifact" reframe is the subtractive version of that same instinct — same shape, stronger commitment.

**How to leverage:** When the question is actually addressed, frame it explicitly as additive-vs-subtractive. The schema implicitly chose additive by default; the reframe is a deliberate flip to subtractive. Don't slip back into additive accidentally by adding the summary without changing how the hub or `/research` workflow treats the topics.

---

## 🟡 What Needs Improvement

### Research artifact structure is read-symmetric, but usage is asymmetric

**What the problem was:** `/research` produces N topic files (one per research question) plus optionally a `research-summary.md`. Topic files and summary are treated as siblings — same directory, same hub, same status indicator vocabulary. The structure implies all are intended to be read with similar weight. In practice, the topic files are rarely re-read and the summary (when present) is the only durable read surface. The mismatch shows up at the moments where artifact value should be highest: handing work back to future-self, handing it to a reviewer, or feeding it to an agent on a downstream task. In each case the topic files add noise around the actual deliverable (the synthesis), and there's no schema-level signal about which file is primary.

**How to prevent:** The reframe under consideration is to treat topic files as **archived audit trail** (preserved for traceability, rarely opened) and produce one **front-facing digestible artifact** as the primary read surface. But — see Additional Notes — that reframe quietly inverts the writing workflow too, and the right design depends on naming the reader.

**Template changes needed:** None yet. See Additional Notes for the questions that gate any change. Locking in a format now would commit to the status quo (raw topic files as durable read surface) exactly when the status quo is under question.

---

## 📝 Additional Notes

### The reframe quietly inverts the writing workflow

Today's rhythm: explore each topic in depth via `/research`, then compose a summary from them. If the summary becomes the primary read surface, eventually you face:

- **Same workflow, different display** — cheap. `/research` keeps writing topics; the hub points readers at the summary first; topics demoted to drill-down.
- **Summary-first with topics as appendix** — a real change to how `/research` works. Synthesis moves earlier; topics become drill-down material rather than the primary deliverable.

These have very different scope implications and should be named before any change to `/research`.

### The structural decision depends on naming the reader

The crux question that gates any redesign: **who is the front-facing digestible artifact *for*?**

- **You-six-months-from-now picking the work back up.** Wants enough context to re-engage without the full research depth. Drill-down available but not in the face.
- **A PR reviewer.** Wants conclusions, not journey. Topics are noise; the summary *is* the deliverable.
- **Future-you on a different project trying to reuse the pattern.** Wants the meta-shape (how was this researched, what worked) more than the specific findings.

The "never re-read" data is only about one of those readers (present-self). The format question answers differently depending on which reader matters most — and possibly the answer is "different artifacts for different readers, not one front-facing thing." This is not a question to answer reflexively; it deserves an explicit `/discuss` or `/explore` round before any schema change is drafted.

### Context of capture

Surfaced during a `/discuss` round in the skill-template-separation feature work (2026-06-03), prompted by a mechanical decision about whether to merge the research branch into `develop`. The user noted "I don't want to throw away research when we haven't decided what we want to do with it" — preserving the research branch on origin (rather than landing the raw topic files on `develop`) keeps the structural decision deferred. Cherry-picking the raw files onto `develop` now would have locked in the very pattern this learning questions.

### Related artifacts

- **`feat/skill-template-separation`** — the curated ADR-001 + planning tree on `develop` currently sits without its research lineage by intentional choice. The blockquote notes on ADR-001 and `implementation-plan.md` point reviewers at the research branch.
- **`docs/skill-template-separation-research`** (on origin) — where the topic files currently live, preserved as-is pending the structural decision.
- **Possible follow-up:** an explicit exercise to answer the "what does never-read mean" disambiguation and the "who is the reader" question, before any `/research` schema change is drafted. Likely belongs under `admin/services/ai-workflow/explorations/` as a new exploration or amendment to an existing one about research workflow.

---

## ⏱️ Time Investment

N/A — discovery captured at the moment of surfacing, not a phase retrospective. Total elapsed thinking time was roughly one `/discuss` round (~20 minutes of back-and-forth) plus the realization that a pending mechanical decision (merge-research-to-develop) hinged on the unresolved structural question.

---

**Last Updated:** 2026-06-03
