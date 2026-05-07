# Research: Migration Path for Existing Projects

**Status:** 🔴 Not Started
**Priority:** Low
**Created:** 2026-05-06

---

## Research Question

What happens to projects already generated from the comprehensive template? Do they get a migration command, or do they just keep their existing structure indefinitely?

---

## Research Goals

- [ ] Inventory projects generated from comprehensive templates (PiHole-DNS, support-shark, others)
- [ ] Assess what "migration" means: removing scaffold? Slimming docs? Adding profile? All of the above?
- [ ] Evaluate "do nothing" option: existing projects keep their structure, new projects start minimal
- [ ] Evaluate migration command: `proj migrate --to-minimal` that strips scaffold and adds profile
- [ ] Evaluate incremental approach: skills gradually stop depending on pre-built structure, existing projects naturally slim
- [ ] Determine if proj-cli's `proj plan` / `proj apply` mechanism could handle template version migration

---

## Methodology

*(To be filled during research-conduct)*

---

## Sources

- [ ] `proj-cli` design docs — does it already handle template version upgrades?
- [ ] Existing projects' actual directory listings (what do they use vs. what's unused scaffold?)
- [ ] `proj-cli-focused-role` exploration — proj-cli's sync scope and lifecycle role
- [ ] Web search: template migration patterns (Rails generators, Create React App eject, framework upgrade guides)

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

Lowest priority — address after Topics 1 and 4 determine what "minimal" means and how bundling works. The answer may be "do nothing; existing projects are fine."
