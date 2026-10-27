---
id: airisk:runaway-consumption
title: Runaway consumption
threat_class: resources-and-sustainability
agent_specific: false
contexts: [development, production-adversary, production-unintentional]
patterns: [scanners]
related: [infrastructure-load, energy-cost]
sources:
  owasp_llm_2025: [LLM10]
  owasp_llm_2026: [LLM06]
  owasp_agentic_threats: [T4]
  cosai_mcp: [MCP-T10]
  mitre_atlas: [AML.T0034, AML.T0029]
  google_saif: [Denial of ML Service]
---
# Runaway consumption

**Watch for it when** agents run on a schedule, in a loop, or on someone else's account.

Agents retry, loop and fan out. A stuck job can spend a month's budget in a
night, and an endpoint that runs a model per request can be made to do so on
purpose.

## What it looks like in curation

- A scheduled agent that reprocesses the whole knowledge base every run.
- A loop between two bots that reply to each other.
- A personal API key used for project work, with no spending limit.

## What helps

- Spending limits and alerts on every key. Use project keys or an institutional
  gateway, not personal keys.
- Turn on scheduled agents one at a time, and match the model and cadence to
  the job. See [Scanners find the work](../patterns/scanners.md).
- Rate-limit any endpoint that runs a model per request.
