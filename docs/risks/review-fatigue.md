---
id: airisk:review-fatigue
title: Review fatigue and overreliance
threat_class: oversight-and-accountability
agent_specific: false
contexts: [development]
patterns: [human-regulating-the-loop, review-checklists]
related: [fake-success, fabricated-content]
sources:
  owasp_agentic_top10: [ASI09]
  owasp_agentic_threats: [T10, T15]
  cosai_mcp: [MCP-T2]
  nist_ai_600_1: ["2.7"]
  mit_ai_risk: ["5.1", "5.2"]
---
# Review fatigue and overreliance

**Watch for it when** agents produce more pull requests than people can read.

"Human in the loop" fails quietly. Once agents produce more work than curators
can review, review turns into rubber-stamping, and the human check that every
other control relies on is no longer there.

## What it looks like in curation

- Pull requests approved within a minute of opening.
- Reviewers who trust the agent's summary of its own change.
- Curators who stop doing the parts of the work the agent now drafts, and lose
  the skill to check it.

## What helps

- Spend curator time on the process, not on every item. See
  [Regulate the loop](../patterns/human-regulating-the-loop.md).
- Automate the checks that can be automated, and give reviewers one checklist
  for the rest. See [One review checklist](../patterns/review-checklists.md).
- Throttle agents to the rate your reviewers can sustain.
