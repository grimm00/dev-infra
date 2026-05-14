# Skill Package Controller — Exploration

**Created:** 2026-05-06
**Service:** ai-workflow
**Status:** 🟠 In Progress

---

## Quick Links

- [Exploration](exploration.md) — themes, questions, spike determination
- [Research Topics](research-topics.md) — prioritized questions for investigation

## Overview

Explores the **controller** layer of the ai-workflow package: the runtime component that detects repo context, manages a persistent registry of repo relationships, bootstraps new repos via setup flow, and passes resolved configuration to skills/agents/commands. Distinct from individual skill path overrides (which are the *endpoints* of what the controller provides) and from the meta-level skill-template-separation question (which determines *what authority the controller carries*).

## Related

- [Skill-Template Separation](../../../meta/explorations/skill-template-separation/) — meta exploration; Themes 1–2 decisions directly constrain controller scope
- [skills-path-roots-configurable.md](../../../../planning/opportunities/internal/dev-infra/improvements/skills-path-roots-configurable.md) — immediate skill-level fixes the controller would subsume
- [per-repo-skill-profile-unified.md](../../../../planning/opportunities/internal/dev-infra/improvements/per-repo-skill-profile-unified.md) — unified profile (the registry shape) the controller manages

---

**Last Updated:** 2026-05-06
