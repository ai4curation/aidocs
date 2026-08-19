# EFO

The Experimental Factor Ontology. EFO treats the main agent as an orchestrator
that routes work to specialists, and keeps one review checklist for three
different agent runtimes.

**Repository**: [EBISPOT/efo](https://github.com/EBISPOT/efo)
**Product**: `src/ontology/efo-edit.owl`
**Agent surface**: local sessions, started with a command

## What to look at

| Path | What it is |
| --- | --- |
| [`CLAUDE.md`](https://github.com/EBISPOT/efo/blob/master/CLAUDE.md) | The orchestrator role and its routing table |
| [`AGENTS.md`](https://github.com/EBISPOT/efo/blob/master/AGENTS.md) | A short pointer to the authoritative files |
| [`.claude/agents/`](https://github.com/EBISPOT/efo/tree/master/.claude/agents) | Specialist subagents |
| [`.github/agents/`](https://github.com/EBISPOT/efo/tree/master/.github/agents) | The same specialists for GitHub Copilot |
| [`.claude/commands/`](https://github.com/EBISPOT/efo/tree/master/.claude/commands) | Commands, including `/efo-ticket` |
| [`.mcp.json`](https://github.com/EBISPOT/efo/blob/master/.mcp.json) | Two MCP servers: OLS and artl-mcp |
| `docs/agents-documentation/efo-pr-review-checklist.md` | One review checklist, shared by three reviewers |

## What works

**`CLAUDE.md` gives the agent a role.** It says the agent is the orchestrator,
then gives a table of which specialist handles which kind of request. Most
repositories describe the project; EFO describes the job.

**`AGENTS.md` is a pointer, not a copy.** It is about twenty lines and it names
`.github/copilot-instructions.md` and `CLAUDE.md` as the authoritative sources.
Nothing has to be kept in sync by hand. Every other Block A repository
duplicates its instructions across two files. See
[One source of instructions](../patterns/one-source-of-instructions.md).

**One checklist, three reviewers.** The Claude, Copilot, and Codex reviewers all
apply `docs/agents-documentation/efo-pr-review-checklist.md`. The Codex reviewer
has its own procedure file that points at the same checklist. When the review
standard changes, one file changes.

**`/efo-ticket <issue-number>` is a front door.** A curator does not have to
describe the workflow. The command holds it.

**MCP servers are declared in the repository.** `.mcp.json` gives every session
the same two tools: the EBI Ontology Lookup Service over HTTP, and `artl-mcp`
for literature. Curators do not configure these themselves.

## What to copy first

Copy `AGENTS.md`. It is the cheapest fix on this site: replace your duplicated
instructions file with a pointer, and the drift problem disappears today.

After that, copy the shared review checklist. One file that all your reviewers
read is worth more than three reviewers with three standards.

## Gaps

EFO has no workflow that runs an agent when someone mentions it on an issue. The
orchestrator and its specialists are reachable from a local session only. GO,
Uberon, and Cell Ontology all have that surface. This looks like a deliberate
choice, but it means EFO issues do not get agent responses.

The specialists exist twice, once under `.claude/agents/` and once under
`.github/agents/`, with names that differ only in case. The two sets can drift.
The review checklist shows the fix EFO already knows: one authoritative file,
referenced from both places.
