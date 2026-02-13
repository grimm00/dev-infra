# Lightweight Commands from Helm-Charts

**Source:** `~/Projects/work/helm-charts/.cursor/commands/`
**Status:** 🟠 Partially Integrated
**Last Updated:** 2026-02-13

---

## 🎯 Overview

While working on `helm-charts` (a shared team Helm chart repo, **not** created with proj-cli), we adapted a small set of Cursor commands from scratch. These commands were not ported from dev-infra templates -- they were written lean and purpose-built for a project that has no `admin/`, no phase structure, and no Sourcery integration.

The result: a lightweight command set that proved surprisingly effective for day-to-day agentic development. These patterns can inform how dev-infra provides guidance for contributing to **external projects not scaffolded with proj-cli**.

---

## ✅ What Worked Well

### `/review` + `/commit` (Review-then-Commit workflow)

**Problem:** With agentic coding (AI making changes), it's too easy to commit code you haven't actually reviewed. The standard `git add && git commit` flow moves too fast.

**Solution:** Split the workflow into two commands:

1. `/review [description]` -- stages files, captures a diff + summary to a temp folder, drafts a commit message, then **stops**. Does not commit.
2. `/commit` -- reads the draft commit message (from session context or the review folder), confirms with the user, commits, and cleans up the review folder.

**Why it worked:**
- Forces a pause between "AI wrote code" and "code is committed"
- The summary.md artifact gives a human-readable description alongside the raw diff
- `/commit` auto-detects the review folder or uses session context, so the flow is frictionless when used right after `/review`
- `--no-delete` flag lets you keep review artifacts for reference
- Caught real issues in agentic output that would have been committed blindly

**Lightweight pattern for other projects:**
- Any project can use this -- no project structure assumptions
- Only requires a gitignored temp folder for review artifacts
- The two-command split (review, then commit) is the key insight

### `/explore` → `/research` → `/decision` (Spike workflow)

**Problem:** When investigating something new (e.g., "can we migrate Kyverno policies to VAPs?"), it's easy to go down rabbit holes without capturing what you learned.

**Solution:** Three commands that flow into each other:

1. `/explore [topic]` -- captures initial questions, themes, unknowns
2. `/research [topic]` -- structured investigation with web searches and codebase analysis
3. `/decision [topic]` -- ADR documenting the decision and rationale

**Why it worked:**
- Even in a repo with no `admin/` directory, dumping exploration/research/decision docs into a gitignored `tests/tmp/` folder was useful
- The structured output (especially ADRs) gave something concrete to share with the team
- Prevented the "I investigated this 2 weeks ago but forgot what I found" problem

**Lightweight pattern for other projects:**
- Output goes to any gitignored scratch folder -- doesn't need `admin/planning/`
- The three-phase structure (explore → research → decide) is the useful part, not the file locations
- ADR template is universally applicable

### `/reflect --eod` (End-of-day reflection)

**Problem:** Writing daily EOD updates is repetitive. Git history has the data but it takes effort to summarize into something useful for a rotation lead.

**Solution:** Added `--eod` flag to `/reflect` that:
- Runs `date +%Y-%m-%d` to get the actual date (never assumes)
- Gathers today's git commits, changed files, and PR activity
- Drafts a reflection following the apprentice-notes template
- Generates a Slack-ready version for copy-paste
- Has an `--eod update` mode for second/third sessions on the same day (squashes the Slack version to capture the full day's highlights, not just the latest session)

**Why it worked:**
- The Slack version alone saves 5-10 minutes daily
- The `update` mode handled the real-world case of multiple work sessions per day
- Writing to `~/apprentice-notes/` (outside the repo) worked fine -- commands don't have to be repo-scoped

**Lightweight pattern for other projects:**
- The template (What I Did, Key Takeaways, Tomorrow's Focus, Slack version) is universal
- Output location is configurable -- could be any notes directory
- The "squash on update" pattern for Slack messages is reusable

---

## 🔑 Key Insights for proj-cli

### 1. Commands don't need project scaffolding to be useful

The helm-charts repo has no `admin/`, no phases, no Sourcery. Commands worked by writing to a gitignored temp folder and following simple conventions. **Dev-infra should offer a "lightweight command pack"** that works in any repo.

### 2. The review-then-commit split is essential for agentic coding

This was the single most impactful pattern. Any project using AI-assisted development benefits from forcing a review pause before commits. This should be a **default command** in proj-cli templates.

### 3. Spike commands (explore/research/decision) scale down well

The full dev-infra versions have commit automation, hub updates, and branch creation. The helm-charts versions stripped all of that and kept just the document templates. They were still useful. **The templates are the valuable part**, not the automation around them.

### 4. EOD reflections are a workflow, not a project feature

Writing `/reflect --eod` in a Helm chart repo that outputs to a personal notes directory shows these commands can cross repo boundaries. **Consider personal-workflow commands** as a category alongside project-workflow commands.

### 5. Fewer commands, better adoption

Helm-charts has 13 commands total (vs. the 14+ in work-prod). Several are domain-specific (`/test`, `/vap`). The general-purpose ones (`/review`, `/commit`, `/explore`, `/research`, `/decision`, `/reflect`, `/handoff`, `/switch`, `/pr`) form a minimal effective set. **A "starter pack" of ~8 commands** would cover most projects.

---

## 📊 Command Inventory (helm-charts)

| Command | Category | Portable? | Notes |
|---------|----------|-----------|-------|
| `/review` | Core workflow | Yes | Review agentic changes before commit |
| `/commit` | Core workflow | Yes | Commit from review context |
| `/explore` | Spike | Yes | Initial investigation |
| `/research` | Spike | Yes | Structured research |
| `/decision` | Spike | Yes | ADR creation |
| `/reflect` | Personal workflow | Yes | Project + EOD reflection |
| `/handoff` | Collaboration | Yes | Session handoff docs |
| `/switch` | Git utility | Yes | Safe stash + branch switch |
| `/pr` | Core workflow | Yes | PR creation with checklist |
| `/test` | Domain-specific | No | Helm-unittest + chainsaw + kyverno |
| `/vap` | Domain-specific | No | ValidatingAdmissionPolicy creation |
| `/spike` | Alias | Yes | Explore → research → decision flow |
| `/transition-plan` | Planning | Partially | Release transition |

**Portable commands (9):** Could be extracted into a lightweight template for any project.
**Domain-specific (2):** Unique to helm-charts, but the *pattern* (wrapping project-specific test tools, guiding creation of domain artifacts) is reusable.

---

## 🚀 Recommended Next Steps

1. **Create a "lightweight command pack"** in dev-infra templates with the 9 portable commands
2. ~~**Make `/review` + `/commit` a default** in all proj-cli project types~~ ✅ Done (2026-02-13)
3. **Document the "gitignored temp folder" pattern** as the lightweight alternative to `admin/` structure
4. **Add a "personal workflow" command category** for things like `/reflect --eod` that cross repo boundaries
5. ~~**Extract the spike command templates** (explore/research/decision docs) as standalone assets~~ ✅ Done (2026-02-13)

---

**Source:** `~/Projects/work/helm-charts/.cursor/commands/`
**Last Updated:** 2026-02-13
**Status:** 🟠 Partially Integrated
**Next:** Document gitignored temp folder pattern, evaluate personal workflow commands
