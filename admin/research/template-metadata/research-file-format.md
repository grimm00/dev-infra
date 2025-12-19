# Research: File Format

**Research Topic:** Template Metadata System  
**Question:** What file format should dev-infra use for project metadata?  
**Status:** ✅ Complete  
**Created:** 2025-12-18  
**Last Updated:** 2025-12-18

---

## 🎯 Research Question

What file format (YAML, JSON, TOML, etc.) should dev-infra use for project metadata files?

---

## 🔍 Research Goals

- [x] Goal 1: Compare common config file formats (YAML, JSON, TOML)
- [x] Goal 2: Identify which formats are common in similar tools
- [x] Goal 3: Assess readability, tooling support, and ecosystem fit
- [x] Goal 4: Recommend format that aligns with dev-infra patterns

---

## 📚 Research Methodology

**Approach:** Compare file formats based on readability, tooling, and ecosystem fit.

**Sources:**
- [x] Web search: Config file format comparisons
- [x] Case studies: How similar tools handle this
- [x] Dev-infra patterns: What we already use in templates

---

## 📊 Findings

### Finding 1: YAML is Human-Readable but Requires External Parser

YAML offers excellent human readability with minimal syntax noise. However, parsing YAML in bash requires external tools like `yq` or converting to a format bash can handle natively. This adds a dependency that may complicate simple scripts.

**Source:** Web research on bash YAML parsing

**Relevance:** Dev-infra is bash-based. Adding yq dependency increases complexity for a tool designed to be simple and portable.

---

### Finding 2: JSON is Universal but Verbose

JSON is universally supported and can be parsed with `jq` (common on most systems). However, JSON is more verbose than YAML, doesn't support comments, and is less pleasant to edit manually. Many modern tools accept JSON5 (JSON with comments) but standard JSON lacks this.

**Source:** Web research on config formats

**Relevance:** The metadata file will need manual editing. JSON's verbosity and lack of comments make it less ideal for user-edited config.

---

### Finding 3: TOML Balances Readability and Simplicity

TOML is readable like YAML but with simpler, more explicit syntax. It's gaining popularity in modern developer tools (Rust/Cargo, Python/pyproject.toml). However, TOML parsing in bash also requires external tools.

**Source:** Web research on TOML adoption

**Relevance:** While TOML is nice, it has the same bash parsing challenge as YAML without being as widely adopted.

---

### Finding 4: Simple Key-Value Format is Native to Bash

A simple key-value format (like `.env` files or shell variable files) can be parsed natively in bash using `source` or simple text processing. This format is less structured but extremely simple to work with in bash scripts.

Example:
```bash
# .dev-infra
TEMPLATE=standard-project
VERSION=0.7.0
CREATED=2025-12-18
```

**Source:** Internal analysis of dev-infra patterns

**Relevance:** Dev-infra already uses bash for all tooling. A bash-native format eliminates dependencies.

---

### Finding 5: Industry Tools Use JSON with Schema

Professional scaffolding tools like Yeoman use `.yo-rc.json` for metadata. This is JSON stored at project root with a known schema. The trade-off is requiring `jq` for parsing, which is widely available.

**Source:** Yeoman documentation

**Relevance:** JSON with `jq` is a reasonable middle ground - structured data with commonly available tooling.

---

## 🔍 Analysis

**Comparison Matrix:**

| Format | Readability | Comments | Bash Parsing | Dependencies | Ecosystem |
|--------|-------------|----------|--------------|--------------|-----------|
| YAML | ⭐⭐⭐ | ✅ | Requires `yq` | Medium | Wide |
| JSON | ⭐⭐ | ❌ | Requires `jq` | Low | Universal |
| TOML | ⭐⭐⭐ | ✅ | Requires tool | Medium | Growing |
| Key-Value | ⭐⭐ | ✅ | Native | None | Limited |

**Key Insights:**
- [x] Insight 1: YAML is most human-friendly but adds dependency
- [x] Insight 2: Simple key-value format is bash-native but less structured
- [x] Insight 3: JSON with `jq` is a reasonable middle ground for structured data
- [x] Insight 4: Given single-user context, simplicity trumps enterprise features

---

## 💡 Recommendations

- [x] **Recommendation 1:** Use YAML format (`.dev-infra.yml`) for the metadata file
  - Most human-readable for editing
  - Comments support documentation inline
  - Industry standard for dev config
  - `yq` is widely available and easy to install

- [x] **Recommendation 2:** Keep the schema simple enough that basic operations can use `grep`/`sed` if needed
  - Flat structure for essential fields
  - Nested structure only where semantically necessary

- [x] **Recommendation 3:** Consider shipping a helper script that handles YAML parsing
  - Abstracts the `yq` dependency
  - Graceful fallback to grep for simple reads

---

## 📋 Requirements Discovered

- [x] FR-1: Metadata file format must support inline comments for documentation
- [x] FR-2: Essential fields should be parseable without external dependencies (flat key-value)
- [x] NFR-1: Format should be human-editable with standard text editors
- [x] NFR-2: Format should be familiar to developers (industry standard)

---

## 🚀 Next Steps

1. Define schema in YAML format
2. Consider helper functions for reading metadata in bash

---

**Last Updated:** 2025-12-18
