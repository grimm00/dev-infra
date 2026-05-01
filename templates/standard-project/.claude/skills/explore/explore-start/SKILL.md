---
name: explore-start
description: >-
  Create a new exploration from unstructured input. Use when the user invokes
  /explore [topic] (without --amend) and wants to organize raw thoughts, ideas,
  or a brain dump into themed scaffolding with prioritized research questions.
  Do NOT use for appending to an existing exploration (/explore-amend) or for
  implementing planned work (/task).
disable-model-invocation: true
---

# Explore Start

Before proceeding, read `../SKILL.md` for family conventions (path detection,
output sizing, topic naming, commit discipline).

Create lightweight exploration scaffolding from unstructured input. The output
is a checkpoint for human review — not a finished artifact. The user decides
whether to proceed to research or discard.

```
input → parse themes + questions → create scaffolding → commit → stop
```

## Input Sources

Accept exactly one input source. Error if multiple are provided.

| Source | Flag | What it provides |
|--------|------|------------------|
| Inline text | `/explore "thoughts..."` or `--input "text"` | Raw ideas to organize |
| File | `--input path/to/file.txt` | Reads file content as input |
| start.txt | `--from-start` | Project initialization notes |
| Reflection | `--from-reflect [path]` | Actionable suggestions from a `/reflect` output |
| Interactive | *(no flag)* | Prompt: "What topic would you like to explore?" |

**If `--from-reflect`:** extract only the "Actionable Suggestions" section. If that
section is missing, warn and use the full document.

**If `--from-start`:** search current directory then project root for `start.txt`.
Error if not found or empty.

## Workflow

### 1. Resolve topic and detect conflicts

Sanitize the topic name per family conventions (kebab-case). Then check whether
an exploration already exists at the detected path:

- **No existing directory:** proceed to step 2.
- **Existing with `🔴 Scaffolding` status:** warn and suggest `--force` to overwrite
  or point the user to `/explore-amend` if the exploration is already expanded.
- **Existing with `✅ Expanded` status:** warn and suggest `/explore-amend` to append,
  or `--force` to overwrite.

### 2. Extract themes and questions

Parse the input for distinct ideas, concerns, and open questions.

**Theme extraction:**
1. Identify distinct ideas or concerns in the input
2. Group related thoughts into thematic clusters
3. Name each theme with a descriptive noun phrase (2–5 words)
4. Preserve the user's original phrasing under each theme

**Question extraction:**
1. Collect explicit questions (sentences ending in `?`)
2. Convert implicit uncertainty markers (`"maybe"`, `"not sure"`, `"what about"`,
   `"consider"`) into research questions
3. Prioritize by apparent importance in the input (High / Medium / Low)

### 3. Create scaffolding files

Create three files in the exploration directory. Use the path detected per
family conventions.

**`README.md`** (~20 lines) — hub with quick links to exploration.md and
research-topics.md.

**`exploration.md`** (~40–50 lines) — the core scaffolding:

```markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 🎯 What We're Exploring

[2–3 sentence summary extracted from input]

---

## 🔍 Initial Themes

### Theme 1: [Name]
[Bullet points preserving user's thoughts]

### Theme 2: [Name]
[Bullet points preserving user's thoughts]

---

## ❓ Key Questions

1. [Question]
2. [Question]

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| [From themes] | [HIGH/MEDIUM-HIGH/MEDIUM/LOW] | [Yes/Consider/No] | [Brief] |

**Risk framework:** HIGH = spike first (hard to pivot), MEDIUM-HIGH = consider
spike, MEDIUM/LOW = research only.

---

## 🚀 Next Steps

Review this scaffolding, then run `/explore-amend` to add themes or
`/research --from-explore` to begin investigating questions.
```

**`research-topics.md`** (~20–30 lines) — prioritized questions:

```markdown
# Research Topics — [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 📋 Topics Identified

### Topic 1: [Name]

**Question:** [Core question]
**Priority:** [High | Medium | Low]

### Topic 2: [Name]

**Question:** [Core question]
**Priority:** [High | Medium | Low]

---

## 🚀 Next Steps

Use `/research --from-explore [topic]` to investigate these questions.
```

### 4. Commit and stop

Commit all three files with `docs(explore): create [topic] exploration scaffolding`.
Then **stop and present the scaffolding summary to the user.** Do not proceed to
research or expansion — the human review checkpoint is the whole point.

## Behavioral Contract

**Create exactly three files.** Do not create additional files, directories, or
artifacts beyond README.md, exploration.md, and research-topics.md.

**Preserve the user's language.** Themes should use the user's words, not
paraphrased corporate summaries. The scaffolding is a mirror of their thinking,
not a rewrite.

**Assess spike risk for every theme.** The spike determination table is not
optional. Every theme gets a row with a risk level and rationale.

**Do not expand themes.** Scaffolding contains bullet points and placeholders,
not multi-paragraph analysis. Expansion is a separate workflow step that has
been deprecated (conduct mode, C1-2). If the user wants deeper analysis,
they proceed directly to `/research`.

**Stop after committing.** Do not start research, create additional explorations,
or suggest immediate next actions beyond reviewing the scaffolding. The
checkpoint exists so the user can discard or redirect before investing more time.

## Gotchas

**Expanding when you should scaffold.** The strongest temptation is to write
3–5 paragraphs of analysis per theme. Don't. Scaffolding is bullet points and
placeholders. If the output exceeds ~80 lines for exploration.md, you're
expanding, not scaffolding.

**Merging the user's distinct thoughts into one theme.** If the user mentions
authentication AND notification in the same paragraph, those are likely two
themes, not one. Err toward splitting; the user can merge during review.

**Inventing questions the user didn't imply.** Extract questions from the
input. If the user didn't express uncertainty about a topic, don't manufacture
a research question for it. The spike determination table is where you assess
risk — the questions section reflects the user's actual uncertainties.

**Creating the directory without checking for conflicts.** An existing
exploration at the same path means the user has prior work. Overwriting it
silently is a data-loss risk. Always check and warn.

**Skipping the commit.** The scaffolding must be committed before stopping.
If the user abandons the exploration, the commit makes it recoverable. If
they proceed, the commit creates a clean diff for the next step.

**Proceeding to research without stopping.** The whole point of setup mode
is the human review checkpoint. Even if the user seems eager to continue,
stop after the commit. They invoke the next step explicitly.
