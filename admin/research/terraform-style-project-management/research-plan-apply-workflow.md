# Research: Plan/Apply Workflow

**Research Topic:** Terraform-Style Project Management  
**Question:** How should the plan/apply workflow work in practice?  
**Status:** ✅ Complete  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22  
**Completed:** 2025-12-22

---

## 🎯 Research Question

How should the plan/apply workflow work in practice? What user experience provides safe, predictable, and informative sync operations?

---

## 🔍 Research Goals

- [x] Goal 1: Research Terraform's plan/apply UX patterns
- [x] Goal 2: Design diff generation between template and project
- [x] Goal 3: Determine partial apply strategy (selective file updates)
- [x] Goal 4: Define commit strategy (auto-commit vs manual)

---

## 📚 Research Methodology

**Sources:**
- [x] Terraform CLI documentation (plan, apply commands)
- [x] Web search: Infrastructure-as-code diff visualization
- [x] Web search: Safe deployment patterns with preview
- [x] Git diff and merge strategies

---

## 📊 Findings

### Finding 1: Terraform's Plan/Apply Separation is Key to Safety

Terraform separates planning from execution:
1. `terraform plan` - Shows what WOULD change (no side effects)
2. User reviews the plan
3. `terraform apply` - Executes the plan

This two-phase approach prevents surprises and enables review.

**Source:** Terraform CLI documentation, IaC best practices

**Relevance:** Core pattern for our implementation. Never apply without showing plan first.

---

### Finding 2: Diff Visualization Should Be Familiar

Terraform uses color-coded output:
- `+` Green for additions
- `-` Red for deletions
- `~` Yellow for modifications

This mirrors git diff, which developers already understand.

**Source:** Terraform CLI output patterns

**Relevance:** Use similar visualization for file sync diffs.

---

### Finding 3: Selective Apply via Target Flag

Terraform supports `terraform apply -target=resource` for:
- Applying specific resources only
- Useful for incremental updates
- Reduces blast radius

**Source:** Terraform -target flag documentation

**Relevance:** Support `proj apply --file <path>` for selective file updates.

---

### Finding 4: Plan Can Be Saved for Later Apply

Terraform's `terraform plan -out=plan.tfplan` saves plan for:
- Review by others before apply
- Audit trail of what was approved
- Guarantee apply matches plan

**Source:** Terraform plan output patterns

**Relevance:** Consider `proj plan --save` for review workflows, but may be overkill for v1.

---

### Finding 5: Auto-Commit is Optional, Not Mandatory

Infrastructure changes in Terraform don't auto-commit.
User decides when to commit state changes.
This respects user's git workflow.

**Source:** IaC workflow patterns

**Relevance:** Apply should update files, user decides when to commit.

---

## 🔍 Analysis

**Plan Command Flow:**
```
proj plan
  → Read .dev-infra.yml (state)
  → Compare project files to template (version in state)
  → Generate diff for each file
  → Display: added, modified, deleted, unchanged
  → Show sync rules that would apply
  → Exit (no changes made)
```

**Apply Command Flow:**
```
proj apply
  → Run plan internally
  → Show diff summary
  → Prompt for confirmation (unless --yes)
  → Apply changes per sync rules:
    - always: Apply without prompting
    - ask: Prompt for each file
    - never: Skip
  → Update last_sync in .dev-infra.yml
  → Print summary
```

**Key Insights:**
- [x] Insight 1: Plan must be non-destructive (read-only operation)
- [x] Insight 2: Apply should confirm before any changes
- [x] Insight 3: Use familiar git-style diff output
- [x] Insight 4: Support selective apply for granular control
- [x] Insight 5: Don't auto-commit - respect user's git workflow

---

## 💡 Recommendations

- [x] Recommendation 1: Implement `proj plan` as read-only diff view
- [x] Recommendation 2: Implement `proj apply` with confirmation prompt
- [x] Recommendation 3: Support `--file <path>` for selective apply
- [x] Recommendation 4: Use Rich for colored terminal output (already in proj-cli)
- [x] Recommendation 5: V1 does not need saved plans - direct apply is sufficient

**Example CLI Output:**

```
$ proj plan

📋 Sync Plan for myproject

Template: standard-project
Current version: 0.7.0
Latest version: 0.8.0

Changes to apply:

  ~ .cursor/commands/task-phase.md    (modified)
  + .cursor/commands/new-command.md   (added)
  = .cursor/commands/status.md        (unchanged)
  
  Files: 1 modified, 1 added, 15 unchanged
  
To apply changes: proj apply
```

---

## 📋 Requirements Discovered

- [x] FR-5: `proj plan` must show diff without modifying files
- [x] FR-6: `proj apply` must confirm before changes
- [x] FR-7: Apply must respect sync rules (always/ask/never)
- [x] FR-8: Support selective apply with `--file` flag
- [x] FR-9: Show clear summary of changes (added/modified/deleted/unchanged)
- [x] NFR-2: Use colored output for clear diff visualization
- [x] NFR-3: Plan must complete in <5 seconds for typical projects

---

## 🚀 Next Steps

1. ✅ Research complete
2. Proceed to Conflict Resolution research
3. Implementation in proj-cli

---

**Last Updated:** 2025-12-22
