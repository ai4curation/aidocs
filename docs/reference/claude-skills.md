# Claude Skills for Curation

Claude skills are reusable instruction packages that teach Claude Code how to complete specialized tasks in a repeatable way. The [curation-skills repository](https://github.com/ai4curation/curation-skills) provides a collection of skills specifically designed for knowledge curation and ontology workflows.

## What are Claude Skills?

Claude skills combine instructions, scripts, and resources to enhance Claude's performance on domain-specific work. They enable Claude to:

- Autonomously formulate complex queries for ontology systems
- Execute specialized workflows consistently
- Apply domain-specific knowledge and patterns
- Process results in context-aware ways

## Available Skills

The curation-skills repository currently provides three specialized skills:

### 1. Ontology Access Kit (OAK)
Query ontologies using the OAK framework with advanced capabilities for:
- Complex boolean queries with property lookups
- Intelligent navigation of ontology structures
- Dynamic command formulation for specific research needs

### 2. Editing OBO Ontologies
Tools and guidance for working with OBO format ontologies, including:
- Structured editing workflows
- Format validation and consistency checks
- Best practices for ontology maintenance

### 3. DOSDP Design Patterns
Understanding and applying Dead Simple Ontology Design Patterns for:
- Consistent ontology construction
- Pattern-based term creation
- Design pattern validation and application

## Installation

There are two ways to integrate these skills:

### Plugin Marketplace (Recommended)
Install via Claude Code's plugin marketplace:
```bash
/plugin marketplace add ai4curation/curation-skills
```
This method allows you to interactively select and install specific skills.

### Copy-Paste Method
Copy skill folders into `.claude/skills/` directory of your repository. This makes them available to teams and GitHub Actions universally.

## Use Cases

These skills are particularly valuable for:

- **Ontology Curators**: Streamline complex ontology queries and editing tasks
- **Knowledge Engineers**: Apply consistent design patterns and validation
- **Bioinformatics Researchers**: Access specialized biological ontology workflows
- **AI Teams**: Enhance Claude's domain-specific reasoning capabilities

## Getting Started

1. Choose your installation method above
2. Explore the [full documentation](https://github.com/ai4curation/curation-skills) for detailed usage examples
3. Review related guides in the [how-tos section](../how-tos/index.md) for integration strategies

## Resources

- **Full Documentation**: [https://github.com/ai4curation/curation-skills](https://github.com/ai4curation/curation-skills)
- **Related Guides**: [Integrate AI into your KB](../how-tos/integrate-ai-into-your-kb.md)
- **Client Setup**: [Claude Code](clients/claude-code.md)