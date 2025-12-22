# Research Topics - Terraform-Style Project Management

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions about implementing Terraform-style project management in dev-infra.

---

### Research Topic 1: State File Format

**Question:** What should `.dev-infra.yml` contain and how should it be structured?

**Why:** The state file is the foundation of the entire system. It needs to track version, configuration, sync history, and customizations without being overly complex.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- What's the minimum viable state information?
- How to track sync history?
- How to record intentional customizations?
- Should it be `.dev-infra.yml`, `.dev-infra.json`, or something else?
- How does this relate to existing Template Metadata research?

---

### Research Topic 2: Registry Architecture

**Question:** How should dev-infra track which projects it manages?

**Why:** To push updates or provide a portfolio view, dev-infra needs to know what projects exist and where they are.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Local registry (`~/.dev-infra/registry.json`) vs GitHub-based discovery?
- How to handle projects across multiple machines?
- Should the registry sync with work-prod API?
- How to handle private vs public repos?
- What metadata to store in the registry?

**Options to explore:**
1. **Local-only:** Fast, simple, but not portable
2. **GitHub-based:** Discoverable, but requires API access
3. **Hybrid:** Local cache + GitHub sync
4. **work-prod integration:** Central API for all project tracking

---

### Research Topic 3: Plan/Apply Workflow

**Question:** How should the plan/apply workflow work in practice?

**Why:** This is the core user interaction pattern. It needs to be intuitive, safe, and informative.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- How to generate diffs between template and project?
- How to display changes in a readable way?
- How to handle partial applies (some files, not all)?
- Should `apply` create a commit automatically?
- How to handle merge conflicts?

**Terraform patterns to consider:**
- `terraform plan -out=plan.tfplan` (save plan for later apply)
- `terraform apply -target=resource` (selective apply)
- `terraform plan -refresh=false` (skip state refresh)

---

### Research Topic 4: CI/CD Push Updates

**Question:** How should dev-infra automatically push updates to managed projects?

**Why:** Manual sync is good, but automated PRs on release would provide proactive updates.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- GitHub Actions workflow design?
- How to authenticate across repos (PAT, GitHub App, etc.)?
- PR creation strategy (one PR per project, batched, etc.)?
- How to handle failed PRs or merge conflicts?
- Should projects opt-in or opt-out of auto-updates?

**Considerations:**
- GitHub API rate limits
- Permission model (who can push to which repos?)
- Notification strategy (how to alert project owners?)

---

### Research Topic 5: Drift Detection

**Question:** How to detect when projects have diverged from their template?

**Why:** Drift detection helps identify projects that need attention and validates that sync is working.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- File-level or content-level comparison?
- How to distinguish intentional changes from drift?
- Should drift be reported or just logged?
- How to handle files that should never sync?
- Performance considerations for large projects?

**Options to explore:**
1. **Hash-based:** Compare file hashes to template
2. **Git-based:** Track changes since last sync commit
3. **Content-diff:** Semantic comparison of file contents
4. **Manifest-based:** Only check files listed in sync manifest

---

### Research Topic 6: Conflict Resolution

**Question:** How to handle conflicts between template updates and local customizations?

**Why:** Projects will customize. The system needs to respect intentional changes while still enabling updates.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- How to mark files as "do not sync"?
- How to handle partial file customizations (some sections customized, some not)?
- Should conflicts block apply or be handled interactively?
- How to record conflict resolution decisions?

**Terraform patterns to consider:**
- `lifecycle { ignore_changes = [...] }` - Ignore specific attributes
- `lifecycle { prevent_destroy = true }` - Prevent accidental deletion
- Manual state manipulation (`terraform state rm`)

**Merge strategies:**
1. **Ours:** Always keep local version
2. **Theirs:** Always take template version
3. **Interactive:** Ask user for each conflict
4. **Smart merge:** Attempt automatic merge, flag failures

---

## 📊 Priority Matrix

| Topic | Priority | Complexity | Dependencies |
|-------|----------|------------|--------------|
| State File Format | High | Medium | Template Metadata research |
| Registry Architecture | High | High | work-prod integration |
| Plan/Apply Workflow | High | High | State file, proj-cli |
| CI/CD Push Updates | Medium | High | Registry, GitHub API |
| Drift Detection | Medium | Medium | State file |
| Conflict Resolution | High | High | Plan/Apply workflow |

**Recommended Research Order:**
1. State File Format (foundational)
2. Plan/Apply Workflow (core UX)
3. Conflict Resolution (required for safe applies)
4. Registry Architecture (enables CI/CD)
5. Drift Detection (quality of life)
6. CI/CD Push Updates (automation layer)

---

## 🎯 Research Workflow

1. Use `/research terraform-style-project-management --from-explore terraform-style-project-management` to conduct research
2. Research will create documents in `admin/research/terraform-style-project-management/`
3. After research complete, use `/decision terraform-style-project-management --from-research` to make decisions

---

## 🔗 Related Research

- **[Template Metadata](../../research/template-metadata/README.md)** - Already exploring `.dev-infra.yml` format
- **[Global Command Distribution](../../research/global-command-distribution/README.md)** - Distribution patterns
- **[Work-prod Integration](../../research/work-prod-integration/README.md)** - Registry/API integration

---

**Last Updated:** 2025-12-22

