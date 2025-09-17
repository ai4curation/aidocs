# How to create an AI agent for GitHub actions

This assumes that you are already using GitHub as your source of truth for
content, O3-guidelines style.

It also assumes you have some familiarity with GitHub actions, and
have basic QC actions set up. If you are managing an ODK-compliant
repo this is certainly the case.

# IMPORTANT - GitHub repo configuration
When using AI agents, ensure that your `main` repository branch has [GitHub branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches) enabled. Specifically, the `main` branch should have at least these settings configured:
- Require pull request reviews before merging
- Require at least one PR reviewer to approve the PR
- Do not allow bypassing the above settings

## Quick setup with Claude Code

If you have [Claude Code](../reference/clients/claude-code.md) installed, you can use the `install-github-app` command for a streamlined setup process. This command will authenticate you and create a pull request with GitHub Actions configuration:

```bash
claude install-github-app
```

This approach automatically handles authentication and creates the necessary GitHub Actions workflow for you. For more details, see the [Claude Code GitHub Actions documentation](https://docs.anthropic.com/en/docs/claude-code/github-actions).

If you prefer manual setup or need more customization, continue with the manual configuration steps below.

## Set up `ai.yml`

This might look something like this:

https://github.com/monarch-initiative/mondo/blob/master/.github/workflows/ai-agent.yml

```yaml
name: Dragon AI Agent GitHub Mentions

on:
  issues:
    types: [opened, edited]
  issue_comment:
    types: [created, edited]
  pull_request:
    types: [opened, edited]
  pull_request_review_comment:
    types: [created, edited]

jobs:
  check-mention:
    runs-on: ubuntu-latest
    outputs:
      qualified-mention: ${{ steps.detect.outputs.qualified-mention }}
      prompt: ${{ steps.detect.outputs.prompt }}
      user: ${{ steps.detect.outputs.user }}
      item-type: ${{ steps.detect.outputs.item-type }}
      item-number: ${{ steps.detect.outputs.item-number }}
      controllers: ${{ steps.detect.outputs.controllers }}
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        
      - name: Detect AI mention
        id: detect
        uses: dragon-ai-agent/github-mention-detector@v1.0.0
        with:
          github-token: ${{ secrets.PAT_FOR_PR }}
          fallback-controllers: 'cmungall'

  respond-to-mention:
    needs: check-mention
    if: needs.check-mention.outputs.qualified-mention == 'true'
    permissions:
      contents: write
      pull-requests: write
      issues: write
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          token: ${{ secrets.PAT_FOR_PR }}

      - name: Respond with AI Agent
        uses: dragon-ai-agent/run-goose-obo@v1.0.4
        with:
          anthropic-api-key: ${{ secrets.ANTHROPIC_API_KEY }}
          openai-api-key: ${{ secrets.CBORG_API_KEY }}
          github-token: ${{ secrets.PAT_FOR_PR }}
          prompt: ${{ needs.check-mention.outputs.prompt }}
          user: ${{ needs.check-mention.outputs.user }}
          item-type: ${{ needs.check-mention.outputs.item-type }}
          item-number: ${{ needs.check-mention.outputs.item-number }}
          controllers: ${{ needs.check-mention.outputs.controllers }}
          agent-name: 'Dragon-AI Agent'
          branch-prefix: 'dragon_ai_agent'
          robot-version: 'v1.9.7'
```

This assumes using [goose-ai-obo-action](https://github.com/ai4curation/goose-ai-obo-action/)

## Set up repository secrets

The URL should be something like `https://github.com/monarch-initiative/mondo/settings/secrets/actions`

A typical setup might include:

* `ANTHROPIC_API_KEY`
* `CBORG_API_KEY`
* `PAT_FOR_PR`

The key names will correspond to what you have in the action.yml above

## Configure the agent, including default MCPs

Create a folder `.config/[goose](../glossary.md#goose)` with a file `config.yaml`.

Examples:

- [.config/goose for Mondo](https://github.com/monarch-initiative/mondo/tree/master/.config/goose)

Here is an example:

```yaml
OPENAI_HOST: https://api.cborg.lbl.gov
OPENAI_BASE_PATH: v1/chat/completions
GOOSE_MODEL: anthropic/[claude-sonnet](../glossary.md#claude)
GOOSE_PROVIDER: openai
extensions:
  developer:
    bundled: true
    display_name: Developer
    enabled: true
    name: developer
    timeout: 300
    type: builtin
  git:
    args:
    - mcp-server-git
    bundled: null
    cmd: uvx
    description: Git version control system integration
    enabled: false
    env_keys: []
    envs: {}
    name: git
    timeout: 300
    type: stdio
  memory:
    bundled: true
    display_name: Memory
    enabled: true
    name: memory
    timeout: 300
    type: builtin
  owlmcp:
    args:
    - owl-mcp
    bundled: null
    cmd: uvx
    description: ''
    enabled: false
    env_keys: []
    envs: {}
    name: owlmcp
    timeout: 300
    type: stdio
  pdfreader:
    args:
    - mcp-read-pdf
    bundled: null
    cmd: uvx
    description: Read large and complex PDF documents
    enabled: false
    env_keys: []
    envs: {}
    name: pdfreader
    timeout: 300
    type: stdio
```

The `extensions` section defines the default MCP plugins.

This setup is configured to use Anthropic claude-sonnet via a LiteLLM proxy (CBORG):

```yaml
OPENAI_HOST: https://api.cborg.lbl.gov
OPENAI_BASE_PATH: v1/chat/completions
GOOSE_MODEL: anthropic/claude-sonnet
GOOSE_PROVIDER: openai
```

You can use a similar setup for your own LiteLLM proxy if you have one. Note: if you find this complex, please upvote [this issue](https://github.com/block/goose/issues/2507).

Things are easier if you just want to talk straight to a provider like Anthropic, no proxy, all you need is `GOOSE_MODEL`. But note that this likely means you are using a personal API key. Be aware that agentic AI usage can be costly.

## Set up .goosehints

For many of my repos, I have a `CLAUDE.md` and I symlink `.goosehints` to that, because I am too lazy to write different instructions for different agents. In practice it might be better to tune instructions.

What you put in there depends on your own use case. Do careful evaluations if you can't, but otherwise do vibe tests and iterate.

Some examples here:

- [CLAUDE.md on Mondo](https://github.com/monarch-initiative/mondo/blob/master/CLAUDE.md)


## NEW: enable GitHub copilot to do reviews and PRs

Change two files, as documented here:

https://github.com/obophenotype/uberon/pull/3580


