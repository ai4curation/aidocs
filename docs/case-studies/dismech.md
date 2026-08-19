# DisMech

A knowledge base of disease mechanisms. Most edits come from agents. Humans
review the process rather than every entry.

**Repository**: [monarch-initiative/dismech](https://github.com/monarch-initiative/dismech)
**Site**: [dismech.monarchinitiative.org](https://dismech.monarchinitiative.org/app/)
**Product**: `kb/disorders/*.yaml`, one file per disorder
**Agent surface**: local sessions, Claude Code on the web, GitHub mention, and
about 28 workflows

DisMech is the most developed agentic curation setup we know of. Read its
[`CONTRIBUTING.md`](https://github.com/monarch-initiative/dismech/blob/main/CONTRIBUTING.md)
first. It is a guide to running a curation project with agents, not only a guide
to this repository.

## What to look at

| Path | What it is |
| --- | --- |
| [`CONTRIBUTING.md`](https://github.com/monarch-initiative/dismech/blob/main/CONTRIBUTING.md) | How the project works, written for humans |
| [`.claude/skills/`](https://github.com/monarch-initiative/dismech/tree/main/.claude/skills) | Seventeen skills, including `curate-next`, `dismech-terms`, `dismech-references`, and `dismech-pr-review` |
| [`.github/workflows/`](https://github.com/monarch-initiative/dismech/tree/main/.github/workflows) | Review, scanners, guards, and site builds |
| `.github/agent-config.yaml` | Which model each automated job uses |
| `.github/cron-profiles.yaml` | How often each scanner runs |
| `src/dismech/schema/dismech.yaml` | The LinkML schema |
| `docs/explanation/design-decisions.md` | Why the project is built this way |
| `justfile` | Every validation command |

## What works

### The philosophy is written down

`CONTRIBUTING.md` states the rules of the project in plain language:

* Assume that issues and comments are AI-generated. If you write something
  yourself and want that known, mark it `[human authored]`.
* Contributors are not expected to check agent output themselves. Review is a
  process, not a personal duty.
* Use top-tier models. Weaker models produce work that review has to send back,
  which costs everyone time.
* Be bold. Every team member is encouraged to do work that ends in a pull
  request.

Most projects leave these questions unanswered and each contributor guesses.

### Humans regulate the loop

The project asks curators to fix patterns rather than entries:

> look for *patterns* where results are suboptimal; curate examples and
> counter-examples; work with agent to integrate this into the process

It also asks curators to review the reviews, and to check whether each automated
process is too eager or not eager enough. See
[Regulate the loop](../patterns/human-regulating-the-loop.md).

### Human documentation is treated as perishable

`CONTRIBUTING.md` warns that it may be out of date, and tells you to ask the
agent instead:

> "I want to contribute. How?"
> "Explain what this repo is"
> "I noticed a problem on one of the pages -- what should I do?"

The repository is the current answer. The document is a snapshot.

### Validation has a fast loop and a slow loop

`just count-verified-snippets` checks evidence quotes against a local cache in
seconds, so you can run it while you curate. `just validate-disorders` runs the
full schema, term, and reference sweep, and is meant to run once before you open
the pull request. See
[Fast and slow validation](../patterns/fast-and-slow-validation.md).

### Scanners find work

Separate workflows scan the literature for new papers, look for incomplete
entries, and move stalled issues and pull requests forward. Low-risk scanners
may use cheaper models. A `low_effort` label lets a human assign a task to a
cheaper model by hand. See [Scanners](../patterns/scanners.md).

### Two bots, so review counts

DisMech runs two GitHub Apps of its own.
[`ai4c-agent`](https://github.com/apps/ai4c-agent) does the work. It responds to
mentions and moves stalled pull requests forward.
[`ai4c-reviewer`](https://github.com/apps/ai4c-reviewer) reviews and supplies
the approving review that branch protection requires.

The split exists because GitHub does not let an identity approve its own pull
request. One bot doing both jobs would mean every agent pull request needed a
human approval, which would undo the whole model. See [Bots](../reference/bots.md).

The `dragon-ai-agent` machine account is retired here. The
`@dragon-ai-agent please ...` mention survives as a trigger keyword only.

### The untrusted surface is guarded

Pull requests from forks are closed, because GitHub does not give fork workflows
the secrets that automated review needs. A separate workflow guards untrusted
comments, and only registered controllers can summon the agent.

## What to copy first

Copy `CONTRIBUTING.md` and edit it for your project. Deciding who is accountable
for agent output, and saying so in writing, costs nothing and prevents the most
common argument.

If you are starting a new knowledge base rather than adding agents to an
existing one, copy the repository shape instead: one YAML file per record, a
LinkML schema, and a `justfile` with fast and slow validation targets. See
[Create an agentic curation pipeline](../how-tos/create-agentic-curation-pipeline.md).

## Gaps

The project describes itself as alpha and experimental, and says so on the
front page along with a clear statement that it is not medical advice.
Validation proves that citations exist, that quoted text is exact, and that
ontology terms are real. It does not prove that a claim is scientifically
correct. That distinction is stated in the README, and every project running
this pattern should state it too.

Twenty-eight workflows is a lot to hold in your head. The repository handles
this by telling you to ask an agent for the current picture rather than reading
a list. That works, but it means a newcomer cannot audit the automation without
running an agent.
