# Research: Topic Unification Pattern

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** How should `--topic [name] --type` pattern work across commands?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

How should `--topic [name] --type` pattern work across commands?

**Context:** Currently commands use `--feature`, `--ci`, or implicit type detection. A unified pattern could simplify usage and provide consistent UX across all commands.

---

## 🔍 Research Goals

- [x] Goal 1: Audit current commands for type-specific flags (`--feature`, `--ci`, `--topic`)
- [x] Goal 2: Define mapping from `--type` to directory paths
- [x] Goal 3: Determine interaction with auto-detection (when no type specified)
- [x] Goal 4: Evaluate if `--topic` should replace positional arguments

---

## 📚 Research Methodology

**Sources:**
- [x] Current command implementations audit (.cursor/commands/*.md)
- [x] Directory structure mapping analysis
- [x] Transition-plan command review (uses `--feature`, `--type`)
- [x] Research command review (uses `--from-explore`, `--topic`)

**Sub-questions to investigate:**
- What commands currently use type-specific flags (`--feature`, `--ci`)?
- What would the mapping from `--type` to directory path look like?
- How does this interact with auto-detection (when no type specified)?
- Should `--topic` replace the positional argument in commands?

---

## 📊 Findings

### Finding 1: Current Flag Usage is Inconsistent

| Command | Topic/Name Flags | Type Flags | Positional Arg |
|---------|------------------|------------|----------------|
| `/transition-plan` | `--feature [name]` | `--type feature\|release\|ci-cd\|infrastructure` | `[topic]` (for expand) |
| `/research` | `--topic [topic]`, `--topic-num N`, `--topic-name [name]` | None (implicit) | `[topic]` |
| `/explore` | `--topic [name]` | None | `[topic]` |
| `/decision` | `--topic [topic]`, `--decision-point [point]` | None (implicit) | `[topic]` |

**Source:** Command documentation audit

**Relevance:** Shows need for unification - commands use different terms for the same concept

---

### Finding 2: "Topic" Has Multiple Meanings

The word "topic" is overloaded across commands:

| Context | Meaning | Example |
|---------|---------|---------|
| **Exploration topic** | Subject being explored | `explore-two-mode` |
| **Research topic number** | Research question within exploration | Topic 1, 2, 3... |
| **Feature/planning topic** | The item being planned | `transition-plan-two-mode` |
| **Planning type** | Category: feature, ci, release | `--type feature` |

**Source:** Command documentation audit

**Relevance:** Need clear vocabulary - "topic" for the name, "type" for the category

---

### Finding 3: Path Mapping Already Exists

Current path detection follows consistent pattern:

| Type | Dev-Infra Path | Template Path |
|------|----------------|---------------|
| exploration | `admin/explorations/[topic]/` | `docs/maintainers/planning/explorations/[topic]/` |
| research | `admin/research/[topic]/` | `docs/maintainers/research/[topic]/` |
| decision | `admin/decisions/[topic]/` | `docs/maintainers/decisions/[topic]/` |
| feature | `admin/planning/features/[topic]/` | `docs/maintainers/planning/features/[topic]/` |
| ci | `admin/planning/ci/[topic]/` | `docs/maintainers/planning/ci/[topic]/` |
| release | `admin/planning/releases/[topic]/` | `docs/maintainers/planning/releases/[topic]/` |

**Source:** Command documentation path detection sections

**Relevance:** Mapping from type to path is already well-defined, just needs standardization

---

### Finding 4: Auto-Detection Works Well

Commands already implement intelligent auto-detection:

1. **Path-based detection:**
   - Check if `admin/[category]/` exists → use dev-infra structure
   - Check if `docs/maintainers/[category]/` exists → use template structure

2. **Type inference:**
   - `/transition-plan` infers type from artifact path (e.g., `features/` → feature)
   - `/research` infers topic from `--from-explore` source

**Source:** Command documentation

**Relevance:** Auto-detection should remain the default; explicit flags only for override

---

### Finding 5: Positional Args vs Named Flags

Current pattern: `[topic]` as positional, `--topic` as named alternative

**Pros of positional:**
- Shorter commands: `/explore auth-system` vs `/explore --topic auth-system`
- Natural reading order

**Pros of named:**
- Explicit when combined with other flags
- Consistent with `--type` pattern

**Source:** Command usage patterns

**Relevance:** Keep positional for simplicity, named for explicit override

---

### Finding 6: Industry CLI Patterns (git, kubectl, npm)

Analysis of widely-adopted CLI tools reveals consistent patterns:

| Tool | Command Pattern | Type/Category Approach |
|------|----------------|------------------------|
| **git** | `git [command] [target]` | Implicit type from context (e.g., `git branch -d [name]`) |
| **kubectl** | `kubectl [verb] [type] [name]` | Explicit type as second positional: `kubectl get pods nginx` |
| **npm** | `npm [command] [target]` | Mixed: `npm run [script]`, `npm install [pkg]` |
| **docker** | `docker [object] [command]` | Type as first positional: `docker container ls` |

**Key observations:**
1. **Consistent verb-first pattern** - Action comes before target
2. **Type often implicit** - Context determines where things go
3. **Explicit type when ambiguous** - Only specified when needed
4. **Short-form for common cases** - Longer flags for less common options

**Source:** CLI tool documentation (git, kubectl, npm, docker)

**Relevance:** Our auto-detection approach aligns with git/npm; explicit `--type` when needed follows kubectl pattern

---

### Finding 7: Migration Strategy for Flag Changes

Changing flags (e.g., `--feature` → `--topic`) requires migration strategy:

**Options:**
1. **Hard cutover** - Change all at once, update docs
2. **Deprecation period** - Support both, warn on old usage
3. **Alias approach** - Old flag works, new flag preferred

**Industry precedent:**
- Git uses deprecation warnings for changed flags
- npm shows deprecation notices but continues to work
- kubectl maintains backward compatibility for at least one major version

**Recommended approach for dev-infra:**
- Since commands are documentation-based (not executable code), can do hard cutover
- Update all command docs at once
- Document the change in CHANGELOG

**Source:** Migration pattern analysis

**Relevance:** Hard cutover is acceptable for documentation-based commands; no runtime compatibility needed

---

### Finding 8: Interaction Between Mode and Type Flags

The two-mode pattern (`--conduct`, `--expand`) interacts with type flags:

| Command | Mode Flag | Type/Scope Flag | Interaction |
|---------|-----------|-----------------|-------------|
| `/research` | `--conduct` | `--topic-num N` | Mode affects what happens; topic-num selects scope |
| `/transition-plan` | `--expand` | `--phase N`, `--type` | Mode affects depth; phase selects scope |
| `/explore` (proposed) | `--conduct` | `--type` | Mode affects action; type affects output location |

**Pattern:** Mode flags (conduct/expand) affect **what action** is performed. Type/scope flags affect **where/which** items are targeted.

**Source:** Command interaction analysis

**Relevance:** Clear separation of concerns - mode vs scope - should be documented and consistent

---

## 🔍 Analysis

The current inconsistency stems from organic command growth. A unified pattern would:

1. **Standardize vocabulary:**
   - "topic" = the name/subject (what)
   - "type" = the category (where it goes)

2. **Keep what works:**
   - Positional argument for topic name
   - Auto-detection for type inference
   - Path-based structure detection

3. **Add explicit overrides:**
   - `--type` for forcing category when auto-detection fails
   - `--topic` as named alternative to positional

4. **Separate concerns:**
   - Mode flags (`--conduct`, `--expand`) - control what action
   - Type flags (`--type feature|research|exploration`) - control where/which
   - Scope flags (`--topic-num`, `--phase`) - control subset within type

**Pattern Hierarchy:**
```
[command] [topic-name] --type [category] --mode-flag [--scope-flag N]
                       ↑                  ↑           ↑
                    optional           optional    optional
                  (auto-detect)       (default)   (all items)
```

**Key Insights:**
- [x] Insight 1: "Topic" should mean the subject name; "type" should mean the category
- [x] Insight 2: Auto-detection should remain default; explicit flags for override only
- [x] Insight 3: Positional args should stay for simplicity
- [x] Insight 4: `/research --topic-num` is different (sub-selection within research) - keep as-is
- [x] Insight 5: Mode flags and type/scope flags serve different purposes - document clearly
- [x] Insight 6: Industry CLI patterns validate our auto-detection approach
- [x] Insight 7: Hard cutover migration is acceptable for documentation-based commands

---

## 💡 Recommendations

### Vocabulary & Structure
- [x] Recommendation 1: Standardize vocabulary - "topic" = name, "type" = category
- [x] Recommendation 2: Add `--type` flag to `/explore` for explicit category (exploration, research, feature)
- [x] Recommendation 3: Keep positional args as primary, `--topic` as explicit alternative
- [x] Recommendation 4: Rename `/transition-plan --feature` to `--topic` for consistency
- [x] Recommendation 5: Keep `/research --topic-num` as-is (different semantic: sub-selection)
- [x] Recommendation 6: Document the unified pattern in command reference

### Mode & Scope Separation
- [x] Recommendation 7: Document clear distinction between mode flags (`--conduct`, `--expand`) and type/scope flags
- [x] Recommendation 8: Ensure mode flags are consistently named across two-mode commands
- [x] Recommendation 9: Use `--conduct` as the standard expansion flag for all two-mode commands (not `--expand`)

### Migration
- [x] Recommendation 10: Apply hard cutover for flag changes since commands are documentation-based
- [x] Recommendation 11: Document all flag changes in CHANGELOG under "Breaking Changes" section

### Implementation Priority
| Change | Priority | Complexity |
|--------|----------|------------|
| Add vocabulary docs | High | Low |
| Add `--type` to `/explore` | High | Medium |
| Rename `--feature` → `--topic` | Medium | Low |
| Unify mode flag naming | Medium | Medium |

---

## 📋 Requirements Discovered

**Functional Requirements:**

- [x] FR-TU-1: Commands MUST accept topic as positional argument OR `--topic` flag
- [x] FR-TU-2: Commands with category variance MUST support `--type` flag
- [x] FR-TU-3: Auto-detection MUST remain default behavior; explicit flags for override
- [x] FR-TU-4: Mode flags (`--conduct`, `--expand`) MUST be distinct from type/scope flags
- [x] FR-TU-5: `/explore --type` MUST support values: exploration, research, feature
- [x] FR-TU-6: `/transition-plan` SHOULD rename `--feature` to `--topic` for consistency

**Non-Functional Requirements:**

- [x] NFR-TU-1: Command syntax MUST be consistent across all planning commands
- [x] NFR-TU-2: Documentation MUST clearly explain topic vs type distinction
- [x] NFR-TU-3: Command help text MUST show default behavior and override options
- [x] NFR-TU-4: Migration to new flag names SHOULD use hard cutover with CHANGELOG documentation

**Constraints:**

- [x] C-TU-1: `/research --topic-num` semantic MUST be preserved (sub-selection, not unification)
- [x] C-TU-2: Positional arguments MUST remain the primary input method for simplicity

---

## 🚀 Next Steps

1. ✅ Research complete (expanded with conduct mode)
2. ✅ All research topics complete
3. Proceed to `/decision explore-two-mode --from-research` for ADR creation
4. Include unified flag pattern in ADR decisions

---

**Last Updated:** 2026-01-09 (expanded via conduct mode)

