# HabitatMech

A knowledge base of microbial habitats that merges four source vocabularies into
one record per habitat. It is the best worked example of using agents to
harmonize sources that disagree.

**Repository**: [CultureBotAI/HabitatMech](https://github.com/CultureBotAI/HabitatMech)
**Site**: [Browse the corpus](https://culturebotai.github.io/HabitatMech/)
**Product**: `data/habitats/<category>/<slug>.yaml`

HabitatMech follows the [DisMech](dismech.md) pattern and is part of the
[CultureBot family](communitymech.md).

## The problem it solves

The same habitat has a different name in every source:

| Source | How it names marine sediment |
| --- | --- |
| JGI GOLD | `Environmental > Aquatic > Marine > Sediment` |
| BacDive | `Marine-sediment` |
| PREGO | `ENVO:00002113` |
| Madin et al. | `ENVO:00002113` |

## What to look at

| Path | What it is |
| --- | --- |
| `data/habitats/` | One YAML file per habitat, about 3,200 records |
| [Term requests page](https://culturebotai.github.io/HabitatMech/pages/term-requests.html) | Gaps this project is asking ENVO to fill |
| `src/habitatmech/schema/` | The LinkML schema |

## What works

### The merge is the product

Each source name becomes a source concept. Every source concept resolves to an
identifier. Source concepts that resolve to the same identifier merge into one
record that keeps all of their attestations.

So `data/habitats/terrestrial/soil.yaml` is one record, grounded in
`ENVO:00001998`, that knows GOLD saw 26,399 organisms there and that PREGO and
Madin's literature curation associate 8,715 and 2,934 taxa with it
independently. The disagreement between sources is kept, not flattened.

### Minted identifiers are honest about being minted

Where an ontology term is defensible, the record uses the ontology CURIE. Where
none is, the project mints a content-hashed `habitatmech:` CURIE instead of
forcing a bad ontology match. You can tell the two apart by looking.

This matters for agents. Forcing a term match is exactly the kind of plausible
error an agent makes, and a project that permits a local identifier removes the
pressure to guess.

### Gaps are published as term requests

The project renders the terms it needs and cannot find as a public
[term requests page](https://culturebotai.github.io/HabitatMech/pages/term-requests.html)
for the ontology community. Curation that finds a gap produces a request rather
than a workaround.

## What to copy first

Copy the term request page. If your curation depends on an ontology you do not
control, publish what you needed and could not find. It turns a private
annoyance into a contribution the ontology maintainers can act on.

## Gaps

The corpus was seeded in a batch from kg-microbe. As with any seeded knowledge
base, coverage reflects what the sources contained, not what the domain
contains. Check the README for the seed date before treating counts as current.
