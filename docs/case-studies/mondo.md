# Mondo

The Mondo Disease Ontology. Mondo is the clearest example of a repository whose
automated agent and whose subagent library are on different tracks.

**Repository**: [monarch-initiative/mondo](https://github.com/monarch-initiative/mondo)
**Product**: `src/ontology/mondo-edit.obo`
**Agent surface**: GitHub mention through dragon-ai-agent, local Claude Code sessions

## What to look at

| Path | What it is |
| --- | --- |
| [`.github/workflows/ai-agent.yml`](https://github.com/monarch-initiative/mondo/blob/master/.github/workflows/ai-agent.yml) | The automated agent, built on dragon-ai-agent and Goose |
| [`.claude/agents/`](https://github.com/monarch-initiative/mondo/tree/master/.claude/agents) | Six subagents for Claude Code |
| [`.config/goose/`](https://github.com/monarch-initiative/mondo/tree/master/.config/goose) | Goose configuration used by the workflow |
| [`CLAUDE.md`](https://github.com/monarch-initiative/mondo/blob/master/CLAUDE.md) | Repository instructions |

The subagents are `deep-research-specialist`, `design-pattern-advisor`,
`identifier-validator`, `metadata-checker`, `ontology-reasoner`, and
`task-coordinator`. Four of these names also appear in
[Uberon](uberon.md).

## What works

Mondo has run agent-assisted curation longer than most of the repositories on
this site. Its issue tracker is a good place to read real agent pull requests
from end to end, including the ones that went wrong:
[issues involving dragon-ai-agent](https://github.com/monarch-initiative/mondo/issues?q=involves%3Adragon-ai-agent).

The subagents are a working library. If you want a starting set for an OBO
ontology, read Mondo's and Uberon's together and take the four they share.

## What to copy first

Read the merged agent pull requests before you copy any configuration. Mondo has
enough history to show you what agent output looks like after review, which is
more useful than any template.

## Gaps

The only automated agent workflow runs dragon-ai-agent and Goose. The six
subagents under `.claude/agents/` are Claude Code features. An agent triggered
by `ai-agent.yml` therefore cannot reach them. They are available in local
Claude Code sessions only.

This is not necessarily wrong, but it is undocumented. If you have both, say in
`CLAUDE.md` which surface each one serves. If you want the subagents reachable
from GitHub, add a workflow that runs Claude Code the way
[GO](go-ontology.md) and [Uberon](uberon.md) do.

Goose is no longer a tool we recommend for new setups. See
[Harnesses](../reference/harnesses.md).
