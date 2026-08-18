# Evidence

We measure what these repositories actually do, rather than what they say they
do. This page describes where the observations on this site come from.

## agent-watcher

`ai4curation/agent-watcher` scans repositories where agents are deployed and
publishes dated reports.

!!! note

    The agent-watcher repository is currently private, so the links in this
    section need access. The counts below are reproduced here so you can read
    them without it.

It runs two jobs:

**Per-repository activity reports.** For each watched repository, it collects
recently updated issues and pull requests, marks the ones that involve an agent,
and asks a model to write a plain-language assessment of what is working and
what is not. Reports appear as dated issues, one per repository per report date.

**A weekly cross-repository setup review.** This one compares the ontology
repositories against each other: instruction files, workflow conventions, and
whether repeated work is broken into skills, commands, or subagents.

The setup reviews are the source of the skill, subagent, and workflow counts in
our [case studies](case-studies/index.md). This is the snapshot from the setup review of 10 August 2026:

| Repository | Instructions | Subagents | Skills and commands | Agent workflows |
| --- | ---: | ---: | ---: | ---: |
| [EFO](case-studies/efo.md) | 3 | 8 | 2 | 1 |
| [GO](case-studies/go-ontology.md) | 2 | 0 | 10 | 3 |
| [Mondo](case-studies/mondo.md) | 2 | 6 | 4 | 2 |
| [Cell Ontology](case-studies/cell-ontology.md) | 1 | 0 | 0 | 2 |
| [Uberon](case-studies/uberon.md) | 2 | 8 | 1 | 3 |

Counts change. Check the latest report before you rely on a number here.

### Why this design is worth copying

Two parts of agent-watcher transfer to other monitoring jobs.

**The collector does not judge.** It produces a neutral document of counts and
timelines. The model reads that document and writes the assessment. Keeping the
measurement separate from the judgment means you can check both.

**Reading and writing are separated.** The watcher reads the repositories it
watches with a read-only token, and publishes its reports into a different
repository. It cannot modify anything it observes. See
[Guard the untrusted surface](patterns/guard-untrusted-input.md).

## Execution traces

agent-watcher also mines and publishes agent execution traces under
`public-traces/`. Each trace covers one agent pull request: the pull request,
the workflow runs behind it, and the log.

Traces are the only way to answer questions like which tool the agent called
before it produced a wrong answer, or how many attempts a task took. Reports
tell you what happened. Traces tell you why.

## Provenance in the repository

[ai-blame](https://github.com/ai4curation/ai-blame) extracts provenance from
agent execution traces and gives you line-level attribution: which lines an
agent wrote, when, and in what session.

Some projects record provenance in the data itself instead. The CultureBot
mechs have a `CurationEvent` class in their schema that records who made each
change and whether a model assisted. See
[CommunityMech](case-studies/communitymech.md).

## What we do not measure yet

* **Quality over time.** We can count agent pull requests. We cannot yet say
  whether the entries they produce are getting better.
* **What review catches.** Automated reviewers request changes. Nobody has
  measured which categories of error they reliably catch and which they miss.
* **Community feedback as a signal.**
  [AI Gene Review](case-studies/ai-gene-review.md) collects votes from domain
  experts. Turning those into a number you can track across releases is open
  work.

These are the three most useful things anyone reading this site could build.
