# How to create curation skills

The behavior and capabilities of agents can easily be customized using [Agent skills](../reference/claude-skills.md).
Most of the time you will be working from GitHub repos that have a core set of skills predefined, and you might not need
to write your own skill or even modify existing ones.

But if you are defining a new SOP or adding a new capability, it can be useful to know the procedure for making skills.

Making skills is deceptively easy, and no matter what you do, it will likely "work" to some degree, because agents are generally
somewhat smart and resilient. But it's worth taking care to do it right to get the best results.

## Use a skill creator skill

Rather than hand-authoring a skill, use an agent to write the skill for you! Just describe to the agent what it
is you're trying to do and it will guide you through the process.

If you are doing this, always make sure you are using an up to date and highly capable coding agent harness
(e.g. latest claude code or codex), along with the most powerful model, and make sure you have the skill creator skill available.
If you don't there is a danger the agent will guess as to format and conventions. It is still good to check against the guidelines here.

!!! info "Further reading"

    - [Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) (Anthropic Engineering, Oct 2025) — the canonical introduction to skills; its advice to "start with evaluation" and iterate from observed agent behavior is exactly the mindset to bring to a skill-creator session.
    - [anthropics/skills](https://github.com/anthropics/skills) (Anthropic) — the public repo that ships the `skill-creator` skill itself, plus worked examples you can read to learn conventions firsthand.

## Use standard layouts

The challenge here is there is no standard that is guaranteed to work with all agents! But thankfully the proposed standards mostly agree and if you do things right then it's easy to
have your skills work with most agents.

Important: if you don't follow the standards, then most agents will probably find your skills anyway and use them appropriately -- most of the time! Except when they don't...
which can cause cryptic degradation of performance.

I find these two docs the most useful

- [https://agentskills.io/specification](https://agentskills.io/specification) --> the proposed standard
- [https://code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) --> de facto standard

!!! info "Further reading"

    - [Anthropic launches enterprise 'Agent Skills' and opens the standard](https://venturebeat.com/technology/anthropic-launches-enterprise-agent-skills-and-opens-the-standard) (VentureBeat, Dec 2025) — context on why the layout was standardized and why following it matters: within weeks of the open-standard announcement it was adopted across 20+ platforms (OpenAI, Google, GitHub, Cursor), so a spec-conformant skill is increasingly portable rather than Claude-only.

I'll first cover the claude de facto standard. Let's say I have two skills, I'll make the folder structure like this (always at the root of the GitHub repo):

```
.claude/
  skills/
    my-awesome-skill/
      SKILL.md
      <other files>
    my-brilliant-skill/
      SKILL.md
      <other files>
```

I will also typically make symlinks, either

- between `.agents -> .claude`
- between `.agents/skills -> ../.claude/skills`

Many non-claude agents will work just fine with `.claude`. You can always test it out later.

Note that previously claude code had separate mechanisms for skills and commands, and commands followed a slightly different structure:

```
.claude
  commands/
    my-awesome-command.md
    my-brilliant-command.md
```

There is now no need to make commands, as every skill can be invoked as a command. So don't make commands, just make skills.

## Use frontmatter in the SKILL.md

From [Anthropic guide](https://code.claude.com/docs/en/skills):

Every skill needs a SKILL.md file with two parts: YAML frontmatter between `---` markers that tells Claude when to use the skill, and markdown content with the instructions Claude follows when the skill runs. The directory name becomes the command you type, and the `description` helps Claude decide when to load the skill automatically.

I always include a `name` as well as a `description`, even though the name is a bit redundant:

```
---
name: my-awesome-skill
description: Use this skill to do <some awesome thing>
---

<detailed description here>

```

It may be possible to get away without writing frontmatter -- if you don't include it claude code will default to the directory name for `name` and the first paragraph of the markdown as `description`. But by including
the frontmatter, you make the separation clearer for other *humans* who come after you and edit the markdown.

You should also make sure you follow yaml syntax. Annoyingly, claude code can be lenient on broken yaml, which can burn you when you try and use the skill with another agent harness.

## Understand progressive disclosure

The Claude docs give you the three levels cleanly: (1) name + description preloaded into the system prompt so the agent knows the skill exists; (2) the full SKILL.md body, loaded only when the skill is invoked; (3) bundled files (reference.md, scripts, examples) referenced from SKILL.md and loaded only when the agent decides it needs them. Worth adding the practical consequence: keep SKILL.md lean because once invoked it stays in context for the rest of the session, and push bulky reference material to level-3 files.

!!! info "Further reading"

    - [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) (Anthropic Engineering, 2025) — the "why" behind progressive disclosure: context is a finite, degrading resource, so loading only what's relevant is a first-class design constraint, not just a tidiness preference.
    - [Code execution with MCP: building more efficient agents](https://www.anthropic.com/engineering/code-execution-with-mcp) (Anthropic Engineering, Nov 2025) — takes the same idea further, showing how moving tool catalogs out of context and into on-demand code cut one workflow from ~150K tokens to ~2K; a useful intuition pump for how aggressively level-3 material should be deferred.

??? abstract "What the research shows (with numbers)"

    - [*SkillJuror: Measuring How Agent Skill Organization Changes Runtime Behavior*](https://arxiv.org/abs/2606.11543) (arXiv, Jun 2026) — across 82 tasks, progressive disclosure raised the distinct skill resources an agent accessed per run from **1.18 to 3.85** and produced **+4.1%** more verifier-passing trials than a flat layout. Gains were largest when bundled resources guide implementation, checking, or repair, and weakest for exact-format or numeric-threshold tasks — a good cue for *what* belongs in level-3 files.
    - [*Evaluating Long-Context Reasoning in LLM-Based WebAgents*](https://arxiv.org/abs/2512.04307) (arXiv, Dec 2025) — agent success **fell from 40–50% to under 10%** as context grew from 25K to 150K tokens, with agents losing track of the original task. Concrete motivation for keeping SKILL.md lean: a bloated skill body doesn't just waste tokens, it degrades reasoning.

## Include wrapper scripts

Some skills might not involve any new tools. For example, a review skill might give a checklist for the agent to follow and tick off items.

In other cases, a skill might exist in order to give the agent a specific piece of functionality, or to guide it in correct use of a tool. There are different approaches here:

1. standalone bash or python scripts in the skills folder
    - these might wrap an external API
    - or they might import python modules and provide a shim onto them
2. instructions inlined in the skill markdown
     - instructions on how to call an external API
     - instructions/examples on python scripts that use a particular module or modules
  
This is partly a matter of style, but I generally prefer to include scripts. These are easier to test standalone,
and allow me to constrain the actions of the agent more. The exception is if the skill is highly open-ended by nature,
then I might prefer to document a flexible module and give some examples of use in the markdown.

My skills folder might end up looking like this:

```
.claude/
  skills/
    my-awesome-skill/
      SKILL.md
      scripts/
        do-the-thing.sh
```


Example: https://github.com/cmungall/lakehouse-skills/tree/main/kbase-query

## Modularize your skills

Ideally skills should be relatively standalone. Don't assume tacit knowledge beyond what is already documented in your `CLAUDE.md` or `AGENTS.md`.

## Favor skills over MCPs (mostly)

MCPs are a good solution for giving agents capabilities in more constrained environments; an http MCP is good if you want people to use it in a web based chat.

In general skills, provide more flexibility, and general fewer tokens and context flooding. However, if you already have MCPs for a particular capability and they work fine for you there may be no pressing reason to rewrite

!!! info "Further reading"

    - [Claude Skills are awesome, maybe a bigger deal than MCP](https://simonwillison.net/2025/Oct/16/claude-skills/) (Simon Willison, Oct 2025) — argues skills are conceptually simpler than MCP (a markdown file plus optional scripts) and often the better default, which is the same trade-off this section describes.
    - [Code execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) (Anthropic Engineering, Nov 2025) — the counterpoint: rather than skills *vs* MCP, it shows how to keep MCP servers but stop flooding context with their tool definitions, so an existing MCP need not be rewritten.

## Consider not writing a skill

Many people think they need to write a skill to perform a task they think of as challenging or requiring specialized knowledge. But in fact the models used by
agents have already learned common APIs, and agents can easily do research to find relevant docs. Of course, dynamic doc discovery is prone to flakiness, latency.

Even if your agent knows how to parse fasta files (for example), you may still want to write a skill that guides the agent do it *your* preferred way (you might
have particular conventions in your fasta files, or you may have particular environment considerations). I often tend to write skills not because the agent doesn't
know how to do something, but because I have latent knowledge that overrides its defaults.

!!! info "Further reading"

    - [Writing effective tools for AI agents](https://www.anthropic.com/engineering/writing-tools-for-agents) (Anthropic Engineering, Sep 2025) — though framed around tools rather than skills, its core lesson applies directly: don't build thin wrappers around things the agent can already do; reserve new capabilities for genuine, high-leverage gaps.

## Test your skill

The first thing to do is test if your agent is aware of your skill. You can list skills in most coding tools with the `/skills` command, which should show something like:

```
  ✔ on         annotation-reviewer · project · ~120 tok
  ✔ on         bioinformatics-analyzer · project · ~160 tok
```

If you don't see your skill there then you may have a problem, e.g. something is in the wrong folder. Again it may not manifest as agents like to dig around folders and they may find your skills
and use them... until they don't.

## Optional: Create a skills marketplace

TODO
