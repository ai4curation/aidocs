---
id: airisk:secret-exposure
title: Secret exposure
threat_class: secrets-and-data-exposure
agent_specific: true
taxonomy_gap: true
contexts: [development, production-adversary, production-unintentional]
patterns: [guard-untrusted-input]
related: [excessive-agency, ci-agent-injection, data-exfiltration, untraceable-actions]
sources:
  owasp_llm_2025: [LLM02]
  owasp_llm_2026: [LLM02, LLM08]
  owasp_agentic_top10: [ASI03]
  owasp_agentic_threats: [T9]
  owasp_mcp_top10: [MCP01]
  cosai_mcp: [MCP-T1]
  mitre_atlas: [AML.T0055, AML.T0083, AML.T0098]
  nist_ai_600_1: ["2.9"]
  mit_ai_risk: ["2.2"]
  google_saif: [Sensitive Data Disclosure]
---
# Secret exposure

**Watch for it when** a token sits anywhere an agent can read, or anywhere an agent's output is published.

Agents read files, environment variables and command output, and they write
logs, transcripts and comments. A token that an agent can see can end up in
anything the agent produces.

The taxonomies cover secrets in configuration and protocol logs. They say little
about the path that matters most for open projects: **published agent
transcripts and traces**. Log masking catches a token as it was stored; it can
miss the same token after encoding, so it can survive in a raw execution log or
an observability export.

## What it looks like in curation

- A checkout step leaves the token in `.git/config`, the agent prints the file,
  and the transcript is published. A bot token leaked exactly this way in 2026
  and was abused a few weeks later.
- Storage keys pasted into shared meeting notes that agents later index.
- An API key in a notebook committed to a public repository.

## What helps

- Short-lived, narrowly scoped tokens: GitHub App tokens rather than personal
  access tokens. See [Bots](../reference/bots/index.md).
- `persist-credentials: false` on every checkout in an agent job.
- Pass the agent an allowlisted environment, not every secret in the job.
- Keep raw agent transcripts and traces private. Scan anything you publish,
  including decoded forms.
- Never paste keys into documents or chats. Rotate any key that has been.
