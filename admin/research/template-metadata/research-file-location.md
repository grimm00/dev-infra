# Research: File Location

**Research Topic:** Template Metadata System  
**Question:** Where should the metadata file live in generated projects?  
**Status:** ✅ Complete  
**Created:** 2025-12-18  
**Last Updated:** 2025-12-18

---

## 🎯 Research Question

Where should the dev-infra metadata file be located in generated projects? Root directory? Hidden directory? Inside an existing config file?

---

## 🔍 Research Goals

- [x] Goal 1: Evaluate location options (root, .dev-infra/, existing config)
- [x] Goal 2: Research conventions in similar tools
- [x] Goal 3: Consider visibility and discoverability
- [x] Goal 4: Assess impact on project structure

---

## 📚 Research Methodology

**Approach:** Compare location options and research conventions.

**Sources:**
- [x] Web search: Config file location conventions
- [x] Case studies: Where similar tools put config
- [x] Ecosystem analysis: What's common in modern projects

---

## 📊 Findings

### Finding 1: Root Dotfiles are Industry Standard

Most developer tools place config files at project root with a dot prefix:
- `.eslintrc` / `.eslintrc.yml`
- `.prettierrc`
- `.editorconfig`
- `.yo-rc.json` (Yeoman)
- `.nvmrc`, `.node-version`
- `.tool-versions` (asdf)

This convention is universally understood and expected.

**Source:** Analysis of modern project conventions

**Relevance:** Following convention reduces cognitive load for developers.

---

### Finding 2: Hidden Directories for Complex Config

Tools with multiple config files or state use hidden directories:
- `.git/` - Git internal state
- `.cursor/` - Cursor AI config and commands
- `.vscode/` - VS Code settings
- `.github/` - GitHub workflows and config
- `.husky/` - Git hooks

This approach keeps project root clean while allowing structured internal config.

**Source:** Analysis of modern project conventions

**Relevance:** If metadata expands to multiple files, a directory may be appropriate.

---

### Finding 3: Existing Config Integration (package.json)

Some tools embed config in existing files:
- ESLint allows config in `package.json` under `eslintConfig`
- Prettier allows config in `package.json` under `prettier`
- Babel uses `package.json` under `babel`

This reduces file count but limits to JS projects with package.json.

**Source:** Web research on config conventions

**Relevance:** Dev-infra templates don't always have package.json; this approach is too limiting.

---

### Finding 4: Cursor Already Uses .cursor/ Directory

Dev-infra templates already use `.cursor/` directory for:
- `.cursor/commands/` - AI command guides
- `.cursor/rules/` - AI context rules

This is an established pattern in dev-infra projects.

**Source:** Current dev-infra template structure

**Relevance:** Could add `.cursor/dev-infra.yml` for consistency with existing structure.

---

### Finding 5: Visibility Matters for Adoption

If the metadata file is too hidden, users forget it exists. If it's too prominent, it clutters the project root. The dot prefix strikes a balance - present but not distracting.

**Source:** UX analysis

**Relevance:** Want metadata to be discoverable but not intrusive.

---

## 🔍 Analysis

**Location Options Comparison:**

| Location | Pros | Cons |
|----------|------|------|
| `.dev-infra.yml` (root) | Standard convention, discoverable | Adds file to root |
| `.dev-infra/config.yml` | Room to grow, organized | Adds directory, less discoverable |
| `.cursor/dev-infra.yml` | Uses existing structure | Ties to Cursor specifically |
| `package.json` | No new files | Not all projects have it |

**Key Insights:**
- [x] Insight 1: Root dotfile (`.dev-infra.yml`) is most conventional and discoverable
- [x] Insight 2: `.cursor/` integration would be natural but ties metadata to Cursor IDE
- [x] Insight 3: Single file at root is simpler than directory for v1
- [x] Insight 4: Can migrate to directory later if needed

---

## 💡 Recommendations

- [x] **Recommendation 1:** Use `.dev-infra.yml` at project root
  - Follows industry convention (dotfile at root)
  - Discoverable but not intrusive
  - Clear ownership (it's a dev-infra file)
  - Can be found by scripts easily (`find -name '.dev-infra.yml'`)

- [x] **Recommendation 2:** Do NOT embed in `.cursor/`
  - Metadata is about project generation, not Cursor-specific
  - Should work even if project uses different IDE
  - Keeps concerns separate

- [x] **Recommendation 3:** Add to `.gitignore` template? (Decision needed)
  - Option A: Track in git (version history, shared with team)
  - Option B: Ignore in git (local-only, regenerated)
  - **Recommended: Track in git** - metadata is part of project identity

---

## 📋 Requirements Discovered

- [x] FR-7: Metadata file must be located at project root
- [x] FR-8: Metadata file must have a recognizable name (`.dev-infra.yml`)
- [x] FR-9: Metadata file must be tracked in git (not ignored)
- [x] NFR-5: Location must be consistent across all template types

---

## 🚀 Next Steps

1. Define `.dev-infra.yml` as the standard location
2. Add file to template generation process
3. Ensure templates include this file in git

---

**Last Updated:** 2025-12-18
