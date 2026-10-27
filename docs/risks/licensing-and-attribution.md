---
id: airisk:licensing-and-attribution
title: Licensing and attribution
threat_class: oversight-and-accountability
agent_specific: false
taxonomy_gap: true
contexts: [development]
related: [untraceable-actions, cascading-errors]
sources:
  nist_ai_600_1: ["2.10"]
  mit_ai_risk: ["6.3"]
  google_saif: [Unauthorized Training Data]
---
# Licensing and attribution

**Watch for it when** an agent copies content from one resource into another.

Open data comes under many licenses, and attribution is often the only thing
the original curators asked for. An agent that summarizes, merges or rewrites
content can drop the attribution, mix incompatible licenses, or copy text from
sources that do not permit reuse. The taxonomies cover intellectual property in
general but not this pattern of remixing open data.

## What it looks like in curation

- Definitions copied from a resource with a no-derivatives license.
- Merged records that lose the source each part came from.
- Long verbatim passages from papers stored as "evidence".

## What helps

- Keep the source and license with every imported value.
- Store short evidence quotes with their citation, not long passages.
- Add license checks to review for content imported from outside.
