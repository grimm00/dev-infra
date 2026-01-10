# Work-prod Integration - Exploration Hub

**Purpose:** Explore work-prod API integration and local data store for project tracking  
**Status:** 🔴 Exploration  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration document
- **[Research Topics](research-topics.md)** - Research questions to investigate

---

## 🎯 Overview

This exploration investigates how dev-infra can:

1. **Integrate with work-prod API** - Register and track projects using work-prod's standard project model
2. **Maintain local registry** - Keep a central index of all dev-infra managed projects locally

This builds on the [dev-infra identity exploration](../dev-infra-identity-and-focus/README.md) and complements the [template metadata research](../../research/template-metadata/README.md).

---

## 🏗️ Architecture Context

```
Per-project:  .dev-infra.yml (what template, version, sync rules)
Central:      ~/.dev-infra/registry.json (list of all projects)
Remote:       work-prod API (cloud sync, cross-machine visibility)
```

---

## 📊 Status

**Current Phase:** Exploration  
**Next Step:** Conduct research on topics identified in research-topics.md

---

**Last Updated:** 2025-12-19

