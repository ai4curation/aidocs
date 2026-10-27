# Risks

Risks that come with running AI agents on curation and data infrastructure.
Each page is short. It says when to watch for the risk, what it looks like in
curation, and which [patterns](../patterns/index.md) help.

The list is built from published taxonomies (below), trimmed to what matters for
knowledge bases, ontologies and data platforms that use coding agents, MCP
servers and agents in CI. Where practice turned up a risk that the taxonomies
miss or cover only in general terms, the table marks it as a gap.

One principle runs through most pages: **instructions are guidance; credentials
are the control.** You cannot prompt an agent into being safe. Decide what it
can reach, and check what it produces.

## The list

<!-- risk-table:start -->
| Class | Risk | Agent-specific | Gap in published taxonomies | Main entries elsewhere |
| --- | --- | --- | --- | --- |
| Instruction manipulation | [Data poisoning](data-poisoning.md) | no | no | LLM04, NIST 2.8, NIST 2.9 |
| Instruction manipulation | [Poisoned instructions and memory](poisoned-instructions.md) | yes | no | LLM08, ASI06, NIST 2.9 |
| Instruction manipulation | [Prompt injection](prompt-injection.md) | no | no | LLM01, ASI01, NIST 2.9 |
| Instruction manipulation | [Tool poisoning](tool-poisoning.md) | yes | no | LLM03, ASI02, ASI04, NIST 2.12 |
| Agency and action | [Agents in CI triggered by untrusted input](ci-agent-injection.md) | yes | no | LLM01, LLM06, ASI01, ASI03, ASI05 |
| Agency and action | [Destructive actions](destructive-actions.md) | yes | no | LLM06, ASI02, NIST 2.7 |
| Agency and action | [Excessive agency](excessive-agency.md) | yes | no | LLM06, ASI03, NIST 2.7 |
| Agency and action | [Reported success that did not happen](fake-success.md) | yes | yes | ASI10, NIST 2.7 |
| Agency and action | [Unsafe code execution](unsafe-code-execution.md) | yes | no | LLM05, ASI05, NIST 2.9 |
| Secrets and data exposure | [Data exfiltration](data-exfiltration.md) | yes | no | LLM02, LLM07, ASI01, ASI02, NIST 2.4 |
| Secrets and data exposure | [Secret exposure](secret-exposure.md) | yes | yes | LLM02, ASI03, NIST 2.9 |
| Secrets and data exposure | [Unprotected agent endpoints](unprotected-endpoints.md) | yes | no | ASI03, NIST 2.9 |
| Supply chain | [Supply chain](supply-chain.md) | no | no | LLM03, ASI04, NIST 2.12 |
| Output integrity | [Cascading errors](cascading-errors.md) | yes | no | ASI08, NIST 2.6, NIST 2.8 |
| Output integrity | [Fabricated identifiers, citations and facts](fabricated-content.md) | no | yes | LLM09, NIST 2.2, NIST 2.8 |
| Output integrity | [Improper output handling](improper-output-handling.md) | no | no | LLM05, ASI05, NIST 2.9 |
| Oversight and accountability | [Licensing and attribution](licensing-and-attribution.md) | no | yes | NIST 2.10 |
| Oversight and accountability | [Review fatigue and overreliance](review-fatigue.md) | no | no | ASI09, NIST 2.7 |
| Oversight and accountability | [Untraceable agent actions](untraceable-actions.md) | yes | yes | — |
| Resources and sustainability | [Energy cost without benefit](energy-cost.md) | no | yes | NIST 2.5 |
| Resources and sustainability | [Load on open infrastructure](infrastructure-load.md) | no | yes | — |
| Resources and sustainability | [Runaway consumption](runaway-consumption.md) | no | no | LLM10 |
<!-- risk-table:end -->

The last column gives the OWASP Top 10 for LLM Applications (2025), the OWASP
Top 10 for Agentic Applications, and NIST AI 600-1 sections. Each page's
metadata lists the matching entries in all the taxonomies below.

## Three settings

Each risk page says in which of these settings the risk arises:

| Setting | Meaning |
| --- | --- |
| Development | Your own agents, in your own repositories, CI and machines |
| Production, adversary | Someone deliberately attacking a service you run |
| Production, unintentional | A legitimate user's agent causing harm by accident |

The third setting is the one most specific to agents, and probably the most
common in practice.

## Using this for your project

The risk pages are generic. To record your own project's position, write a
profile that says, for each risk, whether it applies, what you do in each
setting, and who is the contact. Record incidents and findings against the same
risk identifiers. The schema `schema/ai_risk.yaml` in the
[aidocs repository](https://github.com/ai4curation/aidocs) defines both, as well
as the metadata at the top of each risk page.

Keep profiles and incidents in your own repository, and keep them private if
they describe open gaps. Only fixed, sanitized lessons belong on these pages.

## Out of scope

These appear in the taxonomies but are left out here, because projects of this
kind cannot act on them or are not exposed to them:

- Chemical, biological, radiological and nuclear misuse of models.
- Harmful, violent or obscene content generation by public chat assistants.
- Election disinformation, fraud and deepfakes.
- Society-wide effects such as labor markets and concentration of power.
- Attacks on model training and serving, such as model theft or evasion. Most
  projects use hosted models rather than training their own.
- Agent-to-agent protocols. Exposure is low today; revisit if you adopt them.

## Sources

- OWASP, [Top 10 for LLM Applications 2025](https://genai.owasp.org/llm-top-10/)
  and the [2026 edition](https://genai.owasp.org/resource/owasp-genai-llm-top-10-2026/),
  which renumbers several entries.
- OWASP, [Top 10 for Agentic Applications](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/)
  and [Agentic AI Threats and Mitigations](https://genai.owasp.org/download/45674/) (v1.1).
- OWASP, [MCP Top 10](https://owasp.org/www-project-mcp-top-10/).
- Coalition for Secure AI, [Model Context Protocol security](https://www.coalitionforsecureai.org/wp-content/uploads/2026/03/model-context-protocol-security-1.pdf).
- MITRE, [ATLAS](https://atlas.mitre.org/).
- NIST, [AI 600-1: Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf).
- MIT, [AI Risk Repository](https://airisk.mit.edu/).
- Google, [SAIF risk map](https://saif.google/secure-ai-framework/risks).
