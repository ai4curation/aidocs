# GitHub AI Integrations

This guide documents the different approaches for integrating AI agents with GitHub workflows in ontology repositories. Each approach has different trade-offs in terms of setup complexity, billing, and capabilities.

## Overview

| Approach | Billing | Model Selection | Setup Complexity | Best For |
|----------|---------|-----------------|------------------|----------|
| [Dragon-AI Agent](#dragon-ai-agent) | API key (project-based) | Configurable | Medium | Custom workflows, team control |
| [GitHub Copilot](#github-copilot) | GitHub subscription | GitHub-controlled | Low | Quick setup, GitHub-native |
| [Claude Code Action](#claude-code-action) | API key or Max subscription | Anthropic models | Low-Medium | Claude-specific features |

## Dragon-AI Agent

The Dragon-AI Agent approach uses custom GitHub Actions to deploy headless AI coding assistants (Claude Code or Goose) in response to issue/PR comments.

### How It Works

1. A controller invokes the agent with `@dragon-ai-agent please` in an issue or PR comment
2. A GitHub Action triggers, running the AI in a containerized environment
3. The AI reads the issue context, makes changes, and creates/updates PRs
4. Controllers are authorized via `.github/ai-controllers.json`

### Setup

See [Set up GitHub Actions](../how-tos/set-up-github-actions.md) for detailed setup instructions.

Key configuration files:
- `.github/workflows/` - GitHub Action workflow definitions
- `.github/ai-controllers.json` - Authorized users list
- `CLAUDE.md` - AI system instructions

### When to Use

- **Team control**: You want fine-grained control over who can invoke the AI
- **Custom tooling**: Your workflow requires specific MCP servers or tools
- **Project billing**: You want to charge AI usage to a specific project/grant via API proxy
- **Multi-model support**: You need to switch between different AI providers

### Limitations

- Requires maintenance of GitHub Action workflows
- Setup is more involved than native integrations
- Debugging requires checking GitHub Actions logs

## GitHub Copilot

GitHub Copilot's coding agent can be assigned to issues and PRs directly through the GitHub interface.

### How It Works

1. Assign an issue to Copilot - it creates a PR to address the issue
2. Assign a PR to Copilot - it reviews and suggests changes
3. Copilot works within GitHub's infrastructure

### Setup

1. Enable GitHub Copilot for your organization/repository
2. Copilot appears as an assignable user on issues and PRs

For educational users, see the [GitHub Education benefits](../how-tos/instruct-github-agent.md#github-copilot-pro-coupon-through-github-education) section for free Copilot Pro access.

### When to Use

- **Quick setup**: You want to start using AI agents immediately
- **GitHub-native**: You prefer staying within GitHub's ecosystem
- **Individual use**: For personal repositories or small teams
- **PR reviews**: Copilot excels at code review tasks

### Limitations

- Less control over model selection and behavior
- Billing tied to GitHub subscription
- May not support ontology-specific tooling (ROBOT, OWL tools)
- Configuration options are limited compared to custom approaches

### Ontology-Specific Considerations

For ontology repositories, Copilot may need additional guidance:

- Include clear instructions in repository documentation
- Copilot may attempt to run tools locally before using ODK wrappers
- Add prominent warnings in README/CLAUDE.md about using ODK containers

## Claude Code Action

Anthropic's official [Claude Code Action](https://github.com/anthropics/claude-code-action) provides a streamlined way to run Claude Code in GitHub Actions.

### How It Works

1. Trigger via issue/PR comments (configurable trigger phrase)
2. Claude Code runs with access to repository contents
3. Can create commits, PRs, and respond to comments

### Setup

Install via Claude Code:
```bash
claude /install-github-app
```

Or manually add the GitHub Action to your repository.

**Billing options:**
- API key (pay-per-use via Anthropic API)
- Claude Max subscription (included usage)

### When to Use

- **Claude-specific features**: You want access to latest Claude capabilities
- **Simple setup**: Official action with maintained support
- **Flexible billing**: Choose between API or subscription billing
- **Anthropic ecosystem**: Already using Claude for other workflows

### Limitations

- Limited to Anthropic models
- Less customization than Dragon-AI approach
- Requires Anthropic API key or Max subscription

## Comparison for Ontology Repositories

For ontology curation workflows, consider these factors:

### Tool Access

| Tool | Dragon-AI | Copilot | Claude Code Action |
|------|-----------|---------|-------------------|
| ROBOT via ODK | Yes (configurable) | Limited | Yes (configurable) |
| OWL-MCP | Yes | No | Yes |
| Custom MCP servers | Yes | No | Yes |
| Web search | Yes | Limited | Yes |

### Recommended Approach by Use Case

**Starting out / Experimentation:**
- Use GitHub Copilot for quick wins on simple issues
- Low barrier to entry, good for learning

**Production ontology curation:**
- Use Dragon-AI Agent or Claude Code Action
- Better tool integration and customization
- Project-based billing for grant compliance

**Mixed team (technical + non-technical):**
- Dragon-AI Agent with clear controller authorization
- Provides guardrails while enabling AI assistance

## Configuration Files

Regardless of which approach you use, these files help guide AI behavior:

| File | Purpose |
|------|---------|
| `CLAUDE.md` | System instructions for Claude-based agents |
| `.goosehints` | Instructions for Goose (often symlinked to CLAUDE.md) |
| `.github/copilot-instructions.md` | Instructions for GitHub Copilot |
| `.github/ai-controllers.json` | Authorized users for Dragon-AI |

## Related Resources

- [Set up GitHub Actions](../how-tos/set-up-github-actions.md)
- [Instruct the GitHub Agent](../how-tos/instruct-github-agent.md)
- [Claude Code Action Repository](https://github.com/anthropics/claude-code-action)
