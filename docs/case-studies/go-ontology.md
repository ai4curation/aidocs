# GO ontology

The Gene Ontology edit file, with the largest library of agent skills of any
ontology repository we track.

**Repository**: [geneontology/go-ontology](https://github.com/geneontology/go-ontology)
**Product**: `src/ontology/go-edit.obo`
**Agent surface**: GitHub mention, pull request review, local sessions

## What to look at

| Path | What it is |
| --- | --- |
| [`.claude/skills/`](https://github.com/geneontology/go-ontology/tree/master/.claude/skills) | Ten skills, one per recurring job |
| [`.github/workflows/ai-agent.yml`](https://github.com/geneontology/go-ontology/blob/master/.github/workflows/ai-agent.yml) | Runs an agent when someone mentions it in an issue |
| [`.github/workflows/claude-code-review.yml`](https://github.com/geneontology/go-ontology/blob/master/.github/workflows/claude-code-review.yml) | Reviews pull requests |
| [`CLAUDE.md`](https://github.com/geneontology/go-ontology/blob/master/CLAUDE.md) | Repository instructions |

The ten skills are `chemical-entity`, `design-pattern`, `external-term-lookup`,
`mapping`, `odk-make`, `pr-review`, `reaction`, `research`,
`taxon-constraint`, and `term-obsoletion`.

## What works

The skill names map onto jobs a GO editor already recognizes. An editor who has
handled a taxon constraint ticket knows what `taxon-constraint` is for. This
makes the setup readable to curators, not only to developers.

Skills also keep instructions out of the main context. `CLAUDE.md` stays short
because the detail lives in the skill that needs it. See
[Break work into skills](../patterns/skills-before-automation.md).

`odk-make` is worth a look on its own. It wraps the Ontology Development Kit
commands so the agent runs the same build steps an editor runs, instead of
inventing its own.

## What to copy first

Copy the idea, not the files. List the five tickets your editors handle most
often. Write one skill for each. Name each skill after the ticket type.

## Gaps

There is no command or subagent that sequences the skills. Each run plans its
own path from issue to pull request. EFO solves this with an
[orchestrator and a `/efo-ticket` command](efo.md). GO has the workflow wiring
to make the same approach useful.

`CLAUDE.md` and `.github/copilot-instructions.md` hold the same text in two
files. Both need editing by hand when guidance changes. See
[One source of instructions](../patterns/one-source-of-instructions.md).
