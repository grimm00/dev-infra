# ADR-002: Input Sources for /explore

**Status:** Proposed  
**Created:** 2026-01-10  
**Last Updated:** 2026-01-10

---

## Context

Unlike other commands in the pipeline (`/research`, `/decision`, `/transition-plan`) which expect structured input from previous commands, `/explore` sits at the beginning of the ideation pipeline. This unique position means it needs to handle **unstructured input** - raw thoughts, ideas, and brain dumps.

Research identified that `/explore` should serve as a "thought organizer" that transforms unstructured thinking into structured exploration.

**Related Research:**
- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Explore Input Sources](../../research/explore-two-mode/research-explore-input-sources.md)

**Related Requirements:**
- FR-IS-1: `/explore` MUST accept unstructured text input
- FR-IS-2: `/explore` SHOULD support `--from-start` flag
- FR-IS-3: `/explore` MAY support `--from-reflect` flag

---

## Decision

**Support multiple input sources with raw text as primary.**

### Input Source Priority

| Priority | Source | Flag | Use Case |
|----------|--------|------|----------|
| 1 (Primary) | Raw text | `--input [text\|file]` | Brain dumps, ideas, thoughts |
| 2 | start.txt | `--from-start` | Project initialization context |
| 3 | Reflections | `--from-reflect [file]` | Actionable suggestions |
| 4 | Interactive | (no flag) | Prompt for topic |

### Raw Text Input (Primary)

```bash
# Inline text
/explore "I've been thinking about improving our auth system..."

# From file
/explore --input thoughts.txt

# From stdin (if supported)
cat ideas.md | /explore
```

### start.txt Input

```bash
/explore --from-start
```
- Reads project's `start.txt` file
- Extracts themes and questions from initialization notes
- Natural for new projects

### Reflection Input

```bash
/explore --from-reflect reflection-2026-01-10.md
```
- Reads "Actionable Suggestions" from reflection document
- Converts suggestions into exploration topics
- Bridges `/reflect` → `/explore` pipeline

---

## Consequences

### Positive

- **Low Friction Entry:** Users can start with raw thoughts
- **Multiple Entry Points:** Supports different starting contexts
- **Pipeline Integration:** Connects to `/reflect` output
- **Project Bootstrap:** `--from-start` helps new project exploration

### Negative

- **Input Parsing Complexity:** Must handle unstructured text
- **Multiple Flags:** More options to document and test
- **Ambiguity:** Raw text may produce varied results

---

## Alternatives Considered

### Alternative 1: Structured Input Only

**Description:** Require structured input format (YAML, Markdown sections).

**Pros:**
- Predictable parsing
- Consistent output

**Cons:**
- High friction for ideation
- Doesn't match exploration use case
- Blocks spontaneous ideas

**Why not chosen:** Exploration is inherently unstructured; forcing structure defeats the purpose.

---

### Alternative 2: Topic-Only Input

**Description:** Only accept topic name, generate exploration from scratch.

**Pros:**
- Simplest interface
- No parsing needed

**Cons:**
- Loses user's initial thoughts
- AI generates without context
- Doesn't leverage existing content

**Why not chosen:** User's raw thoughts are valuable input; discarding them loses context.

---

## Decision Rationale

**Key Factors:**
1. **Unique Position:** `/explore` is the pipeline entry point - must handle unstructured input
2. **Thought Organizer:** Primary value is transforming chaos into structure
3. **start.txt Natural Fit:** Project initialization notes are perfect exploration input
4. **Pipeline Continuity:** `--from-reflect` connects existing workflow

**Research Support:**
- Finding 3: `/explore` uniquely handles unstructured input
- Insight 3: Two-mode as "thought organizer"
- Insight 4: start.txt is natural structured input

---

## Requirements Impact

**Requirements Addressed:**
- FR-IS-1: Unstructured Text Input ✅
- FR-IS-2: start.txt Input Source ✅
- FR-IS-3: Reflection Input Source ✅
- FR-IS-4: Theme Organization ✅
- FR-IS-5: Question Extraction ✅

**Requirements Refined:**
- FR-IS-1 clarified: Raw text is PRIMARY input, not just supported

---

## References

- [Research Summary](../../research/explore-two-mode/research-summary.md)
- [Input Sources Research](../../research/explore-two-mode/research-explore-input-sources.md)
- [Requirements Document](../../research/explore-two-mode/requirements.md)

---

**Last Updated:** 2026-01-10
