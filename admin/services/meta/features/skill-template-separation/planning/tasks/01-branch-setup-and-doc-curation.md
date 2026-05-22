# Branch Setup & Doc Curation

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Branch Setup & Doc Curation
**Status:** ✅ Expanded
**Last Updated:** 2026-05-22

---

## 📌 Operating Context

This group implements **Plan B** (curated-merge strategy):

- The current `docs/skill-template-separation-research` branch keeps **all** process artifacts (research, exploration, ADR-002, ADR-003, decision interview/summary, etc.) and is **not** merged to develop.
- A **new** feature branch is created from `develop`'s tip and receives **only** ADR-001 + this planning tree.
- This carries Theme 6 of the exploration ("branch-as-workspace — process artifacts don't merge") into concrete practice.

**Critical caveat:** The research branch was forked before develop's `7a292c2 chore: remove globally-installed dotfiles from repo tracking` commit. Naively rebasing or copying-with-history would resurrect ~40 deleted dotfiles (`.claude/skills/*`, `.agents/group-cycle.agent.md`, etc.). Tasks below avoid that by branching from develop's tip and only **copying file contents** (not commits) for the curated artifacts.

---

## 📝 Tasks

### Task 1: Create new feature branch from develop

**Purpose:** Establish a clean branch off develop's current tip (which already has the dotfile-removal commit) so the curated artifacts can be staged without inheriting the research branch's stale dotfile state.

**Steps:**

1. From any worktree on this repo, fetch the latest develop:
   ```bash
   git fetch origin develop
   ```
2. Verify develop's tip includes the dotfile-removal commit:
   ```bash
   git log origin/develop --oneline | grep "remove globally-installed dotfiles"
   # Expect: 7a292c2 chore: remove globally-installed dotfiles from repo tracking
   ```
3. Create a sibling worktree for the new branch (keeps the research worktree intact for copying):
   ```bash
   git worktree add ../feat-skill-template-separation -b feat/skill-template-separation origin/develop
   ```
4. Switch into the new worktree and verify the working tree does NOT contain the resurrected dotfiles:
   ```bash
   cd ../feat-skill-template-separation
   ls .claude/skills/decision/SKILL.md 2>&1   # expect: No such file
   ls .agents/group-cycle.agent.md 2>&1        # expect: No such file
   ```
5. Verify the feature directory on the new branch is empty (clean slate):
   ```bash
   ls admin/services/meta/features/skill-template-separation/ 2>&1
   # expect: No such file or directory
   ```

**Files:**

- New branch ref: `feat/skill-template-separation` (sibling worktree at `../feat-skill-template-separation`)
- No file changes yet — branch creation only

**Acceptance:**

- `git branch --show-current` in the new worktree returns `feat/skill-template-separation`
- `git diff develop` returns empty (no commits ahead yet)
- The four "no such file" checks above all succeed (proves the dotfile resurrection is avoided)

---

### Task 2: Selectively transfer ADR-001 to the new branch

**Purpose:** Stage ADR-001 — the only ADR in scope for this implementation — onto the new branch by copying file contents (not git history), so the new branch's history starts cleanly from develop.

**Steps:**

1. From the new branch worktree, create the destination directory:
   ```bash
   mkdir -p admin/services/meta/features/skill-template-separation/decisions
   ```
2. Copy the ADR file from the research worktree (use absolute paths to avoid ambiguity):
   ```bash
   cp /Users/cdwilson/Projects/dev-infra/worktrees/docs-skill-template-separation-research/\
admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md \
      admin/services/meta/features/skill-template-separation/decisions/
   ```
3. Confirm only ADR-001 was copied (no sibling decision artifacts):
   ```bash
   ls admin/services/meta/features/skill-template-separation/decisions/
   # expect exactly: adr-001-separation-model.md
   ```
4. Stage and commit:
   ```bash
   git add admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md
   git commit -m "docs(skill-template-separation): add ADR-001 (Skill-Template Separation Model)"
   ```

**Files:**

- New: `admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md`

**Acceptance:**

- Listing the `decisions/` directory shows exactly one file (the ADR)
- Commit log on the new branch shows the ADR-001 commit as the first commit ahead of develop
- ADR-002, ADR-003, `decisions/README.md`, `decision-interview.md`, and `decisions-summary.md` are **absent** on the new branch

