# Design: Agentic Workflow Modernization

**Purpose:** Holistic design for the agentic workflow modernization feature  
**Status:** 🔴 Not Started (stub -- pending remaining research and decisions)  
**Created:** 2026-04-02  
**Last Updated:** 2026-04-02

---

## Quick Links

### Design Artifacts

- **[decision-interview.md](../../decisions/agentic-workflow-modernization/decision-interview.md)** -- Human priorities interview (🔴 Awaiting human input -- in decisions directory)
- **[design.md](design.md)** -- Design document (🔴 Stub -- section headings only)

### Pipeline Context

- **[Exploration](../../explorations/agentic-workflow-modernization/exploration.md)** -- 10 themes, constraints, spike determinations
- **[Research Topics](../../explorations/agentic-workflow-modernization/research-topics.md)** -- 11 topics (4 complete, 7 pending)
- **[Research](../../research/agentic-workflow-modernization/)** -- Completed topic findings (Topics 1-4)
- **[Requirements (Final)](../../research/agentic-workflow-modernization/requirements.md)** -- 22 FRs, 3 NFRs, 4 Constraints, 2 Assumptions (consolidated 2026-04-10)
- **Decisions** -- (pending -- after interview + decision clustering)

---

## Why This Directory Exists

This is the first use of the "design step" pattern identified in a /discuss session (2026-04-02). The observation: the pipeline from research → decision → transition-plan has a gap where holistic system design should happen.

Research produces per-topic findings and requirements. Decision picks an approach. But neither answers "how does this all work together as a coherent system?" or "in what order do we build it so the system is usable at every intermediate step?" That's what the design document addresses.

**Current step:** Fill out [decision-interview.md](../../decisions/agentic-workflow-modernization/decision-interview.md) with your priorities, then bring it to a `/decision` session. The agent uses your answers to cluster requirements, present options, and scope v1.

**When to fill in the design document:** After decisions are made. The design composes individual decisions and requirements into a coherent system with staging.

**See also:** [Design Step in Pipeline (int-opp)](../../planning/opportunities/internal/dev-infra/improvements/design-step-in-pipeline.md) -- The systemic observation that the pipeline needs a design step for all features, not just this one.

---

**Last Updated:** 2026-04-02
