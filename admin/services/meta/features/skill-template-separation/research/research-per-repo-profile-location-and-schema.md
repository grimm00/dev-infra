# Research: Per-Repo Profile Location and Schema

**Status:** 🔴 Not Started
**Priority:** High
**Created:** 2026-05-06

---

## Research Question

Where should the unified per-repo skill profile live, what's its schema, and how do skills look it up?

---

## Research Goals

- [ ] Evaluate candidate locations: `~/.cursor/repos/<slug>.yaml`, `~/.cursor/profiles/<slug>.yaml`, `~/.cursor/skills/_shared/repos/<slug>.yaml`, in-repo `.cursor/profile.yaml`
- [ ] Define slug derivation strategy (repo basename, org/repo, remote URL hash, user-chosen)
- [ ] Determine v1 schema fields: paths (artifact root, plan root, scratch), ticket conventions, skill version targeting
- [ ] Assess migration cost of each location choice (if wrong, how hard to move later?)
- [ ] Determine lookup convention: env var → explicit flag → config file → detection fallback
- [ ] Evaluate relationship to `ticket-intake/repos/<slug>.yaml` (absorb, extend, or coexist?)
- [ ] Determine whether in-repo files (AGENTS.md) can override/supplement the external profile

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] `~/.cursor/skills/ticket-intake/repos/` — existing per-repo YAML precedent
- [ ] `per-repo-skill-profile-unified.md` int-opp — proposed schema sketch
- [ ] `skills-path-roots-configurable.md` int-opp — skill-level override patterns
- [ ] `skill-package-controller` exploration — registry/controller relationship to profile
- [ ] XDG Base Directory specification (for location conventions)
- [ ] Web search: per-project configuration patterns in other tool ecosystems (direnv, mise, asdf, editorconfig)

---

## Findings

*(To be filled during research-conduct)*

---

## Analysis

*(To be filled during research-conduct)*

---

## Recommendations

*(To be filled during research-conduct)*

---

## Requirements Discovered

*(To be extracted during research-conduct and consolidated in requirements.md)*

---

## Next Steps

Begin research-conduct for this topic. Findings directly constrain Topics 3 and 4 (ownership and bundling depend on how the profile works).
