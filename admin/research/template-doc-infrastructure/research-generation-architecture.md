# Research: Generation Script Architecture

**Research Topic:** Template Doc Infrastructure  
**Question:** How should doc generation scripts be structured (standalone, library, command integration)?  
**Status:** ✅ Complete  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 🎯 Research Question

How should doc generation scripts be structured - standalone scripts per doc type, a shared library with functions, or deep integration with Cursor commands? The choice affects maintainability, reusability, and how commands invoke generation.

---

## 🔍 Research Goals

- [x] Goal 1: Review existing script patterns (check-release-readiness.sh, new-project.sh)
- [x] Goal 2: Analyze pros/cons of standalone vs library vs integrated approaches
- [x] Goal 3: Identify integration points with Cursor commands
- [x] Goal 4: Design extensible architecture for future doc types

---

## 📚 Research Methodology

**Sources:**

- [x] Source 1: Review `scripts/check-release-readiness.sh` architecture
- [x] Source 2: Review `scripts/new-project.sh` generation patterns
- [x] Source 3: Review `scripts/shell-functions.sh` library pattern
- [x] Source 4: Analyze `.cursor/commands/` for generation patterns
- [x] Source 5: Understand how Cursor commands interact with shell environment

---

## 📊 Findings

### Finding 1: Existing Script Architecture Patterns

**Three distinct patterns exist in dev-infra:**

#### Pattern A: Standalone Validation + Generation Script

**Example:** `check-release-readiness.sh`

```bash
# Key features:
- Single-purpose script
- CLI interface with flags (--generate, --json, --verbose)
- Direct output (stdout) or file generation
- Self-contained with embedded templates
- Exit codes for CI integration
```

**Architecture:**

```
check-release-readiness.sh
├── argument parsing (getopts)
├── validation functions (check_release_branch, check_version_consistency)
├── generation function (generate_assessment)
└── main() orchestration
```

**Strengths:**

- Self-contained, no dependencies
- Clear single responsibility
- Easy to test in isolation
- CI-friendly exit codes

**Weaknesses:**

- Templates embedded in script (hard to maintain)
- Code duplication if multiple scripts need similar patterns
- No shared infrastructure

---

#### Pattern B: Interactive Generator Script

**Example:** `new-project.sh`

```bash
# Key features:
- Interactive prompts (prompt_input, prompt_yes_no)
- Template file copying + variable substitution
- Multi-step workflow with user feedback
- Environment detection (CI, BATS, non-interactive)
```

**Architecture:**

```
new-project.sh
├── utility functions (print_status, print_error)
├── prompt functions (prompt_input, prompt_yes_no)
├── validation functions (validate_target_directory)
├── generation logic (copy + sed substitution)
└── main flow with interactive prompts
```

**Strengths:**

- Rich user interaction
- Progressive disclosure of options
- Graceful handling of CI/non-interactive environments

**Weaknesses:**

- Complex argument handling
- Long script with mixed concerns
- Templates scattered throughout

---

#### Pattern C: Sourced Function Library

**Example:** `shell-functions.sh`

```bash
# Key features:
- Source-able library (not directly executed)
- Composable functions
- Aliases and shortcuts
- Dependency on external scripts (worktrees.sh)
```

**Architecture:**

```
shell-functions.sh
├── wt() - main worktree function
├── cursor-wt() - cursor integration
└── aliases (worktrees, wtl, wth)
```

**Strengths:**

- Composable and reusable
- Can be sourced in other scripts
- Thin wrappers around core functionality

**Weaknesses:**

- Requires explicit sourcing
- Tight coupling to external scripts
- Limited to shell environment

**Source:** Direct analysis of `scripts/check-release-readiness.sh`, `scripts/new-project.sh`, `scripts/shell-functions.sh`

**Relevance:** These patterns inform the architecture decision for doc generation.

---

### Finding 2: Current Command Generation Pattern

**Commands currently generate docs inline via AI interpretation:**

````markdown
# Command defines template:

**File:** `explorations/[topic]/exploration.md`

```markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
...
```
````

**How it works:**

1. Command markdown contains template examples
2. AI reads command definition
3. AI generates content following template
4. AI writes files directly

**Problems with current approach:**

