# Explore Two-Mode - Phase 2: Input Sources

**Phase:** 2 - Input Sources  
**Duration:** ~2 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete, ADR-002 approved

---

## 📋 Overview

Implement multiple input sources with raw text as primary, enabling `/explore` to serve as the "thought organizer" entry point for the ideation pipeline.

**Success Definition:** `/explore` accepts raw text, start.txt, and reflection documents as input sources.

---

## 🎯 Goals

1. **Raw Text Input** - Accept inline text or file as primary input
2. **start.txt Integration** - Add `--from-start` flag
3. **Reflection Integration** - Add `--from-reflect` flag
4. **Theme Organization** - Extract themes from unstructured input
5. **Question Extraction** - Identify research questions from input

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan explore-two-mode --expand --phase 2` to add detailed TDD tasks.

### Task Categories

- [ ] **Raw Text Handling** - Implement inline and file input parsing
- [ ] **start.txt Flag** - Add `--from-start` source option
- [ ] **Reflection Flag** - Add `--from-reflect` source option
- [ ] **Theme Extraction** - Organize unstructured input into themes
- [ ] **Question Extraction** - Identify questions from input

---

## ✅ Completion Criteria

- [ ] `/explore "raw thoughts..."` processes inline text
- [ ] `/explore --input file.txt` reads from file
- [ ] `/explore --from-start` reads project's start.txt
- [ ] `/explore --from-reflect [file]` reads reflection suggestions
- [ ] Themes organized in scaffolding output
- [ ] Questions extracted to research-topics.md

---

## 📦 Deliverables

- Input source handling in explore.md
- Theme extraction logic
- Question extraction logic
- Updated command documentation

---

## 🔗 Dependencies

### Prerequisites

- Phase 1: Command Structure (complete)
- ADR-002: Input Sources (approved)

### Blocks

- Phase 4: Template Updates (needs input source logic)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [ADR-002](../../../decisions/explore-two-mode/adr-002-input-sources.md)

---

**Last Updated:** 2026-01-10  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan explore-two-mode --expand --phase 2`
