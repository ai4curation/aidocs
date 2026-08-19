# Break work into skills

**Use it when** the same instructions keep getting repeated.

A skill is a folder with a `SKILL.md` file that describes one job. The agent
loads it when the job comes up, and ignores it otherwise. This keeps the main
instructions file short and gives each recurring task a place to live.

## The pattern

Name skills after the work, not after the technology. A curator should
recognize the name.

[GO](../case-studies/go-ontology.md) has ten skills, and the names are ticket
types: `taxon-constraint`, `term-obsoletion`, `design-pattern`,
`external-term-lookup`. An editor who has handled one of those tickets knows
what the skill does.

Write a skill when you notice yourself explaining the same thing twice.

## Automation without decomposition does not work well

[Cell Ontology](../case-studies/cell-ontology.md) is the example to learn from.
It has two workflows sending real work to an agent and no skills, subagents, or
commands. Every run starts from the same general instructions and plans its own
approach.

The symptom shows up in the instructions file. Cell Ontology's `CLAUDE.md`
contains this:

> DO NOT bother doing your own greps over the file, or looking for other files,
> unless otherwise asked, you will just waste time.

That is a fix for something that went wrong, written as a prohibition.
Prohibitions accumulate and start to conflict. A skill tells the agent what to
do instead, and composes with the others.

## Skills or subagents?

Both split work up. They are not the same.

| | Skill | Subagent |
| --- | --- | --- |
| Runs in | The current session | Its own context |
| Good for | A job that needs specific instructions | A job that reads a lot and reports a little |
| Cost | Instructions loaded on demand | A separate run |

[Uberon](../case-studies/uberon.md) uses subagents for research and checking.
`deep-research-specialist` can read twenty papers and return three sentences,
and the main session never carries the twenty papers.

Use a subagent when you want the reading kept out of the main context. Use a
skill for everything else.

## Who does this

* [GO](../case-studies/go-ontology.md): ten skills, no subagents.
* [Uberon](../case-studies/uberon.md): eight subagents, one skill.
* [DisMech](../case-studies/dismech.md): seventeen skills, including one that
  holds the pull request review rubric.
* [AI Gene Review](../case-studies/ai-gene-review.md): fifteen skills, split
  between reviewing and synthesizing.

## Read more

* [Create curation skills](../how-tos/author-skills.md)
