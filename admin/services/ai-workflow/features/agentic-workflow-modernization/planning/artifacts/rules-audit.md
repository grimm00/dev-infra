# Rules Audit — Four-Type Classification (FR-4)

**Task:** Task 1 of Stage 1 (Foundation)
**Date:** 2026-04-24
**Source Files:** `.cursor/rules/main.mdc` (547 lines), `workflow.mdc` (648 lines), `template.mdc` (431 lines)
**Total:** ~1,626 lines across 46 sections

---

## Destinations (FR-4)

| Code | Destination | Description |
|------|-------------|-------------|
| **A** | AGENTS.md | Portable conventions shared across Cursor + Claude Code |
| **C** | Slimmed `.mdc` | Cursor-specific agent config (~50 lines target) |
| **S** | Skill body/assets | Procedural reference, deferred to respective skill conversions |
| **R** | Removed | Mutable state (FR-5), stale inventories, internal navigation |

---

## Classification Table

### main.mdc (547 lines, 16 sections)

| # | Section (H2) | Lines | ~Size | Dest | Rationale |
|---|-------------|-------|-------|------|-----------|
| M1 | Header/metadata | 5-10 | 6 | **R** | Meta-header for the rules file itself |
| M2 | Quick Links | 14-24 | 11 | **R** | Internal navigation between rules files |
| M3 | Project Overview | 27-43 | 17 | **A** | Portable project identity + key principles |
| M4 | Project Identity: Template Factory | 46-73 | 28 | **A** | ADR-001 identity, work categories, distribution model |
| M5 | Documentation Standards | 77-122 | 46 | **A** | Hub-and-spoke pattern, status indicators, date format, file naming |
| M6 | Project Structure | 125-166 | 42 | **A** | Directory organization tree, file location rules (needs update for service-first) |
| M7 | Workflow Processes | 169-178 | 10 | **R** | Pointer to workflow.mdc; irrelevant after slimming |
| M8 | Template Development Standards | 181-221 | 41 | **A** | Template modification conventions, structure requirements |
| M9 | Cursor Commands Integration | 224-243 | 20 | **R** | Stale commands inventory; replaced by skills |
| M10 | Code and Development Standards | 246-274 | 29 | **A** | Template code quality, script quality conventions |
| M11 | AI Assistant Guidelines | 277-318 | 42 | **A/C** | Split — see detail below |
| M12 | Reference Templates | 322-365 | 44 | **S** | Markdown snippet templates for doc creation workflows |
| M13 | Project-Specific Context | 368-394 | 27 | **A** | Target audience, core goals, success metrics |
| M14 | Current Project State | 397-515 | 119 | **R** | FR-5 mutable state (version, feature lists, status) |
| M15 | Maintenance | 518-541 | 24 | **R** | Self-referential meta about rules management |
| M16 | Footer | 544-547 | 4 | **R** | Last Updated / Status / Next |

**M11 split detail:**
- "When suggesting changes" (5 behavioral points) → **A** (portable convention)
- "When creating new templates" (6 points) → **A** (portable convention)
- "When making template changes" (5 points) → **A** (portable convention)
- "When integrating commands" (5 points) → **R** (replaced by skills)
- "Response style" (5 points) → **C** (Cursor-specific agent preferences)

**main.mdc summary:**
- **A** (AGENTS.md): ~230 lines from M3, M4, M5, M6, M8, M10, M11-partial, M13
- **C** (Slimmed .mdc): ~5 lines from M11 response style
- **S** (Skill body): ~44 lines from M12
- **R** (Removed): ~194 lines from M1, M2, M7, M9, M11-partial, M14, M15, M16

---

### workflow.mdc (648 lines, 17 sections)

