# Getting Started with AI for Curators

Welcome! This guide will help you begin integrating AI into your curation workflows. Whether you're maintaining ontologies, knowledge bases, or other curated resources, AI can serve as a powerful assistant to enhance your productivity.

## Prerequisites

Before diving in, you should have:

- Basic familiarity with your knowledge base or ontology editing workflow
- Access to GitHub (most of our tools integrate with GitHub-based workflows)
- A willingness to experiment and iterate (AI assistants improve as you learn to work with them)

## Understanding the AI Mindset

Before jumping into specific tools, it's helpful to understand different ways to think about AI in your workflow:

### AI as Junior Curators
Think of AI as a team of junior curators who are eager to help but need clear instructions. They:

- Benefit from detailed technical documentation and context
- Can handle routine tasks efficiently
- Need guidance on domain-specific conventions and best practices
- Should have their work reviewed before finalizing

### AI as Agents
Modern AI can go beyond answering questions - they can:

- Develop comprehensive plans for complex tasks
- Execute multi-step workflows autonomously
- Search, analyze, and synthesize information from multiple sources
- Make changes to files and create pull requests

### AI as Personal Assistants
AI can serve as your coding and curation scribe:

- Document your decisions and rationale
- Draft boilerplate text and code
- Help with repetitive formatting tasks
- Assist with documentation writing

## Learning Path

We recommend following this progression to build your skills effectively:

### 1. Start with the Fundamentals

**Read first:** [Using AI Right Now: A Quick Guide](https://www.oneusefulthing.org/p/using-ai-right-now-a-quick-guide) by Ethan Mollick

This accessible guide covers:

- Which AI models to use and when
- Practical prompting strategies
- Privacy and cost considerations
- Real-world examples of effective AI use

**Time investment:** 15-20 minutes
**Key takeaway:** AI is most useful when you learn to work *with* it iteratively, not just throw requests at it

### 2. Choose Your Primary Tool

Based on your workflow and needs, select one of these tools to start:

#### Claude Code (Recommended for most curators)

Best for: Integrated coding and curation workflows, GitHub-based projects

**Resources:**

- [Claude Code Overview](https://docs.claude.com/en/docs/claude-code/overview) - Official introduction
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) - Essential reading
- [DeepLearning.ai Short Course](https://www.deeplearning.ai/short-courses/claude-code-a-highly-agentic-coding-assistant/) - Comprehensive hands-on course (highly recommended)

**When to use:**

- Working with files in a GitHub repository
- Need to make systematic changes across multiple files
- Want an AI that can explore your codebase and understand context
- Prefer a conversational, iterative workflow

**See also:** Our [Claude Code reference](reference/clients/claude-code.md)

#### GitHub Copilot

Best for: In-editor assistance while coding or writing

**When to use:**

- Working directly in VS Code, Visual Studio, or other supported editors
- Want inline suggestions as you type
- Prefer suggestions integrated into your existing editor workflow

#### DragonAI (GitHub Agent)

Best for: Automating GitHub-based workflows

**When to use:**

- Want an AI agent that responds to GitHub issues and comments
- Need automated pull request generation
- Building CI/CD pipelines with AI assistance

**See also:** Our guide on [instructing the GitHub agent](how-tos/instruct-github-agent.md)

#### Goose

Best for: Command-line workflows and automation

**When to use:**

- Prefer working in the terminal
- Need scriptable AI interactions
- Want to integrate AI into existing shell scripts

**See also:** Our [Goose reference](reference/clients/goose.md)

### 3. Apply to Your Workflow

Once you've chosen a tool and completed initial training:

1. **Start small** - Pick a single, well-defined task
2. **Provide context** - Give the AI information about your domain and conventions
3. **Iterate** - Refine your prompts based on results
4. **Review carefully** - Always validate AI-generated content before committing

**Practical guides:**

- [Instruct the GitHub agent](how-tos/instruct-github-agent.md)
- [Make identifiers hallucination-resistant](how-tos/make-ids-hallucination-resistant.md)
- [Integrate AI into your KB](how-tos/integrate-ai-into-your-kb.md)
- [Ontology editing with AI](tutorials/ontology-editing-with-ai.md)

### 4. Expand Your Skills (Advanced)

Once comfortable with the basics, explore advanced topics:

- **Multi-agent workflows:** [Multi-agent Research System at Anthropic](https://www.anthropic.com/engineering/multi-agent-research-system)
- **Knowledge graph construction:** [Agentic Knowledge Graph Construction Course](https://www.deeplearning.ai/short-courses/agentic-knowledge-graph-construction/)
- **Claude Skills:** Our guide on [Claude Skills](reference/claude-skills.md) for creating reusable AI capabilities

## Quick Reference: Tool Selection

Not sure which tool to use? Here's a quick decision tree:

```
Do you need to make changes to files in a GitHub repo?
├─ Yes → Are you working on systematic, multi-file changes?
│  ├─ Yes → Claude Code or DragonAI
│  └─ No → GitHub Copilot (in-editor) or Claude Code
└─ No → Are you primarily asking questions or exploring ideas?
   ├─ Yes → Claude Desktop or web interface
   └─ No → Command-line workflows? → Goose
```

## Common Pitfalls to Avoid

1. **Expecting perfection on the first try** - AI tools work best with iteration and refinement
2. **Not providing enough context** - Share relevant documentation, examples, and conventions
3. **Skipping validation** - Always review AI-generated content, especially for critical data
4. **Using AI for everything** - Some tasks are still faster done manually
5. **Ignoring privacy** - Don't share sensitive data with AI tools unless you understand their privacy policies

## Getting Help

- Check our [FAQ](faq.md) for common questions
- Review our [Glossary](glossary.md) for terminology
- Explore topic-specific guides in our [how-tos](how-tos/instruct-github-agent.md) section
- See the [Reference section](reference/client-apps.md) for detailed tool documentation

## What's Next?

Now that you understand the landscape, we recommend:

1. **Complete the foundational reading** (Ethan Mollick's guide + your chosen tool's documentation)
2. **Pick one tool** and complete its tutorial or short course
3. **Try one real task** from your actual workflow
4. **Share your experience** - contribute back by documenting what worked (or didn't!)

Remember: the goal is to enhance your curation workflow, not replace your expertise. AI tools are most effective when they amplify your knowledge and judgment.
