# Decisions Summary — Skill-Template Separation

**Status:** 🔴 All Proposed (awaiting acceptance)
**Created:** 2026-05-20

---

## At a Glance

| ADR | Decision | Key Consequence |
|-----|----------|-----------------|
| [001](adr-001-separation-model.md) | Corpus is a separate repo; templates carry manifest only | Templates shrink 91%; drift eliminated |
| [002](adr-002-installation-architecture.md) | Symlink farm + three-tier distribution | Zero-friction dev; plugin publish deferred |
| [003](adr-003-per-repo-profile-schema.md) | Unified profile at `~/.config/ai-workflow/repos/` | Skills stop hardcoding paths; one config per repo |

---

## Dependency Order

```
ADR-001 (what separates) → ADR-002 (how it installs) → ADR-003 (how skills find config)
```

ADR-001 is foundational — the other two assume the corpus is its own repo. ADR-003 can proceed in parallel with ADR-002 (profile schema doesn't depend on installer mechanics).

---

## Requirements Coverage

| Category | Total reqs | Covered by ADRs | Deferred (Topics 5,7,8,9) |
|----------|-----------|-----------------|---------------------------|
| FR | 25 | 23 | 2 (MVPC-4 README, MVPC-5 no pre-built structure — implementation details) |
| NFR | 10 | 10 | 0 |
| C | 9 | 9 | 0 |

---

## Open Items After Acceptance

1. **Spike:** Confirm skills load via symlinks in Cursor (5-minute test, de-risks C-INST-1)
2. **Spike:** Generate a minimal template (7-9 files) and test agent operability (validates Topic 1)
3. **Implementation:** Create corpus repo, move skills, run installer
4. **Implementation:** Add `expected_skills` field to `.dev-infra.yml` schema
5. **Implementation:** Build profile migration for ticket-intake (backwards-compat fallback)
6. **Cleanup:** Retire `template-sync-manifest.txt`; remove bundled skills from template tree

---

## Next Steps

- Owner reviews and accepts/rejects each ADR
- On acceptance: status → ✅ Accepted, proceed to `/write-plan-setup` for implementation planning
- Deferred research topics (5, 7, 8, 9) may amend these ADRs later but don't block implementation of the core architecture
