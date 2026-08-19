# Cell Ontology

Cell Ontology runs two agent workflows and has no skills, subagents, or
commands. It is the most useful negative example on this site.

**Repository**: [obophenotype/cell-ontology](https://github.com/obophenotype/cell-ontology)
**Product**: `src/ontology/cl-edit.owl`
**Agent surface**: GitHub mention, pull request review

## What to look at

| Path | What it is |
| --- | --- |
| [`CLAUDE.md`](https://github.com/obophenotype/cell-ontology/blob/master/CLAUDE.md) | The whole agent configuration |
| [`.github/workflows/ai-agent.yml`](https://github.com/obophenotype/cell-ontology/blob/master/.github/workflows/ai-agent.yml) | Runs an agent on a GitHub mention |
| [`.github/workflows/clara-review.yml`](https://github.com/obophenotype/cell-ontology/blob/master/.github/workflows/clara-review.yml) | Reviews pull requests |

## What works

There is one instructions file. Most repositories in
[Block A](index.md#block-a-ontologies) keep the same text in both `CLAUDE.md`
and `.github/copilot-instructions.md` and have to edit both. Cell Ontology does
not have that problem.

`CLAUDE.md` is specific about search. It tells the agent that `cl-edit.owl` has
one axiom per line, and gives exact `grep` commands for finding a term by
identifier and by label. Concrete commands beat general advice.

It is also specific about identifiers. New term requests use the `CL_99xxxxx`
range, defined in `src/ontology/cl-idranges.owl`, and the file says never to
guess a term identifier or a PubMed identifier.

## What to copy first

Copy the search section. Three worked `grep` examples against your own edit file
will save more agent time than a page of prose.

## Gaps

Two workflows send real work to the agent, and nothing underneath breaks that
work into parts. Every run starts from the same general instructions.

`CLAUDE.md` contains this line:

> DO NOT bother doing your own greps over the file, or looking for other files,
> unless otherwise asked, you will just waste time.

That is a fix for something that went wrong once, written as a prohibition. A
search skill would do the same job and would also tell the agent what to do
instead of what to avoid. Prohibitions accumulate; skills compose.

Of the repositories we track, this one would gain the most from a small set of
skills. [Uberon's](uberon.md) `identifier-validator` and `metadata-checker` are
a reasonable starting pair.
