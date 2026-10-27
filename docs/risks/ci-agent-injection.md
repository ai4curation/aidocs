---
id: airisk:ci-agent-injection
title: Agents in CI triggered by untrusted input
threat_class: agency-and-action
agent_specific: true
contexts: [development, production-adversary]
patterns: [guard-untrusted-input]
related: [prompt-injection, excessive-agency, secret-exposure, unsafe-code-execution]
sources:
  owasp_llm_2025: [LLM01, LLM06]
  owasp_llm_2026: [LLM01, LLM03]
  owasp_agentic_top10: [ASI01, ASI03, ASI05]
  owasp_agentic_threats: [T2, T3, T11]
  mitre_atlas: [AML.T0119]
  mit_ai_risk: ["2.2"]
---
# Agents in CI triggered by untrusted input

**Watch for it when** an issue, comment or pull request on a public repository can start an agent.

This is where the other risks meet. A GitHub Actions workflow that runs an agent
on `issues: opened` or on a mention combines untrusted text, shell access and
repository secrets in one job. In late 2025 Aikido Security showed working
attacks of this kind, which they called
[PromptPwnd](https://www.aikido.dev/blog/promptpwnd-github-actions-ai-agents),
against workflows using several popular agent actions.

## What it looks like in curation

- A triage or summary workflow that runs on every new issue, with no check on
  who wrote it.
- A workflow that copies issue text into a shell command with
  `${{ github.event.issue.body }}`.
- A moderation workflow that runs separately from the agent and is assumed to
  protect it. It does not: the agent job still runs.

## What helps

- Check who triggered the run inside the same job as the agent, and fail
  closed. A separate workflow is not an authorization boundary.
- Keep an allowlist of controllers. See
  [Guard the untrusted surface](../patterns/guard-untrusted-input.md).
- Never interpolate event text into a shell line. Pass it through an environment
  variable or a file.
- Use `persist-credentials: false` on checkout, short-lived App tokens, and pin
  actions to a commit.
- Close or ignore pull requests from forks.
- Scan your workflows for these mistakes on a schedule.
