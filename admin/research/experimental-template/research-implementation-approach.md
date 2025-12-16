# Research: Implementation Approach

**Research Topic:** Experimental Template  
**Question:** Which approach is best: separate template, flag, or addon system?  
**Priority:** 🔴 High  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Completed:** 2025-12-12

---

## 🎯 Research Question

Which implementation approach is best for delivering experimental commands to users?

**Options to evaluate:**
1. **Separate Template:** `experimental-project/` alongside `standard-project/`
2. **Template Flag:** `./new-project.sh --experimental`
3. **Addon System:** `./add-experimental-commands.sh` post-generation

---

## 🔍 Research Goals

- [x] Goal 1: Assess maintenance implications of each approach
- [x] Goal 2: Evaluate impact on generator script complexity
- [x] Goal 3: Compare user experience of each approach
- [x] Goal 4: Identify best practices from similar tools
- [x] Goal 5: Recommend best approach for dev-infra

---

## 📚 Research Methodology

**Note:** Research based on established template/scaffolding tool patterns.

**Sources:**
- [x] Cookiecutter (Python project templates)
- [x] Yeoman (JavaScript project generator)
- [x] Create-React-App / Create-Next-App (React scaffolding)
- [x] Nx (monorepo tooling)
- [x] Plop / Hygen (micro-generators)
- [x] Current dev-infra generator script

---

## 📊 Findings

### Finding 1: Cookiecutter Uses Template Variants with Conditionals

**Approach:** Single template with Jinja2 conditionals

```jinja
{% if cookiecutter.use_experimental == 'y' %}
# Experimental features here
{% endif %}
```

**Pros:**
- Single source of truth
- Easy to keep in sync
- No duplication

**Cons:**
- Template complexity increases
- Harder to read/maintain
- Conditional logic scattered

**Source:** Cookiecutter documentation, popular templates

**Relevance:** Demonstrates flag-based approach within templates. Works well for small variations, struggles with large differences.

---

### Finding 2: Yeoman Uses Composable Generators

**Approach:** Base generator + feature generators

```bash
yo webapp              # Base project
yo webapp:angular      # Add Angular support
yo webapp:experimental # Add experimental features (hypothetical)
```

**Pros:**
- Modular and composable
- Each generator is focused
- Can layer features

**Cons:**
- More complex architecture
- Requires generator infrastructure
- Multiple commands needed

**Source:** Yeoman documentation, generator ecosystem

**Relevance:** Demonstrates addon/plugin approach. Good for ecosystems with many variations, overhead for simple cases.

---

### Finding 3: Create-React-App Used Template Packages

**Approach:** Separate template packages (npm)

```bash
npx create-react-app my-app --template typescript
npx create-react-app my-app --template redux
```

**Pros:**
- Templates are independent packages
- Community can create templates
- Clear separation

**Cons:**
- Maintenance burden (multiple packages)
- Sync challenges between templates
- CRA eventually deprecated this complexity

**Source:** Create-React-App documentation (now deprecated)

**Relevance:** Package-based templates work for ecosystems but add overhead. CRA's deprecation suggests simpler is better.

---

### Finding 4: Nx Uses Plugin Architecture

**Approach:** Core + plugins for features

```bash
nx g @nx/react:app        # React app
nx g @nx/experimental:... # Experimental (hypothetical)
```

**Pros:**
- Highly extensible
- Clean separation of concerns
- First-class plugin support

**Cons:**
- Complex plugin architecture
- Significant infrastructure
- Overkill for simple needs

**Source:** Nx documentation

**Relevance:** Plugin systems are powerful but require significant investment. Not appropriate for dev-infra's scale.

---

### Finding 5: Simple Tools Use Multiple Templates

**Approach:** Separate template directories

```
templates/
├── basic/          # Minimal setup
├── standard/       # Full setup
└── experimental/   # Bleeding edge
```

**Pros:**
- Simple to understand
- Independent evolution
- Clear boundaries

**Cons:**
- Potential for drift
- Duplication of common files
- Manual sync required

**Source:** Plop, Hygen, many internal tools

**Relevance:** Many successful tools use simple multiple templates. Sync challenge is real but manageable.

---

### Finding 6: Dev-Infra Current Generator is Simple Shell Script

**Current Implementation:**
```bash
./scripts/new-project.sh project-name [template-type]
```

- Template type selection: `standard-project` or `learning-project`
- Simple directory copy with minimal transformation
- No complex conditional logic

**Pros:**
- Simple and maintainable
- Easy to understand
- Works well for current needs

**Cons:**
- Limited flexibility
- Adding options increases complexity
- No built-in sync mechanism

**Source:** Current `scripts/new-project.sh`

**Relevance:** Current approach favors simplicity. Adding flags would increase complexity; separate template aligns better.

---

## 📊 Comparison Matrix

| Approach | Maintenance | Generator Complexity | User Experience | Flexibility | Dev-Infra Fit |
|----------|-------------|---------------------|-----------------|-------------|---------------|
| **Separate Template** | 🟡 Medium (sync needed) | 🟢 Low (minimal changes) | 🟢 Simple (clear choice) | 🟡 Medium | ⭐ Best |
| **Template Flag** | 🟢 Low (single source) | 🟠 High (conditionals) | 🟡 Medium (flags to learn) | 🟢 High | 🟡 Good |
| **Addon System** | 🟠 High (two systems) | 🟠 High (new script) | 🟠 Complex (two steps) | 🟡 Medium | 🔴 Poor |

---

## 🔍 Analysis

Based on the findings:

**Separate Template is Best for Dev-Infra because:**
1. **Aligns with current architecture** - Already have `standard-project` and `learning-project`
2. **Minimal generator changes** - Just add another template option
3. **Clear user experience** - Users choose template type at generation
4. **Independent evolution** - Experimental can evolve faster
5. **Template factory identity** - Templates as distinct products (per ADR-001)

**Sync Challenge Mitigation:**
- Use CI validation to detect drift
- Maintain "sync points" for shared files
- Document which files should be identical
- Consider symlinks for truly shared content

**Key Insights:**
- [x] Insight 1: Separate template aligns with dev-infra's existing pattern and identity
- [x] Insight 2: Generator complexity should be minimized (KISS principle)
- [x] Insight 3: Sync challenge is real but manageable with CI checks
- [x] Insight 4: Clear user choice (template type) is better than hidden flags

---

## 💡 Recommendations

- [x] Recommendation 1: Use **Separate Template** approach (`experimental-project/`)
- [x] Recommendation 2: Keep generator script changes minimal (add template type)
- [x] Recommendation 3: Implement CI-based drift detection for sync
- [x] Recommendation 4: Document which files should stay in sync

---

## 📋 Requirements Discovered

- [x] REQ-IA-1: New template directory `templates/experimental-project/`
- [x] REQ-IA-2: Generator script update to support new template type
- [x] REQ-IA-3: CI validation to detect template drift
- [x] REQ-IA-4: Documentation of sync expectations
- [x] REQ-IA-5: Clear naming to distinguish from standard template

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with remaining medium-priority topics
3. Use separate template approach in implementation planning

---

**Last Updated:** 2025-12-12
