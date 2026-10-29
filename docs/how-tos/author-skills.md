# How to create curation skills

The behavior and capabilities of agents can easily be customized using [Agent skills](../reference/claude-skills.md).
Most of the time you will be working from GitHub repos that have a core set of skills predefined, and you might not need
to write your own skill or even modify existing ones.

But if you are defining a new SOP or adding a new capability, it can be useful to know the procedure for making skills.

Making skills is deceptively easy, and no matter what you do, it will likely "work" to some degree, because agents are generally
somewhat smart and resilient. But it's worth taking care to do it right to get the best results.

## Use a skill creator skill

Rather than hand-authoring a skill, use an agent to write the skill for you! Just describe to the agent what it
is you're trying to do and it will guide you through the process.

If you are doing this, always make sure you are using an up to date and highly capable coding agent harness
(e.g. latest claude code or codex), along with the most powerful model, and make sure you have the skill creator skill available.
If you don't there is a danger the agent will guess as to format and conventions. It is still good to check against the guidelines here.

!!! info "Further reading"

    - [Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) (Anthropic Engineering, Oct 2025) — the canonical introduction to skills; its advice to "start with evaluation" and iterate from observed agent behavior is exactly the mindset to bring to a skill-creator session.
    - [anthropics/skills](https://github.com/anthropics/skills) (Anthropic) — the public repo that ships the `skill-creator` skill itself, plus worked examples you can read to learn conventions firsthand.

## Use standard layouts

The challenge here is there is no standard that is guaranteed to work with all agents! But thankfully the proposed standards mostly agree and if you do things right then it's easy to
have your skills work with most agents.

Important: if you don't follow the standards, then most agents will probably find your skills anyway and use them appropriately -- most of the time! Except when they don't...
which can cause cryptic degradation of performance.

I find these two docs the most useful

- [https://agentskills.io/specification](https://agentskills.io/specification) --> the proposed standard
- [https://code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) --> de facto standard

!!! info "Further reading"

    - [Anthropic launches enterprise 'Agent Skills' and opens the standard](https://venturebeat.com/technology/anthropic-launches-enterprise-agent-skills-and-opens-the-standard) (VentureBeat, Dec 2025) — context on why the layout was standardized and why following it matters: within weeks of the open-standard announcement it was adopted across 20+ platforms (OpenAI, Google, GitHub, Cursor), so a spec-conformant skill is increasingly portable rather than Claude-only.

I'll first cover the claude de facto standard. Let's say I have two skills, I'll make the folder structure like this (always at the root of the GitHub repo):

```
.claude/
  skills/
    my-awesome-skill/
      SKILL.md
      <other files>
    my-brilliant-skill/
      SKILL.md
      <other files>
```

I will also typically make symlinks, either

- between `.agents -> .claude`
- between `.agents/skills -> ../.claude/skills`

Many non-claude agents will work just fine with `.claude`. You can always test it out later.

Note that previously claude code had separate mechanisms for skills and commands, and commands followed a slightly different structure:

```
.claude
  commands/
    my-awesome-command.md
    my-brilliant-command.md
```

There is now no need to make commands, as every skill can be invoked as a command. So don't make commands, just make skills.

## Use frontmatter in the SKILL.md

From [Anthropic guide](https://code.claude.com/docs/en/skills):

Every skill needs a SKILL.md file with two parts: YAML frontmatter between `---` markers that tells Claude when to use the skill, and markdown content with the instructions Claude follows when the skill runs. The directory name becomes the command you type, and the `description` helps Claude decide when to load the skill automatically.

I always include a `name` as well as a `description`, even though the name is a bit redundant:

```
---
name: my-awesome-skill
description: Use this skill to do <some awesome thing>
---

<detailed description here>

```

It may be possible to get away without writing frontmatter -- if you don't include it claude code will default to the directory name for `name` and the first paragraph of the markdown as `description`. But by including
the frontmatter, you make the separation clearer for other *humans* who come after you and edit the markdown.

You should also make sure you follow yaml syntax. Annoyingly, claude code can be lenient on broken yaml, which can burn you when you try and use the skill with another agent harness.

## Understand progressive disclosure

The Claude docs give you the three levels cleanly: (1) name + description preloaded into the system prompt so the agent knows the skill exists; (2) the full SKILL.md body, loaded only when the skill is invoked; (3) bundled files (reference.md, scripts, examples) referenced from SKILL.md and loaded only when the agent decides it needs them. Worth adding the practical consequence: keep SKILL.md lean because once invoked it stays in context for the rest of the session, and push bulky reference material to level-3 files.

!!! info "Further reading"

    - [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) (Anthropic Engineering, 2025) — the "why" behind progressive disclosure: context is a finite, degrading resource, so loading only what's relevant is a first-class design constraint, not just a tidiness preference.
    - [Code execution with MCP: building more efficient agents](https://www.anthropic.com/engineering/code-execution-with-mcp) (Anthropic Engineering, Nov 2025) — takes the same idea further, showing how moving tool catalogs out of context and into on-demand code cut one workflow from ~150K tokens to ~2K; a useful intuition pump for how aggressively level-3 material should be deferred.

??? abstract "What the research shows (with numbers)"

    - [*SkillJuror: Measuring How Agent Skill Organization Changes Runtime Behavior*](https://arxiv.org/abs/2606.11543) (arXiv, Jun 2026) — across 82 tasks, progressive disclosure raised the distinct skill resources an agent accessed per run from **1.18 to 3.85** and produced **+4.1%** more verifier-passing trials than a flat layout. Gains were largest when bundled resources guide implementation, checking, or repair, and weakest for exact-format or numeric-threshold tasks — a good cue for *what* belongs in level-3 files.
    - [*Evaluating Long-Context Reasoning in LLM-Based WebAgents*](https://arxiv.org/abs/2512.04307) (arXiv, Dec 2025) — agent success **fell from 40–50% to under 10%** as context grew from 25K to 150K tokens, with agents losing track of the original task. Concrete motivation for keeping SKILL.md lean: a bloated skill body doesn't just waste tokens, it degrades reasoning.

## Include wrapper scripts

Some skills might not involve any new tools. For example, a review skill might give a checklist for the agent to follow and tick off items.

In other cases, a skill might exist in order to give the agent a specific piece of functionality, or to guide it in correct use of a tool. There are different approaches here:

1. standalone bash or python scripts in the skills folder
    - these might wrap an external API
    - or they might import python modules and provide a shim onto them
2. instructions inlined in the skill markdown
     - instructions on how to call an external API
     - instructions/examples on python scripts that use a particular module or modules
  
This is partly a matter of style, but I generally prefer to include scripts. These are easier to test standalone,
and allow me to constrain the actions of the agent more. The exception is if the skill is highly open-ended by nature,
then I might prefer to document a flexible module and give some examples of use in the markdown.

My skills folder might end up looking like this:

```
.claude/
  skills/
    my-awesome-skill/
      SKILL.md
      scripts/
        do-the-thing.sh
```


Example: https://github.com/cmungall/lakehouse-skills/tree/main/kbase-query

## Modularize your skills

Ideally skills should be relatively standalone. Don't assume tacit knowledge beyond what is already documented in your `CLAUDE.md` or `AGENTS.md`.

## Favor skills over MCPs (mostly)

MCPs are a good solution for giving agents capabilities in more constrained environments; an http MCP is good if you want people to use it in a web based chat.

In general skills, provide more flexibility, and general fewer tokens and context flooding. However, if you already have MCPs for a particular capability and they work fine for you there may be no pressing reason to rewrite

!!! info "Further reading"

    - [Claude Skills are awesome, maybe a bigger deal than MCP](https://simonwillison.net/2025/Oct/16/claude-skills/) (Simon Willison, Oct 2025) — argues skills are conceptually simpler than MCP (a markdown file plus optional scripts) and often the better default, which is the same trade-off this section describes.
    - [Code execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) (Anthropic Engineering, Nov 2025) — the counterpoint: rather than skills *vs* MCP, it shows how to keep MCP servers but stop flooding context with their tool definitions, so an existing MCP need not be rewritten.

## Consider not writing a skill

Many people think they need to write a skill to perform a task they think of as challenging or requiring specialized knowledge. But in fact the models used by
agents have already learned common APIs, and agents can easily do research to find relevant docs. Of course, dynamic doc discovery is prone to flakiness, latency.

Even if your agent knows how to parse fasta files (for example), you may still want to write a skill that guides the agent do it *your* preferred way (you might
have particular conventions in your fasta files, or you may have particular environment considerations). I often tend to write skills not because the agent doesn't
know how to do something, but because I have latent knowledge that overrides its defaults.

!!! info "Further reading"

    - [Writing effective tools for AI agents](https://www.anthropic.com/engineering/writing-tools-for-agents) (Anthropic Engineering, Sep 2025) — though framed around tools rather than skills, its core lesson applies directly: don't build thin wrappers around things the agent can already do; reserve new capabilities for genuine, high-leverage gaps.

## Put each check in the right layer

A skill is instructions. The agent reads them and usually follows them, but
nothing guarantees it. A model that has seen every GO evidence code in training
can still write one in the wrong field. Anything that must always hold belongs
in something that runs and can say no.

Split the work into four layers:

| Layer | What it decides | Examples | Where it lives |
| --- | --- | --- | --- |
| **Skill** | Biological judgment, how to read evidence, the order of work | Whether an experiment supports IDA or IMP; when a binding term is too generic; when to stop and ask | `SKILL.md` and its reference files |
| **Validation** | Constraints a machine can check | Required fields and cardinality; allowed evidence codes; term exists and its label matches; taxon constraints; ontology logic | Schema, rules, scripts, the write API, CI |
| **Reference verification** | Whether the receipt is real | The identifier resolves; the title matches; the quoted text appears in the source | [linkml-reference-validator](../reference/agentic-tools.md#linkml-reference-validator), run by the skill and again in CI |
| **Scientific review** | Whether the evidence supports the claim | A curator, a second-pass review agent, or a classifier that triages for a curator | Pull request review, review skills |

The last two are easy to confuse. A PMID that resolves, with a title that
matches and a quote that appears verbatim in the paper, shows that the agent
did not invent the citation. It does not show that the paper supports the
annotation. The quote may describe a paralog, a different species, or an
overexpression artifact. That call is scientific review, and no validator
makes it.

Not every biological judgment stays in the skill. Some biological policies can
be stated precisely enough to check. GO's taxon constraints are an example:
editors record which taxa a term can apply to, and
[GORULE:0000013](https://github.com/geneontology/go-site/blob/master/metadata/rules/gorule-0000013.md)
checks annotations against them in GO's annotation pipeline. Even that rule
encodes a policy, not just a test: experimental annotations that fail are
reported, and non-experimental ones are filtered out. Other judgments, such as
whether an assay was direct, resist this. Leave those in the skill and in
review.

### An example: evidence codes

Three statements about evidence belong in three different places:

* **"Each annotation has exactly one evidence code, from the allowed set."**
  This is a validation rule. Put it in the schema as an enum and a
  cardinality, so a record with `IDAA` or with two codes fails.
* **"Is this IDA or IMP?"** This is domain guidance. A kinase assay on purified
  protein is a direct assay; a knockout whose phenotype implicates the gene in
  a process is a mutant phenotype. Edge cases need judgment, so the skill
  explains how to decide and review checks the decision.
* **"`IDA` and `ECO:0000314` are not interchangeable."** GO evidence codes are
  short codes such as `IDA`. The [Evidence and Conclusion
  Ontology](https://www.evidenceontology.org/) (ECO) has its own identifiers,
  and ECO publishes a
  [mapping](https://github.com/evidenceontology/evidenceontology/blob/master/gaf-eco-mapping.txt)
  in which `IDA` corresponds by default to `ECO:0000314`. Validation should
  reject an ECO ID in a field that expects a code, and the reverse. The skill
  only needs to say which one the format uses.

### Who writes the rules

Curators know which constraints matter and what they mean. Engineers know how
to make a check fast, testable, and hard to bypass. Design rules together. A
good working split is that curators state the rule in plain language and supply
examples that must pass and examples that must fail, and engineers turn them
into a validator with those examples as tests. Curators then review the error
messages, because they are the ones who will read them.

Do not treat validators as engineering territory that curators cannot touch.
GO's rules are a model here: each one is a short page with a prose description,
a status, and a link to its implementation, so a curator can propose or
question a rule without reading the code.

### Skills orient; they do not enforce

A skill may tell the agent briefly what the format looks like, where the schema
is, and which command validates it. That saves wasted attempts. For example:

```markdown
Records follow `src/schema/kb.yaml`. After every edit, run
`just validate <file>` and fix what it reports before moving on.
The most common failure is a term ID whose label does not match.
```

Do not copy the schema's enums, required fields, or patterns into the skill.
The schema changes and the copy will not, and an agent following a stale copy
will argue with the validator. Point to the source instead. See
[One source of instructions](../patterns/one-source-of-instructions.md).

### Make invalid edits impossible to accept

The gate has to sit where every edit passes, not in one tool or one user
interface. A rule enforced only by an editor's form does nothing when an agent
writes through the API, and a rule enforced only in a skill does nothing when a
curator edits by hand. There are two common places for it:

* **Transactions.** When edits go through a script, an API, or an MCP server,
  that write path can check the edit and refuse it. The
  [noctua-py](https://github.com/geneontology/noctua-py) client for GO-CAM
  supports this: a caller gives each class ID with its expected label, and
  if the result does not match, the change is rolled back
  ([docs](https://github.com/geneontology/noctua-py/blob/main/docs/validation.md)).
  Read its note on `ok` versus `succeeded`: a response can report a working API
  call even though validation failed.
* **Files under version control.** An agent can write anything to a file, so
  the gate is acceptance. Make validation a required status check on the pull
  request, so nothing merges until it passes. Hooks and pre-commit checks give
  faster feedback but can be skipped, so treat them as a convenience, not the
  gate. See [Fast and slow validation](../patterns/fast-and-slow-validation.md).

### Write errors the agent can act on

The agent reads the error and tries again, so the error is part of the
interface. Compare:

```text
Validation failed.
```

```text
annotations[3].evidence_code: "ECO:0000314" is not an allowed value.
This field takes a GO evidence code such as IDA or IMP.
ECO:0000314 corresponds to IDA. See src/schema/kb.yaml (EvidenceCodeEnum).
```

A useful error names the location, the value, what was expected, and where the
rule is defined. It does not suggest the agent change the evidence to make the
error go away.

### Separate "failed" from "could not check"

Reference verification has three outcomes, not two:

* **Verified**: the reference resolved and the quote was found.
* **Failed**: the reference does not exist, the title does not match, or the
  quote is not in the text. The agent should fix or remove the evidence.
* **Not checked**: the service was down, the request was rate-limited, or only
  the abstract was available. The agent should not change the citation. The
  record stays unverified until a later run succeeds.

Tools do not always tell a failure from a missed check.
linkml-reference-validator reports "Could not fetch reference" both for a
PMID that does not exist and for a network or NCBI outage
([troubleshooting](https://github.com/linkml/linkml-reference-validator#troubleshooting)).
Its `skip_prefixes` setting makes skipped references pass with severity INFO;
that is meant for reference types you have decided not to check, and a skipped
reference has not been verified. Whatever wrapper or CI step calls the
validator should retry outages, report them separately, and never count them
as passes. The GO `gocam-review` skill states the same rule for people: a
finding that rests on a paper read only in abstract is "not verified (abstract
only)", not "wrong".

### Test with examples that must fail

For each rule, keep at least one fixture that must fail, and assert both that
it fails and what the message says. Useful negative cases for annotation data:

* an evidence code that is not in the allowed set, or an ECO ID in the code field;
* a term ID with the label of a different term, or an obsolete term;
* a PMID whose title does not match the one recorded;
* a quote that is not in the paper;
* two evidence codes where the schema allows one.

Then test the skill and the gate together. Give the agent a task where the
tempting answer breaks a rule, and check that the gate catches it and that the
agent repairs the record from the error message alone.
[go-skills](https://github.com/geneontology/go-skills/tree/main/tests) keeps
tests for the checks script behind `gocam-review`, for example.

### What GO has in place today

Tools that exist are not the same as tools wired into a workflow. As of
October 2026:

* **Ontology edits** ([go-ontology](https://github.com/geneontology/go-ontology)):
  pull requests run the ODK quality-control build in CI. The `research` skill
  tells the agent to cache references and validate its supporting text with
  linkml-reference-validator, and the agent workflow installs it. That check
  is run by the agent, not required on every pull request.
* **GO-CAM**: noctua-py provides label-checked writes with rollback, and
  [noctua-mcp](https://github.com/geneontology/noctua-mcp) exposes the Noctua
  API to agents. The go-skills `gocam-review` skill is read-only and runs a
  tested checks script; it states that the GO AI Hub has no write access to
  production Noctua.
* **Standard annotations**: the go-skills `annotate-function` skill proposes
  annotations as a table with terms, evidence codes and references. It never
  creates them, so a curator is the gate. GO's rules check annotations in the
  release pipeline, after submission.
* **PAINT**: on the [GO AI Hub](../case-studies/go-ai-hub.md), agents have
  prepared literature reviews for PAINT curators to read. This site knows of no
  agent-facing validator for PAINT annotations.

linkml-term-validator and linkml-reference-validator are available to any of
these. [DisMech](../case-studies/dismech.md) runs both as CI gates, which is
the arrangement to copy.

### Author checklist

Before you share a skill that produces curated content:

- Each rule that must always hold is enforced by a schema, script, API or
  required CI check, not only by the skill text.
- The skill explains the judgment calls and points to the schema rather
  than copying it.
- Every rule has a fixture that must fail, and a test checks the message.
- Error messages name the field, the value, what was expected, and where
  the rule lives.
- "Could not check" is reported separately from "failed" and never counts
  as a pass.
- Identifiers are recorded with labels, and citations with quotes, so they
  can be verified.
- Someone reviews whether the evidence supports the claim, and the skill
  does not imply that passing validation settles it.
- Curators helped write the rules and have read the error messages.

!!! info "Further reading"

    - [Show me the receipts: patterns for verification in agentic knowledge generation](https://chrismungall.substack.com/p/show-me-the-receipts-patterns-for) (Chris Mungall, Oct 2026) — the reasoning behind these layers: ask the agent for a checkable receipt, check it deterministically where possible, use fast classifiers to triage whether evidence aligns with the claim, and keep people on the cases that matter.

## Test your skill

The first thing to do is test if your agent is aware of your skill. You can list skills in most coding tools with the `/skills` command, which should show something like:

```
  ✔ on         annotation-reviewer · project · ~120 tok
  ✔ on         bioinformatics-analyzer · project · ~160 tok
```

If you don't see your skill there then you may have a problem, e.g. something is in the wrong folder. Again it may not manifest as agents like to dig around folders and they may find your skills
and use them... until they don't.

## Case studies

The principles above are easier to absorb from real, working skill sets. Both repos below keep their skills at the root of the repo in `.claude/skills/`, follow the de facto Claude layout, and are public, so you can read the actual `SKILL.md` files.

### Monarch dismech

[`monarch-initiative/dismech`](https://github.com/monarch-initiative/dismech) is a knowledge base of disease mechanisms, stored as LinkML-schema YAML files with bindings to ontologies like MONDO, HPO, and GO. It ships seventeen skills covering the full curation lifecycle, and is a good example of using skills as **standard operating procedures** rather than just capability shims.

Patterns worth copying:

- **Project-prefixed naming for related skills.** Several skills share a `dismech-` prefix ([`dismech-references`](https://github.com/monarch-initiative/dismech/tree/main/.claude/skills/dismech-references), [`dismech-compliance`](https://github.com/monarch-initiative/dismech/tree/main/.claude/skills/dismech-compliance), [`dismech-pr-review`](https://github.com/monarch-initiative/dismech/tree/main/.claude/skills/dismech-pr-review)), which keeps them grouped and unambiguous in the `/skills` list.
- **Wrapping a tool to enforce a guardrail.** [`dismech-references`](https://github.com/monarch-initiative/dismech/tree/main/.claude/skills/dismech-references) drives a `linkml-reference-validator` tool to check that every quoted evidence snippet matches its PubMed/ClinicalTrials source verbatim, classifies each as SUPPORT / REFUTE / PARTIAL / etc., and deletes fabricated evidence outright. This is the "include wrapper scripts" pattern doing real work — constraining the agent and catching hallucinated citations.
- **Skills that orchestrate other skills.** [`curate-next`](https://github.com/monarch-initiative/dismech/tree/main/.claude/skills/curate-next) batches work: it filters GitHub issues assigned to the current user, runs a duplicate preflight check, and dispatches parallel `/curate` agents — with input validation (N between 1–8) baked into the SKILL.md. A skill is a natural home for this kind of workflow logic.

### GO AI Hub

On the [GO AI Hub](../case-studies/go-ai-hub.md), skills live in
[geneontology/go-skills](https://github.com/geneontology/go-skills), and every
curator's home holds an editable clone with Claude's skills linked into it. A
curator can change a skill, try it in their own session, and open a pull
request; a merge reaches every curator within minutes. See
[Writing and sharing skills on the hub](https://github.com/geneontology/go-jupyter#writing-and-sharing-skills).

### GO ontology

[`geneontology/go-ontology`](https://github.com/geneontology/go-ontology) is the development repo for the Gene Ontology. Its ten skills (`design-pattern`, `taxon-constraint`, `term-obsoletion`, `external-term-lookup`, `mapping`, `reaction`, `chemical-entity`, `research`, `odk-make`, `pr-review`) are a clean illustration of the "[consider not writing a skill](#consider-not-writing-a-skill)" point inverted: the agent already knows ontology basics, so these skills exist to encode **latent, project-specific knowledge that overrides its defaults**.

Patterns worth copying:

- **Skills that teach your conventions, not the basics.** [`design-pattern`](https://github.com/geneontology/go-ontology/tree/master/.claude/skills/design-pattern) points the agent at GO's DOSDP patterns in `src/patterns/*.yaml`, tells it to check for similar existing terms with `obo-grep.pl` before writing a logical definition, and warns against over-specifying — exactly the kind of house style an agent won't guess.
- **Domain SOPs with explicit judgement calls.** [`taxon-constraint`](https://github.com/geneontology/go-ontology/tree/master/.claude/skills/taxon-constraint) encodes when *not* to act: prefer parsimonious (broader) constraints, skip constraints already inherited from CL/UBERON, and remove them when a term is obsoleted.
- **Cross-referencing skills for composition.** The `design-pattern` skill defers chemical terms to the `chemical-entity` skill rather than duplicating that knowledge — modular skills that point at each other instead of repeating content.

For more on both repositories, see the
[DisMech](../case-studies/dismech.md) and [GO](../case-studies/go-ontology.md)
case studies.

## Optional: create a skills marketplace

Once several repositories in your organization need the same skill, stop copying
it. A marketplace is a repository of skills that others install from, so a fix
lands in one place.

[curation-skills](https://github.com/ai4curation/curation-skills) holds the
shared ontology and biocuration skills for this organization. The CultureBot
mechs keep a shared `culturebot-skills` repository and use it the same way
across their six knowledge bases.

Use a marketplace when a skill is genuinely general, such as term lookup or
reference validation. Keep skills that encode one project's conventions in that
project. A shared skill that has to describe five projects' conventions helps
none of them.

Whichever you choose, record where a skill came from. The main risk with copied
skills is silent divergence: [Uberon](../case-studies/uberon.md) and
[Mondo](../case-studies/mondo.md) share four subagent names, and neither
repository says whether the shared ones are kept in sync. See
[One source of instructions](../patterns/one-source-of-instructions.md).
