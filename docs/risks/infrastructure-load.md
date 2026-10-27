---
id: airisk:infrastructure-load
title: Load on open infrastructure
threat_class: resources-and-sustainability
agent_specific: false
taxonomy_gap: true
contexts: [production-adversary, production-unintentional]
related: [runaway-consumption, unprotected-endpoints, energy-cost]
sources:
  owasp_agentic_threats: [T4]
  cosai_mcp: [MCP-T10]
  mitre_atlas: [AML.T0029]
---
# Load on open infrastructure

**Watch for it when** you run a public API or endpoint, and when your agents call someone else's.

AI crawlers and agents now make up a large share of traffic to open scholarly
and data infrastructure. In 2025, more than 90% of 66 open repositories surveyed
by COAR reported aggressive bots, some with weekly outages. Wikimedia reported
that bots generated at least 65% of its most expensive traffic.

The taxonomies only see the victim's side, as denial of service. Science
projects are on both sides: they run public endpoints, and their own agents make
bulk calls to other people's services.

## What it looks like in curation

- A SPARQL endpoint or lakehouse API slowed by agents downloading everything.
- Users creating many accounts to get around download limits.
- Your own agent looking up ten thousand identifiers one request at a time.

## What helps

- As a provider: a gateway with per-token rate limits; track usage before
  blocking; give agents better paths, such as bulk downloads, a documented API
  and an MCP server, so they do not scrape pages.
- As a client: cache, batch, back off on errors, and identify your agent in its
  user agent string.

## Further reading

- COAR, [Open repositories are being profoundly impacted by AI bots and other crawlers](https://coar-repositories.org/news-updates/open-repositories-are-being-profoundly-impacted-by-ai-bots-and-other-crawlers-results-of-a-coar-survey/) (2025)
- COAR, [Dealing with bots](https://dealing-with-bots.coar-repositories.org/), a resource for repository managers
- GLAM-E Lab, [Are AI bots knocking cultural heritage offline?](https://glamelab.org/products/are-ai-bots-knocking-cultural-heritage-offline/) (2025)
- Wikimedia, [How crawlers impact the operations of the Wikimedia projects](https://diff.wikimedia.org/2025/04/01/how-crawlers-impact-the-operations-of-the-wikimedia-projects/) (2025)
