# Spike: Nested Skill Discovery and Context Sharing

**Exploration:** agentic-workflow-modernization
**Created:** 2026-04-13
**Time-box:** ~30 minutes
**Result:** Validated (with modifications)

---

## Questions Answered

- [x] Q1: Does Cursor auto-discover project-level `.claude/skills/`? -- **No.** Cursor only surfaces skills from `~/.cursor/skills/` (user-level) and `~/.claude/plugins/cache/` (plugins). Project-level `.claude/skills/` is invisible to Cursor's skill system.
- [x] Q2: Does Claude Code discover nested skill directories? -- **Yes.** Claude Code's `Skill` tool does recursive discovery. Parent SKILL.md can list children, agent navigates the tree.
- [x] Q3: Does a parent SKILL.md's behavioral contract automatically inherit to child skills? -- **No.** Test A confirmed: no marker, no sign-off appeared in the child's response. Directory nesting provides zero implicit context sharing.
- [x] Q4: Is explicit "read the parent" a viable alternative to automatic inheritance? -- **Yes.** The instruction "Before proceeding, read `../SKILL.md` for family conventions" is trivial, reliable, and gives the child skill explicit control over whether to opt in.

---

## Key Findings

### Finding 1: No Automatic Inheritance

Test A (child with no parent reference) confirmed that the parent's behavioral contract (`[EXPLORE-FAMILY]` marker, sign-off rule) did NOT propagate to the child skill. The agent had "no context from previous sessions and no awareness of parent skills." This is definitive: directory nesting = zero implicit context sharing.

### Finding 2: Explicit Reference Is Sufficient and Preferable

The pragmatic conclusion (reached by the user after reflection, not from Test B mechanically): asking the AI to "read the parent file" is a trivial instruction, not a fragile inheritance mechanism. It's no different from "check the README in the parent directory." Modern models handle this reliably.

Key benefits of explicit over implicit:
- Each skill controls whether it opts into family context
- Graceful degradation: skills that don't need family context just don't read it
- No magic, no surprises -- explicit reads beat implicit inheritance
- Smaller, focused context loading -- parent read adds only what's needed

### Finding 3: Platform Discovery Divergence

| Platform | Project-level `.claude/skills/` | Nested directories | Invocation |
|----------|---|---|---|
| **Claude Code** | Auto-discovered | Recursive traversal | Agent navigates tree |
| **Cursor** | Not discovered | Not traversed | Explicit attachment by user |

The same directory layout works in both -- files are identical, only discovery differs. This is a thin adaptation layer (how skills are found), not a content fork (what skills say).

---

## Go / No-Go

**Recommendation:** Go with modifications

**The validated architecture:**

```
.claude/skills/
├── explore/
│   ├── SKILL.md                    ← Parent: shared behavioral contract + family orientation
│   ├── explore-start/SKILL.md      ← Child: "read ../SKILL.md for family conventions" (explicit opt-in)
│   ├── explore-conduct/SKILL.md    ← Child: may or may not reference parent
│   └── explore-amend/SKILL.md      ← Child: may or may not reference parent
```

**Modifications from original hypothesis:**
- No automatic inheritance -- explicit "read parent" instruction in child skills that need it
- Directory grouping serves human maintenance, not platform discovery
- Claude Code users get recursive navigation as a bonus; Cursor users use explicit attachment
- Discovery is a per-platform adapter, not a reason to restructure skill content

---

## Deeper Insight: Explicit Over Implicit as a Unifying Principle

*Added 2026-04-13 from /discuss session.*

The spike result (explicit "read parent" over automatic inheritance) is an instance of a principle that runs through the entire research:

| Research Finding | Implicit (fragile) | Explicit (reliable) |
|---|---|---|
| FR-2: Invocation control | Auto-detection | `disable-model-invocation: true` |
| Topic 8: Behavioral contracts | Persona role-play | Outcome-based contracts with observable properties |
| Topic 8: Enforcement | Prose rules ("never commit") | Hooks (deterministic pre-commit gate) |
| This spike: Context sharing | Automatic inheritance | Explicit "read parent" instruction |

**The principle:** Take what's implicit and probabilistic, make it explicit and deterministic. Each move on this list reduces the system's dependence on the model "getting it right" and increases the surface area of deterministic guarantees.

### Directory Grouping Benefits Both Humans AND Agents

The initial spike conclusion ("directory grouping serves humans") understates the agent benefit. The parent SKILL.md functions as a **progressive disclosure index** for agents:

- **Without grouping:** Agent scans 60-80 flat skill descriptions to find relevant ones (context waste)
- **With grouping:** Agent reads one parent SKILL.md (~50 tokens of orientation), then loads only the right child (focused context)

This is the same progressive disclosure pattern Topic 1 identified as valuable. The parent is a lightweight routing index -- it reduces the agent's search space without loading unnecessary content.

| Benefit | Humans | Agents |
|---------|--------|--------|
| Navigation | File explorer grouping | Reduced search space |
| Context | README-like orientation | Progressive disclosure (parent -> child) |
| Behavioral contract | Shared conventions visible in one file | Explicit opt-in reference loads family rules |
| Graceful degradation | Can browse without reading every file | Can operate without loading every sibling |

## Connection to Research

- **Topic 1 (Auto-Detection):** Progressive disclosure for skills (load description first, full content on match) -- parent SKILL.md is the same pattern at the family level
- **Topic 3 (Conversion Mechanics):** FR-7 (one skill per workflow) is compatible with directory grouping -- decomposition is about SKILL.md content, directory layout is about organization
- **Topic 5 (Cross-Platform Portability):** Live demonstration of the portability gap -- same structure, different discovery
- **Topic 6 (Dual Distribution):** Skill content is 1:1 between dev-infra authoring and marketplace shipping; discovery is the only platform-specific concern
- **Topic 8 (Behavioral Contracts):** Parent SKILL.md is where family-wide gotchas and behavioral rules live -- children reference when needed, self-contained when not (consistent with FR-8)
- **Topic 8 Finding 9 (Escalation Ladder):** The "explicit over implicit" principle applies to context sharing the same way it applies to enforcement -- don't depend on the probabilistic layer when the deterministic layer works

---

## Spike Code

**Location:** `.claude/skills/explore/` (test fixtures)
**Keep or discard:** Keep as reference for skill family pattern; clean up test-specific canned responses before real skill conversion

---

## Next Steps

- [x] Update v1-scope.md C3-2 from "unvalidated" to "validated via spike"
- [ ] Use this pattern when converting the first real skill family (explore)
- [ ] Document the explicit-reference pattern in a skill authoring guide

---

**Last Updated:** 2026-04-13
