# Foundation (Rules + AGENTS.md)

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Foundation (Rules + AGENTS.md)
**Status:** ✅ Expanded
**Last Updated:** 2026-04-24

---

## 📝 Tasks

- [ ] Task 1: Audit current `.mdc` rules content and classify by destination
  - **Purpose:** Map every section of the existing 1,623 lines to its four-type destination (FR-4) before making changes
  - **Steps:**
    1. Read `.cursor/rules/main.mdc` (546 lines, 16 sections)
    2. Read `.cursor/rules/workflow.mdc` (647 lines, 15 sections)
    3. Read `.cursor/rules/template.mdc` (430 lines, 14 sections)
    4. For each section, classify as one of: **portable convention** (→ AGENTS.md), **Cursor-specific config** (→ slimmed `.mdc`), **procedural reference** (→ skill body, deferred to skill conversion), **mutable project state** (→ removed)
    5. Produce a classification table in the output
  - **Files:** `.cursor/rules/main.mdc`, `.cursor/rules/workflow.mdc`, `.cursor/rules/template.mdc`
  - **Acceptance:** Classification table covers all 45 sections across 3 files, each section mapped to exactly one destination

  **Preliminary classification (from section headers — verify during audit):**

  | File | Section | Likely Destination |
  |------|---------|-------------------|
  | main.mdc | Project Overview, Project Identity | AGENTS.md (portable identity) |
  | main.mdc | Documentation Standards | AGENTS.md (portable conventions) |
  | main.mdc | Project Structure | AGENTS.md (directory overview) |
  | main.mdc | Workflow Processes | Pointer only; detail → skill bodies |
  | main.mdc | Template Development Standards | AGENTS.md (conventions) or skill body |
  | main.mdc | Cursor Commands Integration | Skill body (procedural) |
  | main.mdc | Code and Development Standards | AGENTS.md (conventions) |
  | main.mdc | AI Assistant Guidelines | Slimmed `.mdc` (Cursor-specific) |
  | main.mdc | Reference Templates | Skill `assets/` (procedural) |
  | main.mdc | Current Project State | **REMOVED** (FR-5) |
  | main.mdc | Maintenance | Slimmed `.mdc` (meta-pointer) |
  | workflow.mdc | Git Flow Workflow | AGENTS.md (conventions) |
  | workflow.mdc | Review-then-Commit Workflow | Skill body (`review`, `commit`) |
  | workflow.mdc | PR Review Workflow | Skill body (`pr`, `pr-validation`) |
  | workflow.mdc | Template Development Process | Skill body or AGENTS.md |
  | workflow.mdc | CI/CD Integration | AGENTS.md (brief) or removed |
  | workflow.mdc | Command Integration Workflow | Skill body (procedural) |
  | workflow.mdc | Plan Review, Spike, Worktree workflows | Skill bodies (respective skills) |
  | workflow.mdc | TDD for Bash, Script Flags | AGENTS.md (conventions) |
  | workflow.mdc | Release Process | Skill body (`task-release`) |
  | workflow.mdc | Template Maintenance, CI Investigation | AGENTS.md or skill body |
  | template.mdc | Template Structure Standards | AGENTS.md (conventions) |
  | template.mdc | Template File Standards | AGENTS.md (conventions) |
  | template.mdc | Template Generation Standards | Skill body (procedural) |
  | template.mdc | Template Testing Standards | AGENTS.md (conventions) |
  | template.mdc | Template Sync Validation | Skill body (procedural) |
  | template.mdc | TDD for Template Scripts | AGENTS.md (conventions) |
  | template.mdc | Template Evolution Process | AGENTS.md or removed |

  **Note:** The preliminary classification is a starting point. The actual audit will verify each section's content against FR-4 criteria and may reclassify.

---

- [ ] Task 2: Draft AGENTS.md with portable conventions
  - **Purpose:** Create the portable always-on context layer shared between Cursor and Claude Code
  - **Steps:**
    1. Using the audit classification from Task 1, extract all "portable convention" content
    2. Write `AGENTS.md` at the repo root with conventions organized by category
    3. All content must be inline (FR-1 — no file references or "see X.md" as a substitute for actual content)
    4. Include a single pointer to current state: `Current project state: see admin/services/meta/features/dev-infra-identity-and-focus/ or admin/planning/status-and-next-steps.md`
    5. Verify no mutable state embedded (FR-5)
    6. Target: ~150-200 lines (tight, conventions-only writing)
  - **Content categories** (from ADR-003):
    - Git Flow branching strategy and commit format conventions
    - Hub-and-spoke documentation pattern description
    - Status indicators (`🔴`, `🟡`, `🟠`, `✅`) and date format (`YYYY-MM-DD`)
    - File naming conventions (kebab-case)
    - Project structure overview (truncated directory map showing services/, templates/, scripts/)
    - Template development standards (test generation, update docs, maintain consistency)
  - **Files:** `AGENTS.md` (new, at repo root)
  - **Acceptance:** AGENTS.md exists at repo root, ~150-200 lines, all content inline, no mutable state, no procedural workflows (those belong in skills)
  - **Gotcha:** Don't include workflow procedures (command steps, checklists). Those are for skill bodies. AGENTS.md carries *conventions*, not *instructions*.

---

