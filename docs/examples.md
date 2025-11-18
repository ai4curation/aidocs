# Example Repositories Using AI4Curation Setup

This page showcases repositories that have implemented AI agent integration for knowledge base curation, providing real-world examples for learning and reference.

## Ontology Repositories

These repositories demonstrate AI agent integration for ontology curation workflows:

### Mondo Disease Ontology
**Repository**: [monarch-initiative/mondo](https://github.com/monarch-initiative/mondo)

The Mondo Disease Ontology is an exemplar implementation of the dragon-ai-agent GitHub Actions setup using Goose as the agent platform.

**Key Files to Explore**:
- [ai-agent.yml](https://github.com/monarch-initiative/mondo/blob/master/.github/workflows/ai-agent.yml) - GitHub Actions workflow configuration
- [CLAUDE.md](https://github.com/monarch-initiative/mondo/blob/master/CLAUDE.md) - Agent instructions
- [.config/goose/config.yaml](https://github.com/monarch-initiative/mondo/tree/master/.config/goose) - Goose configuration with MCP extensions

**Agent Platform**: Goose (via dragon-ai-agent)

**Notable Features**:
- Uses dragon-ai-agent/github-mention-detector for detecting @mentions
- Configured with dragon-ai-agent/run-goose-obo for ontology-specific tasks
- Includes MCP extensions for developer tools, memory, and PDF reading
- LiteLLM proxy integration for cost management

### Cell Ontology (CL)
**Repository**: [obophenotype/cell-ontology](https://github.com/obophenotype/cell-ontology)

Cell Ontology provides structured knowledge about cell types and has integrated AI agents into its curation workflow.

**Key Files to Explore**:
- CLAUDE.md - Agent instructions for cell ontology curation

**Agent Platform**: Part of the unified ontology pipeline effort

**Domain Focus**: Cell type classification and relationships

### Uberon Anatomy Ontology
**Repository**: [obophenotype/uberon](https://github.com/obophenotype/uberon)

Uberon provides cross-species anatomy ontology and has explored multiple AI agent platforms.

**Key Files to Explore**:
- [PR #3580](https://github.com/obophenotype/uberon/pull/3580) - GitHub Copilot integration for reviews and PRs

**Agent Platform**: GitHub Copilot (in addition to other setups)

**Notable Features**:
- Demonstrates GitHub Copilot setup for automated reviews
- Part of the OBO Phenotype ontology ecosystem

## Documentation Repositories

### AI4Curators Documentation
**Repository**: [ai4curation/aidocs](https://github.com/ai4curation/aidocs) (this repository)

This documentation repository serves as both a guide and example of AI agent integration.

**Key Files to Explore**:
- `.github/workflows/` - GitHub Actions for AI agent integration
- `CLAUDE.md` - Repository-specific instructions
- Documentation in `docs/` demonstrating best practices

**Agent Platform**: Multiple (Claude Code, Goose)

**Notable Features**:
- Comprehensive documentation on AI integration patterns
- Examples and how-to guides
- Reference implementations

## Additional Known Implementations

These repositories are confirmed to use AI agent setups, though detailed configuration may vary:

- **EFO (Experimental Factor Ontology)** - Part of the unified ontology pipeline effort
- **NAMO** - Mentioned in pipeline unification discussions

## Learning from These Examples

When exploring these repositories, look for:

1. **Workflow Configuration**: `.github/workflows/` files showing how agents are triggered
2. **Agent Instructions**: `CLAUDE.md`, `.goosehints`, or similar instruction files
3. **MCP Configuration**: `.config/goose/config.yaml` or `.claude/settings.json` for tool integrations
4. **Access Control**: `.github/ai-controllers.json` for authorized users
5. **Example PRs**: Search for PRs created by the agent to see real interactions

## Comparison of Agent Platforms

### Goose (via dragon-ai-agent)
- **Used by**: Mondo, Cell Ontology, many OBO ontologies
- **Strengths**: Open source, MCP support, self-hosted options
- **Setup**: Requires `.config/goose/` configuration
- **API**: Anthropic Claude (typically via LiteLLM proxy)

### Claude Code
- **Used by**: Various repositories, simplified setup
- **Strengths**: Streamlined installation via `claude install-github-app`
- **Setup**: Automated GitHub Actions configuration
- **API**: Anthropic Claude (direct)

### GitHub Copilot
- **Used by**: Uberon (for reviews)
- **Strengths**: Native GitHub integration
- **Setup**: Simple file changes for review automation
- **API**: GitHub/OpenAI

## Related Resources

- [How to set up GitHub Actions](how-tos/set-up-github-actions.md) - Step-by-step setup guide
- [How to instruct the GitHub agent](how-tos/instruct-github-agent.md) - Writing effective agent instructions
- [Issue #40: Unify ontology pipelines](https://github.com/ai4curation/aidocs/issues/40) - Ongoing standardization effort

## Contributing to This Gallery

If you have implemented AI agent integration in your repository and would like to be included in this gallery, please:

1. Open an issue with the repository URL and description
2. Submit a pull request adding your repository to this page
3. Contact the AI4Curation team

We're particularly interested in examples that demonstrate:
- Novel use cases or workflows
- Different agent platforms or configurations
- Domain-specific adaptations
- Advanced features or integrations

## Future Directions

The AI4Curation community is working toward:

- **Pipeline unification**: Standardizing AI agent patterns across repositories (see [Issue #40](https://github.com/ai4curation/aidocs/issues/40))
- **Best practices**: Documenting proven patterns and anti-patterns
- **Tooling**: Developing shared tools and actions
- **Community**: Building a network of practitioners and knowledge sharing
