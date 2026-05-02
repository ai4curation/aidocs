# Build Your Agentic Harness for Curation

## What is an agent harness?

An [agent harness](../glossary.md#agent-harness) is the infrastructure that wraps around an AI agent to manage its execution. It is not the agent itself — it is the system that governs how the agent operates, ensuring it remains reliable, consistent, and reviewable.

Think of it this way: the same model (e.g. Claude Opus) behaves differently in Claude Code versus Cursor versus a custom API setup. The model is the same. **The harness changes everything.**

In 2025, the focus was on building agents. In 2026, the focus has shifted to building the infrastructure that controls them — context management, tool orchestration, validation, provenance, and human-in-the-loop controls.

## Why curators need a harness

Without a harness, AI-assisted curation is fragile:

- Agents lose track of objectives mid-task
- Agent outputs contain hallucinated ontology terms or fabricated citations
- There's no record of what the agent changed or why
- Different agents behave inconsistently on the same repository
- Errors compound without automated validation gates

A harness addresses each of these failure modes with concrete infrastructure.

## Components of a curation harness

The ai4curation ecosystem already provides the building blocks. Here's how they map to harness components:

### 1. Prompt preset management — System instructions

Every repository should have a `CLAUDE.md` (for Claude Code / GitHub agents) and/or `.goosehints` (for Goose) checked into the root. These files tell the agent what the repository is, what conventions to follow, and what tools to use.

**Examples:**

- [CLAUDE.md in Mondo](https://github.com/monarch-initiative/mondo/blob/master/CLAUDE.md)
- [CLAUDE.md in Uberon](https://github.com/obophenotype/uberon/blob/master/CLAUDE.md)

**See:** [Instruct the GitHub agent](instruct-github-agent.md)

### 2. Tool access — MCP servers

MCP servers give agents structured access to domain-specific operations instead of relying on raw file manipulation:

- **[noctua-mcp](https://github.com/geneontology/noctua-mcp)** — GO-CAM editing via Noctua/Barista
- **[oak-mcp](https://github.com/monarch-initiative/oak-mcp)** — ontology operations via OAK
- **[owl-mcp](https://github.com/monarch-initiative/owl-mcp)** — OWL ontology operations

Without proper tool access, agents resort to ad-hoc text manipulation of ontology files, which is error-prone.

### 3. Validation — Automated quality gates

Validators catch errors in agent outputs before they reach human reviewers:

- **[linkml-term-validator](https://github.com/linkml/linkml-term-validator)** — checks that ontology terms referenced in agent outputs actually exist
- **[linkml-reference-validator](https://github.com/linkml/linkml-reference-validator)** — checks that cited references actually contain the claimed supporting text

These can be run as part of CI/CD pipelines or as pre-commit hooks.

### 4. Provenance — Audit trails

**[ai-blame](https://github.com/ai4curation/ai-blame)** extracts provenance from agent execution traces, enabling line-level attribution. This answers the question: "which changes did the AI make, and which did a human make?"

### 5. Consistent behavior — Agent skills

**[curation-skills](https://github.com/ai4curation/curation-skills)** provides reusable skill packs that make agent behavior consistent and domain-aware across different curation tasks.

### 6. Lifecycle hooks — GitHub Actions

GitHub Actions workflows (e.g. `ai-agent.yml`) automate the agent lifecycle:

- Trigger agents on issue creation or labeling
- Run validation after agent commits
- Gate merging on passing checks

**See:** [Set up GitHub Actions](set-up-github-actions.md)

### 7. Human-in-the-loop — Branch protection

GitHub branch protection rules ensure agents can't merge directly to main. Every agent-generated change goes through a pull request where a human curator reviews it.

## How the components compose

```
┌─────────────────────────────────────────────────────┐
│                  Agent Harness                       │
│                                                     │
│  ┌──────────────┐  ┌──────────────┐                 │
│  │  CLAUDE.md   │  │  curation-   │   System        │
│  │  .goosehints │  │  skills      │   Instructions  │
│  └──────────────┘  └──────────────┘                 │
│                                                     │
│  ┌──────────────┐  ┌──────────────┐                 │
│  │  noctua-mcp  │  │  oak-mcp     │   Tool          │
│  │  owl-mcp     │  │              │   Access        │
│  └──────────────┘  └──────────────┘                 │
│                                                     │
│  ┌──────────────┐  ┌──────────────┐                 │
│  │  term-       │  │  reference-  │   Validation    │
│  │  validator   │  │  validator   │                  │
│  └──────────────┘  └──────────────┘                 │
│                                                     │
│  ┌──────────────┐  ┌──────────────┐                 │
│  │  ai-blame    │  │  GitHub      │   Provenance    │
│  │              │  │  Actions     │   & Lifecycle   │
│  └──────────────┘  └──────────────┘                 │
│                                                     │
│  ┌─────────────────────────────────┐                │
│  │  Branch protection / PR review  │   Human        │
│  │                                 │   Oversight    │
│  └─────────────────────────────────┘                │
│                                                     │
│  ┌─────────────────────────────────┐                │
│  │    AI Agent (Claude, Goose)     │   The Agent    │
│  └─────────────────────────────────┘                │
└─────────────────────────────────────────────────────┘
```

## Getting started

A minimal harness for an ontology repository:

1. **Add system instructions**: Create a `CLAUDE.md` at the repo root ([guide](instruct-github-agent.md))
2. **Set up GitHub Actions**: Add an `ai-agent.yml` workflow ([guide](set-up-github-actions.md))
3. **Enable branch protection**: Require PR reviews before merging
4. **Install validators**: Add `linkml-term-validator` and/or `linkml-reference-validator` to your CI pipeline
5. **Configure MCP servers**: Set up `oak-mcp` or `noctua-mcp` for domain-specific tool access

As you mature your setup, add:

6. **Provenance tracking**: Integrate `ai-blame` for audit trails
7. **Curation skills**: Use `curation-skills` packs for consistent agent behavior

## Further reading

- [Agentic tools reference](../reference/agentic-tools.md) — detailed documentation for each tool
- [Example repositories](../examples.md) — see harnesses in action
- [Agentic tooling on GitHub](https://github.com/topics/ai4curation)
