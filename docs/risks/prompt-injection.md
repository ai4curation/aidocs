---
id: airisk:prompt-injection
title: Prompt injection
threat_class: instruction-manipulation
agent_specific: false
contexts: [development, production-adversary, production-unintentional]
patterns: [guard-untrusted-input, human-regulating-the-loop]
related: [ci-agent-injection, tool-poisoning, poisoned-instructions, data-exfiltration]
sources:
  owasp_llm_2025: [LLM01]
  owasp_llm_2026: [LLM01]
  owasp_agentic_top10: [ASI01]
  owasp_agentic_threats: [T6]
  owasp_mcp_top10: [MCP06]
  cosai_mcp: [MCP-T4]
  mitre_atlas: [AML.T0051, AML.T0093]
  nist_ai_600_1: ["2.9"]
  mit_ai_risk: ["2.2"]
  google_saif: [Prompt Injection]
---
# Prompt injection

**Watch for it when** an agent reads text that someone else wrote.

A model cannot reliably tell your instructions apart from instructions hidden in
the material it is working on. Text in an issue, a pull request, a paper, a web
page, a dataset description or a tool result can redirect the agent.

## What it looks like in curation

- A comment on a public issue asks the agent to "also update the workflow file".
- A fetched abstract contains a line telling the agent to ignore the evidence
  rules.
- A free-text metadata field in a submitted dataset carries instructions to the
  agent that later summarizes it.

Plain chat is mostly harmless. The risk grows with what the agent can do: a
read-only summarizer can be misled, but an agent holding a write token can be
steered into using it.

## What helps

- Control who can start a run, and treat everything the agent reads as data.
  See [Guard the untrusted surface](../patterns/guard-untrusted-input.md).
- Keep the credentials an agent holds no stronger than the least trusted text it
  reads. Instructions are guidance; credentials are the control.
- Avoid the *lethal trifecta*: private data, untrusted content and a way to send
  data out, in the same session. Meta's
  [Agents Rule of Two](https://ai.meta.com/blog/practical-ai-agent-security/)
  says the same thing as a design rule.
- Let deterministic checks and a person decide what merges. See
  [Regulate the loop](../patterns/human-regulating-the-loop.md).

No filter or system prompt removes this risk. Design so that a successful
injection cannot do much.

## Further reading

- Simon Willison, [The lethal trifecta for AI agents](https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/) (2025)
