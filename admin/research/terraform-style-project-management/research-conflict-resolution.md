# Research: Conflict Resolution

**Research Topic:** Terraform-Style Project Management  
**Question:** How to handle conflicts between template updates and local customizations?  
**Status:** ✅ Complete  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22  
**Completed:** 2025-12-22

---

## 🎯 Research Question

How to handle conflicts between template updates and local customizations? What conflict resolution strategy respects intentional changes while enabling updates?

---

## 🔍 Research Goals

- [x] Goal 1: Research Terraform lifecycle ignore patterns
- [x] Goal 2: Design "do not sync" file marking mechanism
- [x] Goal 3: Evaluate merge strategies (ours, theirs, interactive, smart)
- [x] Goal 4: Define conflict recording and resolution decisions

---

## 📚 Research Methodology

**Sources:**
- [x] Terraform lifecycle blocks documentation
- [x] Web search: Git merge strategies and conflict resolution
- [x] Web search: Configuration management conflict patterns
- [x] Template sync tools (cookiecutter/cruft patterns)

---

## 📊 Findings

### Finding 1: Terraform's Lifecycle Ignore Pattern

Terraform uses `lifecycle { ignore_changes = [...] }` to:
- Prevent specific attribute changes from triggering updates
- Allow infrastructure to be modified outside Terraform
- Essential for user-managed resources

**Source:** Terraform lifecycle block documentation

**Relevance:** Our `sync.never` pattern serves the same purpose for files.

---

### Finding 2: Template Sync Tools Use Git Merge

Tools like cruft (for cookiecutter templates) use:
- Git three-way merge for updates
- Template original → Template updated → Project current
- Shows conflicts for manual resolution

**Source:** Template sync tool patterns

**Relevance:** Git's merge algorithms can help with file-level conflicts.

---

### Finding 3: Customization Recording Prevents Surprise Conflicts

Recording when users intentionally modify files:
- System knows which files have been customized
- Can warn or skip during apply
- Reduces merge conflicts

**Source:** Drift detection and reconciliation patterns

**Relevance:** Our `customizations` array in state file serves this purpose.

---

### Finding 4: Interactive vs Automatic Resolution

**Options:**
1. **Ours (keep local):** Safe but may miss important updates
2. **Theirs (take template):** Dangerous, loses customizations
3. **Interactive:** Prompt for each conflict
4. **Smart merge:** Attempt automatic, flag failures

**Source:** Git merge strategies

**Relevance:** Use sync rules + interactive fallback for best UX.

---

### Finding 5: Section-Level Customization is Complex

Tracking partial file customizations (some sections custom, some not) requires:
- Content parsing (YAML, markdown, etc.)
- Section markers or checksums
- Significantly more complexity

**Source:** Configuration management patterns

**Relevance:** V1 should use file-level granularity only. Section-level is future work.

---

## 🔍 Analysis

**Conflict Resolution Strategy:**

1. **Prevention via Sync Rules:**
   - `sync.never` - Files that should never sync (README.md, backend/, frontend/)
   - User explicitly marks files as "do not touch"

2. **Tracking via Customizations:**
   - When user modifies a synced file, they can record it
   - `proj customize <file>` command to add to customizations list
   - Plan shows warning for customized files

3. **Resolution via Prompts:**
   - For `sync.ask` files, prompt during apply
   - Options: Skip, Apply (overwrite), Show diff, Merge (future)
   - User makes the decision with full context

4. **Recording Resolution Decisions:**
   - If user skips a file, optionally add to customizations
   - Prevents repeated prompting

**Key Insights:**
- [x] Insight 1: Prevention is better than resolution - use sync.never for known customizations
- [x] Insight 2: File-level granularity is sufficient for V1
- [x] Insight 3: Interactive prompts for `ask` files give user control
- [x] Insight 4: Recording customizations reduces future conflicts

---

## 💡 Recommendations

- [x] Recommendation 1: Implement three-tier sync rules (always/ask/never)
- [x] Recommendation 2: Add `proj customize <file>` command to mark customizations
- [x] Recommendation 3: During apply, show diff and prompt for `ask` files
- [x] Recommendation 4: Offer "remember this choice" option to prevent re-prompting
- [x] Recommendation 5: Defer section-level merging to V2+

**Example Apply Flow with Conflicts:**

```
$ proj apply

📋 Applying updates...

.cursor/commands/task-phase.md
  This file is in your customizations list.
  Reason: "Added project-specific examples"
  [S]kip / [V]iew diff / [A]pply anyway? S
  → Skipped

.github/workflows/ci.yml
  This file was modified locally but not in customizations.
  [S]kip / [V]iew diff / [A]pply / [R]emember skip? V
  
  --- template version
  +++ your version
  @@ -10,6 +10,7 @@
     - name: Test
       run: npm test
  +    timeout-minutes: 30
  
  [S]kip / [A]pply / [R]emember skip? R
  → Skipped and added to customizations

✅ Applied: 3 files
⏭️ Skipped: 2 files
```

---

## 📋 Requirements Discovered

- [x] FR-10: Three-tier sync rules (always/ask/never)
- [x] FR-11: `proj customize <file>` command to mark files
- [x] FR-12: Prompt user for `ask` files during apply
- [x] FR-13: Show diff during conflict resolution prompts
- [x] FR-14: "Remember skip" option adds file to customizations
- [x] NFR-4: Skip prompts for files in customizations list

---

## 🚀 Next Steps

1. ✅ Research complete
2. Proceed to Registry Architecture research
3. Implementation will be part of proj-cli apply command

---

**Last Updated:** 2025-12-22
