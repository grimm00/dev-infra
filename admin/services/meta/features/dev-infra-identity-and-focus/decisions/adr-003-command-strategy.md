# ADR-003: Command Strategy - Tiered Approach for Templates

**Status:** ✅ Accepted  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## Context

Templates currently include 18 AI commands. Research raised questions:

- Are all 18 commands essential for template users?
- Should templates have fewer, more stable commands?
- How do we manage command maintenance across templates?

**Current State:**

| Location | Commands | Notes |
|----------|----------|-------|
| Dev-infra | 23 | Full set |
| Standard Template | 18 | Core workflow |
| Learning Template | 18 | Same as standard |

**Dev-infra-only commands (5):**
- `release-prep`
- `release-finalize`
- `post-release`
- `status`
- `address-review`

**Related Research:**
- [Command Maintenance](../../research/dev-infra-identity-and-focus/research-command-maintenance.md)
- [Minimum Viable Tooling](../../research/dev-infra-identity-and-focus/research-minimum-viable-tooling.md)

**Related Requirements:**
- FR-4: Commands must have explicit stability levels
- FR-13: Templates should have explicit command tiers
- FR-14: Essential command set should be ≤7 commands
- NFR-1: Template commands should be stable

---

## Decision

**Adopt a tiered command strategy for templates.**

### Command Tiers

| Tier | Purpose | Count | Stability |
|------|---------|-------|-----------|
| **Essential** | Every project needs | 5-7 | 🔴 Very Stable |
| **Valuable** | Most projects benefit | 6 | 🟡 Stable |
| **Advanced** | Complex projects only | 7 | 🟢 Evolving |
| **Internal** | Dev-infra only | 5+ | 🔵 Can Change |

### Proposed Tier Classification

**Tier 1 - Essential (5 commands):**
1. `/pr` - Core PR workflow
2. `/task-phase` - Phase implementation
3. `/fix-plan` - Issue triage
4. `/fix-implement` - Issue fixing
5. `/reflect` - Project reflection

**Tier 2 - Valuable (6 commands):**
6. `/explore` - Exploration workflow
7. `/research` - Research workflow
8. `/decision` - ADR creation
9. `/pre-phase-review` - Quality check
10. `/pr-validation` - PR review
11. `/post-pr` - Post-merge cleanup

**Tier 3 - Advanced (7 commands):**
12. `/transition-plan` - Planning from artifacts
13. `/reflection-artifacts` - Extract artifacts
14. `/int-opp` - Capture opportunities
15. `/address-review` - Address reviews (consider moving to Tier 2)
16. `/task-release` - Release tasks
17. `/cursor-rules` - Rule management
18. `/fix-review` - Fix batch review

**Internal - Not for Templates (5 commands):**
- `/release-prep`
- `/release-finalize`
- `/post-release`
- `/status`
- `/task-improvement`

---

## Consequences

### Positive

- **Clear expectations** - Users know which commands are core vs optional
- **Stable foundation** - Essential commands are very stable
- **Flexibility** - Complex projects can use advanced commands
- **Maintainability** - Fewer high-priority commands to maintain
- **Guidance** - New users know where to start

### Negative

- **Documentation needed** - Must explain tiers to users
- **Potential confusion** - "Why isn't X in Tier 1?"
- **Gradual implementation** - Can't enforce tiers immediately

### Neutral

- **Current templates unchanged** - All 18 commands still available
- **Metadata addition** - Just adding stability/tier labels

---

## Alternatives Considered

### Alternative 1: All Commands Equal

**Description:** Keep all 18 commands with no tier distinction

**Pros:**
- No changes needed
- Simple model

**Cons:**
- Users don't know what's essential
- All commands need same stability
- Overwhelms new users

**Why not chosen:** Research showed users need guidance on essential commands

---

### Alternative 2: Minimal Template (Essential Only)

**Description:** Templates only include Tier 1 commands

**Pros:**
- Very simple templates
- Maximum stability
- Low maintenance

**Cons:**
- Users lose valuable commands
- Big change from current
- Some projects need more

**Why not chosen:** Too drastic; would lose valuable functionality

---

### Alternative 3: Template Editions

**Description:** Multiple template versions (Lite, Standard, Full)

**Pros:**
- User choice
- Different complexity levels
- Clean separation

**Cons:**
- Multiplies maintenance (3x templates)
- Increases complexity for maintainers
- May confuse users

**Why not chosen:** Deferred to v2.0 consideration; too complex for now

---

## Decision Rationale

**Key Factors:**

1. **Guidance** - Users benefit from knowing what's essential vs optional

2. **Stability** - Not all commands need the same maintenance priority

3. **Incremental** - Can implement as metadata without breaking changes

4. **Future flexibility** - Supports template editions in v2.0 if desired

**Research Support:**
- research-command-maintenance.md: "Not all commands need the same maintenance approach"
- research-minimum-viable-tooling.md: "Essential command set: 5-7 commands"

---

## Requirements Impact

**Requirements Affected:**
- FR-4: Commands must have explicit stability levels ✅
- FR-13: Templates should have explicit command tiers ✅
- FR-14: Essential command set should be ≤7 commands ✅

**Implementation creates foundation for:**
- Template editions (v2.0)
- Command graduation process
- Stability tracking

---

## Implementation

### Phase 1: Add Metadata (v0.5.0)

1. **Add tier metadata to commands:**
   ```markdown
   **Tier:** Essential | Valuable | Advanced | Internal
   **Stability:** 🔴 Very Stable | 🟡 Stable | 🟢 Evolving
   ```

2. **Document tiers in template README**

3. **No command removal** - Just classification

### Phase 2: Consider Editions (v2.0)

1. Evaluate if template editions are warranted
2. If yes, create Lite/Standard/Full templates
3. If no, maintain single template with tier documentation

---

## References

- [Command Maintenance Research](../../research/dev-infra-identity-and-focus/research-command-maintenance.md)
- [Minimum Viable Tooling Research](../../research/dev-infra-identity-and-focus/research-minimum-viable-tooling.md)
- [Requirements](../../research/dev-infra-identity-and-focus/requirements.md)

---

**Last Updated:** 2025-12-11

