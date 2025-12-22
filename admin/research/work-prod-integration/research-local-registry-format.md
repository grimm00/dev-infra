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
- [x] Goal 5: Define JSON schema for registry
- [x] Goal 6: Document bash/jq operations

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

| Tool     | Storage Format                  | Location             |
| -------- | ------------------------------- | -------------------- |
| npm      | `package.json` + `node_modules` | per-project + global |
| asdf     | `.tool-versions` (text)         | per-project          |
| nvm      | `.nvmrc` (text) + shell vars    | per-project          |
| Homebrew | JSON receipts                   | `/usr/local/Cellar`  |
| VS Code  | JSON settings                   | `~/.vscode/`         |

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

| Operation         | Complexity | JSON Support |
| ----------------- | ---------- | ------------ |
| List all projects | O(n)       | ✅ Simple    |
| Find by path      | O(n)       | ✅ grep/jq   |
| Find by template  | O(n)       | ✅ jq filter |
| Add project       | O(1)       | ✅ Append    |
| Remove project    | O(n)       | ✅ jq filter |
| Update project    | O(n)       | ✅ jq        |

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

| Format            | Pros                    | Cons                       | Verdict      |
| ----------------- | ----------------------- | -------------------------- | ------------ |
| JSON              | Universal, `jq` support | Needs `jq` for complex ops | ✅ Best      |
| SQLite            | Powerful queries        | Overkill, binary           | ❌           |
| YAML              | Human-readable          | Needs `yq`                 | ❌ Redundant |
| CSV               | Simple                  | Limited structure          | ❌           |
| Text (line-based) | Simplest                | No structure               | ❌           |

**Key Insights:**

- [x] Insight 1: JSON is the right choice for local registry
- [x] Insight 2: 20-50 projects is well within JSON's sweet spot
- [x] Insight 3: `jq` is acceptable dependency (like `yq`)
- [x] Insight 4: Simple location (`~/.dev-infra/`) is preferred

---

## 📁 Directory Structure

```
~/.dev-infra/
├── config.yml           # Global config (API key, settings)
├── registry.json        # Project registry
└── cache/               # Cache directory (optional)
    └── work-prod/       # Cached work-prod data
```

**Rationale:**

- Single directory is easier to backup/restore
- Clear separation between config and data
- Cache can be safely deleted

---

## 📋 JSON Schema Definition

### Registry Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "version": {
      "type": "string",
      "description": "Registry schema version"
    },
    "projects": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/project"
      }
    }
  },
  "definitions": {
    "project": {
      "type": "object",
      "required": ["id", "name", "path", "template", "created"],
      "properties": {
        "id": {
          "type": "string",
          "description": "Unique identifier (UUID)"
        },
        "name": {
          "type": "string",
          "description": "Project name"
        },
        "path": {
          "type": "string",
          "description": "Absolute path to project"
        },
        "template": {
          "type": "string",
          "enum": ["standard-project", "learning-project"],
          "description": "Template type used"
        },
        "version": {
          "type": "string",
          "description": "Dev-infra version at creation"
        },
        "created": {
          "type": "string",
          "format": "date",
          "description": "Creation date (YYYY-MM-DD)"
        },
        "repository": {
          "type": "string",
          "description": "Git remote URL (optional)"
        },
        "status": {
          "type": "string",
          "enum": ["active", "archived"],
          "default": "active"
        },
        "work_prod_id": {
          "type": "string",
          "description": "Work-prod project ID (if synced)"
        },
        "last_sync": {
          "type": "string",
          "format": "date-time",
          "description": "Last sync with work-prod"
        }
      }
    }
  }
}
```

### Example Registry

```json
{
  "version": "1.0",
  "projects": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "name": "work-prod",
      "path": "/Users/cdwilson/Projects/work-prod",
      "template": "standard-project",
      "version": "0.7.0",
      "created": "2025-11-01",
      "repository": "https://github.com/grimm00/work-prod.git",
      "status": "active",
      "work_prod_id": "wp-123",
      "last_sync": "2025-12-19T10:30:00Z"
    },
    {
      "id": "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
      "name": "proj-cli",
      "path": "/Users/cdwilson/Projects/proj-cli",
      "template": "standard-project",
      "version": "0.7.0",
      "created": "2025-12-01",
      "repository": "https://github.com/grimm00/proj-cli.git",
      "status": "active"
    },
    {
      "id": "7c9e6679-7425-40de-944b-e07fc1f90ae7",
      "name": "learning-rust",
      "path": "/Users/cdwilson/Projects/learning-rust",
      "template": "learning-project",
      "version": "0.6.0",
      "created": "2025-10-15",
      "status": "archived"
    }
  ]
}
```

---

## 🛠️ Bash/jq Operations

### List All Projects

```bash
# Simple list
jq -r '.projects[].name' ~/.dev-infra/registry.json