---

### Task 3: Selectively transfer planning tree to the new branch

**Purpose:** Bring the implementation plan (this very plan) and its task-group skeletons to the new branch so the work it describes is checked in alongside ADR-001.

**Steps:**

1. From the new branch worktree, create the planning destination:
   ```bash
   mkdir -p admin/services/meta/features/skill-template-separation/planning/tasks
   ```
2. Copy the entire planning tree from the research worktree:
   ```bash
   RESEARCH_PLANNING="/Users/cdwilson/Projects/dev-infra/worktrees/docs-skill-template-separation-research/\
admin/services/meta/features/skill-template-separation/planning"
   cp "$RESEARCH_PLANNING/implementation-plan.md"     admin/services/meta/features/skill-template-separation/planning/
   cp "$RESEARCH_PLANNING/status-and-next-steps.md"   admin/services/meta/features/skill-template-separation/planning/
   cp "$RESEARCH_PLANNING/tasks/"*.md                  admin/services/meta/features/skill-template-separation/planning/tasks/
   ```
3. Verify the file count matches expectations (1 plan + 1 status + 6 tasks = 8 files):
   ```bash
   find admin/services/meta/features/skill-template-separation/planning -type f | wc -l
   # expect: 8
   ```
4. Sanity-check the implementation plan's frontmatter survived intact:
   ```bash
   head -20 admin/services/meta/features/skill-template-separation/planning/implementation-plan.md
   # expect to see task_count: 25 + groups[] block
   ```
5. Stage and commit:
   ```bash
   git add admin/services/meta/features/skill-template-separation/planning/
   git commit -m "docs(skill-template-separation): create implementation plan scaffolding for ADR-001"
   ```

**Files:**

- New: `admin/services/meta/features/skill-template-separation/planning/implementation-plan.md`
- New: `admin/services/meta/features/skill-template-separation/planning/status-and-next-steps.md`
- New: `admin/services/meta/features/skill-template-separation/planning/tasks/01-branch-setup-and-doc-curation.md` (this expanded file)
- New: `tasks/02-template-cleanup.md` through `tasks/06-documentation-and-supersession.md`

**Acceptance:**

- 8 planning files exist on the new branch
- `implementation-plan.md` retains its YAML frontmatter (`task_count: 25`, `groups[]`, `tasks_files[]`)
- `git log --oneline` on the new branch shows two commits: ADR-001 (Task 2) + planning tree (this task)

---

### Task 4: Decide how ADR-001's research references are handled on develop

**Purpose:** ADR-001's References and Decision Rationale sections link to `../research/research-*.md` files that won't exist on develop. Choose a deliberate handling strategy so reviewers and future readers don't hit dead links.

**Steps:**

1. Inventory the research references currently in ADR-001:
   ```bash
   grep -E "\(\.\./research/" admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md
   # expect ~5 links: research-skill-corpus-ownership-model, research-template-skill-bundling-strategy,
   # research-minimum-viable-project-contract, research-global-command-distribution-requirements-audit, requirements.md
   ```
2. Choose one of three strategies:
   - **(a) Strip references** — Remove the `../research/...` links; keep the prose context inline.
   - **(b) Replace with branch-pointer URLs** — Rewrite each link to a GitHub permalink on the `docs/skill-template-separation-research` branch (e.g., `https://github.com/grimm00/dev-infra/blob/docs/skill-template-separation-research/admin/services/meta/features/skill-template-separation/research/...`).
   - **(c) Keep links + add a one-line note** — Add a line at the top of the References section like *"Research artifacts live on the `docs/skill-template-separation-research` branch; in-repo links may not resolve on develop."*
3. Apply the chosen strategy to ADR-001 on the new branch.
4. Document the choice in `status-and-next-steps.md` under a new `## Decisions Made` heading or in the existing Notes section.
5. Stage and commit:
   ```bash
   git add admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md \
           admin/services/meta/features/skill-template-separation/planning/status-and-next-steps.md
   git commit -m "docs(skill-template-separation): handle research references in ADR-001 for develop merge"
   ```

**Files:**

- Modified: `admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md`
- Modified: `admin/services/meta/features/skill-template-separation/planning/status-and-next-steps.md`

