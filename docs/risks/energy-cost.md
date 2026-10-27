---
id: airisk:energy-cost
title: Energy cost without benefit
threat_class: resources-and-sustainability
agent_specific: false
taxonomy_gap: true
contexts: [development, production-unintentional]
related: [runaway-consumption, infrastructure-load]
sources:
  nist_ai_600_1: ["2.5"]
  mit_ai_risk: ["6.6"]
---
# Energy cost without benefit

**Watch for it when** you cannot say what an agent run achieved.

Agent runs use energy and money. The risk is not that they cost something; it is
that they cost something and achieve nothing. Security taxonomies leave energy
out entirely. NIST and the MIT repository list environmental impact, but none
frames the question a project can act on: was this run worth it?

## What it looks like in curation

- Scheduled agents that run whether or not there is work.
- The largest model used for routine lookups.
- No record of what a pipeline produced, so its cost cannot be weighed.

## What helps

- Record tokens and cost per task and per pipeline, next to what each produced.
- Run scheduled agents only when a scanner has found work.
- Cache results, and use smaller models for routine steps.
- For measurement methods, see the Green Software Foundation's
  [SCI for AI](https://greensoftware.foundation/standards/sci-ai/).
