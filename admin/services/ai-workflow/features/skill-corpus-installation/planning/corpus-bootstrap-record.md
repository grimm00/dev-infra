# Corpus Bootstrap Record (Task 5)

**Feature:** Skill Corpus Installation (ADR-002)
**Task:** Group 2 / Task 5
**Date:** 2026-06-09

Reproducibility record for the proj-cli nightly bootstrap of the corpus repos.

---

## Nightly pin (the "develop/nightly" used)

| Component | Branch | SHA |
|-----------|--------|-----|
| dev-infra (templates) | develop | `88fc037` |
| proj-cli (generator + expected_skills validation, #31) | develop | `bec1d54` |

## Invocation

```bash
# from ~/Projects/proj-cli (venv)
./venv/bin/proj create agentic-ocean \
  --template standard-project --target-dir ~/Projects --local-only \
  --desc "Core AI-agent corpus: skills, commands, agents (symlink-installed)"

./venv/bin/proj create agentic-ocean-personal \
  --template standard-project --target-dir ~/Projects --local-only \
  --desc "Personal/ad-hoc AI-agent corpus (private)"
```

`--local-only`: no GitHub remote created (reversible; remotes + private-visibility deferred to Task 7 / when ready).

## Result

- `~/Projects/agentic-ocean` and `~/Projects/agentic-ocean-personal` created, git-init'd (`main`, **no initial commit yet** — generated files untracked).
- `.dev-infra.yml` generated with the 13 core `expected_skills` (Group 4 output). expected_skills validation ran **warn-not-error** and was clean (the listed skills are installed locally).

---

## Findings / open decisions for Task 6

1. **standard-project over-scaffolds.** It's an *application* template — it generated `backend/`, `frontend/`, `tests/`, `scripts/`, `.github/`, `start.txt`. A corpus repo needs a flat `skills/ commands/ agents/`. **Decision needed:** trim the app scaffolding (backend/frontend/tests) during Task 6, or reconsider whether a corpus should be proj-cli-generated at all vs a leaner skeleton. (The dogfooding value — exercising the nightly template + validation — was still achieved.)
2. **Unsubstituted placeholders:** `[DEV_INFRA_VERSION]` / `[CREATED_DATE]` in `.dev-infra.yml` (same gap noted in skill-template-separation Group 4 — `new-project.sh`/proj-cli don't substitute them). Minor; fix when populating.
3. **No initial commit** — repos are git-init'd but empty. First commit happens after structure is settled (trim + migrate, Task 6).

---

**Last Updated:** 2026-06-09
