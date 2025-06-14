# Glossary

## AI Agent

An agent is a program that allows AI models to call [tools](#tool) to achieve some objective. 

## CBORG

An AI proxy used by members of Berkeley Lab. CBORG uses [LiteLLM](#litellm) to proxy calls to models.

## Claude

A LLM from Anthropic. 

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

## PMID (PubMed ID)
A unique numerical identifier assigned to every record in PubMed, the comprehensive database of biomedical literature.

PMIDs are usually written as CURIEs, e.g. PMID:123456

## API Key
A unique code or token that is passed to an Application Programming Interface (API) to authenticate the calling application or user. API keys are used to control access to the API, track usage, and manage permissions.

## Knowledge Base (KB)
A centralized repository for storing and managing complex information, both structured and unstructured. In the context of AI and curation, KBs often refer to curated collections of domain-specific knowledge that AI systems can utilize and help maintain.

## Large Language Model (LLM)
A type of artificial intelligence (AI) model trained on vast amounts of text data to understand, generate, and process human language. LLMs are the foundation for many modern AI applications, including chatbots and content generation tools.

## LiteLLM
A lightweight library that provides a unified interface for interacting with various Large Language Model (LLM) APIs. It simplifies the process of switching between different LLM providers and managing API calls. For more information, visit [LiteLLM's official documentation](https://docs.litellm.ai/).

## Model Context Protocol (MCP)
A specification or standard that defines how AI models and external tools or services should communicate and exchange contextual information. MCP enables AI agents to effectively utilize a diverse set of capabilities by providing a common interface for tool interaction.

The best way to understand the concept of MCPs is to try them out - the Goose desktop app makes this easy.

## ODK (Ontology Development Kit)
A suite of tools, best practices, and standardized workflows for creating, maintaining, and quality control for ontologies, particularly those in the OBO (Open Biomedical Ontologies) ecosystem. More information can be found at the [ODK GitHub repository](https://incatools.github.io/ontology-development-kit/).

## O3 Guidelines
The Open Data, Open Code, Open Infrastructure (O3) Guidelines are an actionable set of recommendations centered around management of content (such as ontology or knowledge base content) as interpretable files managed in GitHub.

The O3 guidelines work particularly well for AI coding agents, because they are easily viewed and manipulated by the AI using standard filesystem based tools.

See this figure

![img](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41597-024-03406-w/MediaObjects/41597_2024_3406_Fig1_HTML.png)

from [Hoyt et al](https://www.nature.com/articles/s41597-024-03406-w).

Here the community can be conceived of as containing both humans and AI agents.
