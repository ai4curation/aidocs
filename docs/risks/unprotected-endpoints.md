---
id: airisk:unprotected-endpoints
title: Unprotected agent endpoints
threat_class: secrets-and-data-exposure
agent_specific: true
contexts: [production-adversary, production-unintentional]
patterns: [shared-control]
related: [data-exfiltration, excessive-agency, infrastructure-load]
sources:
  owasp_agentic_top10: [ASI03]
  owasp_agentic_threats: [T9, T16]
  owasp_mcp_top10: [MCP07, MCP09]
  cosai_mcp: [MCP-T1, MCP-T7, MCP-T8]
  mitre_atlas: [AML.T0132]
  nist_ai_600_1: ["2.9"]
  mit_ai_risk: ["2.2"]
---
# Unprotected agent endpoints

**Watch for it when** you stand up an MCP server or agent-facing API for your data.

It is easy to build an MCP server that wraps a database and forget that it is
now a network service. Servers bound to all interfaces, servers with no
authentication, servers that use one shared service credential for every caller,
and servers nobody remembers running are all common.

The last is a *confused deputy*: the server has more access than the user
calling it, and it acts on the user's request with its own access.

## What it looks like in curation

- An MCP server for a curation database reachable from the internet.
- An agent-facing API that authenticates the agent but not the person behind it.
- A server that someone set up for a demo and left running.

## What helps

- Wrap the API your curation interface already uses, so agents get the same
  checks and permissions people do. See [Shared control](../patterns/shared-control.md).
- Authenticate the person behind the agent, and authorize each request as them.
- Bind local servers to localhost. Keep an inventory of the servers you run.