| # | Section (H2) | Lines | ~Size | Dest | Rationale |
|---|-------------|-------|-------|------|-----------|
| W1 | Header/metadata | 5-9 | 5 | **R** | Meta-header |
| W2 | Quick Links | 13-17 | 5 | **R** | Internal navigation |
| W3 | Git Flow Workflow | 21-67 | 47 | **A** | Branch strategy, commit requirements, message format |
| W4 | Review-then-Commit Workflow | 70-101 | 32 | **S** | Procedural for review/commit skills |
| W5 | Pull Request Review Workflow | 105-172 | 68 | **S** | Procedural for pr/pr-validation skills |
| W6 | Template Development Process | 175-234 | 60 | **A/S** | Split — see detail below |
| W7 | CI/CD Integration | 237-265 | 29 | **A** | Testing requirements per branch type |
| W8 | Command Integration Workflow | 268-283 | 16 | **R** | Stale commands inventory |
| W9 | Plan Review Workflow | 287-313 | 27 | **S** | Procedural for plan-review skill |
| W10 | Spike Workflow | 316-366 | 51 | **S** | Procedural for spike skill |
| W11 | Worktree Feature Workflow | 370-449 | 80 | **A/S** | Split — see detail below |
| W12 | TDD for Bash Scripts | 453-493 | 41 | **A** | RED-GREEN-REFACTOR conventions, Bats, best practices |
| W13 | Script Flag Conventions | 497-514 | 18 | **A** | Standard flags table |
| W14 | Release Process | 518-570 | 53 | **S** | Procedural for task-release skill |
| W15 | Template Maintenance Guidelines | 574-601 | 28 | **A** | Test first, update docs, consistency |
| W16 | CI/CD Failure Investigation | 604-632 | 29 | **A** | Root cause analysis conventions |
| W17 | Footer/Related | 636-648 | 13 | **R** | Links + metadata |

**W6 split detail:**
- Template development lifecycle (6-step overview) → **A** (high-level convention)
- Creating new template features (directory structure, required files, implementation plan YAML structure) → **S** (procedural for transition-plan/task skills)

**W11 split detail:**
- Worktree setup + naming convention (3 lines) → **A** (portable convention)
- Self-contained branches principle (5 lines) → **A** (portable convention)
- Draft PR workflow details, fix-before-re-review, PR count, sourcery config → **S** (procedural for pr skill)

**workflow.mdc summary:**
- **A** (AGENTS.md): ~180 lines from W3, W6-partial, W7, W11-partial, W12, W13, W15, W16
- **C** (Slimmed .mdc): 0 lines
- **S** (Skill body): ~371 lines from W4, W5, W6-partial, W9, W10, W11-partial, W14
- **R** (Removed): ~39 lines from W1, W2, W8, W17

---

### template.mdc (431 lines, 13 sections)

| # | Section (H2) | Lines | ~Size | Dest | Rationale |
|---|-------------|-------|-------|------|-----------|
| T1 | Header/metadata | 5-9 | 5 | **R** | Meta-header |
| T2 | Quick Links | 14-17 | 4 | **R** | Internal navigation |
| T3 | Template Structure Standards | 20-85 | 66 | **A** | Standard + learning project structure (overlaps M6, M8) |
| T4 | Template File Standards | 90-134 | 45 | **A/S** | Split — see detail below |
| T5 | Template Generation Standards | 137-185 | 49 | **S** | Procedural for template generation workflow |
| T6 | Documentation Template Standards | 188-218 | 31 | **A** | Hub-and-spoke, status, dates (duplicates M5) |
| T7 | Template Customization Guidelines | 221-250 | 30 | **A** | Required + optional customization conventions |
| T8 | Template Testing Standards | 253-320 | 68 | **A/S** | Split — see detail below |
| T9 | Template Sync Validation | 324-354 | 31 | **S** | Procedural for template sync workflow |
| T10 | TDD for Template Scripts | 358-376 | 19 | **A** | RED-GREEN-REFACTOR (duplicates W12) |
| T11 | Script Flag Conventions | 379-398 | 20 | **A** | Standard flags (duplicates W13) |
| T12 | Template Evolution Process | 402-415 | 14 | **A** | High-level learning-from-projects convention |
| T13 | Footer/Related | 419-431 | 13 | **R** | Links + metadata |

**T4 split detail:**
- Placeholder patterns + template variables → **A** (conventions for template customization)
- README.md hub file markdown template snippet → **S** (procedural reference for doc creation)

