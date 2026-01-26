# Handoff Command - Exploration

**Status:** 🔴 Exploration  
**Created:** 2026-01-06  
**Last Updated:** 2026-01-06

---

## 🎯 What Are We Exploring?

A command system for managing context handoff between AI chat sessions. The core problem: continued use of a chat session degrades AI performance over time due to context accumulation. This command would provide structured ways to:

1. **Hand Off** - One session creates a handoff document capturing current state
2. **Pick Up** - A new session reads the handoff document and continues work

---

## 🤔 Why Explore This?

**Problem Statement:**

Long AI chat sessions accumulate context that:
- Slows down responses
- Introduces confusion from earlier conversation
- Can cause the AI to "forget" or contradict earlier decisions
- Results in degraded performance over time

**Current Solution (Manual):**

Users manually create handoff documents (like `tmp/handoff-2026-01-06.md` in proj-cli) with:
- Quick context
- Current state
- Immediate next action
- Key files
- Development environment
- Known issues
- Session goals

**Opportunity:**

Automate this pattern into a standardized command that:
- Generates consistent handoff documents
- Gathers context automatically where possible
- Provides clear "pick up" instructions for new sessions
- Reduces cognitive overhead of context management

---

## 💡 Initial Thoughts

### Command Modes

**Two-Mode Approach:**

1. **`/handoff --create`** (or `/handoff create`)
   - Generates a handoff document
   - Summarizes current state
   - Lists immediate next actions
   - Could be interactive (prompts for context) or auto-generated

2. **`/handoff --pickup`** (or `/handoff pickup`)
   - Reads existing handoff document
   - Loads context into current session
   - Presents state and suggested next action

**Additional Mode Ideas:**

3. **`/handoff --update`** - Update existing handoff without creating new
4. **`/handoff --list`** - List available handoff documents
5. **`/handoff --archive`** - Archive old handoff documents

### Storage Location

**Options:**

1. **Untracked `tmp/` directory** (current approach)
   - Pro: Keeps repo clean, no noise in commits
   - Con: Could be lost, not shared across machines

2. **Tracked `admin/handoffs/` directory**
   - Pro: Versioned, shareable, permanent record
   - Con: Clutters repo with transient state

3. **Date-based organization**
   - `tmp/handoffs/YYYY-MM-DD.md`
   - `tmp/handoffs/YYYY-MM-DD-[topic].md`

### Content Generation

**What can be auto-generated:**

- Current git branch
- Recent commits
- Modified files
- Current TODO status (from `/status` command)
- Feature/phase being worked on (from file paths)

**What needs human input:**

- Quick context summary
- Known issues/blockers
- Session goals
- Key learnings from current session

### Integration Points

**Related commands:**

- `/status` - Could provide current TODO state
- `/task-phase` - Could indicate current phase/task
- `/int-opp` - Learnings could be captured
- `/reflect` - Reflection artifacts could inform handoff

---

## 🔄 Alternative Context Management Approaches

Before committing to a handoff command, consider the broader context management landscape:

### 1. Handoff Documents (This Exploration)

- **How:** Explicit file-based context transfer between sessions
- **Pros:** Self-contained, portable, works across any AI tool
- **Cons:** Manual effort, can get stale

### 2. Cursor's Built-in Context

- **`.cursor/rules/`** - Always-applied rules loaded into every session
- **`@` mentions** - Explicitly reference files, folders, codebase
- **Notepads** - Cursor's built-in context storage (experimental)
- **Pros:** Native, automatic
- **Cons:** Limited to Cursor, rules are project-wide not session-specific

### 3. Living Status Documents

- **How:** Keep `status-and-next-steps.md` always current
- **Example:** Existing feature status docs serve as "passive handoff"
- **Pros:** Already part of workflow, git-tracked
- **Cons:** More general, not session-specific

### 4. Git-Based Context

- **How:** Use git state as context source
  - Branch name encodes current work (`feat/template-generation-phase-4`)
  - Recent commits show activity
  - Uncommitted changes show WIP
- **Pros:** Automatic, no extra effort
- **Cons:** Limited to code changes, misses reasoning/context

### 5. Session Checkpoints

- **How:** Periodic mid-session summaries stored in tmp
- **Example:** Every hour or after major milestone, update a running context file
- **Pros:** Gradual context capture, less end-of-session pressure
- **Cons:** More overhead during session

### 6. Command-Driven Context Loading

- **How:** Commands like `/status` output context that AI can consume
- **Example:** `/status --context` outputs machine-readable state
- **Pros:** Integrates with existing workflow
- **Cons:** Requires AI to "read" its own output

### 7. MCP (Model Context Protocol)

**MCP is an open standard developed by Anthropic** that allows AI assistants to connect to external data sources and tools.

```
┌─────────────────┐     MCP Protocol     ┌─────────────────┐
│   AI Assistant  │ ←──────────────────→ │   MCP Server    │
│   (e.g. Claude) │                      │ (data/tools)    │
└─────────────────┘                      └─────────────────┘
```

