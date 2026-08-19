# How to integrate AI into your [Knowledge Base](../glossary.md#knowledge-base-kb)

This is a high level advanced guide for maintainers of knowledge bases with some high level pointers on how to start effectively using AI to enhance curation.

## Tip 1: No fancy frameworks needed - just simple MCPs or command line tools

Intimidated by the growing number of agent frameworks? Don't worry, you don't need
most of these.

All you really need are a handful of simple [MCPs](../glossary.md#model-context-protocol-mcp) servers or command line tools. These can be hooked up to generic frameworks.

The command line tools could be wrapped in a Docker container; this is the strategy for [ODK-AI](https://ai4curation.github.io/odk-ai/).

You should rely on existing tools for doing things like literature search - you only need to write MCPs that are specific to read/write/validation on your KB.

This is much easier if you follow [O3 guidelines](../glossary.md#o3-guidelines) and manage your content in GitHub. In fact if your content is small enough, you might not need any new tools!

## Tip 2: Keep AI instructions checked in at the root of your GitHub repo

Examples:

 - [CLAUDE.md in Uberon repo](https://github.com/obophenotype/uberon/blob/master/CLAUDE.md)

## Tip 3: Let curators run agents in the cloud

The two things that stop curators are installing software and getting access to
a model. Both go away if you point them at a browser.

[Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web)
clones the repository, runs the session in a cloud container, and opens the pull
request. A curator needs a paid Claude plan and write access to your repository.

For a whole team at once, a shared hosted environment removes the account
problem as well. The Gene Ontology consortium runs a JupyterHub instance for its
workshops, where each participant gets a workspace with an agent already
configured and no key of their own.

Whichever route you choose, write down the setup steps in your repository.
DisMech's [`CONTRIBUTING.md`](https://github.com/monarch-initiative/dismech/blob/main/CONTRIBUTING.md)
is a good model: it covers the environment configuration, the network access
setting, and the environment variables its tools need.

We previously recommended Goose here. We no longer do for new setups. See
[Harnesses](../reference/harnesses.md).

## Tip 4: Validate agent outputs automatically

Agents hallucinate ontology terms and fabricate citations. Add automated validation to catch these before review:

- **[linkml-term-validator](https://github.com/linkml/linkml-term-validator)** — checks that ontology terms in agent outputs actually exist
- **[linkml-reference-validator](https://github.com/linkml/linkml-reference-validator)** — checks that cited references contain the claimed supporting text

These can run as CI checks on agent-generated pull requests.

## Tip 5: Track what the agent changed

Use **[ai-blame](https://github.com/ai4curation/ai-blame)** to extract [provenance](../glossary.md#provenance) from agent execution traces. This gives you line-level attribution — essential for understanding what the agent did and what a human did.

## Tip 6: Use MCP servers for domain-specific tool access

Rather than having agents manipulate ontology files as raw text, give them structured tool access through [MCP](../glossary.md#model-context-protocol-mcp) servers:

- **[noctua-mcp](https://github.com/geneontology/noctua-mcp)** — GO-CAM editing via Noctua/Barista
- **[oak-mcp](https://github.com/monarch-initiative/oak-mcp)** — ontology operations via OAK

## Tip 7: Think in terms of a harness, not just an agent

Effective AI curation isn't about picking the right model — it's about building the right infrastructure around it. This infrastructure is called an [agent harness](../glossary.md#agent-harness). For a complete guide to assembling one, see [Build your agentic harness](build-agentic-harness.md).

## Set up [GitHub actions](../glossary.md#github-actions)

See some of the actions in this org. Again this works best if your content is managed
according to O3 guidelines. See [Set up GitHub Actions](set-up-github-actions.md) for details.

## Document and Train

## Continuous evaluation.
