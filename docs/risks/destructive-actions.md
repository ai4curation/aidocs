---
id: airisk:destructive-actions
title: Destructive actions
threat_class: agency-and-action
agent_specific: true
contexts: [development, production-unintentional]
patterns: [human-regulating-the-loop]
related: [excessive-agency, fake-success]
sources:
  owasp_llm_2025: [LLM06]
  owasp_llm_2026: [LLM03]
  owasp_agentic_top10: [ASI02]
  owasp_agentic_threats: [T2]
  cosai_mcp: [MCP-T2]
  mitre_atlas: [AML.T0053, AML.T0101]
  nist_ai_600_1: ["2.7"]
  mit_ai_risk: ["7.3"]
  google_saif: [Rogue Actions]
---
# Destructive actions

**Watch for it when** an agent can delete, overwrite or force anything.

Agents make confident mistakes. Most are cheap because they land on a branch.
Some are not: a force-push to a shared branch, a dropped table, a bulk edit
applied directly to a production database, a deleted cache that took days to
build.

## What it looks like in curation

- An agent "cleans up" files it judged unused.
- A bulk relabeling applied through an API with no dry run.
- A force-push that discards a curator's commits.

## What helps

- Agents work on branches and propose changes; they do not write to `main` or to
  production data directly. See [Regulate the loop](../patterns/human-regulating-the-loop.md).
- Branch protection with no bypass, including for bots.
- Dry runs and diffs before any bulk change through an API.
- Backups you have restored from at least once.
