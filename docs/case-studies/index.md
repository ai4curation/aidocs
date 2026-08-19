# Case studies

Every page in this section describes one repository that runs agents on real
curation work. Each page points at the files and folders you can open and copy.

We do not centralize the material here. The repositories are the source of
truth. If a page disagrees with the repository, trust the repository and
[open an issue](https://github.com/ai4curation/aidocs/issues).

## Block A: ontologies

These are established OBO ontologies that added agents to an existing editor
workflow. The ontology file stays the product. Agents work through issues and
pull requests.

| Repository | Best known for | Read this first |
| --- | --- | --- |
| [GO](go-ontology.md) | The largest skill library of any ontology repository | `.claude/skills/` |
| [Uberon](uberon.md) | Subagents for specialist jobs | `.claude/agents/` |
| [Mondo](mondo.md) | A Goose-based agent alongside Claude Code subagents | `.github/workflows/ai-agent.yml` |
| [Cell Ontology](cell-ontology.md) | Live agent traffic with almost no supporting structure | `CLAUDE.md` |
| [EFO](efo.md) | An orchestrator that routes work to specialists | `CLAUDE.md` |

## Block B: the mechs

These are newer knowledge bases built for agents from the start. The record is
a YAML file. Validation is strict. Most edits come from agents.

| Repository | What it curates | Read this first |
| --- | --- | --- |
| [DisMech](dismech.md) | Disease mechanisms | `CONTRIBUTING.md` |
| [AI Gene Review](ai-gene-review.md) | Gene Ontology annotations | `.claude/skills/` |
| [CommunityMech](communitymech.md) | Microbial communities | `src/communitymech/schema/` |
| [HabitatMech](habitatmech.md) | Microbial habitats | `data/habitats/` |

Four more repositories in the CultureBot family follow the same shape:
[CultureMech](https://github.com/CultureBotAI/CultureMech) (culture media),
[MediaIngredientMech](https://github.com/CultureBotAI/MediaIngredientMech)
(media ingredients),
[TraitMech](https://github.com/CultureBotAI/TraitMech) (microbial traits), and
[proteintraitsmech](https://github.com/CultureBotAI/proteintraitsmech) (protein
traits). See [CommunityMech](communitymech.md) for how the family fits together.

## How to read a case study

Each page has the same four sections:

* **What to look at** lists paths in the repository.
* **What works** describes practices worth copying.
* **What to copy first** is the shortest useful step.
* **Gaps** records what the repository has not solved. These sections are
  honest, not critical. Every setup here has gaps.

## Where the observations come from

Counts of skills, subagents, and workflows come from agent-watcher, which scans
these repositories on a schedule and publishes dated reports. See
[Evidence](../evidence.md).
