---
id: airisk:cascading-errors
title: Cascading errors
threat_class: output-integrity
agent_specific: true
contexts: [development, production-unintentional]
patterns: [ground-identifiers, human-regulating-the-loop]
related: [fabricated-content, data-poisoning, untraceable-actions]
sources:
  owasp_agentic_top10: [ASI08]
  owasp_agentic_threats: [T5, T12]
  mitre_atlas: [AML.T0059, AML.T0118]
  nist_ai_600_1: ["2.6", "2.8"]
  mit_ai_risk: ["3.2", "7.6"]
---
# Cascading errors

**Watch for it when** agents read what other agents wrote.

Knowledge bases feed each other. When agent-written records in one resource
become the evidence for agents curating another, a single error can spread, and
repeated agreement between agents can look like independent confirmation. Over
time, agent-written text also tends to make curated content more uniform.

## What it looks like in curation

- An agent cites another knowledge base's agent-generated summary as evidence.
- A wrong mapping copied across several resources within a release cycle.
- Review agents agreeing with the authoring agent because they share a model.

## What helps

- Ground claims in primary evidence, not in other curated summaries. See
  [Make identifiers hard to fake](../patterns/ground-identifiers.md).
- Record which records were agent-written, so downstream users can tell. See
  [Untraceable agent actions](untraceable-actions.md).
- Look for repeated errors and fix the process that made them. See
  [Regulate the loop](../patterns/human-regulating-the-loop.md).
