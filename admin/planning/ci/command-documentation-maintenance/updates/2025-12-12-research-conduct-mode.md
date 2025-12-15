# Command Documentation Update: `/research` - Add Conduct Mode

**Command:** `/research`  
**Date:** 2025-12-12  
**Source:** User feedback during experimental-template research setup  
**Status:** ✅ Complete

---

## 📋 Overview

This document details the update to the `/research` command to add a `--conduct` flag that actually performs research, as opposed to the default behavior which only creates research structure/scaffolding.

---

## 🤔 Problem Discovered

During the `/research --from-explore experimental-template` execution, it became apparent that the command only creates research document templates but does not actually conduct research. This is misleading because:

1. The command is named "research" but doesn't research
2. Users expect research to be conducted, not just scaffolded
3. There was no clear path for actually filling in research findings

The original behavior is more accurately described as "research prep" or "research setup".

---

## 🎯 Solution

Added a `--conduct` flag that enables **Conduct Mode**, which actually performs research:

**Two Modes:**

| Mode | Flag | Purpose |
|------|------|---------|
| **Setup Mode** | Default (no flag) | Creates research structure and templates |
| **Conduct Mode** | `--conduct` | Actually performs research using web search |

**New Options:**

- `--conduct` - Enable Conduct Mode
- `--topic-num [N]` - Research specific topic by number (with --conduct)
- `--topic-name [name]` - Research specific topic by name (with --conduct)

---

## 📝 Changes Made

### 1. Updated Command Description

Changed from:
> "Creates research documents for each research topic/question"

To:
> "Has two modes: Setup Mode (creates structure) and Conduct Mode (actually performs research)"

### 2. Updated Workflow Overview

Added clear distinction between Setup Mode and Conduct Mode workflows.

### 3. Updated Usage Section

Added Conduct Mode examples:
```bash
/research experimental-template --conduct
/research experimental-template --conduct --topic-num 1
/research experimental-template --conduct --topic-name user-demand
```

### 4. Added Conduct Mode Workflow Section

New comprehensive section covering:
1. Identify Research to Conduct
2. Conduct Web Research
3. Fill In Research Document
4. Update Research Status
5. Update Summary and Requirements
6. Update Hub Status
7. Commit Research Results

### 5. Updated Common Scenarios

Added new scenarios:
- Scenario 3: Conduct All Research
- Scenario 4: Conduct Single Topic

### 6. Updated Tips Section

Added guidance on when to use each mode.

---

## 🚀 Impact

Users can now:

1. **Setup Mode:** Create research structure when planning
2. **Conduct Mode:** Actually perform research when ready
3. **Incremental:** Research one topic at a time using `--topic-num`
4. **Web Search:** Conduct Mode explicitly uses web search for findings

---

## 📚 Usage Examples

**Full Workflow:**

```bash
# Step 1: Setup (creates structure)
/research experimental-template --from-explore experimental-template

# Step 2: Conduct (fills in findings)
/research experimental-template --conduct

# Or incrementally:
/research experimental-template --conduct --topic-num 1
/research experimental-template --conduct --topic-num 2
```

---

## 🔗 Related

- **Command File:** `.cursor/commands/research.md`
- **Trigger:** `/research --from-explore admin/explorations/experimental-template/exploration.md`

---

**Last Updated:** 2025-12-12