- [ ] Task 3: Draft CLAUDE.md mirroring AGENTS.md content
  - **Purpose:** Provide identical always-on context for Claude Code CLI users (C-1, C-4)
  - **Steps:**
    1. Copy AGENTS.md content to `CLAUDE.md` at the repo root
    2. Add a header note: `This file is kept in sync with AGENTS.md. When updating conventions, update both files.`
    3. Verify content is identical to AGENTS.md
  - **Files:** `CLAUDE.md` (new, at repo root)
  - **Acceptance:** CLAUDE.md exists at repo root, content byte-identical to AGENTS.md (minus the sync note header)
  - **Future:** Sync enforcement via template sync validation or generation script (not in scope for this task)

---

- [ ] Task 4: Slim `.mdc` rules to ~50 lines
  - **Purpose:** Reduce always-on Cursor context to only what's Cursor-specific (ADR-003)
  - **Steps:**
    1. Create a new `.cursor/rules/cursor-config.mdc` (~50 lines) containing ONLY:
       - Agent response style preferences (tone, formatting)
       - Tool usage preferences ("prefer specialized tools over terminal commands")
       - Mode-switching hints ("switch to plan mode for complex tasks")
       - Pointer: "For project conventions, see AGENTS.md at repo root"
       - Pointer: "For available workflows, see .claude/skills/ directory"
    2. Archive old rules (don't delete yet — keep as reference during skill conversion):
       - Rename `main.mdc` → `main.mdc.archived`
       - Rename `workflow.mdc` → `workflow.mdc.archived`
       - Rename `template.mdc` → `template.mdc.archived`
    3. Verify agent loads `cursor-config.mdc` and `AGENTS.md` correctly
    4. Test: open a new conversation, verify response style and conventions are applied
  - **Files:**
    - Create: `.cursor/rules/cursor-config.mdc` (~50 lines)
    - Archive: `.cursor/rules/main.mdc` → `.cursor/rules/main.mdc.archived`
    - Archive: `.cursor/rules/workflow.mdc` → `.cursor/rules/workflow.mdc.archived`
    - Archive: `.cursor/rules/template.mdc` → `.cursor/rules/template.mdc.archived`
  - **Acceptance:**
    - Only one active `.mdc` file (~50 lines)
    - Old `.mdc` files archived (not deleted — skill conversion in Groups 2-4 needs to reference procedural content from them)
    - Agent behavior is consistent: same response style, same conventions awareness, but dramatically less context consumed
  - **Gotcha:** Don't delete old rules yet. Groups 2-4 extract procedural content from archived rules into skill bodies. Deletion happens in Stage 1 Group 5 (Cutover) or later.
  - **Gotcha:** A-1 says Cursor reads AGENTS.md at lowest priority. Ensure `cursor-config.mdc` doesn't contradict AGENTS.md content. If there's a conflict, `.mdc` wins and AGENTS.md content is silently ignored.

---

## 🎯 Goals

1. Establish the always-on context layer that all subsequent skill conversion depends on
2. Reduce always-on context from ~1,623 lines to ~50 (`.mdc`) + ~150-200 (AGENTS.md)
3. Validate the four-type separation (FR-4) on real content before applying it elsewhere
4. Preserve archived rules as extraction source for Groups 2-4

---

## ✅ Completion Criteria

- [ ] Classification audit complete — every section of all 3 rules files mapped to a destination
- [ ] `AGENTS.md` exists at repo root (~150-200 lines, inline portable conventions)
- [ ] `CLAUDE.md` exists at repo root (synchronized with AGENTS.md)
- [ ] `cursor-config.mdc` exists (~50 lines, Cursor-specific config only)
- [ ] Old `.mdc` files archived (`.mdc.archived` extension)
- [ ] No mutable project state in any always-on file (FR-5)
- [ ] Manual verification: new conversation behaves consistently with reduced context
- [ ] No contradictions between `cursor-config.mdc` and `AGENTS.md` (A-1 compliance)

---

## 🔗 Dependencies

- None (this is the foundation that subsequent groups depend on)
- **Output enables:** Groups 2-4 (skill conversion depends on AGENTS.md existing)
- **Output preserves:** Archived `.mdc` files are extraction source for skill body content in Groups 2-4

---

## Implementation Notes

### Archive Strategy

Old `.mdc` files are archived, not deleted. This is because:
- Groups 2-4 need to read procedural content from them to write skill bodies
- The audit in Task 1 classifies content but doesn't move all of it — only portable conventions go to AGENTS.md and Cursor config stays in `.mdc`
- Procedural content (the bulk of workflow.mdc and template.mdc) transfers to skill bodies during conversion

The archived files can be fully deleted after all Stage 1 skills are converted AND verified (Group 5, Task 17).

### AGENTS.md Sizing

Target 150-200 lines. Current conventions spread across 3 files total ~1,623 lines, but most of that is procedural reference, not conventions. The actual convention content (naming rules, branching strategy, status indicators, file naming, project structure) is relatively compact when written densely. If it lands at 200+ lines, some content may be conventions disguised as procedures — revisit the classification.

### Testing the Slim Rules

After Task 4, open a fresh Cursor conversation and verify:
1. Agent knows the project is dev-infra (from AGENTS.md)
2. Agent follows Git Flow branching conventions
3. Agent uses kebab-case for file naming
4. Agent doesn't reference old mutable state (version numbers, feature lists)
5. Agent response style matches preferences

If anything breaks, check whether the issue is AGENTS.md content (needs more detail) or `.mdc` priority (A-1 conflict).

---

**Last Updated:** 2026-04-24
