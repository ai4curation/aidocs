# Set up GitHub Actions

This guide adds an agent to a repository you already manage on GitHub. It
assumes your content is in the repository and that you have basic quality
control actions running.

By the end you will have three workflows, which is the setup
[GO](../case-studies/go-ontology.md) and [Uberon](../case-studies/uberon.md)
both run.

## Protect the main branch first

Do this before anything else. Once an agent can open pull requests, your branch
protection is what stops unreviewed content reaching your product.

Set these rules on `main` or `master`:

* Require a pull request before merging.
* Require at least one approving review.
* Do not allow anyone to bypass these settings.

## Add the workflows

The quickest route is to let Claude Code do it:

```bash
claude install-github-app
```

This authenticates you and opens a pull request that adds the workflow files.
See the
[Claude Code GitHub Actions documentation](https://docs.claude.com/en/docs/claude-code/github-actions)
for what it creates.

To do it by hand, copy from a repository that already works. All three of these
run [`anthropics/claude-code-action`](https://github.com/anthropics/claude-code-action):

| Workflow | What it does | Copy from |
| --- | --- | --- |
| `ai-agent.yml` | Runs an agent when someone mentions it in an issue or comment | [GO](https://github.com/geneontology/go-ontology/blob/master/.github/workflows/ai-agent.yml) |
| `claude-code-review.yml` | Reviews every pull request | [GO](https://github.com/geneontology/go-ontology/blob/master/.github/workflows/claude-code-review.yml) |
| `copilot-setup-steps.yml` | Prepares the environment for the GitHub Copilot coding agent | [Uberon](https://github.com/obophenotype/uberon/blob/master/.github/workflows/copilot-setup-steps.yml) |

## Add the secrets

Set these at `https://github.com/OWNER/REPO/settings/secrets/actions`.

| Secret | What it is for |
| --- | --- |
| `ANTHROPIC_API_KEY` or `CLAUDE_CODE_OAUTH_TOKEN` | Lets the action call the model. You need one of the two. |
| `PAT_FOR_PR` | A token that lets the agent open pull requests, if the default token is not enough. |

Agent runs cost money. Set a spending limit on the account that owns the key
before you turn on anything that runs on a schedule.

## Write the instructions file

Create `CLAUDE.md` in the repository root. Tell the agent:

* Which file is the editable product, and which files are generated.
* How to search that file, with worked commands.
* Your identifier rules, including the range for new terms.
* The validation command to run before opening a pull request.

[Cell Ontology's `CLAUDE.md`](https://github.com/obophenotype/cell-ontology/blob/master/CLAUDE.md)
is a good short example of the search and identifier sections.

Keep one authoritative file. If you also need `AGENTS.md` or
`.github/copilot-instructions.md`, make them pointers rather than copies. See
[One source of instructions](../patterns/one-source-of-instructions.md).

## Declare your MCP servers in the repository

Add `.mcp.json` so every session gets the same tools without the curator
configuring anything. [EFO](../case-studies/efo.md) declares two:

```json
{
  "mcpServers": {
    "OLS-MCP": {
      "type": "http",
      "url": "http://www.ebi.ac.uk/ols4/api/mcp"
    },
    "artl-mcp": {
      "command": "uvx",
      "args": ["artl-mcp"]
    }
  }
}
```

Ontology term lookup is the one to add first. It is the most common source of
fabricated identifiers, and a lookup tool removes the need to guess. See
[Make identifiers hard to fake](../patterns/ground-identifiers.md).

## Control who can start a run

A mention in an issue comment starts an agent run, and on a public repository
anyone can write that comment. Restrict who can summon the agent before you turn
the workflow on. See
[Guard the untrusted surface](../patterns/guard-untrusted-input.md).

Note also that GitHub does not give repository secrets to workflows triggered
from a fork. Pull requests from forks get no automated review. Decide now
whether you will grant contributors branch access on the origin repository, as
[DisMech](../case-studies/dismech.md) does, or accept that fork contributions
are reviewed by humans only.

## Enable the GitHub Copilot coding agent

Copilot works from issues and produces pull requests inside GitHub, without a
local session. Uberon's
[pull request 3580](https://github.com/obophenotype/uberon/pull/3580) shows the
two files you need to change.

Copilot's agent runs behind a firewall that blocks most external hosts by
default, including `purl.obolibrary.org`. See
[GitHub Copilot](../reference/github-copilot.md) for how to allowlist the hosts
your workflows need.

## Then add validation

Workflows that run agents are the easy half. The half that decides whether this
works is the checking that happens afterwards.

Add term and reference validation to continuous integration before you let
agents open many pull requests. See
[Make identifiers hard to fake](../patterns/ground-identifiers.md) and
[Fast and slow validation](../patterns/fast-and-slow-validation.md).

## Historic: dragon-ai-agent and Goose

Several OBO repositories run an older setup, in which `ai-agent.yml` calls
`dragon-ai-agent` and the agent itself is Goose, configured in
`.config/goose/config.yaml` with a `.goosehints` file for instructions.
[Mondo](../case-studies/mondo.md) still runs this way.

Keep it working where it is deployed. Do not start there. One consequence is
visible in Mondo: subagents defined under `.claude/agents/` are Claude Code
features, so an agent started by a Goose-based workflow cannot reach them.
