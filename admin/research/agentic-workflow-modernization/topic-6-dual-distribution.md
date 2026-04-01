# Research: Dual-Distribution Workflow

**Research Topic:** Agentic Workflow Modernization
**Question:** How should dev-infra maintain sync between skills distributed through templates and skills distributed through a marketplace?
**Status:** 🔴 Not Started
**Priority:** Medium
**Created:** 2026-03-25

---

## 🎯 Research Question

Dev-infra's template system and a team marketplace are two independent distribution channels for skills. How does this dual-distribution model work concretely: how are skills authored, how are they synced, and what happens when they diverge?

---

## 🔍 Research Goals

- [ ] Model the dual-distribution lifecycle: author in dev-infra → test in template → publish to marketplace vs marketplace-first
- [ ] Determine how the existing `template-sync-manifest.txt` approach extends to cover skill files
- [ ] Identify what marketplace metadata (`plugin.json`) is required and what dev-infra provides vs what the marketplace adds
- [ ] Assess whether the `update-pr-description` skill distribution pattern (team marketplace → `.agents/skills/`) is the right model for dev-infra skills

---

## 📚 Research Methodology

**Context already established:**
- Team marketplace deploys to `.agents/skills/` directory (confirmed by user)
- `template-sync-manifest.txt` already handles cross-template file sync validation in CI
- Skills are developed in Cursor but packaged for Claude Code marketplace consumption
- Two distribution paths: (1) in-template for immediate use, (2) marketplace for team-wide publishing

**Sources to investigate:**
- [ ] Review `template-sync-manifest.txt` for extensibility patterns
- [ ] Review `update-pr-description` skill structure for marketplace packaging conventions
- [ ] Web search: monorepo skill publishing workflows, package publishing automation
- [ ] Review CI workflow files for existing distribution automation

---

## 📊 Findings

*To be filled in during conduct mode.*

---

## 🔍 Analysis

*To be filled in during conduct mode.*

**Key Insights:**
- [ ] Insight 1: [Description]
- [ ] Insight 2: [Description]

---

## 💡 Recommendations

- [ ] Dual-distribution sync strategy
- [ ] Template-sync-manifest extension plan
- [ ] Authoring-first recommendation (template vs marketplace)

---

## 📋 Requirements Discovered

*To be filled in during conduct mode.*

---

**Last Updated:** 2026-03-25
