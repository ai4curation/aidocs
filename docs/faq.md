# Frequently Asked Questions

## General Questions

### What is AI4Curators?

AI4Curators provides practical guides for curators and maintainers of knowledge
bases who want to use AI agents in the workflows they already have.

We do not centralize guidance. We point at repositories that run agents on real
curation work and explain what they do, so you can copy a working setup. See
[Case studies](case-studies/index.md).

This repository is itself run this way. Agents contribute to it directly.

## GitHub Copilot Integration

### Why can't GitHub Copilot access OBO PURLs like purl.obolibrary.org?

GitHub Copilot's coding agent includes a firewall that restricts internet access by default to prevent data exfiltration risks. While the agent can access GitHub-related hosts and a recommended allowlist of common package repositories, it blocks access to custom domains like `purl.obolibrary.org` that are commonly used in ontology workflows.

**The Solution:** Repository administrators can allowlist additional hosts in the Copilot firewall settings:

1. Navigate to your repository's **Settings** tab
2. Select **Copilot**, then **coding agent** from the Code & automation sidebar
3. Click **Custom allowlist**
4. Add `purl.obolibrary.org` (or specific URL paths) to the allowlist
5. Click **Add Rule**, then **Save changes**

**Allowlist formats:**
- **Domain**: `purl.obolibrary.org` - allows the domain and all subdomains
- **URL**: `https://purl.obolibrary.org/obo/` - restricts to specific scheme, host, and path

**Workaround:** Until the firewall is configured, use direct GitHub URLs instead of PURLs:
- ✅ Works: `https://raw.githubusercontent.com/oborel/obo-relations/refs/heads/master/ro-base.owl`
- ❌ Blocked: `http://purl.obolibrary.org/obo/ro/ro-base.owl`

For more details, see the [GitHub Copilot](reference/github-copilot.md) documentation and GitHub's guide on [customizing the agent firewall](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/customize-the-agent-firewall).

## Agent Harness and Infrastructure

### What is an agent harness?

An [agent harness](glossary.md#agent-harness) is the infrastructure that wraps around an AI agent to manage its execution — context management, tool orchestration, validation, provenance, and human-in-the-loop controls. It's the difference between an agent that sometimes works and one that's reliable and auditable.

The same model behaves differently depending on the harness around it. Getting the harness right matters more than picking the "best" model.

See [Build your agentic harness](how-tos/build-agentic-harness.md) for a practical guide.

### What tools are available for validating agent outputs?

Two key validators:

- **[linkml-term-validator](https://github.com/linkml/linkml-term-validator)** — checks that ontology terms referenced in agent outputs actually exist and are used correctly
- **[linkml-reference-validator](https://github.com/linkml/linkml-reference-validator)** — checks that cited references actually contain the claimed supporting text

Both can be integrated into CI pipelines to automatically validate agent-generated pull requests. See [Agentic tools](reference/agentic-tools.md) for details.

### How do I track which changes an AI agent made?

Use **[ai-blame](https://github.com/ai4curation/ai-blame)**, which extracts provenance and audit trails from agent execution traces. It provides line-level attribution, so you can see exactly which changes the agent made, when, and in what context.

### What MCP servers are available for ontology work?

- **[noctua-mcp](https://github.com/geneontology/noctua-mcp)** — GO-CAM editing via Noctua/Barista
- **[oak-mcp](https://github.com/monarch-initiative/oak-mcp)** — ontology search, traversal, and operations via OAK
- **[owl-mcp](https://github.com/ai4curation/owl-mcp)** — general OWL ontology operations

These give agents structured access to domain-specific operations instead of raw file manipulation.

### Which harness should I use?

Claude Code or Codex. Both work. Your repository setup matters more than the
choice between them. See [Harnesses](reference/harnesses.md).

We previously recommended Goose for curators who were not comfortable at the
command line. We no longer do for new setups.

### Do I have to install anything?

No. [Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web)
runs the session in a cloud container, clones the repository, and opens the pull
request for you. See [Your first curation session](tutorials/first-curation-session.md).

### Who is responsible for checking what my agent wrote?

Your project has to answer this, and write the answer down.

[DisMech](case-studies/dismech.md) states in its `CONTRIBUTING.md` that
contributors are not assumed to have verified everything their agent produced,
and that review is the process that catches problems. Other projects hold the
contributor responsible. Either works. Leaving it unstated does not. See
[Regulate the loop](patterns/human-regulating-the-loop.md).

### Does validation mean the content is correct?

No. Validation proves that a cited paper exists, that a quoted sentence is
exact, and that an ontology term is real. It does not prove that a claim is
scientifically correct. Say so where your readers can see it.
