# AGENTS.md Spike Test Plan

**Purpose:** Empirical test of AGENTS.md behavior in Cursor
**Date:** 2026-03-25

## Test 1: Auto-Loading

Create `AGENTS.md` at workspace root with a distinctive marker phrase.
Ask the agent "What is the spike canary phrase?" -- if it answers correctly,
AGENTS.md was auto-loaded.

**Marker:** "SPIKE-CANARY-ALPHA-7"

## Test 2: File Reference Following

Add a section to AGENTS.md that says:
"For detailed workflow conventions, see `admin/explorations/agentic-workflow-modernization/spike/referenced-conventions.md`"

Create that file with distinctive content. Ask the agent about conventions.
Does it read the referenced file?

## Test 3: Interaction with .mdc Rules

Check whether AGENTS.md content appears alongside the existing `.cursor/rules/*.mdc`
content, or if one overrides the other.

## Test 4: Subdirectory AGENTS.md

Create `admin/AGENTS.md` with a different marker. Navigate to a file in `admin/`.
Does the subdirectory AGENTS.md load?
