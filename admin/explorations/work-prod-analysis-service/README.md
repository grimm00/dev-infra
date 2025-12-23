# Work-Prod Analysis Service - Exploration Hub

**Purpose:** Explore separating project analysis from proj-cli inventory into work-prod  
**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration document
- **[Research Topics](research-topics.md)** - Research questions to investigate

---

## 🎯 Overview

This exploration investigates moving project analysis capabilities from proj-cli's `inv analyze` command to work-prod as a dedicated analysis service.

**Key Insight:** Analysis is growing in complexity and should live where the data lives (work-prod), not in the CLI client (proj-cli).

**Current State:**
- `proj inv analyze` does basic tech stack detection (~60 lines)
- Limited to local file markers (package.json, pyproject.toml, etc.)
- No dependency analysis, security scanning, or health metrics

**Proposed State:**
- proj-cli: Discovery + export only
- work-prod: Full analysis service with rich capabilities

---

## 🔗 Related Work

- **[Four-Arm Architecture](../four-arm-architecture/README.md)** - Ecosystem context
- **[proj-cli Focused Role](../proj-cli-focused-role/README.md)** - proj-cli scope clarification
- **[Work-prod Integration](../work-prod-integration/README.md)** - API integration patterns

---

## 📊 Status

**Current Phase:** Exploration  
**Next Step:** Conduct research on topics identified in research-topics.md

---

**Last Updated:** 2025-12-22