1. **Inconsistency** - AI interprets templates differently each time
2. **Format drift** - Small variations accumulate (e.g., unlabeled topic numbers)
3. **No validation** - No programmatic check that output matches template
4. **Duplicated templates** - Same template defined in multiple command files

**Source:** Analysis of `.cursor/commands/explore.md`, `research.md`, `decision.md`

**Relevance:** This is the core problem template infrastructure should solve.

---

### Finding 3: Architecture Options Analysis

**Option 1: Standalone Scripts per Doc Type**

```
scripts/doc-gen/
├── gen-exploration.sh     # /explore doc generation
├── gen-research.sh        # /research doc generation
├── gen-decision.sh        # /decision doc generation
├── gen-phase.sh           # /task-phase doc generation
└── gen-handoff.sh         # /handoff doc generation
```

**Pros:**

- ✅ Clear ownership - one script per workflow
- ✅ Easy to test in isolation
- ✅ Simple mental model
- ✅ Can add --validate flag to each

**Cons:**

- ❌ Code duplication (common patterns repeated)
- ❌ 5+ scripts to maintain
- ❌ No shared template infrastructure

**Verdict:** Simple but doesn't scale well

---

**Option 2: Shared Library + Thin Wrappers**

```
scripts/doc-gen/
├── lib/
│   ├── common.sh         # Shared functions
│   ├── templates.sh      # Template loading/rendering
│   └── validate.sh       # Validation functions
├── gen-exploration.sh    # Thin wrapper
├── gen-research.sh       # Thin wrapper
└── gen-doc.sh            # Unified entry point (optional)
```

**Pros:**

- ✅ DRY - common code shared
- ✅ Consistent patterns across workflows
- ✅ Single place to update common functionality
- ✅ Library can be sourced by other scripts

**Cons:**

- ❌ More complex architecture
- ❌ Dependencies between files
- ❌ Need to manage library versioning

**Verdict:** Better for maintainability, recommended approach

---

**Option 3: Unified Generator with Subcommands**

```
scripts/doc-gen.sh
├── gen-doc.sh exploration [topic]
├── gen-doc.sh research [topic]
├── gen-doc.sh decision [topic]
└── gen-doc.sh validate [doc-path]
```

**Pros:**

- ✅ Single entry point
- ✅ Consistent CLI interface
- ✅ Easy to discover available generators
- ✅ Can share state across subcommands

**Cons:**

- ❌ Large single file (or complex include structure)
- ❌ Harder to test individual generators
- ❌ May become unwieldy as more doc types added

**Verdict:** Elegant but potentially monolithic

---

**Option 4: Template Files + Simple Renderer**

```
scripts/templates/
├── exploration/
│   ├── README.md.tmpl
│   ├── exploration.md.tmpl
│   └── research-topics.md.tmpl
├── research/
│   ├── README.md.tmpl
│   ├── research-topic.md.tmpl
│   └── requirements.md.tmpl
└── render-template.sh    # Simple variable substitution
```

**Pros:**

- ✅ Templates are standalone files (easy to edit)
- ✅ Simple renderer (sed/envsubst)
- ✅ Easy to version control template changes
- ✅ Non-programmers can edit templates

**Cons:**

- ❌ Limited template logic (no conditionals)
- ❌ Need external tool for complex rendering
- ❌ Template files require their own validation

**Verdict:** Best for template maintenance, good for simple generation

**Source:** Analysis of architecture patterns in similar tools

**Relevance:** Option 2 (shared library) or Option 4 (template files) best fit our needs.

---

### Finding 4: Command Integration Points

**How Cursor commands could invoke scripts:**

#### Integration Method A: Shell Command in Checklist

```markdown
**Checklist:**

- [ ] Run `scripts/doc-gen/gen-exploration.sh [topic]` to create scaffolding
- [ ] Verify output matches expected structure
```

**Pros:** Explicit, user controls execution
**Cons:** Not automatic, user must copy/paste command

---

#### Integration Method B: Command Instructs AI to Execute

````markdown
### Step 1: Generate Scaffolding

**Execute:**

```bash
scripts/doc-gen/gen-exploration.sh "$TOPIC" --mode setup
```
````

**Then:** Verify the generated files and continue with Step 2.

