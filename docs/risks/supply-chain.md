---
id: airisk:supply-chain
title: Supply chain
threat_class: supply-chain
agent_specific: false
contexts: [development, production-unintentional]
related: [tool-poisoning, unsafe-code-execution, fabricated-content]
sources:
  owasp_llm_2025: [LLM03]
  owasp_llm_2026: [LLM04, LLM07]
  owasp_agentic_top10: [ASI04]
  owasp_agentic_threats: [T17]
  owasp_mcp_top10: [MCP04]
  cosai_mcp: [MCP-T6, MCP-T11]
  mitre_atlas: [AML.T0010, AML.T0115, AML.T0109, AML.T0060]
  nist_ai_600_1: ["2.12"]
  mit_ai_risk: ["2.2"]
  google_saif: [Insecure Integrated Component, Model Source Tampering]
---
# Supply chain

**Watch for it when** your agent setup installs anything at run time.

An agent job pulls in a lot: GitHub Actions, the agent CLI, MCP servers,
plugins, skills, Python and npm packages. Each one runs with the job's
credentials. If any of them is referenced by a moving tag such as `@main` or
`latest`, someone else decides what runs in your job next time.

Agents add a new twist: they suggest package names, and sometimes the package
does not exist. Attackers register the names models tend to invent
("slopsquatting").

## What it looks like in curation

- A workflow that installs a plugin from its default branch on every run, next
  to a token that can merge to `main`.
- An agent that adds a dependency it half-remembered.
- An MCP server installed with `npx some-server` and no version.

## What helps

- Pin actions to a commit SHA, and pin packages, MCP servers, plugins and skills
  to a version.
- Check that a package exists and is the one you meant before adding it.
- Keep secrets out of jobs that install third-party code where you can.
- Review updates to pinned components like any other code change.
