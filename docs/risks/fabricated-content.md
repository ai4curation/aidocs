---
id: airisk:fabricated-content
title: Fabricated identifiers, citations and facts
threat_class: output-integrity
agent_specific: false
taxonomy_gap: true
contexts: [development, production-unintentional]
patterns: [ground-identifiers, fast-and-slow-validation]
related: [cascading-errors, fake-success, review-fatigue]
sources:
  owasp_llm_2025: [LLM09]
  owasp_llm_2026: [LLM07]
  owasp_agentic_threats: [T5]
  nist_ai_600_1: ["2.2", "2.8"]
  mit_ai_risk: ["3.1"]
---
# Fabricated identifiers, citations and facts

**Watch for it when** an agent writes an identifier, a citation or a quote.

This is the main integrity risk for curated knowledge. Models produce ontology
term IDs, PMIDs, DOIs and accessions that are well formed and wrong, and quotes
that the cited paper does not contain. They look right, so they pass a quick
read.

The taxonomies call this confabulation or misinformation in general terms. None
names fabricated scientific identifiers and evidence specifically.

## What it looks like in curation

- `GO:0006954` recorded for a process it does not denote.
- A PMID that exists but is about something else.
- A "supporting quote" stitched together from two sentences.

## What helps

- Never record a bare identifier. Record it with a label, a source or a quote
  that must match, and check the match automatically. Ask for receipts. See
  [Make identifiers hard to fake](../patterns/ground-identifiers.md).
- Run those checks while the agent works, not only at review. See
  [Fast and slow validation](../patterns/fast-and-slow-validation.md).
- Tools: [linkml-term-validator](../glossary.md#linkml-term-validator) and
  [linkml-reference-validator](../glossary.md#linkml-reference-validator).