````

**Pros:** More automated feel
**Cons:** AI may not execute reliably, no feedback loop

---

#### Integration Method C: Hybrid (Generate + Customize)
```markdown
### Step 1: Generate Base Scaffolding

Run the generation script:
```bash
scripts/doc-gen/gen-exploration.sh "$TOPIC" --mode setup
````

### Step 2: Customize Generated Content

Read the generated files and customize:

- [ ] Update the "What We're Exploring" section with specific context
- [ ] Add project-specific themes

````

**Pros:** Best of both worlds - consistent structure + AI customization
**Cons:** Two-step process

---

#### Integration Method D: Validation-Only (AI Generates, Script Validates)
```markdown
### After Generation

**Validate output:**
```bash
scripts/doc-gen/validate-doc.sh explorations/[topic]/exploration.md --type exploration
````

If validation fails, fix the issues and re-validate.

````

**Pros:** AI retains generation flexibility, script ensures quality
**Cons:** Fix cycle can be frustrating

**Source:** Analysis of how dev-toolkit commands work with shell scripts

**Relevance:** Method C (hybrid) is most practical for Cursor environment.

---

### Finding 5: Template Variable Expansion Options

**Option A: Simple Placeholder Replacement (sed)**
```bash
# Template: exploration.md.tmpl
**Status:** 🔴 Scaffolding
**Created:** {{DATE}}
**Topic:** {{TOPIC}}

# Script:
sed -e "s/{{DATE}}/$(date +%Y-%m-%d)/g" \
    -e "s/{{TOPIC}}/$TOPIC/g" \
    template.tmpl > output.md
````

**Pros:** No dependencies, works everywhere
**Cons:** Limited (no loops, conditionals)

---

**Option B: envsubst (Environment Variables)**

```bash
# Template uses $VAR syntax
export DATE=$(date +%Y-%m-%d)
export TOPIC="my-topic"
envsubst < template.tmpl > output.md
```

**Pros:** Standard tool, simple
**Cons:** Variables must be exported, no advanced features

---

**Option C: Bash Heredocs (Embedded Templates)**

```bash
generate_exploration() {
    cat <<EOF
# Exploration: $TOPIC

**Status:** 🔴 Scaffolding
**Created:** $(date +%Y-%m-%d)
EOF
}
```

**Pros:** Full bash power, no external files
**Cons:** Templates embedded in code, hard to read

---

**Option D: Template Engine (jinja2-cli, gomplate)**

```bash
# Template with logic
{% if mode == 'scaffolding' %}
**Status:** 🔴 Scaffolding
{% else %}
**Status:** ✅ Expanded
{% endif %}

