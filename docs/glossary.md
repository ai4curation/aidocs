# Glossary

## Agent Harness

The infrastructure and control plane that wraps around an [AI agent](#ai-agent) to manage its execution. An agent harness handles context management, [tool](#tool) orchestration, validation, provenance, error recovery, and human-in-the-loop controls. It does not replace the agent — it governs how the agent operates. Think of it as the difference between writing a container and running Kubernetes.

In a curation context, a harness typically includes: system instructions (e.g. [CLAUDE.md](#claude-code)), validators (e.g. [linkml-term-validator](#linkml-term-validator), [linkml-reference-validator](#linkml-reference-validator)), provenance tools (e.g. [ai-blame](#ai-blame)), [MCP](#model-context-protocol-mcp) servers for domain-specific tool access, and [GitHub Actions](#github-actions) for lifecycle automation.

See also: [Build your agentic harness](how-tos/build-agentic-harness.md)

## Agentic Coding Tool

A coding tool that combines AI capabilities with direct access to development tools and environments, enabling natural language interaction with code bases and automated execution of development tasks.

## AI Agent

An agent is a program that allows AI models to call [tools](#tool) to achieve some objective.

## ai-blame

A tool that extracts provenance and audit trails from agent execution traces, enabling line-level attribution and post-hoc review for AI-assisted edits. Useful for tracking which changes an AI agent made, when, and in what context.

See [GitHub](https://github.com/ai4curation/ai-blame), [Docs](https://ai4curation.github.io/ai-blame), [PyPI](https://pypi.org/project/ai-blame/)

## CBORG

An AI proxy used by members of Berkeley Lab. CBORG uses [LiteLLM](#litellm) to proxy calls to models.

## Claude

A LLM from Anthropic.

## Curation Skill

A reusable, domain-specific instruction pack that shapes [AI agent](#ai-agent) behavior for ontology and biocuration tasks. Skills make agent behavior more consistent, transparent, and domain-aware by providing structured prompts and tool configurations. See [curation-skills](https://github.com/ai4curation/curation-skills).

## Claude Code

An [agentic coding tool](#agentic-coding-tool) that lives in a command line terminal. 

The main purpose of Claude Code is to enable developers to interact with and modify code using natural language commands. However, it can also be used to edit and maintain other content.

## Claude Desktop

An agentic desktop application and host environment that allows you to interact with an AI model (Claude) while also accessing local files, running local code, or using [MCPs](#model-context-protocol-mcp)

## GitHub Actions
An automation platform provided by GitHub that allows users to automate software workflows, including building, testing, and deploying code directly from their repositories.

## Goose

An AI application and host environment that that allows you to interact with an AI model while also accessing local files, running local code, or using [MCPs](#model-context-protocol-mcp)

Goose is actually two separate programs

* A Desktop app (recommended for non-technical tasks)
* A Terminal / Command Line app, similar to Claude Code.

## OBO Format
A standardized file format used for creating and exchanging ontologies, particularly prevalent in the biomedical and life sciences domains. For more details, see the [OBO Flat File Format Specification](http://owlcollab.github.io/oboformat/doc/GO.format.obo-1_4.html).

## Ontology
A collection of concepts that represent some domain, along with the relationships between them.

## Provenance

In the context of AI-assisted curation, provenance refers to tracking the origin, authorship, and context of changes — particularly distinguishing human-authored from AI-generated edits. Tools like [ai-blame](#ai-blame) extract provenance from agent execution traces, enabling line-level attribution and post-hoc review.

## PMID (PubMed ID)
A unique numerical identifier assigned to every record in PubMed, the comprehensive database of biomedical literature.

PMIDs are usually written as CURIEs, e.g. PMID:123456

## API Key
A unique code or token that is passed to an Application Programming Interface (API) to authenticate the calling application or user. API keys are used to control access to the API, track usage, and manage permissions.

## linkml-reference-validator

A validator that checks whether supporting text in structured records is actually present in cited references, helping enforce evidence-backed curation in agent-generated outputs. See [GitHub](https://github.com/linkml/linkml-reference-validator), [Docs](https://linkml.io/linkml-reference-validator/), [PyPI](https://pypi.org/project/linkml-reference-validator/)

## linkml-term-validator

A validator that checks [LinkML](https://linkml.io/) schemas and datasets for correct use of external ontologies and controlled terms, improving consistency for agent-generated outputs. See [GitHub](https://github.com/linkml/linkml-term-validator), [Docs](https://linkml.io/linkml-term-validator/), [PyPI](https://pypi.org/project/linkml-term-validator/)

## Knowledge Base (KB)
A centralized repository for storing and managing complex information, both structured and unstructured. In the context of AI and curation, KBs often refer to curated collections of domain-specific knowledge that AI systems can utilize and help maintain.

## Large Language Model (LLM)
A type of artificial intelligence (AI) model trained on vast amounts of text data to understand, generate, and process human language. LLMs are the foundation for many modern AI applications, including chatbots and content generation tools.

## LiteLLM
A lightweight library that provides a unified interface for interacting with various Large Language Model (LLM) APIs. It simplifies the process of switching between different LLM providers and managing API calls. For more information, visit [LiteLLM's official documentation](https://docs.litellm.ai/).

## Model Context Protocol (MCP)
A specification or standard that defines how AI models and external tools or services should communicate and exchange contextual information. MCP enables AI agents to effectively utilize a diverse set of capabilities by providing a common interface for tool interaction.

The best way to understand the concept of MCPs is to try them out - the Goose desktop app makes this easy.

Domain-specific MCP servers relevant to curation include:

- [noctua-mcp](https://github.com/geneontology/noctua-mcp) — MCP server for GO-CAM editing via Noctua/Barista
- [oak-mcp](https://github.com/monarch-initiative/oak-mcp) — MCP server for ontology operations via [OAK](#oak-ontology-access-kit)

## OAK (Ontology Access Kit)
A unified Python and CLI toolkit for ontology search, graph operations, mapping generation, and programmatic ontology manipulation. OAK provides a common interface over multiple ontology sources including BioPortal, OLS, local files, and SPARQL endpoints. See [GitHub](https://github.com/INCATools/ontology-access-kit), [Docs](https://incatools.github.io/ontology-access-kit/), [PyPI](https://pypi.org/project/oaklib/)

## ODK (Ontology Development Kit)
A suite of tools, best practices, and standardized workflows for creating, maintaining, and quality control for ontologies, particularly those in the OBO (Open Biomedical Ontologies) ecosystem. More information can be found at the [ODK GitHub repository](https://incatools.github.io/ontology-development-kit/).

## O3 Guidelines
The Open Data, Open Code, Open Infrastructure (O3) Guidelines are an actionable set of recommendations centered around management of content (such as ontology or knowledge base content) as interpretable files managed in GitHub.

The O3 guidelines work particularly well for AI coding agents, because they are easily viewed and manipulated by the AI using standard filesystem based tools.

See this figure

![img](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41597-024-03406-w/MediaObjects/41597_2024_3406_Fig1_HTML.png)

from [Hoyt et al](https://www.nature.com/articles/s41597-024-03406-w).

Here the community can be conceived of as containing both humans and AI agents.

## Tool

In the context of AI agents, a tool refers to a specific function or capability that an AI model can access to perform actions beyond text generation, such as reading files, executing code, making API calls, or interacting with external systems.
