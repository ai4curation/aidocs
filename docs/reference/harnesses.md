# Harnesses

A harness is the program that runs the agent loop. It sends your instructions to
a model, runs the tools the model asks for, and feeds the results back.

The harness matters less than how you set up your repository. A well-configured
repository works with several harnesses. A badly configured one works with none.
Choose from this page, then spend your time on
[patterns](../patterns/index.md).

## What to use

| Harness | Where it runs | Instructions file | Use it for |
| --- | --- | --- | --- |
| [Claude Code](https://claude.ai/code) | Terminal, web, desktop, GitHub Actions | `CLAUDE.md` | Most curation work |
| [Codex](https://github.com/openai/codex) | Terminal | `AGENTS.md` | The same work, with OpenAI models |
| [GitHub Copilot coding agent](https://docs.github.com/en/copilot) | GitHub | `.github/copilot-instructions.md` | Issue to pull request inside GitHub |

All the repositories in our [case studies](../case-studies/index.md) use Claude
Code, Codex, or both. Several also support Copilot.

## Use a capable model

[DisMech](../case-studies/dismech.md) states this as a project rule:

> You should always use best-of-class models, and up to date high quality
> harnesses. Using less powerful models is more likely to generate lower
> quality content.

Weak model output does not disappear. It arrives at review, gets sent back, and
costs a curator time. The exception is low-risk background work, where a cheaper
model is appropriate. See [Scanners find the work](../patterns/scanners.md).

## Run in the cloud if installing is hard

Many curators cannot install command line software, because of institutional IT
rules or because the setup is unfamiliar. You do not have to.

[Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web)
clones the repository for you, runs the session in a cloud container, and opens
the pull request when you are done. DisMech's
[`CONTRIBUTING.md`](https://github.com/monarch-initiative/dismech/blob/main/CONTRIBUTING.md)
has step-by-step setup instructions, including the one-time environment
configuration that new users find hardest.

For a whole team at once, a shared hosted environment removes the account and
key problem as well as the installation problem. The Gene Ontology consortium
runs a JupyterHub instance for its workshops, where each participant logs in
with GitHub and gets a workspace with an agent already configured, on a central
key they never see.

## Historic

**Goose.** Earlier versions of this site recommended
[Goose](https://block.github.io/goose/) for curators who were not comfortable at
the command line. We no longer recommend it for new setups. It is still in use:
[Mondo's](../case-studies/mondo.md) `ai-agent.yml` runs dragon-ai-agent on
Goose, and Goose configuration remains in a few repositories. Keep it working
where it is deployed. Do not start there.

**dragon-ai-agent.** The agent behind the `@dragon-ai-agent` mention in several
OBO repositories. Still running in Mondo and elsewhere. New repositories should
use a Claude Code Action workflow instead. See
[GitHub integrations](github-integrations.md).

## Give every session the same tools

Do not rely on curators configuring MCP servers themselves. Check the
configuration into the repository. [EFO](../case-studies/efo.md) declares its
two servers in `.mcp.json`, so every session gets ontology lookup and literature
access without setup.
