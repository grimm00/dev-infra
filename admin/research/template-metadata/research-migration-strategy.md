# Research: Migration Strategy

**Research Topic:** Template Metadata System  
**Question:** How to handle migration from projects without metadata?  
**Status:** ✅ Complete  
**Created:** 2025-12-18  
**Last Updated:** 2025-12-18

---

## 🎯 Research Question

How should dev-infra handle projects that were generated before the metadata system existed? How do we migrate existing projects to include metadata?

---

## 🔍 Research Goals

- [x] Goal 1: Identify existing dev-infra projects that would need migration
- [x] Goal 2: Research how other tools handle retroactive metadata addition
- [x] Goal 3: Design migration workflow (manual vs automated)
- [x] Goal 4: Assess risks and edge cases

---

## 📚 Research Methodology

**Approach:** Analyze existing projects and research migration patterns.

**Sources:**
- [x] Web search: Config file migration patterns
- [x] Case studies: How tools add config to existing projects
- [x] Internal analysis: Existing project structures

---

## 📊 Findings

### Finding 1: Few Existing Projects to Migrate

Current dev-infra projects that would need migration:
- **work-prod** - Generated from earlier template versions
- **proj-cli** - Existing project, potential adoption candidate
- **dev-infra itself** - The meta-project

Given single-user context, this is a small number of projects.

**Source:** Internal analysis

**Relevance:** Migration complexity is low due to small project count.

---

### Finding 2: Init Command Pattern is Common

Many tools use an "init" command to add config to existing projects:
- `eslint --init` - Creates `.eslintrc`
- `prettier --init` - Creates `.prettierrc`
- `npm init` - Creates `package.json`
- `git init` - Creates `.git/`

This is a well-understood pattern for developers.

**Source:** Industry tool patterns

**Relevance:** A `dev-infra init` or similar command would be intuitive.

---

### Finding 3: Template Detection Can Be Automated

Given a project structure, we can likely detect which template it was generated from:
- Has `stage0-fundamentals/` → learning-project
- Has `backend/` + `frontend/` + standard structure → standard-project

This enables automated metadata generation with reasonable confidence.

**Source:** Internal analysis of template differences

**Relevance:** Migration can be semi-automated rather than fully manual.

---

### Finding 4: Version Detection is Harder

Determining which version of dev-infra was used is more difficult:
- Structure changes between versions are subtle
- No existing markers indicate version
- May need to default to "unknown" or "pre-metadata"

**Source:** Internal analysis

**Relevance:** Version field may need special handling for migrated projects.

---

### Finding 5: Manual Migration is Acceptable

Given:
- Small number of existing projects
- Single user context
- Simple metadata format

Manual migration (creating `.dev-infra.yml` by hand) is acceptable for v1. Automated init command can come later.

**Source:** Pragmatic analysis

**Relevance:** Don't over-engineer migration for a few projects.

---

## 🔍 Analysis

**Migration Options:**

| Approach | Complexity | Accuracy | Effort |
|----------|------------|----------|--------|
| Manual creation | Low | High (user knows) | Low |
| Auto-detect template | Medium | Medium | Medium |
| Init command | Medium | High (interactive) | Medium |
| Ignore old projects | None | N/A | None |

**Key Insights:**
- [x] Insight 1: Small project count means migration isn't a major concern
- [x] Insight 2: Template detection is feasible for automation
- [x] Insight 3: Version detection should default to "unknown" for old projects
- [x] Insight 4: Manual migration is acceptable for v1; automate later if needed

---

## 💡 Recommendations

- [x] **Recommendation 1:** For v1, document manual migration process

  ```yaml
  # Manually create .dev-infra.yml in existing project
  template: standard-project  # or learning-project
  version: unknown  # or best guess like "pre-0.7.0"
  created: 2025-01-01  # Approximate or actual creation date
  migrated: 2025-12-18  # When metadata was added
  ```

- [x] **Recommendation 2:** Add `migrated` field for retrofitted projects
  - Distinguishes projects that were generated with metadata vs added later
  - Helps troubleshoot sync issues

- [x] **Recommendation 3:** Defer init command to v2
  - Build when sync feature is implemented
  - Can incorporate template detection at that point
  - For now, manual creation is sufficient

- [x] **Recommendation 4:** New projects get metadata automatically
  - Modify `new-project.sh` to generate `.dev-infra.yml`
  - No migration needed for projects generated after this change

---

## 📋 Requirements Discovered

- [x] FR-10: New projects must automatically include metadata file
- [x] FR-11: Migration documentation must be provided for existing projects
- [x] FR-12: Metadata schema must support "unknown" version for migrated projects
- [x] FR-13: Optional `migrated` field should indicate retrofit date
- [x] NFR-6: Migration process must not require special tools (just text editor)

---

## 🚀 Next Steps

1. Update `new-project.sh` to generate `.dev-infra.yml`
2. Create migration documentation
3. Migrate existing projects manually
4. Plan init command for future version

---

**Last Updated:** 2025-12-18
