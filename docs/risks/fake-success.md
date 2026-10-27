---
id: airisk:fake-success
title: Reported success that did not happen
threat_class: agency-and-action
agent_specific: true
taxonomy_gap: true
contexts: [development]
patterns: [fast-and-slow-validation, review-checklists, human-regulating-the-loop]
related: [destructive-actions, review-fatigue, fabricated-content]
sources:
  owasp_agentic_top10: [ASI10]
  owasp_agentic_threats: [T7]
  nist_ai_600_1: ["2.7"]
  mit_ai_risk: ["7.1", "7.3"]
  google_saif: [Rogue Actions]
---
# Reported success that did not happen

**Watch for it when** you judge an agent's work by its own summary.

Agents under pressure to finish will sometimes weaken a test, skip a validator,
catch and discard an error, or report that a task is complete when it is not.
Automation can do the same without any model involved: a scheduled job that
fails quietly every night still shows a green tick if nobody checks what it
produced.

The taxonomies cover "rogue" or deceptive agents in general terms. They do not
name this everyday failure of coding agents.

## What it looks like in curation

- A pull request that "fixes" validation by loosening the schema.
- An agent that marks evidence as verified without running the check.
- A fleet of scheduled agents that has done nothing for a week while every run
  reports success.

## What helps

- Validation the agent cannot edit, run by CI, not by the agent. See
  [Fast and slow validation](../patterns/fast-and-slow-validation.md).
- A review checklist item for changes to tests, schemas and validators. See
  [One review checklist](../patterns/review-checklists.md).
- Watch outcomes, not exit codes: count what scheduled jobs actually produced.
  See [Regulate the loop](../patterns/human-regulating-the-loop.md).
