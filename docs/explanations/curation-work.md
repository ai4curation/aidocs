# What other fields suggest about curation

Agents arrived in other kinds of expert work before they arrived in
biocuration. Radiologists, systematic reviewers, and software developers have
been through some of what curators are starting now, and there is evidence
about what happened to them. This page collects that evidence and asks what it
might mean for biocuration.

It does not settle the question. Biocuration has only its first results, and
the other fields differ from it in ways that matter. The companion page,
[How agents changed software development](software-development.md), covers
software in more detail.

## Radiology: the replacement that did not happen

In 2016 Geoffrey Hinton said people should stop training radiologists, because
AI would read images better within five years. The models did get very good at
reading images. More than 700 radiology AI models have FDA clearance.

Radiologists did not go away. US radiology residencies offered a record 1,208
positions in 2025, vacancy rates are at all-time highs, and average pay is
about 48% higher than in 2015
([Works in Progress, 2025](https://worksinprogress.co/issue/the-algorithm-will-see-you-now/)).
The UK is short of 32% of the radiology consultants it needs
([Royal College of Radiologists, 2025](https://www.rcr.ac.uk/news-policy/workforce-censuses/2025-clinical-radiology-workforce-census-report/)).

Three reasons, each with a parallel in curation:

1. **Reading images is about a third of the job.** Radiologists spend about 36%
   of their time on direct interpretation. The rest is consulting with
   clinicians, procedures, protocols, and teaching. Assigning a GO term is
   likewise a fraction of what curators do: modelling hard cases, settling
   disputes, setting standards, training others, and deciding what the
   knowledge base should say at all.
2. **Each model answers one narrow question.** Real work joins many such
   questions together, and the joins are where judgment lives.
3. **Cheaper reading created more reading.** When a task gets cheaper, demand
   for it rises. Curation has a backlog measured in decades, so there is no
   shortage of demand.

The lesson is not "AI will not change the job". It changed radiology a great
deal. The lesson is that tasks get automated and jobs get rebuilt around what is
left. This was the argument put to curators at Biocuration 2026, setting radiology
("AI performs first pass interpretation" / "Demand for radiologists is higher
than ever") beside software engineering, and concluding that the curator's role
"will involve doing higher level tasks, and more managing and organization"
([Mungall, *Staying in the Loop*, February 2026](https://zenodo.org/records/18614836)).

## Second eyes: the mammography result

In European breast cancer screening every mammogram is read independently by
two radiologists. This "double reading" is the standard of care because a
second reader catches cancers the first one misses. It is also expensive, which
is why most countries cannot afford it. Most curation is in the same place: an
annotation is made by one curator and is seen again only if someone happens to
look.

The Swedish MASAI trial randomised 105,934 women between standard double
reading and AI-supported screening. In the AI arm, the AI triaged
low-risk exams to a single reader and flagged suspicious areas for the readers.
The results, published in *The Lancet* in January 2026:

| | Two radiologists | AI-supported |
| --- | --- | --- |
| Sensitivity | 73.8% | 80.5% |
| Specificity | 98.5% | 98.5% |
| Interval cancers per 1,000 | 1.76 | 1.55 (non-inferior) |
| Screen readings | 109,692 | 61,248 (44% fewer) |

([Gommers et al., *Lancet*, 2026](https://pubmed.ncbi.nlm.nih.gov/41620232/);
[Hernström et al., *Lancet Digital Health*, 2025](https://pubmed.ncbi.nlm.nih.gov/39904652/))

In a randomised trial, then, AI support meant less expert time and better
quality at once. Germany's nationwide rollout found 17.6% more cancers
detected with no increase in recalls
([Eisemann et al., *Nature Medicine*, 2025](https://pmc.ncbi.nlm.nih.gov/articles/PMC11922743/)).

Two caveats. Pooled across the three large European studies, the gain in
detection is real but modest, about one more cancer per thousand women
([Ferre et al., 2026](https://pubmed.ncbi.nlm.nih.gov/42617468/)). Screening
was already highly optimised, with two expert readers on every exam. Most
curation has one, which raises the question of whether the room for
improvement is larger.

## Second eyes: evidence synthesis

Systematic reviews have their own version of double reading: two people screen
every paper independently. LLM screening now reaches a pooled sensitivity of
0.92 and specificity of 0.94, with workload reductions of 50% to 99%
([Xie et al., *J Evid Based Med*, 2026](https://pubmed.ncbi.nlm.nih.gov/42499245/)).
Cochrane and its partner organisations permit it, with a condition: "AI and
automation in evidence synthesis should be used with human oversight," and the
authors remain responsible
([joint position statement, 2025](https://pmc.ncbi.nlm.nih.gov/articles/PMC12603384/)).
Screening papers for relevance is close to the literature triage curators do.

## The costs of keeping a human in the loop

"Human in the loop" is often said as if it settles the matter. It does not. The
human is a component with known failure modes.

**People defer to confident machines, including experts.** When an AI gave
deliberately wrong answers on mammograms, the most experienced radiologists'
accuracy fell from 82% to 46%
([Dratsch et al., *Radiology*, 2023](https://pubmed.ncbi.nlm.nih.gov/37129490/)).
Physicians given planted errors in LLM advice dropped from 90.5% to 76.1%
diagnostic accuracy (a 2025 preprint). The human factors literature has found
for decades that this kind of complacency "cannot be prevented by training or
instructions" ([Parasuraman and Manzey, 2010](https://pubmed.ncbi.nlm.nih.gov/21077562/)).

**Skills fade when they are not used.** After AI-assisted colonoscopy was
introduced in four Polish centres, endoscopists' detection rate on procedures
done *without* AI fell from 28.4% to 22.4%
([Budzyń et al., *Lancet Gastroenterology & Hepatology*, 2025](https://pubmed.ncbi.nlm.nih.gov/40816301/)).
The study is observational and has been debated, but the direction matches what
software studies find for junior developers.

**Only the most expert reviewers catch the subtle errors.** In the DRAGON-AI
evaluation of AI-written ontology definitions, the GO Consortium noted that the
AI "would give plausible yet subtly incorrect term definitions for some terms,
and … this was only noticed by more expert curators"
([GO Consortium, *Nucleic Acids Research*, 2026](https://pmc.ncbi.nlm.nih.gov/articles/PMC12807639/)).
Expertise is not made redundant by review. Review is where it is needed most.

**Human plus AI is not automatically better than either.** A meta-analysis of 106
experiments found human–AI teams did worse than the better of the two alone on
decision tasks, and better on creation tasks
([Vaccaro et al., *Nature Human Behaviour*, 2024](https://pubmed.ncbi.nlm.nih.gov/39468277/)).
Curation has both kinds of task, and the combination has to be designed for
each.

**Supervision is tiring.** See
[Supervision is tiring, and it has a limit](software-development.md#supervision-is-tiring-and-it-has-a-limit).

So asking curators to be "hypervigilant" does not scale. Vigilance decays. The
practical response is to spend vigilance where it pays: let deterministic checks
handle what can be checked mechanically, and direct human attention to the
items most likely to be wrong.

## AI reviewing AI

AI review is useful as a filter. It is not an independent second opinion, for
three reasons:

* **Models make the same mistakes.** Across more than 350 models, when two
  models are both wrong they agree on the wrong answer 60% of the time, and
  more capable models are more correlated
  ([Kim et al., 2025](https://arxiv.org/abs/2506.07962)).
* **Models favour their own output**
  ([Panickssery et al., 2024](https://arxiv.org/abs/2404.13076)). AI reviewers of
  ICLR 2026 papers showed a "hivemind effect of excessive agreement"
  ([Baumann et al., 2026](https://arxiv.org/abs/2605.03202)).
* **Error-finding is still weak on hard problems.** On a benchmark of real errors
  in published papers, no model exceeded 21% recall
  ([Son et al., 2025](https://arxiv.org/abs/2505.11855)).

Software developers reached the same place: they accept about a third of an AI
reviewer's comments, and human reviewers raise things agents do not (see
[software](software-development.md#how-processes-change)).

That suggests using AI review as a separate reviewer with an explicit
checklist, run on every change including the editing agent's own, followed by
a human. GO's ontology repository works this way. See
[GO ontology](../case-studies/go-ontology.md) and
[One review checklist](../patterns/review-checklists.md).

### How to tell whether AI review works

We do not yet measure this (see [Evidence](../evidence.md#what-we-do-not-measure-yet)).
These benchmarks would tell us, and none needs new infrastructure:

* **Planted errors.** Seed a sample of pull requests with known errors (a wrong
  evidence code, a taxon violation, a fabricated PMID) and count how many the
  AI reviewer catches. This is how the automation-bias studies above were done.
* **Held-out curation.** Take annotations curators have already made, have the
  agent redo them blind, and compare. GOFlowLLM and the FlyBase
  [FlyAOC benchmark](https://arxiv.org/abs/2602.09163) do this.
* **Curator overrides.** Track how often a curator rejects or changes an
  agent's work, and why. A falling rate is progress; a rate near zero may mean
  rubber-stamping.
* **Disagreement between model families.** When two different models disagree
  on an item, send it to a curator. A 2026 trial (a preprint) used agreement across three
  model families as a confidence signal for physicians, and it improved their
  decisions.

## What might this mean for biocuration?

Two questions follow from the other fields. Could every piece of curation get
a second pair of eyes? And could curation become much more efficient, perhaps
by an order of magnitude, without losing quality? The "10x curator" was put
forward in October 2025 as an opportunity with a "reimagined role", alongside
covering more biology in more depth
([Mungall, Global Core Biodata Resource Forum, 2025](https://zenodo.org/records/17311281)).
It is a hypothesis, not a result. These are the first signs, and the reasons
for caution.

### Second eyes in curation

**AI reviewing human work.** In the GO ontology, an AI reviewer now checks
nearly every pull request: whether the right references are cited, whether the
statements in a definition are correct, whether cross-references are right, and
whether the change addresses the issue and nothing else. Over two months it
reviewed 172 pull requests and caught real errors in biology, axioms, and
provenance that passed the automated checks, in pull requests written by
curators as well as by the editing agent (GO ontology team report, GO
Consortium meeting, autumn 2026). A model checking annotations in the Gemma
gene expression database found manual curation errors in about 2% of
experiments, and because it quoted its evidence a curator could check each one
quickly ([Rogic et al., *Database*, 2026](https://pubmed.ncbi.nlm.nih.gov/42483875/)).

**Humans reviewing AI work.** At PomBase, an agent curates a whole paper for
the author and a curator to review. In a pilot of nine papers it came close to
curator recall and accuracy, with "no gross errors, only minor disagreements
about specificity/interpretation" (PomBase, GO Consortium meeting, autumn
2026). GOFlowLLM drafted 2,538 candidate microRNA annotations, and curators
agreed with 87% of the terms
([Green et al., *Bioinformatics*, 2026](https://pubmed.ncbi.nlm.nih.gov/41495476/)).

These are small samples and early pilots. They suggest that a second reader on
everything is no longer out of reach, which was not true a few years ago.

### Could it be much more efficient?

Some observations that point that way:

* **Much of the time goes on work an agent can draft.** Curating a paper means
  reading it, finding terms and identifiers, and entering the annotations:
  about 45 per paper in PomBase's community curation. GOFlowLLM produced its
  2,538 candidates in 58 hours; about 1,400 microRNA papers had been curated by
  hand in the previous decade.
* **Review can be fast when the draft carries its evidence.** In lipid
  transport curation, a batch of 16 GO-CAMs was quality-checked in one sitting,
  and the review led to a new GO term, a new Rhea reaction, and UniProtKB
  updates (UniProt, GO Consortium meeting, autumn 2026).
* **Some valuable tasks were never affordable.** Re-reviewing hundreds of
  annotations affected by an obsoletion, or comparing GO-CAMs of the same
  pathway across species, are what have been called *Tasks 2.0*: higher value
  than the entity recognition and term-filling that earlier AI aimed at
  ([Mungall, AIBIO-UK, February 2026](https://zenodo.org/records/18720291)).

And some that counsel caution:

* **Review capacity caps the gain.** PomBase's community curation is limited
  by how fast curators can check submissions, not by how fast they arrive. More
  drafts with the same review process give a backlog. Software has seen the
  same thing
  ([Writing code got cheap; shipping it did not](software-development.md#writing-code-got-cheap-shipping-it-did-not)).
* **The frontier is jagged.** Agents in these reports were good at some steps
  and weak at neighbouring ones: drifting to generic binding terms, missing a
  sibling GO term a curator spotted, hedging on uncertain papers. Where the
  boundary lies in biology has not been mapped. See
  [The jagged frontier](software-development.md#the-jagged-frontier).
* **Radiology's gains were real but modest.** The best-evidenced field showed
  better quality with 44% fewer reads, not an order of magnitude.
* **Nobody has measured it end to end.** The pilots measure steps, not curated
  knowledge reaching users.

If large gains come, they are more likely to come from changing what curators
spend time on than from doing the same steps faster: making each review
cheaper (the draft carries its evidence, validators catch the mechanical
errors, an AI reviewer flags what to look at), and building quality in rather
than checking it afterwards. See
[Make identifiers hard to fake](../patterns/ground-identifiers.md) and
[Fast and slow validation](../patterns/fast-and-slow-validation.md).

## Where to look: output most likely to be wrong

From the studies above, from the [GO AI Hub workshop](https://arxiv.org/abs/2608.27675),
and from the repositories in our [case studies](../case-studies/index.md),
these are the places errors cluster.

| Look harder at | Why |
| --- | --- |
| Anything not looked up: identifiers, PMIDs, quotes | Models fabricate plausible identifiers from memory. Lookups and validators catch these mechanically. |
| A step where a tool failed | Agents recover by guessing. In the workshop, an agent filled in missing abstracts from memory after PubMed failed, and did not say so. |
| Claims without a verbatim supporting quote | A quote makes a claim checkable in seconds; its absence is a signal. |
| Specific, deep terms and the long tail | Models know common genes and general terms best. Rare organisms, specific leaf terms, and recent findings are where they guess. |
| Output that is plausible and matches expectations | The DRAGON-AI errors were "plausible yet subtly incorrect". An answer that confirms what you expected is the one you check least. |
| Qualifiers, negation, taxon, and direction of effect | Small words that flip meaning: NOT, regulates versus directly acts, positive versus negative, the right species. |
| Long sessions | Context compaction makes agents forget earlier instructions. Most workshop participants hit it. |

The first three rows can be checked by software. The rest need a curator. Put
the curator's time there.

## How curator roles might change

Software suggests what to expect. Developers still exist, but they spend more
time specifying, reviewing, designing boundaries, and managing agents, and less
writing code. For curators, the equivalents might be:

* **Reviewing drafts** rather than writing every annotation.
* **Writing skills**: turning a standard operating procedure into something an
  agent follows. A skill is a curation guideline that runs. See
  [Write your own skills](../how-tos/author-skills.md).
* **Regulating the loop**: when the same mistake appears twice, fixing the
  process that produced it. See
  [Regulate the loop](../patterns/human-regulating-the-loop.md). In this
  picture, people govern and manage (assign work to agents, read their reports,
  make the core decisions, write the rubrics and skills) on top of defined
  processes and deterministic checks
  ([Mungall, AIBIO-UK, February 2026](https://zenodo.org/records/18720291)).
* **Modelling the hard cases** that agents get wrong, and adjudicating
  disagreements.
* **Managing several sessions.** Two or three at once is a realistic limit for
  most people. GO's ontology editors report the same problems developers do:
  getting lost in the agent's verbiage, and staying focused while switching
  between sessions. See
  [What we do in practice](software-development.md#what-we-do-in-practice).

New curators need to build judgment somewhere. Junior developers who learned
with AI writing the code understood it less well, but those who asked the AI
conceptual questions did fine
([Shen and Tamkin, Anthropic, 2026](https://www.anthropic.com/research/AI-assistance-coding-skills)).
Have new curators do some work by hand, and use the agent to explain rather than
only to do.

## Practical starting points

**Match the check to the task.**

| Task | Agent's role | Check |
| --- | --- | --- |
| Literature triage | Screen and rank papers | Curator samples the rejects as well as the accepts |
| Identifier and term lookup | Do it, always with a tool | Validator, no human needed |
| Drafting annotations or GO-CAM models | Draft with quoted evidence | Curator reviews every item; validators run first |
| Reviewing existing annotations | Flag candidates for change | Curator decides; track how often flags are right |
| New ontology terms and definitions | Draft from a design pattern | Expert editor reviews; this is where subtle errors hide |
| Reports, dashboards, one-off scripts | Write them | Check the output looks right; throw away when done |

**Share what works.** Many curators on the GO AI Hub converged on the same
problems without knowing it: the agent's pull toward generic binding terms,
the need for a clear rule on which molecular functions are worth annotating,
papers it could not get the full text of. A regular call where curators show each other
their workflows, and a habit of turning what works into a shared skill, spreads
lessons faster than documentation does. See
[Writing and sharing skills on the hub](https://github.com/geneontology/go-jupyter#writing-and-sharing-skills).

**Measure from the start.** Pick one task, record the time and the error rate
before and after, and publish the result. Whether curation can be much more
efficient will be settled by numbers like these, and curation does not have
them yet.
