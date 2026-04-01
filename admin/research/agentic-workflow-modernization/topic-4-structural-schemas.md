# Research: Templates as Structural Schemas

**Research Topic:** Agentic Workflow Modernization
**Question:** How do existing doc-gen templates become structural schemas that agents validate, fill, and extend?
**Status:** 🔴 Not Started
**Priority:** Medium-High
**Created:** 2026-03-25

---

## 🎯 Research Question

Dev-infra already ships 17+ doc-gen templates. Can these be elevated from "AI fill-in-the-blank helpers" to structural schemas -- formal contracts for document structure that agents validate, diff, and enforce?

---

## 🔍 Research Goals

- [ ] Audit existing doc-gen templates for schema-like properties (required fields, typed sections, validation rules)
- [ ] Research AI document validation patterns: what does "structural schema for a document" look like in practice?
- [ ] Determine what metadata would make a template a schema (required vs optional sections, field types, content rules)
- [ ] Assess whether living schemas within skill reference files is the right packaging (vs standalone schema files)
- [ ] Explore agent-driven validation: "does this document conform to the schema?" as an agentic check

---

## 📚 Research Methodology

**Context already established:**
- Spike B found reference files in skill directories are where doc templates can live
- The structural schema concept emerged from the workplace marketplace insight
- Dev-infra has 17 doc-gen templates across templates and `.cursor/commands/`
- This connects directly to Topic 3 (reference file organization in skills)

**Sources to investigate:**
- [ ] Review dev-infra doc-gen templates (sample 3-4 templates from different types)
- [ ] Web search: AI agent document validation, structured output schemas
- [ ] Web search: JSON Schema / Markdown schema standards for documents
- [ ] Review `update-pr-description` for how it uses reference templates

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

- [ ] Proposed schema metadata format
- [ ] Packaging recommendation (in skill reference files vs standalone)
- [ ] Validation approach

---

## 📋 Requirements Discovered

*To be filled in during conduct mode.*

---

**Last Updated:** 2026-03-25
