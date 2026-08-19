# copilot-swe-agent

GitHub's own coding agent. You assign it an issue, and it opens a draft pull
request and works in the background.

**Kind**: GitHub App
**Byline**: `copilot-swe-agent[bot]`
**Used in**: [EFO](../../case-studies/efo.md),
[Uberon](../../case-studies/uberon.md)

## What it does

Assign an issue to Copilot and it works in its own environment, pushing commits
to a draft pull request as it goes. All those commits are authored by
`copilot-swe-agent[bot]`, not by the person who delegated the task.

It is the only bot here that needs no workflow of your own to run the agent.
The agent runs on GitHub's infrastructure.

## How it is wired

Add `.github/workflows/copilot-setup-steps.yml`. The job must be named
`copilot-setup-steps` or GitHub will not pick it up:

```yaml
jobs:
  copilot-setup-steps:
    runs-on: ubuntu-latest
    permissions:
      contents: read
```

The job installs whatever the agent needs before it starts. Copilot is given its
own token for its own operations, and it checks out the repository for you if
you do not.

Instructions go in `.github/copilot-instructions.md`. Keep one authoritative
instructions file and make the others pointers. See
[One source of instructions](../../patterns/one-source-of-instructions.md).

Uberon's [pull request 3580](https://github.com/obophenotype/uberon/pull/3580)
shows the two files to change.

## The firewall

Copilot's agent runs behind a firewall that blocks most external hosts by
default. For ontology work this bites immediately: `purl.obolibrary.org` is
blocked, so PURL-based imports fail.

Allowlist the hosts you need in the repository's Copilot settings. See
[GitHub Copilot](../github-copilot.md) for the steps and the workarounds.

## Notes

* Naming differs by context. The login is `copilot-swe-agent`; API calls that
  assign an issue need the exact string `copilot-swe-agent[bot]`.
* It is a good fit for work that starts from a well-specified issue. It is a
  poorer fit for exploratory curation, where you want to steer as you go.
