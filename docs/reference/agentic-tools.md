# Agentic Tools

Tools and infrastructure for reliable AI-assisted ontology, schema, and knowledge-base curation workflows. These components form the building blocks of an [agent harness](../glossary.md#agent-harness) — the control plane that makes AI-assisted curation reproducible and reviewable.

For a guide on how these tools fit together, see [Build your agentic harness](../how-tos/build-agentic-harness.md).

## Validators

### linkml-reference-validator

Validates whether supporting text in structured records is actually present in cited references, helping enforce evidence-backed curation.

- **When to use**: After an agent generates structured annotations with literature citations — catch hallucinated or misattributed evidence before review.
- **Install**: `pip install linkml-reference-validator`
- [GitHub](https://github.com/linkml/linkml-reference-validator) | [Docs](https://linkml.io/linkml-reference-validator/) | [PyPI](https://pypi.org/project/linkml-reference-validator/)

### linkml-term-validator

Checks LinkML schemas and datasets for correct use of external ontologies and controlled terms, improving consistency for agent-generated outputs.

- **When to use**: When agents generate data that references ontology terms — ensures terms exist and are used correctly.
- **Install**: `pip install linkml-term-validator`
- [GitHub](https://github.com/linkml/linkml-term-validator) | [Docs](https://linkml.io/linkml-term-validator/) | [PyPI](https://pypi.org/project/linkml-term-validator/)

## Provenance

### ai-blame

Extracts provenance and audit trails from agent execution traces, enabling line-level attribution and post-hoc review for AI-assisted edits.

- **When to use**: After AI-assisted editing sessions — understand which changes an agent made, when, and in what context.
- **Install**: `pip install ai-blame`
- [GitHub](https://github.com/ai4curation/ai-blame) | [Docs](https://ai4curation.github.io/ai-blame) | [PyPI](https://pypi.org/project/ai-blame/)

## Agent Skills

### curation-skills

Reusable skill packs for ontology and biocuration tasks, designed to make agent behavior more consistent, transparent, and domain-aware.

- **When to use**: When configuring agents for curation work — provide structured, domain-specific instructions instead of ad-hoc prompts.
- [GitHub](https://github.com/ai4curation/curation-skills) | [Skills Article](https://anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

## MCP Servers

### noctua-mcp

MCP server wrapping GO-CAM editing capabilities, enabling agentic interaction with Noctua/Barista workflows through a standardized interface.

- **When to use**: When agents need to create or edit GO-CAM models — provides structured access to the Noctua API.
- **Install**: `pip install noctua-mcp`
- [GitHub](https://github.com/geneontology/noctua-mcp) | [PyPI](https://pypi.org/project/noctua-mcp/) | [noctua-py](https://github.com/geneontology/noctua-py)

### oak-mcp

MCP server for ontology operations via the Ontology Access Kit ([OAK](../glossary.md#oak-ontology-access-kit)), enabling agents to search, query, and traverse ontologies programmatically.

- **When to use**: When agents need to look up ontology terms, traverse hierarchies, or perform ontology operations during curation tasks.
- [GitHub](https://github.com/monarch-initiative/oak-mcp)

## System Instructions

### CLAUDE.md / .goosehints

Configuration files checked into the root of your repository that provide system-level instructions to AI agents. These serve as prompt preset management — different repositories can have different instructions tailored to their domain and workflows.

- **When to use**: Always. Every repository that uses AI agents should have system instructions.
- See [Instruct the GitHub agent](../how-tos/instruct-github-agent.md)
- Examples: [CLAUDE.md in Mondo](https://github.com/monarch-initiative/mondo/blob/master/CLAUDE.md), [CLAUDE.md in Uberon](https://github.com/obophenotype/uberon/blob/master/CLAUDE.md)

## Further Reading

- [Build your agentic harness](../how-tos/build-agentic-harness.md) — how these tools compose into a harness
- [Browse agentic tooling on GitHub](https://github.com/topics/ai4curation)
- [ai4curation GitHub org](https://github.com/ai4curation)