# Table format
jq -r '.projects[] | [.name, .template, .status] | @tsv' ~/.dev-infra/registry.json | column -t

# Output:
# work-prod     standard-project  active
# proj-cli      standard-project  active
# learning-rust learning-project  archived
```

### Find by Path

```bash
# Check if path is registered
jq -e --arg path "/Users/cdwilson/Projects/work-prod" \
  '.projects[] | select(.path == $path)' ~/.dev-infra/registry.json

# Return name only
jq -r --arg path "/Users/cdwilson/Projects/work-prod" \
  '.projects[] | select(.path == $path) | .name' ~/.dev-infra/registry.json
```

### Find by Template Type

```bash
# List standard projects only
jq -r '.projects[] | select(.template == "standard-project") | .name' ~/.dev-infra/registry.json

# Count by template
jq '[.projects[] | .template] | group_by(.) | map({(.[0]): length}) | add' ~/.dev-infra/registry.json
# Output: {"learning-project": 1, "standard-project": 2}
```

### Add Project

```bash
# Add new project using jq
NEW_PROJECT='{
  "id": "'$(uuidgen)'",
  "name": "new-project",
  "path": "/Users/cdwilson/Projects/new-project",
  "template": "standard-project",
  "version": "0.7.0",
  "created": "'$(date +%Y-%m-%d)'",
  "status": "active"
}'

jq --argjson proj "$NEW_PROJECT" '.projects += [$proj]' ~/.dev-infra/registry.json > tmp.json \
  && mv tmp.json ~/.dev-infra/registry.json
```

### Remove Project

```bash
# Remove by path
jq --arg path "/Users/cdwilson/Projects/old-project" \
  '.projects = [.projects[] | select(.path != $path)]' ~/.dev-infra/registry.json > tmp.json \
  && mv tmp.json ~/.dev-infra/registry.json
```

### Update Project Status

```bash
# Archive a project
jq --arg path "/Users/cdwilson/Projects/old-project" \
  '(.projects[] | select(.path == $path)).status = "archived"' ~/.dev-infra/registry.json > tmp.json \
  && mv tmp.json ~/.dev-infra/registry.json
```

### grep Fallback (No jq)

```bash
# Simple check if project exists (works without jq)
grep -q '"path": "/Users/cdwilson/Projects/work-prod"' ~/.dev-infra/registry.json && echo "Found"

# List project names (basic, fragile)
grep '"name":' ~/.dev-infra/registry.json | sed 's/.*"name": "\([^"]*\)".*/\1/'
```

---

## 🔄 Backup & Migration

### Backup Strategy

```bash
# Simple backup
cp ~/.dev-infra/registry.json ~/.dev-infra/registry.json.bak

# Timestamped backup
cp ~/.dev-infra/registry.json ~/.dev-infra/backups/registry-$(date +%Y%m%d).json
```

### Migration Between Schema Versions

```bash
# Check current version
jq -r '.version' ~/.dev-infra/registry.json

# Migration script pattern
if [[ $(jq -r '.version' ~/.dev-infra/registry.json) == "1.0" ]]; then
  # Migrate to 1.1 (example: add new field)
  jq '.version = "1.1" | .projects |= map(. + {new_field: null})' \
    ~/.dev-infra/registry.json > tmp.json && mv tmp.json ~/.dev-infra/registry.json
fi
```

### Export for Work-prod Sync

```bash
# Export projects without local-only fields
jq '.projects | map({name, template, version, created, repository, status})' \
  ~/.dev-infra/registry.json > export.json
```

---

## 💡 Recommendations

- [x] Recommendation 1: Use JSON for local registry (`registry.json`)
- [x] Recommendation 2: Store in `~/.dev-infra/registry.json`
- [x] Recommendation 3: Use `jq` for queries (with grep fallback for simple reads)
- [x] Recommendation 4: Keep schema simple and flat
- [x] Recommendation 5: Include schema version for future migrations
- [x] Recommendation 6: Use UUID for project IDs (enables sync without path dependency)

---

## 📋 Requirements Discovered

- [x] FR-8: Local registry uses JSON format
- [x] FR-9: Registry stored at `~/.dev-infra/registry.json`
- [x] FR-10: Support basic operations: list, add, remove, update
- [x] FR-22: Registry has schema version field
- [x] FR-23: Projects have UUID identifiers
- [x] FR-24: Support project status (active/archived)
- [x] NFR-3: Registry readable without special tools (human-readable JSON)
- [x] NFR-4: `jq` is acceptable dependency
- [x] NFR-9: Schema supports migration between versions

---

## 🚀 Next Steps

1. ~~Define JSON schema for registry~~ ✅
2. ~~Document bash/jq operations~~ ✅
3. Implement helper functions in `dev-infra` script
4. Add to `new-project.sh` to register on creation

---

**Last Updated:** 2025-12-19
