---
id: airisk:poisoned-instructions
title: Poisoned instructions and memory
threat_class: instruction-manipulation
agent_specific: true
contexts: [development, production-adversary]
patterns: [one-source-of-instructions, review-checklists, guard-untrusted-input]
related: [prompt-injection, tool-poisoning, cascading-errors]
sources:
  owasp_llm_2025: [LLM08]
  owasp_llm_2026: [LLM09]
  owasp_agentic_top10: [ASI06]
  owasp_agentic_threats: [T1]
  owasp_mcp_top10: [MCP10]
  cosai_mcp: [MCP-T4]
  mitre_atlas: [AML.T0070, AML.T0080, AML.T0081]
  nist_ai_600_1: ["2.9"]
  mit_ai_risk: ["2.2"]
---
# Poisoned instructions and memory

**Watch for it when** anyone can change the files your agent reads on every run.

Agents load standing context before they start: `AGENTS.md` or `CLAUDE.md`,
skills, saved memories, retrieval indexes. A change to any of these changes
every later run. Unlike a one-off injection, it persists.

## What it looks like in curation

- A pull request that edits a skill's instructions alongside a routine content
  change, so the reviewer does not notice.
- An agent that saves a "lesson" to memory from a malicious issue, then applies
  it in other repositories.
- A retrieval index built from documents nobody vetted.

## What helps

- Keep one instructions file, so changes to it are easy to see. See
  [One source of instructions](../patterns/one-source-of-instructions.md).
- Treat instruction files, skills and review checklists as code. Require review
  for changes to them, ideally with a code-owners rule. See
  [One review checklist](../patterns/review-checklists.md).
- Do not let an agent edit its own instructions or workflows in the same run
  that reads untrusted input. See
  [Guard the untrusted surface](../patterns/guard-untrusted-input.md).
