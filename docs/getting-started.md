# Getting Started with AI for Curation

This guide provides a structured introduction to integrating AI into your curation workflows. Whether you're new to AI tools or looking to deepen your usage, this page will help you get oriented.

## Quick Start: Choose Your Path

| I want to... | Start here |
|--------------|------------|
| Try AI tools locally on my machine | [Ontology Editing with AI Tutorial](tutorials/ontology-editing-with-ai.md) |
| Use AI agents in my GitHub repository | [Set up GitHub Actions](how-tos/set-up-github-actions.md) |
| Understand the available tools | [Tool Overview](#tool-overview) below |
| Learn the conceptual foundations | [Mindset Framework](#mindset-framework) below |

## Tool Overview

Several AI tools are available for curation work. Here's when to use each:

### Claude Code

**What it is:** A command-line AI coding assistant from Anthropic that runs locally and can interact with your files and tools.

**When to use:**
- Complex multi-step curation tasks requiring file access
- When you need to run local tools (ROBOT, reasoners, ODK workflows)
- For tasks requiring deep context about your repository
- When you want fine-grained control over AI behavior

**Get started:** [Claude Code Reference](reference/clients/claude-code.md)

### GitHub Copilot

**What it is:** GitHub's AI coding assistant, available as IDE extensions and a GitHub-native agent.

**When to use:**
- Quick fixes and simple issue resolution
- When you want minimal setup (works out of the box on GitHub)
- For PR reviews and code suggestions
- If you're already in the GitHub ecosystem

**Get started:** [Instruct the GitHub Agent](how-tos/instruct-github-agent.md#new-invocation-via-github-copilot)

### Goose

**What it is:** An open-source AI assistant with a desktop app, designed for extensibility via plugins.

**When to use:**
- Non-technical users who prefer a GUI
- When you want to experiment with different AI models
- For workflows requiring custom MCP extensions (like OWL-MCP)
- If you prefer open-source tools

**Get started:** [Goose Reference](reference/clients/goose.md) | [Ontology Editing Tutorial](tutorials/ontology-editing-with-ai.md)

### Claude Desktop

**What it is:** Anthropic's desktop chat application with file and tool access.

**When to use:**
- Interactive exploration and research
- When you need visual/chat interface for AI interaction
- For document analysis and summarization

**Get started:** [Claude Desktop Reference](reference/clients/claude-desktop.md)

## Mindset Framework

Understanding how to think about AI tools helps you use them effectively. Consider these three mental models:

### AI as Junior Curators

Think of AI as new team members who are knowledgeable but need guidance:

- **They need documentation**: The clearer your `CLAUDE.md` and repository documentation, the better the AI performs
- **They make mistakes**: Always review AI work before merging
- **They learn from feedback**: PR reviews and instruction updates improve future performance
- **They're fast but not perfect**: Use AI for first drafts and routine tasks, apply human judgment for final decisions

**Best for:** Routine curation tasks, batch processing, first-pass term additions

### AI as Autonomous Agents

Think of AI as capable workers who can plan and execute complex tasks:

- **Give them objectives, not step-by-step instructions**: "Add terms for cardiac cell types with proper relationships" rather than "First open the file, then..."
- **Trust but verify**: Agents can handle multi-step workflows, but check their output
- **Set up guardrails**: Use GitHub PR reviews, authorization controls, and quality checks
- **Let them use tools**: Agents are most powerful when they can run reasoners, validators, and other ontology tools

**Best for:** Issue resolution, complex refactoring, research-backed curation

### AI as Personal Assistants

Think of AI as always-available helpers for your individual work:

- **Ask questions freely**: Use AI to explore code, understand patterns, draft text
- **Iterate quickly**: Get a first draft, refine it, ask for alternatives
- **Augment your expertise**: AI helps you move faster on tasks you already understand
- **Maintain agency**: You make the decisions; AI provides options and executes

**Best for:** Learning new codebases, drafting documentation, exploratory research

## Learning Path

Follow this sequence for a structured introduction:

### 1. Foundations (Start Here)

1. **Read this guide** - You're here now
2. **Try a chat interface** - Use [Claude](https://claude.ai) or ChatGPT to ask questions about ontology concepts
3. **Understand the basics** - Read Ethan Mollick's [practical guide to AI usage](https://www.oneusefulthing.org/)

### 2. Local Tools

1. **Install Goose** - Follow the [ontology editing tutorial](tutorials/ontology-editing-with-ai.md)
2. **Try simple tasks** - Clone a test ontology, ask the AI to add terms
3. **Experiment with tools** - Install OWL-MCP and explore ontology-specific capabilities

### 3. Repository Integration

1. **Understand GitHub agents** - Read [Instruct the GitHub Agent](how-tos/instruct-github-agent.md)
2. **Set up actions** - If you're an admin, follow [Set up GitHub Actions](how-tos/set-up-github-actions.md)
3. **Try an issue** - Find a simple, mechanical issue and invoke the agent

### 4. Advanced Topics

1. **Deep research** - Learn to use [research integration](how-tos/deep-research-integration.md) for literature-backed curation
2. **Agent improvement** - Understand [PR reviews for agent improvement](how-tos/pr-reviews-for-agent-improvement.md)
3. **Custom workflows** - Explore MCP servers and custom tool integration

## Key Resources

### Official Documentation

- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) - Essential reading for Claude Code users
- [GitHub Copilot Docs](https://docs.github.com/en/copilot) - Official GitHub documentation
- [Goose Documentation](https://block.github.io/goose/) - Goose installation and usage

### Courses and Tutorials

- [DeepLearning.AI Claude Code Course](https://www.deeplearning.ai/) - Short course on Claude Code (highly recommended)
- [OBO Academy Seminar](https://www.youtube.com/watch?v=4nyeGFACPKI) - Video on AI for ontology development

### Community

- [OBO Academy](https://oboacademy.github.io/obook/) - Ontology development training
- [AI4Curation GitHub](https://github.com/ai4curation) - Example repositories and tools

## Common Questions

**Q: Which tool should I start with?**
A: If you're comfortable with command line, try Claude Code. If you prefer a GUI, start with Goose. If you just want to try AI on GitHub issues, use Copilot.

**Q: Do I need to pay for these tools?**
A: Most tools have free tiers or trial periods. GitHub Copilot is free for educational users. Claude Code and Goose require API keys (pay-per-use) or subscriptions.

**Q: Will AI replace curators?**
A: No. AI augments curator work by handling routine tasks faster, but human expertise remains essential for judgment calls, quality control, and domain knowledge.

**Q: How do I know if AI output is correct?**
A: Always review AI-generated changes. Use PR reviews, run validation workflows, and verify citations. See [Make IDs Hallucination-Resistant](how-tos/make-ids-hallucination-resistant.md) for specific techniques.

## Next Steps

Ready to dive in? Choose based on your role:

- **Curators**: Start with the [Ontology Editing Tutorial](tutorials/ontology-editing-with-ai.md)
- **Repository Admins**: Read [Set up GitHub Actions](how-tos/set-up-github-actions.md)
- **Everyone**: Explore the [Glossary](glossary.md) to understand key terminology
