---
id: airisk:improper-output-handling
title: Improper output handling
threat_class: output-integrity
agent_specific: false
contexts: [development, production-adversary, production-unintentional]
patterns: [fast-and-slow-validation]
related: [unsafe-code-execution, fabricated-content]
sources:
  owasp_llm_2025: [LLM05]
  owasp_llm_2026: [LLM10]
  owasp_agentic_top10: [ASI05]
  owasp_agentic_threats: [T11]
  owasp_mcp_top10: [MCP05]
  cosai_mcp: [MCP-T3]
  mitre_atlas: [AML.T0077, AML.T0067]
  nist_ai_600_1: ["2.9"]
  mit_ai_risk: ["2.2"]
  google_saif: [Insecure Model Output]
---
# Improper output handling

**Watch for it when** model output goes straight into a query, a command, a page or a record.

Whatever a model writes should be handled like user input. Generated SQL can
read more than intended, generated YAML can break a pipeline, and generated HTML
or Markdown can carry links that leak data when rendered.

## What it looks like in curation

- Natural-language questions turned into SQL and run with a service account.
- Agent-written records loaded without schema validation.
- A generated comment with an image link whose URL carries query results.

## What helps

- Validate agent-written records against your schema before they land. See
  [Fast and slow validation](../patterns/fast-and-slow-validation.md).
- Run generated queries read-only, with the requesting user's permissions and
  with limits on cost and size.
- Escape or strip active content before rendering model output.
