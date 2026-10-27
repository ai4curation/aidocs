---
id: airisk:excessive-agency
title: Excessive agency
threat_class: agency-and-action
agent_specific: true
contexts: [development, production-unintentional]
patterns: [guard-untrusted-input, human-regulating-the-loop]
related: [destructive-actions, secret-exposure, ci-agent-injection]
sources:
  owasp_llm_2025: [LLM06]
  owasp_llm_2026: [LLM03]
  owasp_agentic_top10: [ASI03]
  owasp_agentic_threats: [T3]
  owasp_mcp_top10: [MCP02]
  cosai_mcp: [MCP-T2, MCP-T9]
  mitre_atlas: [AML.TA0012]
  nist_ai_600_1: ["2.7"]
  mit_ai_risk: ["5.2"]
  google_saif: [Rogue Actions]
---
# Excessive agency

**Watch for it when** an agent's token can do more than its job needs.

What an agent can do is set by the identity and tokens it runs with, not by
what you told it. A reviewer bot with push rights, or a bot with administrator
rights, turns any mistake or injection into something much worse.

## What it looks like in curation

- One bot identity used for curation, review and administration.
- A long-lived personal token in a repository secret, with access to every
  repository its owner can reach.
- An agent that can merge its own pull requests.

## What helps

- One identity per job, each with the narrowest permissions. Prefer GitHub Apps
  with short-lived tokens to machine accounts with personal tokens. See
  [Bots](../reference/bots/index.md).
- Separate reading from writing, and add write access one surface at a time.
  See [Guard the untrusted surface](../patterns/guard-untrusted-input.md).
- Keep the merge decision with a person and branch protection. See
  [Regulate the loop](../patterns/human-regulating-the-loop.md).
- Review bot permissions on a schedule. They grow quietly.
