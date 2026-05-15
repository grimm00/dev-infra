# Exploration: Workflow Decoupling

**Created:** 2026-05-02

---

## 🎯 What We're Exploring

Templates currently bundle three distinct things — project scaffolding, workflow
commands, and skills — that evolve at very different speeds. Projects created from
templates get a frozen snapshot of commands/skills and immediately begin drifting.
This exploration looks at decoupling the workflow layer (commands + skills + agents)
from the structural scaffold so that both can evolve independently.

---

## 🔍 Themes

### Theme 1: Template Drift Is Structural

- Projects generated from dev-infra templates get a snapshot of `.cursor/commands/`
  at creation time and never receive updates (issue #73)
- The problem compounds: `transition-plan.md` already drifted from single-mode to
  setup/expand, and generated projects still have the old version
- The agentic-workflow-modernization is accelerating this — Stage 1 archived 4
  commands and added 6 skills; by Stage 4, the entire command surface will change
- Every generated project is now silently stranded on a stale workflow set
- This isn't a documentation problem — no amount of "here's how to update" fixes
  the root cause that workflows are baked into the scaffold

### Theme 2: Three Layers with Different Change Velocities

- **Scaffold** (directories, README, start.txt, config) changes rarely — maybe
  once per template version
- **Workflow commands** change frequently as processes evolve (post-pr, pr-validation,
  transition-plan all revised multiple times in the last 3 months)
- **Skills** are the newest and highest-velocity layer — 10+ new skills in Stage 1–2
  alone, with more coming in Stages 3–4
- Bundling all three in one template means the slowest-moving layer (scaffold) gates
  the release of the fastest-moving layers (commands, skills)
- The `template-sync-manifest.txt` already acknowledges the coupling — it exists
  solely to keep the two source templates aligned, but says nothing about downstream

### Theme 3: Commands vs Skills — The Invocation Surface Distinction

- The `agent-dispatch` command crystallized a real distinction: commands are
  *invocation surfaces* (what the human or agent says to start something), skills
  are *behavioral contracts* (how the work gets done)
- Not every command should become a skill — `agent-dispatch` is pure orchestration
  glue with no behavioral contract to encode
- The agentic-workflow-modernization's framing of "convert commands to skills"
  is actually "commands that encode behavior → skills" and "commands that
  orchestrate → stay commands"
- This distinction matters for decoupling: both commands and skills should leave
  the template together as a coherent workflow package, not separately
- Agents (`.agents/`) are a third artifact type that orchestrate commands and
  skills — they'd naturally travel with the workflow package

### Theme 4: The Package Manager Question

- If workflows decouple from scaffolding, something needs to install and update them
- Options range from simple (a script that copies from dev-infra) to complex (git
  submodule, package registry, CLI tool)
- The install/update mechanism defines the user experience: "run a script once a
  month" vs "it's always current" vs "opt-in to specific versions"
- `template-sync-manifest.txt` could evolve into the manifest for the workflow
  package — it already lists every synced file
- Issue #76 ("document how to use commands as portable plugins") is the consumer
  side of this same question

### Theme 5: Versioning and Compatibility

- If workflows update independently, they can break against the scaffold they're
  installed into
- A command that references `docs/maintainers/planning/` won't work in a project
  that uses `admin/services/` — path detection already handles this, but it's
  fragile
- Skills reference each other (parent/child, family conventions) — partial updates
  could leave a family in an inconsistent state
- The workflow package might need its own version, or at minimum a compatibility
  contract with the scaffold version it targets

---

## ❓ Key Questions

1. What's the simplest install/update mechanism that solves the drift problem
   without introducing a package management burden?
2. Should the workflow package version independently from templates, or track
   template versions with a separate update channel?
3. What happens to `template-sync-manifest.txt` — does it become the workflow
   package manifest?
4. How do you handle the transition? Projects created before decoupling need a
   migration path to the new model.
5. Does the command-vs-skill distinction affect what goes in the package, or does
   everything under `.cursor/` and `.claude/` travel together?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Template drift | LOW | No | Well-understood problem; issue #73 documents it clearly |
| Change velocity layers | LOW | No | Observational — informs design, doesn't need validation |
| Command vs skill distinction | LOW | No | Already validated by `agent-dispatch` experience |
| Package manager mechanism | MEDIUM-HIGH | Consider | Multiple viable approaches; wrong choice could create maintenance burden worse than the drift it solves |
| Versioning and compatibility | MEDIUM | No | Research first — need to understand the constraint space before spiking |

---

## 🔗 Sibling Explorations

- **[Skill-Template Separation](../../../meta/explorations/skill-template-separation/)** (meta service) — Asks "what *is* the separation and what does a template become after?" while this exploration asks "how do we distribute what's been separated?" The two are complementary halves of the same initiative. Research and decisions should proceed in coordination.

---

## 🚀 Next Steps

Review this exploration, then:
- `/explore-amend` to add new themes from downstream discovery
- `/research --from-explore` to investigate open questions
- Proceed directly to implementation if the exploration is sufficient
