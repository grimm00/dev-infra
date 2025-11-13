# ADR 0001: Template Restructure (admin/ → docs/maintainers/)

**Status:** 🟡 Proposed  
**Date:** 2025-01-27  
**Deciders:** Dev-Infra Maintainers  
**Tags:** templates, documentation, structure

---

## Context

The current template structure uses `admin/` for maintainer-facing documentation (planning, features, releases). This creates several issues:

1. **Mixed Audience Signals:** The `admin/` name doesn't clearly indicate it's for project maintainers/planners
2. **Inconsistent with Industry:** `docs/` is the universally recognized location for documentation
3. **User Confusion:** Template consumers may not understand `admin/` is for their own project planning
4. **Naming Ambiguity:** "regular-project" is vague; "standard-project" is clearer

Additionally, the template name "regular-project" is ambiguous and doesn't clearly communicate its purpose as a standard/typical project structure.

---

## Decision

We will restructure the templates as follows:

### 1. Move Maintainer Docs: `admin/` → `docs/maintainers/`

**For Templates:**
- Move `admin/` directory to `docs/maintainers/` in both `standard-project` and `learning-project` templates
- Maintain hub-and-spoke structure within `docs/maintainers/`
- Create hub READMEs following established patterns

**For Main Repo:**
- Keep `admin/` in main dev-infra repository (established pattern, working well)
- Re-evaluate main repo structure separately in the future

### 2. Rename Template: `regular-project` → `standard-project`

- Rename `templates/regular-project/` to `templates/standard-project/`
- Update `scripts/new-project.sh` to reference `standard-project`
- Update all documentation references

### 3. Clean Up Templates

- Remove operational directories (`migrations/`, `project-index/`) if present
- Templates should only include essential structure, not operational artifacts

### 4. Maintain Hub-and-Spoke Pattern

- Preserve existing hub-and-spoke documentation structure
- Create new hub READMEs in `docs/maintainers/` following best practices
- Ensure progressive disclosure from overview to details

---

## Consequences

### Positive

- ✅ **Clear Audience Separation:** Users vs maintainers clearly distinguished
- ✅ **Industry Alignment:** Follows standard documentation patterns (`docs/` is universal)
- ✅ **Better Discoverability:** Users naturally look in `docs/` first
- ✅ **Maintains Best Practices:** Hub-and-spoke pattern preserved
- ✅ **Clearer Naming:** "standard-project" better describes purpose
- ✅ **Cleaner Templates:** Only essential structure, less noise

### Negative

- ⚠️ **Migration Effort:** Requires updating templates and generator script
- ⚠️ **Documentation Updates:** Need to update all references to old structure
- ⚠️ **Potential Confusion:** Existing projects using templates may need migration guide

### Neutral

- Main repo structure unchanged (keeps `admin/` for now)
- No breaking changes to template functionality
- Can be done incrementally

---

## Rationale

This decision combines:
1. **Internal Best Practices:** Hub-and-spoke patterns from `docs/BEST-PRACTICES.md`
2. **External Conventions:** Industry-standard `docs/` location for documentation
3. **User Experience:** Clearer navigation and purpose
4. **Maintainability:** Better organization and discoverability

The hybrid approach (templates use `docs/maintainers/`, main repo keeps `admin/`) balances:
- Industry standards for templates (external-facing)
- Established patterns in main repo (internal, working well)
- Low risk (templates are external-facing, main repo unchanged)

---

## Alternatives Considered

### Alternative 1: Keep `admin/` in Templates
**Rejected because:**
- Doesn't solve audience confusion
- Inconsistent with industry standards
- Less discoverable for users

### Alternative 2: Move Main Repo `admin/` → `docs/maintainers/`
**Deferred because:**
- Main repo is internal, templates are external-facing
- Established pattern working well
- Can be evaluated separately in the future

### Alternative 3: Use Different Structure
**Rejected because:**
- Proposed structure aligns with both internal and external best practices
- Maintains hub-and-spoke pattern
- Clear separation of concerns

---

## References

- **[Comprehensive Analysis](../research/template-restructure-comprehensive-analysis.md)** - Deep analysis and rationale
- **[Template Structure Options](../research/template-structure-options.md)** - As-is vs proposed comparison
- **[Pre-ADR Proposal](../research/0001-template-restructure-proposal.md)** - Initial proposal
- **[Structure Snapshots](../research/structure-snapshots/)** - Current and proposed structures
- **[Best Practices Guide](../../docs/BEST-PRACTICES.md)** - Internal best practices
- **[Hub-and-Spoke Guide](../notes/examples/hub-and-spoke-documentation-best-practices.md)** - Documentation patterns

---

## Implementation

See **[Template Restructure Roadmap](template-restructure-roadmap.md)** for detailed implementation plan.

---

**Last Updated:** 2025-01-27  
**Status:** 🟡 Proposed  
**Next:** Review and approval, then implementation

