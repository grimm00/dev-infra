# Research: Local Registry Format

**Research Topic:** Work-prod Integration  
**Question:** What storage format for local registry? JSON vs SQLite vs other?  
**Status:** ✅ Complete  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 🎯 Research Question

What storage format for local registry? JSON vs SQLite vs other?

---

## 🔍 Research Goals

- [x] Goal 1: Identify operations needed (list, filter, search, update)
- [x] Goal 2: Estimate realistic project count (10s? 100s?)
- [x] Goal 3: Assess query complexity requirements
- [x] Goal 4: Evaluate acceptable dependencies for bash-based tooling

---

## 📚 Research Methodology

**Approach:** Compare storage formats for CLI tool state management.

**Sources:**
- [x] Industry patterns from similar tools (asdf, nvm, homebrew)
- [x] JSON vs SQLite analysis
- [x] Bash-compatible storage solutions

---

## 📊 Findings

### Finding 1: JSON is Universal for Simple CLI State

Most CLI tools use JSON or simple text files for local state:

| Tool | Storage Format | Location |
|------|----------------|----------|
| npm | `package.json` + `node_modules` | per-project + global |
| asdf | `.tool-versions` (text) | per-project |
| nvm | `.nvmrc` (text) + shell vars | per-project |
| Homebrew | JSON receipts | `/usr/local/Cellar` |
| VS Code | JSON settings | `~/.vscode/` |

**Source:** Analysis of popular CLI tools

**Relevance:** JSON is standard, well-understood, and works with `jq`.

---

### Finding 2: Realistic Project Count is Low

Given single-user context:
- Active projects: 5-15
- Total projects (including archived): 20-50
- Maximum realistic: 100

This is well within JSON's comfortable range. SQLite is overkill.

**Source:** Internal analysis

**Relevance:** JSON scales fine for expected usage.

---

### Finding 3: Required Operations are Simple

| Operation | Complexity | JSON Support |
|-----------|------------|--------------|
| List all projects | O(n) | ✅ Simple |
| Find by path | O(n) | ✅ grep/jq |
| Find by template | O(n) | ✅ jq filter |
| Add project | O(1) | ✅ Append |
| Remove project | O(n) | ✅ jq filter |
| Update project | O(n) | ✅ jq |

No complex queries needed. All operations are straightforward with JSON.

**Source:** Analysis of requirements

**Relevance:** JSON handles all needed operations.

---

### Finding 4: jq is Acceptable Dependency

`jq` is:
- Available on all major platforms
- Pre-installed on many systems
- Easy to install where missing
- Standard tool for JSON processing in bash

For simple reads, can fall back to `grep`/`sed`.

**Source:** Industry analysis

**Relevance:** `jq` dependency is acceptable like `yq` for YAML.

---

### Finding 5: Storage Location Convention

XDG Base Directory Specification recommends:
- Config: `~/.config/dev-infra/config.yml`
- State/data: `~/.local/share/dev-infra/registry.json`

Simpler alternative: `~/.dev-infra/` for everything.

**Source:** XDG Base Directory Specification

**Relevance:** Follow XDG or use simpler `~/.dev-infra/` pattern.

---

## 🔍 Analysis

**Format Comparison:**

| Format | Pros | Cons | Verdict |
|--------|------|------|---------|
| JSON | Universal, `jq` support | Needs `jq` for complex ops | ✅ Best |
| SQLite | Powerful queries | Overkill, binary | ❌ |
| YAML | Human-readable | Needs `yq` | ❌ Redundant |
| CSV | Simple | Limited structure | ❌ |
| Text (line-based) | Simplest | No structure | ❌ |

**Key Insights:**
- [x] Insight 1: JSON is the right choice for local registry
- [x] Insight 2: 20-50 projects is well within JSON's sweet spot
- [x] Insight 3: `jq` is acceptable dependency (like `yq`)
- [x] Insight 4: Simple location (`~/.dev-infra/`) is preferred

---

## 💡 Recommendations

- [x] Recommendation 1: Use JSON for local registry (`registry.json`)
- [x] Recommendation 2: Store in `~/.dev-infra/registry.json`
- [x] Recommendation 3: Use `jq` for queries (with grep fallback for simple reads)
- [x] Recommendation 4: Keep schema simple and flat

---

## 📋 Requirements Discovered

- [x] FR-8: Local registry uses JSON format
- [x] FR-9: Registry stored at `~/.dev-infra/registry.json`
- [x] FR-10: Support basic operations: list, add, remove, update
- [x] NFR-3: Registry readable without special tools (human-readable JSON)
- [x] NFR-4: `jq` is acceptable dependency

---

## 🚀 Next Steps

1. Define JSON schema for registry
2. Implement basic operations

---

**Last Updated:** 2025-12-19
