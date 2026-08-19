# CommunityMech and the CultureBot mechs

A knowledge base of microbial communities, and the clearest evidence that the
[DisMech](dismech.md) pattern transfers to a different domain and a different
group.

**Repository**: [CultureBotAI/CommunityMech](https://github.com/CultureBotAI/CommunityMech)
**Product**: `kb/communities/*.yaml`, one file per community

CommunityMech says so directly in its README: *"Adapted from Monarch
Initiative's dismech"*. It is one of six knowledge bases in the
[CultureBotAI](https://github.com/CultureBotAI) organization built on the same
shape.

## What to look at

| Path | What it is |
| --- | --- |
| `src/communitymech/schema/communitymech.yaml` | The LinkML schema |
| `kb/communities/` | One YAML file per community |
| `src/communitymech/export/kgx_export.py` | Koza transform to knowledge graph edges |
| `src/communitymech/export/browser_export.py` | Faceted browser export |
| `justfile` | Validation and generation commands |

The commands and layout match DisMech closely: `just validate`,
`just validate-terms`, `just validate-references`. If you have read one
repository you can navigate the other.

## The family

| Repository | What it curates | Scale |
| --- | --- | --- |
| [CultureMech](https://github.com/CultureBotAI/CultureMech) | Culture media recipes | 10,657 recipes from 10 sources |
| [MediaIngredientMech](https://github.com/CultureBotAI/MediaIngredientMech) | Media ingredients and their ontology mappings | 995 mapped, 136 unmapped |
| [CommunityMech](https://github.com/CultureBotAI/CommunityMech) | Microbial communities and their interactions | Tens of communities |
| [HabitatMech](habitatmech.md) | Microbial habitats | About 3,200 habitat records |
| [TraitMech](https://github.com/CultureBotAI/TraitMech) | Microbial traits, seeded from METPO | 354 records, 233 reviewed |
| [proteintraitsmech](https://github.com/CultureBotAI/proteintraitsmech) | Protein traits | Early |

## What works

### One shape, six knowledge bases

Each repository curates a different kind of thing, but all of them use one YAML
file per record, a LinkML schema, ontology-grounded terms, evidence with
citations, and a `justfile`. A curator who learns one can work in any of them.
So can an agent.

This is the strongest argument for the mech pattern. It was not designed to be
reusable, and it turned out to be.

### The repositories feed each other

CultureMech aggregates 10,657 media recipes. MediaIngredientMech takes the
ingredients out of those recipes and curates their ontology mappings, then
exports the validated mappings back. The output of one curation project is the
input to the next, and both sides are files under version control.

### Curation events are recorded, including AI assistance

MediaIngredientMech's schema has a `CurationEvent` class that records who made a
change, when, and whether an LLM helped. Provenance is part of the data model
rather than something reconstructed from Git history afterwards.

### Cross-repository work has its own agent layer

[culturebotai-claw](https://github.com/CultureBotAI/culturebotai-claw)
coordinates agents across the repositories for jobs no single repository owns:
schema changes that have to propagate, synchronized releases, and integration
testing. It also assigns a model tier per job, so documentation runs on a cheap
model and integrity auditing runs on an expensive one.

This layer is early. Several of its agents are not built yet. Read it for the
idea rather than as a finished tool.

## What to copy first

If you are starting a new knowledge base, copy the repository layout from
CommunityMech or [HabitatMech](habitatmech.md) rather than from DisMech.
DisMech carries years of accumulated automation. These are smaller and easier to
read as a starting point.

## Gaps

Some `justfile` targets in the CommunityMech README are planned rather than
built. Check the `justfile` before you rely on a command.

Several READMEs in the family contain absolute paths from a developer's laptop
in their setup instructions. Use `git clone` and ignore those lines.
