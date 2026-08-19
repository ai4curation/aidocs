# Scanners find the work

**Use it when** agents only act if a human remembers to ask.

Most agent setups are reactive. Someone opens an issue, mentions the agent, and
the agent responds. The work that nobody files never happens.

A scanner is a scheduled job that looks for work and creates it.

## The pattern

Run each scanner on its own schedule. Each one answers a different question.

| Scanner | Question it answers |
| --- | --- |
| Literature scan | What new papers affect entries we already have? |
| Knowledge gap scan | Which entries are missing required fields? |
| Stalled work scan | Which issues and pull requests have gone quiet? |
| Compliance scan | Which entries fall below our quality bar? |

[DisMech](../case-studies/dismech.md) runs all four. Its cadences live in
`.github/cron-profiles.yaml`, separate from the workflow files, so you can
change how often something runs without editing the job.

## Match the model to the risk

Not every scanner needs your best model. DisMech runs its pull request reviewer
on a top-tier model always, and lets low-risk scanners use cheaper ones. The
per-job model choice lives in `.github/agent-config.yaml`.

It also has a `low_effort` label, so a human can send one specific task to a
cheaper model by hand.

[culturebotai-claw](../case-studies/communitymech.md) assigns a tier per agent
in the same way: documentation on a cheap model, integrity auditing on an
expensive one.

## Start with one

A literature scanner is usually the best first one. It produces issues a curator
can judge quickly, and it does not change any curated content on its own.

Set the cadence low to begin with. A scanner that files thirty issues a day gets
ignored within a week, and an ignored scanner is worse than no scanner.

## Keep tuning it

Scanner cadence is one of the dials that
[regulating the loop](human-regulating-the-loop.md) is about. Ask regularly
whether each scanner is too eager or not eager enough.