**T8 split detail:**
- Test checklist + Bats framework conventions → **A** (portable testing conventions)
- Structure issue investigation details (PR #31 example, comprehensive fix process) → **A** (lessons learned, keep as convention)

**template.mdc summary:**
- **A** (AGENTS.md): ~248 lines from T3, T4-partial, T6, T7, T8-partial, T10, T11, T12
- **C** (Slimmed .mdc): 0 lines
- **S** (Skill body): ~125 lines from T4-partial, T5, T8-partial, T9
- **R** (Removed): ~22 lines from T1, T2, T13

---

## Aggregate Summary

| Destination | Source Lines | Target Lines | Notes |
|-------------|-------------|-------------|-------|
| **A** (AGENTS.md) | ~658 | ~150-200 | Heavy deduplication + denser writing |
| **C** (Slimmed .mdc) | ~5 | ~50 | Response style + pointers to AGENTS.md/skills |
| **S** (Skill body) | ~540 | Distributed | Each skill pulls its own procedural content |
| **R** (Removed) | ~255 | 0 | Mutable state, stale inventories, navigation |
| **Overhead** | ~173 | 0 | Frontmatter, blank lines, markdown structure |
| **Total** | ~1,626 | ~200-250 | 85% reduction in always-on context |

---

## Identified Duplicates (Consolidate in AGENTS.md)

| Content | Found In | Consolidation Note |
|---------|----------|-------------------|
| Hub-and-spoke documentation pattern | M5, T6 | Write once in AGENTS.md |
| Status indicators (🔴🟡🟠✅) | M5, T6 | Write once |
| Date format (YYYY-MM-DD) | M5, T6 | Write once |
| Template structure (directory trees) | M6, M8, T3 | Single condensed tree |
| TDD conventions (RED-GREEN-REFACTOR, Bats) | W12, T10 | Write once |
| Script flag conventions | W13, T11 | Write once |
| Template maintenance (test first, docs, consistency) | M8, W15 | Write once |
| File naming (kebab-case, README.md uppercase) | M5 | Already singular |

Deduplication accounts for ~150-200 lines of source content appearing 2-3 times.

---

## Observations

### Content That Needs Updating Before AGENTS.md (Task 2)

1. **Project Structure (M6):** Still shows old `admin/planning/features/` layout instead of `admin/services/` service-first structure. Must reflect the current directory hierarchy.
2. **Work Categories Table (M4):** References `admin/planning/features/` and `admin/planning/ci/`. Update to use service-first paths.
3. **File Location Rules (M6):** 8 rules reference old paths. Update all to service-first equivalents.
4. **Template Structure (T3):** Standard project template still shows `docs/maintainers/` which is correct for templates (generated projects keep their own structure). Leave as-is.

### Content Balance Check

The ~658 source lines classified as **A** need to compress to ~150-200 lines. This is achievable because:
- ~200 lines are duplicates (write once instead of 2-3 times)
- ~100 lines are verbose formatting (emoji headers, extensive markdown) that can be tightened
- ~100 lines are detailed examples that can be trimmed to conventions-only
- Remaining ~258 lines → ~150-200 lines with denser writing style

### Cursor-Specific Content Is Minimal

Only M11's "Response style" subsection (~5 lines of actual behavioral directives) is truly Cursor-specific. The ~50-line target for `cursor-config.mdc` will be achieved by:
- Response style preferences (~10 lines)
- Tool usage preferences (~10 lines)
- Mode-switching hints (~5 lines)
- Pointers to AGENTS.md and skills directory (~10 lines)
- File header/metadata (~5 lines)
- Margin for future Cursor-specific needs (~10 lines)

### Skill Body Distribution Map

| Skill | Source Sections | Est. Lines |
|-------|----------------|-----------|
| review + commit | W4 | ~32 |
| pr / pr-validation | W5, W11-partial | ~100 |
| plan-review | W9 | ~27 |
| spike | W10 | ~51 |
| task-release | W14 | ~53 |
| transition-plan / task | W6-partial | ~40 |
| template-gen (future) | T5, T9 | ~80 |
| doc-creation (various) | M12, T4-partial | ~60 |

These remain in archived `.mdc` files until extracted during Groups 2-5 conversions.

---

**Last Updated:** 2026-04-24
