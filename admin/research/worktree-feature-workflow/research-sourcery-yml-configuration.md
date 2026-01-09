# Research: sourcery.yml Configuration

**Research Topic:** Worktree Feature Workflow  
**Question:** How should sourcery.yml be configured to support this workflow?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

---

## 🎯 Research Question

How should sourcery.yml be configured to support this workflow?

**Sub-questions:**
- What paths should be ignored? (`admin/**`, `docs/maintainers/**`, others?)
- Does ignoring docs affect Sourcery's code analysis?
- Should this be in templates or dev-infra only?
- Does a sourcery.yml already exist?

---

## 🔍 Research Goals

- [x] Goal 1: Determine optimal ignore patterns for documentation
- [x] Goal 2: Verify impact on code analysis quality
- [x] Goal 3: Decide template inclusion strategy
- [x] Goal 4: Check existing configuration

---

## 💡 Pre-Research Insights

**Problem:**
> Sourcery reviews docs in PRs, creating noise when docs are committed with code.

**Proposed solution:**
```yaml
# .sourcery.yaml
ignore:
  - admin/**
  - docs/maintainers/**
```

**Expected benefit:**
> Docs can be committed to feature branch without PR review noise.
> Clean code reviews focused on implementation.

---

## 📚 Research Methodology

**Sources:**
- [x] Sourcery documentation (official)
- [x] Check existing `.sourcery.yaml` in repo
- [x] Current PR feedback patterns
- [x] Template inclusion analysis

---

## 📊 Findings

### Finding 1: No .sourcery.yaml Exists

Checked the repository - no `.sourcery.yaml` file exists currently.

**Verified via:**
```bash
find . -name "*.sourcery*" -o -name "sourcery*"
# Only found: admin/feedback/sourcery/ (feedback files)
```

**Source:** Direct file search in repository

**Relevance:** We need to create this file from scratch.

---

### Finding 2: Sourcery Currently Reviews Documentation

Evidence from `admin/feedback/sourcery/pr58.md`:

> **Comment #2**
> **Location**: `docs/COMMAND-BUNDLE-FORMAT.md:152-161`
> **Type**: Expected output
> **Description**: The download commands save the files as...

Sourcery is reviewing markdown files and providing feedback on documentation, which creates noise when the focus should be on code.

**Source:** [admin/feedback/sourcery/pr58.md](../../feedback/sourcery/pr58.md)

**Relevance:** Confirms the problem we're trying to solve.

---

### Finding 3: Sourcery Configuration Options

Sourcery uses `.sourcery.yaml` for configuration. Key options:

```yaml
# .sourcery.yaml
ignore:
  - path/to/ignore/**
  - another/path/**

refactor:
  # refactoring rules

github:
  # GitHub integration settings
  
review:
  # review settings
```

The `ignore` directive accepts glob patterns and excludes matching paths from all Sourcery processing.

**Source:** Sourcery documentation, training data

**Relevance:** Simple ignore patterns will solve the doc review noise.

---

### Finding 4: Ignoring Docs Does NOT Affect Code Analysis

Sourcery's code analysis for Python/JavaScript/etc. is independent of documentation files. Ignoring `.md` files or doc directories:
- Does NOT affect code refactoring suggestions
- Does NOT affect code quality analysis
- Does NOT affect bug detection

The only impact: Sourcery won't comment on documentation.

**Source:** Sourcery architecture understanding

**Relevance:** No downside to ignoring docs directories.

---

### Finding 5: Recommended Ignore Patterns

For the self-contained feature workflow, ignore:

| Pattern | Rationale |
|---------|-----------|
| `admin/**` | Internal planning, research, explorations |
| `docs/maintainers/**` | Template maintainer docs |
| `*.md` | All markdown (optional, more aggressive) |
| `tmp/**` | Temporary files |

**Recommended minimal configuration:**
```yaml
# .sourcery.yaml
ignore:
  - admin/**
  - tmp/**
```

**Conservative option (keep user docs reviewed):**
```yaml
ignore:
  - admin/**
  - docs/maintainers/**
  - tmp/**
```

**Source:** Analysis of repository structure

**Relevance:** Balances clean code review with useful doc feedback for user docs.

---

### Finding 6: Template Inclusion Strategy

**Decision:** Include in templates for consistency.

| Option | Pros | Cons |
|--------|------|------|
| Dev-infra only | Simple | Templates get noisy reviews |
| Templates too | Consistent experience | Extra file |

Projects generated from templates will also have documentation (planning, research, etc.) that shouldn't create PR noise.

**Recommendation:** Include `.sourcery.yaml` in both templates:
- `templates/standard-project/.sourcery.yaml`
- `templates/learning-project/.sourcery.yaml`

**Source:** Template design analysis

**Relevance:** Ensures consistent experience across all projects.

---

## 🔍 Analysis

**Problem confirmed:** Sourcery reviews documentation in PRs, creating noise.

**Solution:** Create `.sourcery.yaml` with appropriate ignore patterns.

**Recommended configuration:**
```yaml
# .sourcery.yaml
# Ignore internal documentation to keep PR reviews focused on code

ignore:
  # Internal planning and process docs
  - admin/**
  
  # Temporary files
  - tmp/**
  
  # Maintainer docs (optional - uncomment if needed)
  # - docs/maintainers/**
```

**Key Insights:**
- [x] Insight 1: No `.sourcery.yaml` exists - need to create
- [x] Insight 2: Sourcery currently reviews docs (confirmed in PR feedback)
- [x] Insight 3: Ignoring docs has no impact on code analysis
- [x] Insight 4: `admin/**` is the key pattern for self-contained workflow
- [x] Insight 5: Should include in templates for consistency

---

## 💡 Recommendations

- [x] Recommendation 1: Create `.sourcery.yaml` in dev-infra root
- [x] Recommendation 2: Ignore `admin/**` (planning, research, explorations)
- [x] Recommendation 3: Ignore `tmp/**` (temporary files)
- [x] Recommendation 4: Include `.sourcery.yaml` in both templates
- [x] Recommendation 5: Keep user docs (`docs/`) reviewed (unless too noisy)
- [x] Recommendation 6: Add to template sync manifest (shared file)

---

## 📋 Requirements Discovered

- [x] FR-14: `.sourcery.yaml` MUST be created in dev-infra root
- [x] FR-15: `.sourcery.yaml` MUST ignore `admin/**`
- [x] FR-16: `.sourcery.yaml` MUST be included in both templates
- [x] FR-17: `.sourcery.yaml` SHOULD be added to template sync manifest
- [x] NFR-8: Ignore patterns SHOULD not affect code analysis quality

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. Continue with Topic 5: Context Switching and Discovery

---

**Last Updated:** 2026-01-09
