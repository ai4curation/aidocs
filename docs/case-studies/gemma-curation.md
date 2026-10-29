# Gemma curation agents

A pipeline that proposes sample-level and experiment-level annotations for
transcriptomic studies, evaluated against a published benchmark of human
curation.

**Repository**:
[PavlidisLab/gemma-curation-agents-v1.1](https://github.com/PavlidisLab/gemma-curation-agents-v1.1)
**Benchmark**:
[PavlidisLab/gemma-curation-benchmark-data](https://github.com/PavlidisLab/gemma-curation-benchmark-data)
**Review UI**: [PavlidisLab/gemma-ui](https://github.com/PavlidisLab/gemma-ui)
**Product**: rows in [Gemma](https://gemma.msl.ubc.ca), a database of over
23,000 curated transcriptomic studies
**Agent surface**: a batch CLI (`gca`), run over a list of GEO accessions
**Paper**: [Pavlidis et al. 2026](https://doi.org/10.64898/2026.07.30.741874)

This is the only case study here that is not a Git-native knowledge base. There
is no per-record file, no pull request, and no ontology to edit. The product is
a relational database, agents run as a batch pipeline, and review happens in a
bespoke web UI. It is included because it is the most carefully measured
agentic curation project we know of, and because the parts worth copying —
how the rule corpus was built, how the mechanical and LLM stages are separated,
how the evaluation is kept honest — do not depend on any of that.

Take the scope limits seriously. This is metadata curation: which factors vary
across the samples, what values they take, which sample got which. It is not
knowledge-base assertion curation, and the authors do not claim it is. They
also state plainly that they have only worked with transcriptomic studies from
mammals.

## What to look at

| Path | What it is |
| --- | --- |
| [`docs/curation_rules/`](https://github.com/PavlidisLab/gemma-curation-agents-v1.1/tree/main/docs/curation_rules) | Thirteen files distilling the human curator manual into rules the agent can read |
| [`gemma_curation_agents/ontology/`](https://github.com/PavlidisLab/gemma-curation-agents-v1.1/tree/main/gemma_curation_agents/ontology) | The resolver chain, one file per tier |
| [`gemma_curation_agents/agents/audit/judges/`](https://github.com/PavlidisLab/gemma-curation-agents-v1.1/tree/main/gemma_curation_agents/agents/audit/judges) | Checks on existing curation, deterministic and LLM kept in separate files |
| [`docs/METHODS_agent_pipeline.md`](https://github.com/PavlidisLab/gemma-curation-agents-v1.1/blob/main/docs/METHODS_agent_pipeline.md) | The pipeline written out stage by stage, with the design rules stated |
| [`.../curation_proposer/prompts/`](https://github.com/PavlidisLab/gemma-curation-agents-v1.1/tree/main/gemma_curation_agents/agents/curation_proposer/prompts) | One prompt file per stage, including `boss_critic.md` |
| [`.../curation_proposer/curator_wisdom.md`](https://github.com/PavlidisLab/gemma-curation-agents-v1.1/blob/main/gemma_curation_agents/agents/curation_proposer/curator_wisdom.md) | Accumulated judgement calls that did not fit the manual |
| [`gold/`](https://github.com/PavlidisLab/gemma-curation-benchmark-data/tree/main/gold) (benchmark repo) | 400 development and 100 held-out reference curations, with checksums |
| [`metadata/difficulty_flags_400.json`](https://github.com/PavlidisLab/gemma-curation-benchmark-data/blob/main/metadata/difficulty_flags_400.json) | Per-study difficulty labels, for stratified evaluation |

Counted at commit `9ce41a0` on 2026-09-01: 546 Python files, 114,122 lines in
the package and 71,112 in tests, and 26 prompt and rule files totalling about
52,900 words. Apache 2.0.

## What works

### The curator manual became the rule corpus

`docs/curation_rules/` is a condensation of the project's existing Confluence
curation manual into thirteen numbered files — factor categories, baselines,
predicates, free-text conventions, tags, ontology selection. Each file names the
manual pages it came from. Where the manual is prescriptive, it is quoted
verbatim rather than paraphrased:

> Where the manual is prescriptive ("use X", "never Y") I quote it verbatim.
> Where it gives worked examples, I keep representative ones and drop the rest.

`00_README.md` also lists what was deliberately left out and why — platform
handling, outlier removal, CLI mechanics — so a reader can tell the difference
between a rule the agent does not have and a rule nobody wrote down.

Most curation projects already own a document like this. Very few have turned it
into something an agent reads.

### The escalation ladder is visible in the filenames

The ontology directory is one file per resolution tier, cheapest first:
`tier0_synonym.py`, `cached_lucene_resolver.py`, an `embedding/` index,
`llm_rerank_resolver.py`, `agentic_resolver.py`. An LLM is consulted on the
residue that the exact, lexical, and vector stages could not settle — not on
every string.

The audit judges are split the same way, and the filenames say which is which:
`forbidden_efc_judge.py`, `fv_coverage_judge.py`, and
`term_grounding_judge.py` are deterministic table lookups and presence checks;
`factor_llm_judge.py`, `fv_llm_judge.py`, and `tag_llm_judge.py` ask a model.
You can tell what kind of check you are reading before you open it.

The paper's ablations put numbers on both halves. Removing the LLM stages
degrades the output clearly. So does removing the mechanical ones — the
PubChem-to-ChEBI fallback that expands chemical shorthand, and the table of
string-to-term mappings drawn from previous Gemma curation. Neither half is
decoration.

### Grounding is reused, not recomputed

`12_meta_principles.md` tells the proposer that when a sample characteristic
already arrived with an ontology URI attached by Gemma's preprocessor, it should
reuse that URI rather than resolve the text again:

> reuse the mapped URI rather than re-resolving from text — it's faster and
> avoids drift between the BM annotation and the curator's annotation of the
> same value.

Two independent resolutions of the same string are two chances to disagree. This
is the same instinct as [Make identifiers hard to fake](../patterns/ground-identifiers.md),
applied to consistency rather than fabrication.

### The pipeline never sees the answer

From `METHODS_agent_pipeline.md`:

> The pipeline is **gold-blind by construction**: at no point during proposal
> does it read the curator's reference annotation, including during its own
> internal review.

The internal critic stages are the easy place for a reference annotation to leak
in, and stating the property as a design rule is what makes the held-out scores
mean anything. The comparison chain that does read the reference is separate,
and used only for scoring.

Two further rules are worth reading in full: never drop information until a
surface forces it and never silently, so a wrong binding stays visible instead
of being masked by a sympathetic free-text label; and always annotate, so the
agent never returns an empty result and instead records what it could not
resolve as a recommendation.

### The benchmark is a real release

The reference curation ships as its own versioned repository: 400 development
records and 100 held-out test records in disjoint splits, each with a
`meta.json` carrying provenance, record schema, and a sha256. The README tells
you to pin a tag.

`metadata/difficulty_flags_400.json` labels each study standard, moderate, or
hard, from where the two human curators needed reconciliation — 280 standard, 99
moderate, 21 hard. That makes stratified evaluation possible, and it records the
human disagreement rather than hiding it. The paper reports inter-curator
agreement at around 90% at best, and 60–90% on these particular tasks, which is
the context that makes the reported scores legible.

Publishing the gold set separately from the code is what lets anyone else score
a different system against the same target.

## What to copy first

Distil your curation manual. Take the wiki, the onboarding doc, the Google Doc
of conventions that a senior curator sends to new hires, and turn it into
numbered rule files next to your agent instructions. Cite the source page at the
top of each file, quote the prescriptive parts verbatim, and keep an explicit
list of what you left out.

This is cheap, it needs no new tooling, and it is the step most projects skip on
the way to writing prompts.

## Gaps

Review is not diffable. Proposals go to a write-API queue and a curator accepts,
rejects, or requests changes in a web UI, so there is no artifact you can read
in a pull request the way you can read a changed YAML file. At the snapshot we
read, the write endpoint was still a mock, with the production endpoint marked
TBD — this is a research artifact on its way to production, not a running
service.

The rule corpus cannot be checked against its source. `manual_text/`, the
Confluence export the rules were distilled from, is not in the repository. The
distillation was a judgement call by one person, and drift between the manual
and the rules would be invisible from outside.

The stated position on human review is more radical than anything else on this
site, and worth arguing with rather than adopting. The goal is "to reduce the
need for human review to an absolute minimum", on the grounds that reviewing
every item turns the curator into a "reverse centaur" whose job is defined by
the AI. That is an argument about the quality of curators' work, not about
throughput, and it reaches a similar place to
[Regulate the loop](../patterns/human-regulating-the-loop.md) by a different
route. Whether it holds depends on the triage working: the paper predicts
factual errors at AUC 0.86, cannot predict omissions, and found the model's own
confidence anti-discriminative at AUC 0.38.

The cost figure needs a footnote. The often-quoted ~$0.50 per dataset comes from
a project whose acknowledgements credit the Anthropic AI for Science Program for
computational resources. Treat it as an order of magnitude, not a quote.