**MCP Servers can provide:**

- **Resources** - Files, documents, database records
- **Tools** - Actions the AI can invoke (create file, query API, etc.)
- **Prompts** - Pre-built prompt templates

**Examples of MCP Servers:**

| Server | What It Provides |
|--------|-----------------|
| **Filesystem** | Read/write files from specified directories |
| **GitHub** | Access repos, issues, PRs |
| **Memory** | Persistent key-value storage across sessions |
| **PostgreSQL** | Query databases |

**Relevance to context management:**

- **Memory MCP Server** - Could provide persistent storage across sessions
- **Filesystem MCP Server** - Read/write context files automatically
- **Custom MCP Server** - Purpose-built for workflow context

**Trade-offs:**

- **Pros:** Automatic, programmatic, persistent
- **Cons:** Requires server setup, Cursor/Claude-specific, more complexity

### 8. Context Layers Pattern (Hybrid Approach)

Multiple context sources with different lifespans:

```
┌─────────────────────────────────────────────┐
│ Layer 1: Cursor Rules (always loaded)       │ ← Project patterns, conventions
├─────────────────────────────────────────────┤
│ Layer 2: Status Docs (feature-specific)     │ ← Current phase, tasks, progress
├─────────────────────────────────────────────┤
│ Layer 3: Handoff (session-specific)         │ ← Immediate context, blockers, learnings
└─────────────────────────────────────────────┘
```

**Recommendation:** Handoff documents are one layer in a multi-layer strategy. Start simple, add MCP or other approaches as needs evolve.

---

## 📊 Comparison Matrix

| Approach | Setup | Portability | Persistence | Complexity |
|----------|-------|-------------|-------------|------------|
| **Handoff Docs** | None | High (any AI) | Git optional | Low |
| **Cursor Rules** | Config | Cursor only | Git-tracked | Low |
| **Status Docs** | Workflow | High | Git-tracked | Low |
| **Git Context** | None | Medium | Git history | Low |
| **MCP Memory** | Server setup | Claude/Cursor | External | Medium-High |
| **Checkpoints** | Workflow | High | Git optional | Medium |

---

## 🔍 Key Questions

- [ ] Question 1: What's the optimal location for handoff documents (tracked vs untracked)?
- [ ] Question 2: How much context should be auto-generated vs prompted?
- [ ] Question 3: Should handoffs be session-specific or feature-specific?
- [ ] Question 4: How do we handle multiple concurrent features/work streams?
- [ ] Question 5: What's the ideal handoff document structure/template?
- [ ] Question 6: Should this integrate with other commands (status, task-phase)?
- [ ] Question 7: How do we handle handoff across different projects in workspace?

---

## 🔄 Workflow Scenarios

### Scenario A: End of Work Session

```
User: I'm done for today, need to hand off

Agent: /handoff create

→ Gathers current state (git, TODOs, recent work)
→ Prompts for key context ("What should the next session know?")
→ Creates tmp/handoff-2026-01-06.md
→ Outputs: "Handoff created. Next session can run /handoff pickup"
```

### Scenario B: Start of New Session

```
User: /handoff pickup

Agent reads tmp/handoff-2026-01-06.md
→ Presents: "Picking up from previous session..."
→ Shows: Current state, immediate next action, known issues
→ Asks: "Ready to continue with [next action]?"
```

### Scenario C: Mid-Session Context Refresh

```
User: Context seems degraded, let's refresh

Agent: /handoff create --quick
→ Creates minimal handoff
→ User starts new chat
→ /handoff pickup
→ Continues with clean context
```

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research handoff-command --from-explore handoff-command` to conduct research
3. After research, use `/decision handoff-command --from-research` to make decisions

---

## 📝 Notes

### From proj-cli Example

The manual handoff document in proj-cli (`tmp/handoff-2026-01-06.md`) includes these sections:

1. **Header** - Date, project, feature, current phase
2. **Quick Context** - What is the project/feature
3. **Current State** - Phase table with completion status, overall progress
4. **Immediate Next Action** - Single clear command to run
5. **Key Files** - Tables of documentation and implementation files
6. **Phase Tasks** - Detailed breakdown of current phase
7. **Development Environment** - Shell commands for setup
8. **Known Issues** - Pre-existing failures, deferred work
9. **Command Reference** - Useful commands table
10. **Related Projects** - Cross-project context
11. **Key Learnings** - Important insights from recent work
12. **Session Goals** - Suggested priorities
13. **Troubleshooting** - Where to look if stuck

This structure has proven effective for real handoffs and should inform the template design.

### Design Principles

- **Progressive disclosure** - Quick action upfront, details below
- **Self-contained** - Handoff should work even without repo context
- **Actionable** - Clear next step, not just status dump
- **Portable** - Works across different project structures

---

**Last Updated:** 2026-01-06

