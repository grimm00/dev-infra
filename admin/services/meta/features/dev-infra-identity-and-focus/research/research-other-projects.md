# Research: Other Projects' Patterns

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** How do similar meta-projects handle the laboratory/factory/reference tension?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

How do similar meta-projects (template generators, boilerplates) handle this? Learn from how others have solved the laboratory/factory/reference tension.

---

## 🔍 Research Goals

- [x] Goal 1: Identify similar meta-projects
- [x] Goal 2: Analyze their organizational patterns
- [x] Goal 3: Extract applicable lessons
- [x] Goal 4: Identify patterns to adopt

---

## 📚 Research Methodology

**Note:** Web search didn't return relevant results for specific architecture questions. Analysis based on knowledge of these tools' public documentation and common patterns.

**Projects Analyzed:**
- Create React App (CRA)
- Vue CLI
- Cookiecutter
- Yeoman
- GitHub Template Repositories

---

## 📊 Findings

### Finding 1: Create React App Pattern

**Structure:**
```
create-react-app/
├── packages/
│   ├── create-react-app/      # CLI tool
│   ├── react-scripts/         # Build scripts
│   └── cra-template/          # Default template
│   └── cra-template-typescript/
└── docusaurus/                 # Documentation site
```

**Key Pattern:** **Separation of concerns**
- CLI (create-react-app) is separate from templates
- Templates are separate packages
- Internal tooling doesn't leak into templates

**Lesson:** Templates are output products, not reflections of the tool's internal structure.

### Finding 2: Vue CLI Pattern

**Structure:**
```
vue-cli/
├── packages/
│   ├── @vue/cli/               # Main CLI
│   ├── @vue/cli-service/       # Build service
│   └── @vue/cli-plugin-*/      # Plugins
└── templates/                   # Project templates
```

**Key Pattern:** **Plugin architecture**
- Core is minimal
- Features are plugins
- Templates can include different plugin sets

**Lesson:** Not everything needs to be in the base template. Features can be optional.

### Finding 3: Cookiecutter Pattern

**Structure:**
```
cookiecutter/                    # The tool
cookiecutter-pypackage/          # A template (separate repo)
cookiecutter-django/             # Another template (separate repo)
```

**Key Pattern:** **Complete separation**
- Tool is one repo
- Each template is its own repo
- Templates are not part of the tool

**Lesson:** Templates can be completely decoupled from the generator tool.

### Finding 4: GitHub Template Repositories

**Pattern:**
- Repository marked as "template"
- No generator tool needed
- Template IS the final product (no transformation)

**Key Pattern:** **What you see is what you get**
- No hidden complexity
- Template structure = generated project structure
- Easy to understand and customize

**Lesson:** Simplicity of direct template repositories.

### Finding 5: Common Patterns Across Projects

| Pattern | CRA | Vue | Cookiecutter | GitHub Templates |
|---------|-----|-----|--------------|------------------|
| Tool ≠ Template | ✅ | ✅ | ✅ | N/A |
| Multiple templates | ✅ | ✅ | ✅ | ✅ |
| Internal tooling hidden | ✅ | ✅ | ✅ | N/A |
| Templates are products | ✅ | ✅ | ✅ | ✅ |
| Minimal base template | ✅ | ✅ | Varies | Varies |

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Templates Are Products, Not Process

All successful template systems:
- Treat templates as output products
- Don't expose internal tooling in templates
- Keep templates focused on user needs

**Application to dev-infra:**
- Release automation → internal tooling (don't templatize)
- Validation scripts → internal tooling (don't templatize)
- Focus templates on what generated projects need

### Insight 2: Separation Is Normal and Healthy

None of the researched tools:
- Put their own workflow tooling in templates
- Expect templates to "eat their own dog food"
- Mix internal development with template content

**Application to dev-infra:**
- It's okay for dev-infra to have more tools than templates
- Templates should be simpler than dev-infra itself
- Internal improvements don't need to graduate

### Insight 3: Plugin/Tier Pattern Works

Vue CLI's plugin pattern suggests:
- Core template should be minimal
- Advanced features can be optional additions
- Users can customize their experience

**Application to dev-infra:**
- Essential commands (Tier 1) in base template
- Advanced commands as optional enhancement
- Different template "editions" possible

### Insight 4: WYSIWYG Templates Are Valuable

GitHub template repositories show:
- Direct templates are easy to understand
- No magic transformation
- Users can inspect exactly what they get

**Application to dev-infra:**
- Template structure should be obvious
- Minimize hidden complexity
- Document what each template includes

---

## 💡 Recommendations

- [x] **R13: Treat templates as products** - Not reflections of dev-infra
- [ ] **R14: Keep internal tooling internal** - Don't templatize everything
- [ ] **R15: Consider optional feature tiers** - Vue-style plugin approach
- [ ] **R16: Make templates inspectable** - WYSIWYG clarity

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-15:** Templates should not include dev-infra internal tooling
- **FR-16:** Templates should be understandable by inspection

### Non-Functional Requirements

- **NFR-13:** Template complexity should be appropriate for user projects
- **NFR-14:** Internal tooling should be separate from template content

---

## 🚀 Next Steps

1. Apply "templates as products" thinking
2. Review current template content for internal tooling leakage
3. Consider optional feature tiers for v2.0

---

**Last Updated:** 2025-12-11