**Acceptance:**

- A reviewer reading ADR-001 on develop has a clear, intentional understanding of where the research lives
- Strategy (a): no `../research/` links remain in the file
- Strategy (b): all `../research/` links are replaced with absolute GitHub URLs on the research branch
- Strategy (c): the explanatory note is present at the top of the References section
- The chosen strategy is documented in `status-and-next-steps.md`

---

### Task 5: Verify the new branch contains only curated hard artifacts

**Purpose:** Final verification before the PR is opened — confirm the new branch's diff against develop is exactly the curated set: one ADR + the planning tree, nothing else.

**Steps:**

1. Inventory the full delta against develop:
   ```bash
   git diff develop --name-only | sort
   ```
2. Confirm the diff lists **only** these paths (in some order):
   ```text
   admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md
   admin/services/meta/features/skill-template-separation/planning/implementation-plan.md
   admin/services/meta/features/skill-template-separation/planning/status-and-next-steps.md
   admin/services/meta/features/skill-template-separation/planning/tasks/01-branch-setup-and-doc-curation.md
   admin/services/meta/features/skill-template-separation/planning/tasks/02-template-cleanup.md
   admin/services/meta/features/skill-template-separation/planning/tasks/03-template-sync-manifest-retirement.md
   admin/services/meta/features/skill-template-separation/planning/tasks/04-expected-skills-manifest.md
   admin/services/meta/features/skill-template-separation/planning/tasks/05-proj-cli-validation.md
   admin/services/meta/features/skill-template-separation/planning/tasks/06-documentation-and-supersession.md
   ```
3. Confirm the diff does **NOT** contain any of these patterns (each command should return zero matches):
   ```bash
   git diff develop --name-only | grep -E "^admin/services/meta/explorations/" || echo "OK: no explorations"
   git diff develop --name-only | grep -E "/research/" || echo "OK: no research files"
   git diff develop --name-only | grep -E "/decisions/(README|adr-002|adr-003|decision-interview|decisions-summary)" || echo "OK: no extraneous decision artifacts"
   git diff develop --name-only | grep -E "^\.claude/|^\.cursor/|^\.agents/" || echo "OK: no resurrected dotfiles"
   ```
4. Inventory the line count to sanity-check size:
   ```bash
   git diff develop --stat | tail -1
   # expect roughly 9 files changed, < 1000 insertions, 0 deletions
   ```
5. If any check fails, investigate (likely a stray cp or a forgotten `git add -A`) and clean before pushing.

**Files:**

- No file changes — verification only

**Acceptance:**

- The diff against develop lists exactly 9 files, all under `admin/services/meta/features/skill-template-separation/{decisions,planning}/`
- All four "OK: …" guard checks return their OK message (no extraneous content)
- The branch is ready to push and open a PR per the broader implementation plan

---

## 🎯 Goals

1. **Curated doc surface on develop** — Establish a feature branch whose diff against develop is exactly ADR-001 + this planning tree (Theme 6 in practice).
2. **No dotfile resurrection** — Branch from develop's tip (post-`7a292c2`) so the ~40 globally-installed dotfiles develop deleted stay deleted.
3. **Resolve the broken-reference question** — Pick and apply a deliberate strategy for ADR-001's `../research/...` links before merge.

---

## ✅ Completion Criteria

- [x] `feat/skill-template-separation` branch exists at `origin/develop` head with no extra commits at branch creation (Task 1)
- [x] ADR-001 is the only file under `decisions/` on the new branch (Task 2 — Option C: also removed 11 stale research scaffolds inherited from PR #103)
- [x] All 8 planning files transferred and frontmatter intact (Task 3)
- [x] Reference-handling strategy chosen, applied, and documented (Task 4 — strategy (c): blockquote notes added to ADR-001 and implementation-plan.md)
- [x] All four guard checks in Task 5 pass; total diff is 20 files (9 add + 11 delete, all under the feature dir)

---

## 🔗 Dependencies

- None — this group is the entry point for all subsequent implementation work.
- Downstream groups (2-6) execute on the new `feat/skill-template-separation` branch, not on `docs/skill-template-separation-research`.

---

**Last Updated:** 2026-05-22
