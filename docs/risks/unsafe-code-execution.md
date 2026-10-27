---
id: airisk:unsafe-code-execution
title: Unsafe code execution
threat_class: agency-and-action
agent_specific: true
contexts: [development, production-adversary, production-unintentional]
patterns: [guard-untrusted-input]
related: [supply-chain, improper-output-handling, secret-exposure]
sources:
  owasp_llm_2025: [LLM05]
  owasp_llm_2026: [LLM10]
  owasp_agentic_top10: [ASI05]
  owasp_agentic_threats: [T11]
  owasp_mcp_top10: [MCP05]
  cosai_mcp: [MCP-T3, MCP-T8]
  mitre_atlas: [AML.T0050, AML.T0102, AML.T0105]
  nist_ai_600_1: ["2.9"]
  mit_ai_risk: ["2.2"]
  google_saif: [Insecure Model Output]
---
# Unsafe code execution

**Watch for it when** an agent can run commands, or when your service runs code an agent wrote.

Coding agents run shell commands and scripts. That is what makes them useful.
It also means that anything that steers the agent can run code with the agent's
credentials and network access.

## What it looks like in curation

- An agent in CI with shell access and a write token, triggered by an issue.
- Permission prompts turned off so a scheduled job does not stall, in the same
  job that holds secrets.
- A data platform that lets users' agents submit notebooks or scripts.

## What helps

- Run agents in a container or sandbox with a network allowlist. GitHub's
  Copilot agent has a firewall on by default; see
  [GitHub Copilot](../reference/github-copilot.md).
- Never disable permission checks in a job that holds a write credential.
- Pass agents an allowlisted environment, not your whole shell environment.
- For a service, prefer a constrained surface (a query language, a fixed API)
  to arbitrary code, and isolate any code execution per user.

## Experimental

Static contracts are one research direction: the agent submits a program
together with guarantees about its side effects ("reads only public tables",
"writes only under `tmp/`"), a prover checks the guarantees on every branch, and
a person approves the guarantees rather than the code.
[ClauZ3](https://github.com/normalform-ai/clauz3) is an early example. It is not
yet a recommendation.
