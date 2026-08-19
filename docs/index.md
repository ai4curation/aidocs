# AI4Curators

Practical guides for curators and maintainers of
[knowledge bases](glossary.md#knowledge-base-kb) who want to use AI agents in
the workflows they already have.

Agents are curating real ontologies and knowledge bases today. This site points
you at those repositories and explains what they do, so you can copy working
setups instead of designing your own from scratch.

## Start here

**If you curate**, and you want to try an agent on a real task:

1. Read [Your first curation session](tutorials/first-curation-session.md).
2. Read [Instruct the GitHub agent](how-tos/instruct-github-agent.md) for how to
   ask an agent for work through an issue.
3. Look at [DisMech](case-studies/dismech.md) to see what a project run this way
   looks like from the inside.

**If you maintain a repository**, and you want agents working in it:

1. Read the [case studies](case-studies/index.md) for repositories like yours.
2. Read the [patterns](patterns/index.md) they have in common.
3. Follow [Set up GitHub Actions](how-tos/set-up-github-actions.md) to add an
   agent to your repository.
4. Add validation before you add automation. See
   [Make identifiers hard to fake](patterns/ground-identifiers.md).

## What is on this site

| Section | What it holds |
| --- | --- |
| [Case studies](case-studies/index.md) | One page per repository that runs agents on real curation |
| [Patterns](patterns/index.md) | Practices that appear in more than one of them |
| [How-tos](how-tos/instruct-github-agent.md) | Step-by-step tasks |
| [Reference](reference/harnesses.md) | Harnesses, tools, and GitHub integrations |
| [Evidence](evidence.md) | What we measure across these repositories |
| [Glossary](glossary.md) | Terms used on this site |

## How this site works

We do not centralize guidance here. Repositories are the source of truth, and
they change faster than documentation does. Each page points at files and
folders you can open.

If a page disagrees with the repository it describes, trust the repository and
[tell us](https://github.com/ai4curation/aidocs/issues).
