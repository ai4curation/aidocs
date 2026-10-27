---
id: airisk:untraceable-actions
title: Untraceable agent actions
threat_class: oversight-and-accountability
agent_specific: true
taxonomy_gap: true
contexts: [development, production-unintentional]
related: [cascading-errors, secret-exposure, excessive-agency]
sources:
  owasp_agentic_threats: [T8]
  owasp_mcp_top10: [MCP08]
  cosai_mcp: [MCP-T12]
  mit_ai_risk: ["7.4"]
---
# Untraceable agent actions

**Watch for it when** you cannot say which agent, model or request produced a change.

The taxonomies treat this as an audit-log problem. For a knowledge base it is
also a provenance problem: when a curated assertion turns out to be wrong, you
need to find everything else the same agent, model or prompt produced, and you
need to tell your users which records were agent-written.

## What it looks like in curation

- Several agents committing under one shared bot identity.
- Agent pull requests attributed only to the person who triggered them.
- No record of which model version wrote a batch of records.

## What helps

- One bot identity per job, so the byline says what did the work. See
  [Bots](../reference/bots/index.md).
- Record agent provenance in the data, not only in Git history. See
  [ai-blame](../glossary.md#ai-blame).
- Keep agent transcripts, privately. They are the record of why a change was
  made, and they can contain secrets. See [Secret exposure](secret-exposure.md).