# Requires: pip install jinja2-cli
jinja2 template.j2 data.yaml > output.md
```

**Pros:** Full template power (loops, conditionals)
**Cons:** External dependency

**Recommendation:** Option A (sed) for simplicity, with Option D available for complex templates.

**Source:** Analysis of template approaches in similar projects

**Relevance:** Simplest approach that works should be chosen.

---

**📌 DECISION BREADCRUMB: Tech Stack Selection**

This research recommends sed-based templates, but implementers should validate:

| Question             | Research Position                 | Needs Validation?                               |
| -------------------- | --------------------------------- | ----------------------------------------------- |
| Variable syntax      | `{{VAR}}` with sed                | ✅ Test cross-platform (macOS vs Linux sed)     |
| Complex templates    | Fall back to jinja2-cli if needed | ✅ Identify which templates need conditionals   |
| Dependency tolerance | Prefer 0 external deps            | ⚠️ If jinja2 needed, is pip install acceptable? |
| Template inheritance | Not addressed                     | 🟡 May need for DRY hub templates               |

**Recommendation for /decision phase:** Create ADR for template rendering tech stack if research shows sed insufficient for identified use cases.

---

### Finding 6: Validation Architecture

**Validation rules derived from Topic 1 research:**

| Check             | Doc Type | Rule                                            |
| ----------------- | -------- | ----------------------------------------------- |
| Status Header     | All      | Must contain `**Status:**` with valid indicator |
| Date Format       | All      | `**Created:** YYYY-MM-DD` pattern               |
| Required Sections | Per type | Type-specific sections present                  |
| Status Indicators | All      | Valid emoji (🔴, 🟠, 🟡, 🟢, ✅)                |
| Quick Links       | Hubs     | Section exists with markdown links              |
| Next Steps        | All      | Section exists at end                           |

**Validation script structure:**

```bash
validate_doc() {
    local file="$1"
    local type="$2"

    # Common checks
    check_status_header "$file"
    check_date_format "$file"
    check_next_steps "$file"

    # Type-specific checks
    case "$type" in
        exploration) check_exploration_sections "$file" ;;
        research) check_research_sections "$file" ;;
        adr) check_adr_sections "$file" ;;
    esac
}
```

**Source:** Pattern analysis from Topic 1 findings

**Relevance:** Validation enforces template compliance.

---

## 🔍 Analysis

**Key Insights:**

- [x] **Insight 1:** Existing scripts show two successful patterns: standalone (check-release-readiness) and library (shell-functions)
- [x] **Insight 2:** Current AI-inline generation causes the inconsistency problem we're solving
- [x] **Insight 3:** Hybrid approach (script generates base + AI customizes) balances consistency with flexibility
- [x] **Insight 4:** Simple sed-based variable expansion is sufficient for most templates
- [x] **Insight 5:** Validation is as important as generation - catches drift before it causes problems

**Recommended Architecture:**

```
scripts/
├── doc-gen/
│   ├── lib/
│   │   ├── common.sh         # Colors, logging, utilities
│   │   ├── render.sh         # Template rendering (sed-based)
│   │   └── validate.sh       # Validation functions
│   ├── templates/
│   │   ├── exploration/      # Exploration templates
│   │   ├── research/         # Research templates
│   │   ├── decision/         # Decision templates
│   │   └── planning/         # Feature planning templates
│   ├── gen-doc.sh            # Unified entry point
│   └── validate-doc.sh       # Validation entry point
```

**Usage:**

```bash
# Generate exploration scaffolding
scripts/doc-gen/gen-doc.sh exploration my-topic --mode setup

# Validate generated doc
scripts/doc-gen/validate-doc.sh admin/explorations/my-topic/exploration.md

# Generate from template directly
scripts/doc-gen/gen-doc.sh --template exploration/README.md.tmpl \
    --output admin/explorations/my-topic/README.md \
    --var TOPIC=my-topic --var DATE=$(date +%Y-%m-%d)
```

---

## 💡 Recommendations

- [x] **R1:** Use shared library pattern (Option 2) with template files (Option 4)
- [x] **R2:** Simple sed-based variable expansion for most templates
- [x] **R3:** Separate generation scripts from validation scripts (single responsibility)
- [x] **R4:** Hybrid command integration - scripts generate base, AI customizes
- [x] **R5:** Template files stored in `scripts/doc-gen/templates/[workflow]/`
- [x] **R6:** Unified entry point (`gen-doc.sh`) with subcommand-style interface

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-8:** Generation scripts must support both scaffolding and full generation modes
- **FR-9:** Templates must be stored as separate files (not embedded in scripts)
- **FR-10:** Generation scripts must support variable substitution for common fields (DATE, TOPIC)
- **FR-11:** Validation scripts must check all required sections per doc type
- **FR-12:** Scripts must provide clear error messages for validation failures
- **FR-13:** Scripts must support `--dry-run` flag to preview output
- **FR-14:** Scripts must return meaningful exit codes for CI integration

### Non-Functional Requirements

- **NFR-5:** Scripts must work with standard bash (no exotic dependencies)
- **NFR-6:** Template rendering must be fast (<1 second per file)
- **NFR-7:** Scripts must be testable with BATS or similar framework
- **NFR-8:** Scripts must work in non-interactive CI environments

### Constraints

- **C-4:** No external dependencies beyond coreutils (sed, awk, grep)
- **C-5:** Must work on both macOS and Linux (POSIX-compatible)
- **C-6:** Templates must remain human-readable markdown

---

## 🚀 Next Steps

1. Design detailed script API and CLI interface
2. Create prototype for exploration generation
3. Define validation rule set for each doc type
4. Plan integration with `/explore` command as pilot

---

**Last Updated:** 2026-01-13
