# Research: Drift Detection

**Research Topic:** Terraform-Style Project Management  
**Question:** How to detect when projects have diverged from their template?  
**Status:** ✅ Complete  
**Priority:** Medium  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22  
**Completed:** 2025-12-22

---

## 🎯 Research Question

How to detect when projects have diverged from their template? What drift detection mechanism identifies projects needing attention?

---

## 🔍 Research Goals

- [x] Goal 1: Research Terraform drift detection patterns
- [x] Goal 2: Evaluate file comparison strategies (hash, git, content-diff)
- [x] Goal 3: Define what constitutes "intentional" vs "unintentional" drift
- [x] Goal 4: Design reporting mechanism for drift

---

## 📚 Research Methodology

**Sources:**
- [x] Terraform refresh and drift detection
- [x] Web search: Configuration drift detection tools
- [x] Web search: File synchronization algorithms
- [x] Git-based change tracking patterns

---

## 📊 Findings

### Finding 1: Terraform Uses Refresh Command

Terraform's `terraform refresh` (now `terraform plan -refresh-only`):
- Compares actual state to declared state
- Shows differences without making changes
- Integrated into plan workflow

**Source:** Terraform drift detection patterns

**Relevance:** Drift detection should be part of plan, not separate command.

---

### Finding 2: Git Provides Built-in Change Tracking

Git already tracks:
- What files have changed since commit
- When changes were made
- By whom (if relevant)

No need to reinvent file change tracking.

**Source:** Git version control fundamentals

**Relevance:** Use git as the source of truth for file changes.

---

### Finding 3: Intentional vs Unintentional Drift

**Intentional drift:**
- Files in `customizations` list
- Files in `sync.never` rules
- User explicitly modified

**Unintentional drift:**
- Files modified but not recorded
- May indicate need for sync update

**Source:** Configuration management drift patterns

**Relevance:** Distinguish these for different handling during plan/apply.

---

### Finding 4: Drift Can Be Template-Side or Project-Side

**Template drift:** Template updated, project behind
- Detected by comparing project version to template latest
- Shows available updates

**Project drift:** Project modified, may conflict with template
- Detected by comparing project files to template baseline
- Shows local modifications

**Source:** Version comparison patterns

**Relevance:** Both types of drift are relevant for reporting.

---

### Finding 5: Hash-Based Detection is Simple but Limited

File hash comparison:
- Fast to compute
- Simple equality check
- But: any change (even formatting) triggers drift

Content-aware comparison:
- Understands file format (YAML, markdown)
- Can ignore non-semantic changes
- More complex to implement

**Source:** File synchronization algorithms

**Relevance:** V1 uses simple hash/diff, semantic comparison in V2.

---

## 🔍 Analysis

**Drift Detection Flow:**

```
proj plan
  → Check template version vs project version (template drift)
  → Compare synced files to template (project drift)
  → Report both types of drift
```

**Drift Categories:**

| Category | Detection | Action |
|----------|-----------|--------|
| Template Updated | Version comparison | Show available updates |
| Project Customized (recorded) | In customizations list | Skip in plan, note as intentional |
| Project Modified (unrecorded) | File diff | Warn, suggest adding to customizations |
| Files in sync | No diff | Show as unchanged |

**Key Insights:**
- [x] Insight 1: Drift detection is part of plan, not separate command
- [x] Insight 2: Use git for file change tracking (don't reinvent)
- [x] Insight 3: Distinguish intentional (customized) from unintentional (modified)
- [x] Insight 4: Report both template-side and project-side drift
- [x] Insight 5: Simple file diff is sufficient for V1

---

## 💡 Recommendations

- [x] Recommendation 1: Integrate drift detection into `proj plan` output
- [x] Recommendation 2: Compare project version to latest template version
- [x] Recommendation 3: Show unrecorded modifications as warnings
- [x] Recommendation 4: Offer to add unrecorded modifications to customizations
- [x] Recommendation 5: Use simple file comparison (not semantic) for V1

**Example Plan Output with Drift:**

```
$ proj plan

📋 Sync Plan for myproject

Template: standard-project
Current version: 0.7.0
Latest version: 0.8.0

Template Updates Available:
  ~ .cursor/commands/task-phase.md    (modified in 0.8.0)
  + .cursor/commands/new-command.md   (added in 0.8.0)

Local Modifications Detected:
  ⚠️ .github/workflows/ci.yml
     Modified locally but not in customizations
     Run: proj customize .github/workflows/ci.yml
  
  ✓ .cursor/rules/main.mdc
     In customizations list (will be skipped)

Summary: 2 updates available, 1 unrecorded modification
```

---

## 📋 Requirements Discovered

- [x] FR-19: Plan must show template version vs project version
- [x] FR-20: Plan must detect locally modified files
- [x] FR-21: Plan must distinguish customized vs unrecorded modifications
- [x] FR-22: Plan must suggest `proj customize` for unrecorded changes
- [x] NFR-6: Drift detection must be fast (< 2 seconds for typical project)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Proceed to CI/CD Push Updates research
3. Implementation integrates with proj plan command

---

**Last Updated:** 2025-12-22
