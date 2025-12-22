# Research: CI/CD Push Updates

**Research Topic:** Terraform-Style Project Management  
**Question:** How should dev-infra automatically push updates to managed projects?  
**Status:** ✅ Complete  
**Priority:** Medium  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22  
**Completed:** 2025-12-22

---

## 🎯 Research Question

How should dev-infra automatically push updates to managed projects? What CI/CD workflow enables proactive template propagation?

---

## 🔍 Research Goals

- [x] Goal 1: Design GitHub Actions workflow for push updates
- [x] Goal 2: Research authentication strategies (PAT, GitHub App, etc.)
- [x] Goal 3: Determine PR creation strategy (per-project, batched)
- [x] Goal 4: Define opt-in/opt-out mechanism for projects

---

## 📚 Research Methodology

**Sources:**
- [x] GitHub Actions cross-repository workflows
- [x] Web search: GitHub App vs PAT for automation
- [x] Web search: Dependabot-style automated PRs
- [x] Web search: Multi-repo update strategies

---

## 📊 Findings

### Finding 1: GitHub Apps are Preferred for Automation

**GitHub Apps vs PATs:**

| Aspect | PAT | GitHub App |
|--------|-----|------------|
| Scope | User-level | Installation-level |
| Rate Limits | User limits | Higher limits |
| Security | User credentials | App credentials |
| Granularity | All repos or none | Selected repos |

**Source:** GitHub authentication documentation

**Relevance:** GitHub App is better for organization-scale automation.

---

### Finding 2: Dependabot Pattern is Well-Established

Dependabot creates PRs for dependency updates:
- One PR per update
- Clear title and description
- Assignable, reviewable, mergeable
- Respects branch protection

**Source:** Dependabot documentation

**Relevance:** Similar pattern works for template updates.

---

### Finding 3: Rate Limits Require Batching

GitHub API limits:
- 5,000 requests/hour (authenticated)
- Creating PR + updating files = several API calls
- For 50+ repos, batching is necessary

**Source:** GitHub API rate limit documentation

**Relevance:** Must implement throttling/batching for many projects.

---

### Finding 4: Opt-in is Safer Than Opt-out

Projects should explicitly opt-in to auto-updates:
- Prevents surprises
- Clear consent model
- Easier to troubleshoot

**Source:** Notification and automation best practices

**Relevance:** Add `auto_update: true` to `.dev-infra.yml` for opt-in.

---

### Finding 5: PR Template Improves Review Experience

Automated PRs should include:
- Clear summary of changes
- Link to release notes
- Test/review instructions
- Easy merge/close options

**Source:** Automated PR best practices

**Relevance:** Define PR template for update PRs.

---

## 🔍 Analysis

**Workflow Architecture:**

```
Dev-infra Release Published
       ↓
GitHub Actions: push-updates.yml
       ↓
Read Registry (from work-prod)
       ↓
For each project with auto_update: true
       ↓
Fork/Clone → Run proj plan → Create PR if changes
       ↓
Rate limit: 10 projects/batch, 1 min between batches
```

**Authentication Options:**

1. **V1: PAT-based (simpler)**
   - Store PAT in repository secrets
   - Works for personal projects
   - Limited to owned repos

2. **V2: GitHub App (scalable)**
   - Install app on target repos
   - Separate credentials
   - Organization-ready

**Key Insights:**
- [x] Insight 1: Opt-in via `auto_update` field in state file
- [x] Insight 2: Dependabot-style PRs are familiar to developers
- [x] Insight 3: Rate limiting essential for many projects
- [x] Insight 4: V1 can use PAT, V2 should use GitHub App
- [x] Insight 5: Include release notes link in PR body

---

## 💡 Recommendations

- [x] Recommendation 1: Add `auto_update: true/false` to `.dev-infra.yml`
- [x] Recommendation 2: Create GitHub Actions workflow triggered on release
- [x] Recommendation 3: V1 uses PAT (simpler), V2 migrates to GitHub App
- [x] Recommendation 4: Implement rate limiting (10 projects/batch)
- [x] Recommendation 5: PR template with changelog summary

**Example Workflow:**

```yaml
# .github/workflows/push-updates.yml
name: Push Updates to Managed Projects

on:
  release:
    types: [published]

jobs:
  push-updates:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout dev-infra
        uses: actions/checkout@v4
        
      - name: Get managed projects
        run: |
          # Call work-prod API to get projects with auto_update: true
          curl -s $WORK_PROD_API/projects?auto_update=true > projects.json
          
      - name: Create update PRs
        env:
          GH_TOKEN: ${{ secrets.UPDATE_PAT }}
        run: |
          for project in $(jq -r '.[] | .remote_url' projects.json); do
            # Clone, run proj plan, create PR if changes
            ./scripts/create-update-pr.sh "$project" "${{ github.event.release.tag_name }}"
            sleep 60  # Rate limiting
          done
```

**Example PR:**

```markdown
## 🔄 Template Update: dev-infra v0.8.0

This PR syncs your project with dev-infra template updates.

### Changes

- Updated `.cursor/commands/task-phase.md`
- Added `.cursor/commands/new-command.md`

### Release Notes

See [dev-infra v0.8.0 release notes](https://github.com/user/dev-infra/releases/v0.8.0)

### Review

Please review the changes and merge when ready.
To opt-out of future updates: set `auto_update: false` in `.dev-infra.yml`
```

---

## 📋 Requirements Discovered

- [x] FR-23: `auto_update` field in `.dev-infra.yml` controls opt-in
- [x] FR-24: GitHub Actions workflow triggered on dev-infra release
- [x] FR-25: PRs created with clear title and changelog link
- [x] FR-26: Rate limiting to respect GitHub API limits
- [x] NFR-7: V1 uses PAT, V2 should migrate to GitHub App
- [x] C-4: Requires work-prod API for registry lookup

---

## 🚀 Next Steps

1. ✅ Research complete
2. All 6 research topics complete
3. Update summary and requirements
4. Proceed to decision phase

---

**Last Updated:** 2025-12-22
