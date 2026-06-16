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

## Use standard layouts

The challenge here is there is no standard that is guaranteed to work with all agents! But thankfully the proposed standards mostly agree and if you do things right then it's easy to
have your skills work with most agents.

Important: if you don't follow the standards, then most agents will probably find your skills anyway and use them appropriately -- most of the time! Except when they don't...
which can cause cryptic degradation of performance.

I find these two docs the most useful

- [https://agentskills.io/specification](https://agentskills.io/specification) --> the proposed standard
- [https://code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) --> de facto standard

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

It may be possible to get away without writing frontmatter -- if you don't include it claude code will default to the directory name for `name` and the first paragraph of the markdown as `description`. But my including
the frontmatter you make the separation clearer for other *humans* who come after you and edit the markdown..

## Understand progressive disclosure

The Claude docs give you the three levels cleanly: (1) name + description preloaded into the system prompt so the agent knows the skill exists; (2) the full SKILL.md body, loaded only when the skill is invoked; (3) bundled files (reference.md, scripts, examples) referenced from SKILL.md and loaded only when the agent decides it needs them. Worth adding the practical consequence: keep SKILL.md lean because once invoked it stays in context for the rest of the session, and push bulky reference material to level-3 files.

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

## Favor skills over MCPs (mostly)

TODO

## Consider not writing a skill

Many people think they need to write a skill to perform a task they think of as challenging or requiring specialized knowledge. But in fact the models used by
agents have already learned common APIs, and agents can easily do research to find relevant docs. Of course, dynamic doc discovery is prone to flakiness, latency.

Even if your agent knows how to parse fasta files (for example), you may still want to write a skill that guides the agent do it *your* preferred way (you might
have particular conventions in your fasta files, or you may have particular environment considerations). I often tend to write skills not because the agent doesn't
know how to do something, but because I have latent knowledge that overrides its defaults.

## Test your skill

TODO

## Optional: Create a skills marketplace

