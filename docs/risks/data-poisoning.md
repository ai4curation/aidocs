---
id: airisk:data-poisoning
title: Data poisoning
threat_class: instruction-manipulation
agent_specific: false
contexts: [development, production-adversary]
patterns: [ground-identifiers, fast-and-slow-validation]
related: [prompt-injection, cascading-errors, fabricated-content]
sources:
  owasp_llm_2025: [LLM04]
  owasp_llm_2026: [LLM05]
  mitre_atlas: [AML.T0020, AML.T0059]
  nist_ai_600_1: ["2.8", "2.9"]
  mit_ai_risk: ["2.2"]
  google_saif: [Data Poisoning]
---
# Data poisoning

**Watch for it when** your knowledge base ingests data you do not control.

Knowledge bases and data platforms take in submissions, harvested records and
upstream releases. If an agent processes that data, wrong or adversarial
content can flow into curated records. If others train or ground models on your
data, the damage spreads further.

## What it looks like in curation

- A submitted dataset with plausible but fabricated metadata.
- An upstream source that changes the meaning of an identifier.
- Free-text fields that carry instructions to whichever agent reads them next
  (see [Prompt injection](prompt-injection.md)).

## What helps

- Validate incoming data against a schema before it reaches an agent or a
  curated record. See [Fast and slow validation](../patterns/fast-and-slow-validation.md).
- Record where every ingested value came from, so a bad source can be traced and
  backed out.
- Check identifiers against their labels and sources. See
  [Make identifiers hard to fake](../patterns/ground-identifiers.md).
