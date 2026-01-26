# Research Topics - Handoff Command

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2026-01-06  
**Last Updated:** 2026-01-06

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions.

### Research Topic 1: Storage and Location Strategy

**Question:** Where should handoff documents be stored, and how should they be organized?

**Sub-questions:**
- Tracked (`admin/handoffs/`) vs untracked (`tmp/`) directory?
- Per-date (`YYYY-MM-DD.md`) vs per-feature vs per-session naming?
- Single file vs directory with supporting files?
- Cross-project handoffs (workspace with multiple projects)?

**Why:** Storage location affects discoverability, versioning, and repo cleanliness. Wrong choice could clutter repo or lose valuable context.

**Priority:** High

**Status:** 🔴 Not Started

---

### Research Topic 2: Auto-Generation Capabilities

**Question:** What context can be reliably auto-generated vs requires human input?

**Sub-questions:**
- What git state is useful? (branch, recent commits, modified files, stash)
- Can TODO state from `/status` be incorporated?
- Can current phase/task be detected from recent file changes?
- How to detect "current feature" from directory structure?
- What patterns indicate work in progress vs completed?

**Why:** More auto-generation reduces friction and ensures consistency. Too much auto-generation could miss critical human context.

**Priority:** High

**Status:** 🔴 Not Started

---

### Research Topic 3: Handoff Document Structure

**Question:** What is the optimal template structure for handoff documents?

**Sub-questions:**
- What sections are essential vs optional?
- How to balance brevity with completeness?
- Should structure vary by project type (standard vs learning)?
- How to handle multi-feature/concurrent work streams?
- Progressive disclosure: what goes at top vs bottom?

**Why:** Template design directly impacts handoff effectiveness. The proj-cli example provides a starting point but may need refinement.

**Priority:** High

**Status:** 🔴 Not Started

---

### Research Topic 4: Command Mode Design

**Question:** What modes should the handoff command support and how should they work?

**Sub-questions:**
- Two modes (`create`/`pickup`) vs more modes?
- Interactive vs non-interactive modes?
- Should `--quick` variant exist for minimal handoffs?
- How does `pickup` present information to AI?
- Should pickup be automatic detection or explicit?

**Why:** Mode design affects usability and adoption. Too many modes = complexity. Too few = inflexibility.

**Priority:** Medium

**Status:** 🔴 Not Started

---

### Research Topic 5: Integration with Existing Commands

**Question:** How should handoff integrate with other workflow commands?

**Sub-questions:**
- `/status` - Can handoff use status data?
- `/task-phase` - Can handoff detect current phase/task?
- `/int-opp` - Should learnings auto-populate handoff?
- `/reflect` - Should reflection artifacts inform handoff?
- Should other commands auto-update handoff?

**Why:** Integration reduces duplication and ensures handoff stays current. Over-integration could create tight coupling.

**Priority:** Medium

**Status:** 🔴 Not Started

---

### Research Topic 6: Cross-Project Workspace Support

**Question:** How should handoff work in multi-project workspaces?

**Sub-questions:**
- Per-project handoffs vs workspace-wide handoff?
- How to indicate which project is primary?
- Should handoff capture related project context?
- How to handle projects with different structures?

**Why:** The user's workspace has 4+ projects. Handoff needs to work smoothly in this context.

**Priority:** Medium

**Status:** 🔴 Not Started

---

### Research Topic 7: Pickup Experience Design

**Question:** How should the "pickup" mode present information to a new AI session?

**Sub-questions:**
- How much context to load immediately vs on-demand?
- Should pickup auto-read referenced files?
- How to avoid overwhelming new session with too much context?
- Should pickup confirm understanding before proceeding?
- What's the ideal "first message" after pickup?

**Why:** The pickup experience determines whether the handoff actually helps or just adds noise to the new session.

**Priority:** Medium

**Status:** 🔴 Not Started

---

### Research Topic 8: MCP (Model Context Protocol) as Alternative

**Question:** Could MCP servers provide automatic context persistence instead of manual handoff documents?

**Sub-questions:**
- What MCP servers exist for memory/persistence? (e.g., Memory MCP Server)
- How does Cursor's MCP integration work currently?
- What's the setup complexity vs handoff documents?
- Can MCP and handoff documents work together (hybrid approach)?
- What are the portability implications (Cursor/Claude-specific vs universal)?
- Is there a path to "automatic handoff" via MCP?

**Why:** MCP represents a potential future direction that could automate context management. Understanding this helps avoid building something that MCP will obsolete, or identify where handoff documents complement MCP.

**Priority:** Low (Future Consideration)

**Status:** 🔴 Not Started

---

### Research Topic 9: Context Layers Strategy

**Question:** How should different context mechanisms work together?

**Sub-questions:**
- What goes in Cursor Rules (Layer 1: always-on)?
- What goes in Status Docs (Layer 2: feature-specific)?
- What goes in Handoffs (Layer 3: session-specific)?
- How to avoid duplication across layers?
- When should handoff "graduate" to status docs or rules?

**Why:** A layered approach could be more effective than a single handoff mechanism. Understanding layer boundaries helps design a coherent system.

**Priority:** Low (Design Consideration)

**Status:** 🔴 Not Started

---

## 🎯 Research Workflow

1. Use `/research handoff-command --from-explore handoff-command` to conduct research
2. Research will create documents in `admin/research/handoff-command/`
3. After research complete, use `/decision handoff-command --from-research` to make decisions

---

## 📊 Priority Summary

| Topic | Priority | Reason |
|-------|----------|--------|
| Storage Strategy | High | Foundational decision affecting all other choices |
| Auto-Generation | High | Core feature capability |
| Document Structure | High | Directly impacts effectiveness |
| Command Modes | Medium | UX design, can iterate |
| Command Integration | Medium | Enhancement, not critical path |
| Cross-Project | Medium | Important for workspace, but can defer |
| Pickup Experience | Medium | Refinement, can iterate |
| MCP Alternative | Low | Future consideration, doesn't block v1 |
| Context Layers | Low | Design consideration, informs architecture |

---

**Last Updated:** 2026-01-06

