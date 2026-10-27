---
id: airisk:data-exfiltration
title: Data exfiltration
threat_class: secrets-and-data-exposure
agent_specific: true
contexts: [development, production-adversary, production-unintentional]
patterns: [guard-untrusted-input]
related: [prompt-injection, secret-exposure, unprotected-endpoints]
sources:
  owasp_llm_2025: [LLM02, LLM07]
  owasp_llm_2026: [LLM02, LLM08]
  owasp_agentic_top10: [ASI01, ASI02]
  owasp_agentic_threats: [T2]
  owasp_mcp_top10: [MCP10]
  cosai_mcp: [MCP-T5]
  mitre_atlas: [AML.T0086, AML.T0057, AML.T0077, AML.T0056]
  nist_ai_600_1: ["2.4"]
  mit_ai_risk: ["2.1"]
  google_saif: [Sensitive Data Disclosure, Excessive Data Handling]
---
# Data exfiltration

**Watch for it when** one agent session has private data, untrusted input and a way to send data out.

Most curation data is open, but not all of it. Embargoed or pre-publication
data, controlled-access records, unpublished manuscripts, and the agent's own
instructions and tool definitions are not meant to leave. An agent that can read
them and can also fetch URLs, post comments or call tools can be steered into
sending them somewhere.

Exfiltration also happens without an attacker. Prompts sent to a hosted model
leave your institution, and a provider's terms decide whether they are kept or
used for training.

## What it looks like in curation

- An agent with access to embargoed records that also has a web-fetch tool.
- A rendered link or image in a comment that carries data in its URL.
- Staff pasting unpublished data into a personal chat assistant.

## What helps

- Remove one leg of the trifecta: no outbound channel in sessions that read
  private data, or no private data in sessions that read untrusted input. See
  [Guard the untrusted surface](../patterns/guard-untrusted-input.md).
- An agent acts as a user and never sees more than that user may. Enforce access
  in the data platform, not in the prompt.
- Use institutional model accounts with no-training terms, and say which
  features send data to which provider.
