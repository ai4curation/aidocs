---
id: airisk:tool-poisoning
title: Tool poisoning
threat_class: instruction-manipulation
agent_specific: true
contexts: [development, production-unintentional]
patterns: [guard-untrusted-input]
related: [prompt-injection, supply-chain, poisoned-instructions]
sources:
  owasp_llm_2025: [LLM03]
  owasp_llm_2026: [LLM04]
  owasp_agentic_top10: [ASI02, ASI04]
  owasp_agentic_threats: [T2, T17]
  owasp_mcp_top10: [MCP03]
  cosai_mcp: [MCP-T4, MCP-T6]
  mitre_atlas: [AML.T0110, AML.T0099, AML.T0109]
  nist_ai_600_1: ["2.12"]
  mit_ai_risk: ["2.2"]
  google_saif: [Insecure Integrated Component]
---
# Tool poisoning

**Watch for it when** you install an MCP server, plugin or skill you did not write.

The agent reads a tool's name, description and schema as instructions. A
malicious or careless tool can tell the agent to do things the user never asked
for, or return results that steer it. A tool that was fine when you installed it
can change later (a "rug pull").

## What it looks like in curation

- An MCP server for an ontology lookup service whose description tells the agent
  to send query results to another endpoint.
- A community skill that quietly changes how the agent writes evidence.
- A tool response that contains instructions, the same way a web page can.

## What helps

- Install tools from sources you trust, and pin them to a version or commit so
  they cannot change underneath you. See [Supply chain](supply-chain.md).
- Read the descriptions and skill files you install. They are instructions to
  your agent.
- Give each tool only the scopes it needs. A lookup tool needs no write access.
- Treat tool output as data, not as instructions. See
  [Guard the untrusted surface](../patterns/guard-untrusted-input.md).
