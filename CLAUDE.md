# CLAUDE.md for aidocs

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**aidocs** is a documentation repository for **AI4Curators**, providing practical guides for curators and maintainers of knowledge bases to integrate AI into their workflows. The project focuses on immediate, actionable integration strategies rather than theoretical discussions.

### Core Mission
- Help curators integrate AI agents into existing GitHub-based workflows
- Provide plugins and tools for existing chat UIs
- Support ontology editing and curation workflows with AI assistance

## Repository Structure

```
aidocs/
├── docs/                     # MkDocs documentation source
│   ├── how-tos/             # Practical how-to guides
│   ├── tutorials/           # Step-by-step tutorials  
│   ├── reference/           # Technical reference materials
│   │   └── clients/         # Documentation for various AI clients
│   └── overrides/           # MkDocs theme customizations
├── src/aidocs/              # Python package source
├── tools/                   # Utility scripts and tools
├── mkdocs.yml               # MkDocs configuration
└── pyproject.toml           # Python project configuration
```

## Technology Stack

- **Documentation**: MkDocs with Material theme
- **Python**: >=3.9 (for tooling and scripts)
- **Deployment**: GitHub Pages
- **Build System**: Hatchling

## Key Files and Their Purpose

- `mkdocs.yml`: Configures the documentation site structure, theme, and plugins
- `pyproject.toml`: Python project metadata and dependencies
- `docs/index.md`: Main landing page content
- `docs/glossary.md`: Terminology definitions for the domain
- `docs/how-tos/`: Practical implementation guides
- `docs/reference/clients/`: Documentation for various AI client applications

## Development Guidelines

### Documentation Standards
- Focus on **practical, immediately actionable** content
- Provide step-by-step guides over theoretical explanations
- Include real-world examples and use cases
- Maintain consistency with the existing Material theme styling

### Content Categories
1. **How-tos**: Task-oriented guides for specific implementation scenarios
2. **Tutorials**: Comprehensive learning-oriented walkthroughs
3. **Reference**: Technical specifications and API documentation
4. **Glossary**: Domain-specific terminology and definitions

### Building and Testing
- Use `mkdocs serve` for local development
- Documentation is automatically deployed to GitHub Pages
- Test all links and examples before committing

## Target Audience

- **Primary**: Curators and maintainers of knowledge bases and ontologies
- **Secondary**: Developers integrating AI into existing curation workflows
- **Focus**: Practitioners who need immediate, working solutions over academic discussions

## AI Agent Integration

This repository serves as both documentation and a practical example of AI agent integration:
- GitHub agents can directly contribute to documentation
- Examples demonstrate real-world AI-assisted curation workflows
- Reference materials guide implementation of similar systems

## Contributing Guidelines

When working on this repository:
1. **Prioritize practical value** - every guide should be immediately applicable
2. **Test all examples** - ensure code snippets and procedures work as documented
3. **Maintain consistency** - follow existing patterns in documentation structure
4. **Focus on integration** - emphasize how AI enhances existing workflows rather than replacing them

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
