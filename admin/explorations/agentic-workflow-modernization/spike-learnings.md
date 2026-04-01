# Spike Learnings: AGENTS.md Portability

**Exploration:** `admin/explorations/agentic-workflow-modernization/`
**Created:** 2026-03-25
**Time-box:** ~1 hour (research-heavy spike; empirical testing deferred where noted)
**Result:** Partially Validated

---

## Questions Answered

- [x] Q1: Is AGENTS.md an established standard? -- **Yes.** 60,000+ repos, backed by the Linux Foundation's Agentic AI Foundation (Dec 2025), supported by 25+ tools.
- [x] Q2: Does Cursor read AGENTS.md? -- **Yes.** Treated as agent instructions in markdown. Loaded at lowest priority in the rules chain.
- [x] Q3: Does Claude Code read AGENTS.md? -- **No.** Claude Code only reads `CLAUDE.md`. AGENTS.md support is an open feature request (issue #34235, #6235). Workaround: have `CLAUDE.md` instruct the agent to read `AGENTS.md`, or use hooks.
- [x] Q4: Does AGENTS.md support file references (hub-and-spoke)? -- **Not in the spec.** File reference following is tool-dependent, not specified by the standard. The spec is plain markdown with no required schema.
- [x] Q5: Does AGENTS.md support subdirectory scoping? -- **Proposed but not standardized.** A `.agents/` directory proposal exists (GitHub issue #9) but hasn't been adopted. Each tool has its own directory convention (`.cursor/rules/`, `.github/instructions/`, etc.).
- [x] Q6: What's the precedence when both AGENTS.md and .cursor/rules exist? -- **`.cursor/rules` takes priority.** Full hierarchy: Team Rules > Project Rules (`.cursor/rules/*.mdc`) > User Rules > Legacy Rules (`.cursorrules`) > AGENTS.md (lowest).

---

## Key Findings

### Finding 1: AGENTS.md is Real, But Not Universal

AGENTS.md is a legitimate, widely-adopted standard -- not vaporware. 60k repos, Linux Foundation backing, cross-tool support. It's the emerging "README for agents." However, Claude Code -- one of the two platforms that matter most for dev-infra -- does not natively support it. This means the "one file, all platforms" promise doesn't hold today.

### Finding 2: Cursor Treats AGENTS.md as Lowest Priority

In Cursor, AGENTS.md sits at the bottom of the rules hierarchy. The existing `.cursor/rules/*.mdc` files (with `alwaysApply: true`) take precedence. This means AGENTS.md isn't a replacement for `.mdc` rules in Cursor -- it's supplementary. For dev-infra, this is actually fine: AGENTS.md handles the portable baseline; `.mdc` handles Cursor-specific features (glob patterns, activation modes, auto-attach).

### Finding 3: The Hub-and-Spoke Model Won't Work Via AGENTS.md Alone

The elegant layered AGENTS.md that points to skill directories and reference files isn't supported by the spec. File references in AGENTS.md are just text -- the agent may or may not follow them depending on the tool. The monolithic inline approach (all content in one file) is the safe bet for guaranteed delivery.

However, in practice, capable agents (like Cursor's) will likely read referenced files when asked about them -- they just aren't *auto-loaded*. The distinction is: auto-loaded context (guaranteed) vs. on-demand context (agent reads the file when it seems relevant). Skills handle on-demand loading natively.

### Finding 4: Claude Code Needs CLAUDE.md (Dual-File Strategy)

For Claude Code portability, dev-infra needs a `CLAUDE.md` alongside or instead of `AGENTS.md`. Two strategies:

1. **Dual-file:** Maintain both `AGENTS.md` (for Cursor, Codex, Copilot, etc.) and `CLAUDE.md` (for Claude Code). Risk: sync drift between two files.
2. **CLAUDE.md as shim:** A minimal `CLAUDE.md` that says "Read and follow AGENTS.md in this repository." This depends on Claude Code reliably following that instruction.
3. **Wait:** Claude Code AGENTS.md support is actively requested. It may ship in 2026.

### Finding 5: The Standard Favors Operational Content

Best practices for AGENTS.md emphasize executable commands, concrete conventions, and clear boundaries -- not behavioral identity or philosophical disposition. The "Identity/Rules layer" we envisioned (collaborator by default, pushback on assumptions) goes beyond current AGENTS.md conventions. It *can* go there, but it's not the pattern most tools are optimized for.

The recommended sections: agent role, project overview, dev setup, build/test commands, code style, PR conventions, security, boundaries (Always/Ask First/Never). This maps to our Conventions layer, not our Identity layer.

---

## Edge Cases Tested

| Case | Expected | Actual | Pass? |
|------|----------|--------|-------|
| AGENTS.md auto-loaded in Cursor | Yes | Yes (per docs, lowest priority) | Yes |
| AGENTS.md auto-loaded in Claude Code | Yes | No (CLAUDE.md only) | **No** |
| File references auto-followed | At least partially | Not in spec; tool-dependent | **No** |
| Subdirectory AGENTS.md | Supported | Proposed, not standardized | **No** |
| Coexists with .cursor/rules | Yes, merged | Yes, .mdc takes precedence | Yes |
| AGENTS.md replaces .mdc rules | N/A | No -- .mdc has priority and more features | N/A |

---

## Go / No-Go

**Recommendation:** Go with modifications

**Rationale:** AGENTS.md is worth adopting as a portable conventions layer. It's a real standard with broad tool support. However, the four-layer model needs adjustment:

1. **AGENTS.md** -- portable conventions (project overview, build/test, code style, PR conventions, boundaries). This is the "onboarding doc for any agent, any tool."
2. **CLAUDE.md** -- Claude Code-specific shim or duplicate (until native AGENTS.md support ships). Minimal: "Read AGENTS.md" + any Claude-specific config.
3. **`.cursor/rules/*.mdc`** -- Cursor-specific behavioral config (always-apply, glob patterns, activation modes). The Identity layer lives here for Cursor.
4. **Skills (SKILL.md)** -- portable procedural workflows. These handle progressive loading natively.

The behavioral identity ("collaborator by default") is best expressed in the platform-specific config (`.mdc` for Cursor, `CLAUDE.md` for Claude Code) because behavioral configuration depends on platform-specific mechanisms. AGENTS.md carries the portable, operational baseline that any agent should know.

**Modifications needed:**
- Don't attempt hub-and-spoke AGENTS.md with file references -- use inline content
- Create CLAUDE.md as a shim or minimal duplicate for Claude Code portability
- Keep `.mdc` rules for Cursor-specific behavioral config; don't try to migrate Identity layer to AGENTS.md
- The four-layer model becomes: AGENTS.md (portable ops) + platform config (`.mdc` / `CLAUDE.md`) + skills + commands

---

## Refined Questions

New questions revealed by this spike (feed back to research):

1. How reliable is the "CLAUDE.md shim" approach? Does Claude Code consistently follow instructions to read another file?
2. When Claude Code ships AGENTS.md support, will it follow the same precedence model as Cursor (CLAUDE.md > AGENTS.md)?
3. Should dev-infra's templates seed AGENTS.md alongside `.cursor/rules/`? What's the template impact?
4. The behavioral identity layer: can `.mdc` and `CLAUDE.md` share the same content via template sync, or do they need platform-specific versions?

---

## Spike Code

**Location:** `admin/explorations/agentic-workflow-modernization/spike/`
**Keep or discard:** Keep as reference (test plan + reference conventions file)

---

## Next Steps

- [ ] Create a minimal `AGENTS.md` for dev-infra (conventions layer only) as a real-world test
- [ ] Create a `CLAUDE.md` shim for Claude Code portability
- [ ] Proceed to Spike B: command-to-skill conversion (`/discuss` as the test case)
- [ ] Feed refined questions into Topic 5 (cross-platform portability) and Topic 9 research

---

**Last Updated:** 2026-03-25
