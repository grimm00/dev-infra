# ADR-004: Sourcery Configuration for Documentation

**Status:** ✅ Accepted  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## Context

With self-contained feature branches (ADR-002), PRs now include both code and documentation. Sourcery currently reviews all files, including documentation, which creates noise:
- Documentation comments distract from code issues
- Process docs (`admin/**`) aren't code and shouldn't be "reviewed"
- Sourcery quota is used on non-code content

**Related Research:**
- [research-sourcery-yml-configuration.md](../../research/worktree-feature-workflow/research-sourcery-yml-configuration.md)

**Related Requirements:**
- FR-14: Create .sourcery.yaml
- FR-15: Sourcery Ignore admin/**
- FR-16: Include in Templates
- FR-17: Add to Template Sync Manifest
- NFR-5: Sourcery Ignore Process Docs
- NFR-8: No Code Analysis Impact

---

## Decision

**Create `.sourcery.yaml` that ignores process documentation.**

### Configuration

```yaml
# .sourcery.yaml
ignore:
  - admin/**
  - tmp/**
```

### What Gets Ignored

| Path | Reason |
|------|--------|
| `admin/**` | Process docs (explorations, research, decisions, planning) |
| `tmp/**` | Temporary files (handoff docs, scratch) |

### What Gets Reviewed

| Path | Reason |
|------|--------|
| `scripts/**` | Automation code |
| `tests/**` | Test code |
| `templates/**` | Template structure (code patterns) |
| `docs/**` | User documentation (optional - may add if noisy) |

---

## Consequences

### Positive

- **Focused reviews:** Sourcery focuses on code, not process docs
- **Less noise:** No comments on markdown structure
- **Quota preserved:** Sourcery API calls used for code only
- **Holistic PRs still work:** Code + docs in same PR, only code reviewed

### Negative

- **No doc review:** Sourcery won't catch markdown issues
- **Config maintenance:** Must update if paths change

---

## Alternatives Considered

### Alternative 1: No .sourcery.yaml

**Description:** Let Sourcery review everything.

**Pros:**
- No configuration needed
- Sourcery might catch doc issues

**Cons:**
- Noisy reviews with doc comments
- Quota used on non-code
- Distracts from real code issues

**Why not chosen:** Research confirmed doc comments create noise (PR #58).

---

### Alternative 2: Ignore all .md files

**Description:** Ignore by extension: `**/*.md`

**Pros:**
- Simple pattern
- Covers all markdown

**Cons:**
- Might miss code in docs
- Too broad (ignores READMEs in code dirs)

**Why not chosen:** Path-based ignoring is more precise.

---

### Alternative 3: Ignore docs/** too

**Description:** Also ignore user documentation.

**Pros:**
- Even less noise

**Cons:**
- Might miss doc issues
- User docs should have some review

**Why not chosen:** User docs may benefit from review; can add later if noisy.

---

## Decision Rationale

**Key Insight from Research:**
> Ignoring docs does NOT affect code analysis quality.

Sourcery's code analysis (refactoring suggestions, bug detection) is unaffected by ignoring markdown files.

**Key Factors:**
1. **Focused feedback:** Only code gets reviewed
2. **Proven problem:** PR #58 showed doc noise
3. **No downside:** Code analysis unchanged
4. **Template consistency:** Same config in all projects

---

## Implementation

1. Create `.sourcery.yaml` in dev-infra root
2. Create `.sourcery.yaml` in both templates
3. Add `.sourcery.yaml` to template sync manifest
4. Verify Sourcery ignores `admin/**` on next PR

### Dev-Infra

```yaml
# .sourcery.yaml
ignore:
  - admin/**
  - tmp/**
```

### Templates

```yaml
# templates/standard-project/.sourcery.yaml
# templates/learning-project/.sourcery.yaml
ignore:
  - docs/maintainers/**
  - tmp/**
```

---

## References

- [Research: sourcery.yml Configuration](../../research/worktree-feature-workflow/research-sourcery-yml-configuration.md)
- [Requirements Document](../../research/worktree-feature-workflow/requirements.md)
- [PR #58 Feedback](../../feedback/sourcery/pr58.md)

---

**Last Updated:** 2026-01-09
