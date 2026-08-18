# Uberon

The multi-species anatomy ontology. Uberon splits agent work across eight
subagents instead of skills.

**Repository**: [obophenotype/uberon](https://github.com/obophenotype/uberon)
**Product**: `src/ontology/uberon-edit.obo`
**Agent surface**: GitHub mention, pull request review, local sessions

## What to look at

| Path | What it is |
| --- | --- |
| [`.claude/agents/`](https://github.com/obophenotype/uberon/tree/master/.claude/agents) | Eight subagents |
| [`.github/workflows/ai-agent.yml`](https://github.com/obophenotype/uberon/blob/master/.github/workflows/ai-agent.yml) | Runs an agent on a GitHub mention |
| [`CLAUDE.md`](https://github.com/obophenotype/uberon/blob/master/CLAUDE.md) | Repository instructions |

The subagents are `deep-research-specialist`, `design-pattern-advisor`,
`identifier-validator`, `metadata-checker`, `ntr-term-researcher`,
`ontology-reasoner`, `ontology-term-lookup`, and `task-coordinator`.

## What works

A subagent runs in its own context and returns a result. This suits jobs that
read a lot and report a little. `deep-research-specialist` can read twenty
papers and hand back three sentences, and the main session never carries the
twenty papers.

`identifier-validator` and `metadata-checker` are checkers. They run after the
edit and look for problems. Splitting the checker from the editor is useful:
the checker has no stake in the edit being correct.

`ntr-term-researcher` handles new term requests, the most common ticket type in
an anatomy ontology. Uberon named a subagent after its highest-volume job.

## What to copy first

Take `identifier-validator` and `metadata-checker`. They are the two subagents
that transfer to any OBO ontology with the least change. Mondo already runs
both.

## Gaps

Uberon has one skill and eight subagents. Mondo has six subagents with four of
the same names. Neither repository states whether the shared subagents are kept
in sync or were copied once and left to drift. If you copy them, record where
you copied them from.

`CLAUDE.md` and `.github/copilot-instructions.md` hold the same text. See
[One source of instructions](../patterns/one-source-of-instructions.md).
