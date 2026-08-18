# How to Create an Agentic Curation Pipeline for a YAML Knowledge Graph

This guide describes a practical pattern for building an agent-assisted curation
repository where the canonical knowledge base is a set of YAML files, validated
by LinkML and reviewed through GitHub pull requests.

The main example is
[DisMech](https://github.com/monarch-initiative/dismech), a disorder mechanisms
knowledge base. The same pattern is also used in derived mechanism repositories
such as `community-mech`, and in
[ai-gene-review](https://github.com/ai4curation/ai-gene-review), where each YAML
file is an AI-assisted gene review rather than a disease mechanism record.

This page assumes you already have the basic GitHub agent wiring from
[How to create an AI agent for GitHub actions](set-up-github-actions.md). For
curator-facing invocation patterns, also see
[AI Instructors Guide: GitHub Agents](instruct-github-agent.md). For identifier
and citation guardrails, see
[How to Make Identifiers Hallucination-Resistant](make-ids-hallucination-resistant.md).
For the broader administrative strategy, see
[How to integrate AI into your Knowledge Base](integrate-ai-into-your-kb.md).

## What You Are Building

The target architecture is:

- A GitHub repository where curated records are plain YAML files.
- A LinkML schema that defines exactly what those YAML files can contain.
- A validation suite that checks structure, ontology terms, references, examples,
  and recommended-field compliance.
- Agent instructions that tell AI tools how to edit the repository safely.
- GitHub Actions that reject invalid agent or human changes before merge.
- Optional exports that project the YAML records into KGX, CX2, HTML pages, or a
  search/browse app.

The important design choice is that YAML is the source of truth. Rendered pages,
dashboards, JSON Schema, KGX, and browser data are generated products.

## 1. Start With a Repository Shape That Agents Can Understand

Use a small, predictable layout. DisMech uses this general pattern:

```text
my-curation-repo/
  CLAUDE.md
  pyproject.toml
  justfile
  project.justfile
  conf/
    oak_config.yaml
    reference_validator_config.yaml
  src/
    my_kb/
      schema/
        my_kb.yaml
      datamodel/
  kb/
    records/
      example_record.yaml
    modules/
      shared_pattern.yaml
  references_cache/
  tests/
    data/
      valid/
      invalid/
  .github/
    workflows/
      main.yaml
```

Use names that match the curation unit. In DisMech the main records are in
[kb/disorders](https://github.com/monarch-initiative/dismech/tree/main/kb/disorders),
shared mechanism modules live in
[kb/modules](https://github.com/monarch-initiative/dismech/tree/main/kb/modules),
and the schema is
[src/dismech/schema/dismech.yaml](https://github.com/monarch-initiative/dismech/blob/main/src/dismech/schema/dismech.yaml).
In ai-gene-review, records are organized by organism and gene, for example
[genes/ARATH/BRI1/BRI1-ai-review.yaml](https://github.com/ai4curation/ai-gene-review/blob/main/genes/ARATH/BRI1/BRI1-ai-review.yaml),
and the schema is
[src/ai_gene_review/schema/gene_review.yaml](https://github.com/ai4curation/ai-gene-review/blob/main/src/ai_gene_review/schema/gene_review.yaml).

Keep the layout boring. Agents are much better at reliable edits when every
record of the same kind lives in the same place and validates against the same
target class.

## 2. Model the Curated Record in LinkML

Create a LinkML schema for the smallest record that can carry useful curated
knowledge. A DisMech disease record includes fields such as:

- identity and lifecycle metadata
- disease term
- classifications
- pathophysiology assertions
- phenotypes
- treatments
- evidence items
- ontology-grounded descriptors

A gene-review record uses a different domain model, but the pattern is the same:

- one top-level record per curated subject
- nested objects for assertions
- explicit evidence and references
- ontology terms represented as `id` plus canonical `label`
- recommended fields for quality scoring

At minimum, include a reusable term object:

```yaml
classes:
  Term:
    attributes:
      id:
        identifier: true
        required: true
      label:
        required: true
```

Then use that object everywhere an agent might otherwise hallucinate a bare ID:

```yaml
classes:
  CuratedRecord:
    attributes:
      subject_term:
        range: Term
        inlined: true
        required: true
      evidence:
        range: EvidenceItem
        multivalued: true
        inlined_as_list: true
```

Use LinkML enums and dynamic enum bindings for controlled choices. For example,
DisMech binds frequency categories to HPO terms and validates ontology references
through `linkml-term-validator`.

## 3. Make YAML Records the Human and Agent Editing Surface

A record should be readable in a normal pull request. For a mechanism-oriented
knowledge graph, a compact draft record might look like this:

```yaml
name: Alexander Disease
description: >
  A short curator-readable summary of the disease and its mechanism.
disease_term:
  preferred_term: Alexander disease
  term:
    id: MONDO:0008752
    label: Alexander disease
pathophysiology:
- name: GFAP aggregation and Rosenthal fiber formation
  description: >
    The curated causal mechanism, written as a claim that can be checked.
  biological_processes:
  - preferred_term: Protein aggregation
    term:
      id: GO:0070841
      label: inclusion body assembly
  evidence:
  - reference: PMID:11138011
    reference_title: "Mutations in GFAP, encoding glial fibrillary acidic protein, are associated with Alexander disease."
    supports: SUPPORT
    evidence_source: HUMAN_CLINICAL
    snippet: "<exact text copied from the source>"
    explanation: >
      Why this quote supports the curated mechanism.
```

For an agentic pipeline, the evidence model matters as much as the biological
model. Require:

- a stable reference identifier such as `PMID:12345678`
- the publication title when useful
- exact supporting text snippets
- a support status such as `SUPPORT`, `REFUTE`, `PARTIAL`, or `NO_EVIDENCE`
- a short explanation of how the evidence relates to the claim

This gives validators and human reviewers concrete things to check.

## 4. Add the LinkML Validation Suite

Install the validation tools as normal project dependencies. A typical
`pyproject.toml` includes:

```toml
dependencies = [
  "linkml",
  "linkml-runtime",
  "linkml-term-validator",
  "linkml-reference-validator",
  "linkml-data-qc",
  "oaklib",
]
```

Use `uv` and `just` to make validation easy to run locally and in CI:

```bash
uv sync
uv tool install rust-just
just --list
```

Your `project.justfile` should expose at least these targets. For concrete
examples, compare DisMech's
[project.justfile](https://github.com/monarch-initiative/dismech/blob/main/project.justfile)
and ai-gene-review's
[project.justfile](https://github.com/ai4curation/ai-gene-review/blob/main/project.justfile).

```make
schema_path := "src/my_kb/schema/my_kb.yaml"
record_dir := "kb/records"
target_class := "CuratedRecord"
oak_config := "conf/oak_config.yaml"
ref_validator_config := "conf/reference_validator_config.yaml"

validate-schema file:
    uv run linkml-validate --schema {{schema_path}} --target-class {{target_class}} {{file}}

validate-terms file:
    uv run linkml-term-validator validate-data {{file}} -s {{schema_path}} -t {{target_class}} --labels -c {{oak_config}}

validate-references file:
    uv run linkml-reference-validator validate data {{file}} --schema {{schema_path}} --target-class {{target_class}} --config {{ref_validator_config}}

validate file:
    just validate-schema {{file}}
    just validate-terms {{file}}
    just validate-references {{file}}

validate-all:
    uv run linkml-validate --schema {{schema_path}} --target-class {{target_class}} {{record_dir}}/*.yaml
    uv run linkml-term-validator validate-data {{record_dir}}/*.yaml -s {{schema_path}} -t {{target_class}} --labels -c {{oak_config}}

lint-schema:
    uv run linkml-lint {{schema_path}}

compliance-all:
    uv run linkml-data-qc {{record_dir}}/*.yaml -s {{schema_path}} -t {{target_class}} -f text
```

DisMech extends this with:

- `just validate <file>` for schema, term, and reference validation of one record
- `just validate-all` for all disease YAML files
- `just validate-modules` for shared mechanism modules
- `just validate-terms-schema` for ontology references embedded in schema enums
- `just validate-graphs` for causal graph integrity
- `just compliance-all` and `just gen-dashboard` for recommended-field quality
- `just export-kgx` and `just export-cx2-all` for downstream graph products

ai-gene-review uses the same idea with gene-specific targets such as
`just validate human CFAP300`, `just validate-all`, `just test-examples`, and
`just compliance-dashboard`.

## 5. Configure Ontology Term Validation

Use an OAK configuration file such as DisMech's
[conf/oak_config.yaml](https://github.com/monarch-initiative/dismech/blob/main/conf/oak_config.yaml)
or ai-gene-review's
[conf/oak_config.yaml](https://github.com/ai4curation/ai-gene-review/blob/main/conf/oak_config.yaml)
to say which CURIE prefixes are validated and which are intentionally skipped.

```yaml
ontology_adapters:
  GO: sqlite:obo:go
  HP: sqlite:obo:hp
  MONDO: sqlite:obo:mondo
  CL: sqlite:obo:cl
  UBERON: sqlite:obo:uberon
  NCBITaxon: sqlite:obo:ncbitaxon

  PMID: null
  DOI: null
  file: null
```

The exact prefixes depend on your domain. DisMech validates MONDO, HP, GO, CL,
UBERON, CHEBI, GENO, MAXO, HGNC, NCIT, and related biomedical prefixes.
ai-gene-review validates GO, CHEBI, UBERON, CL, HP, MONDO, PR, SO, PATO,
NCBITaxon, and RHEA, while skipping literature and database prefixes that are
not ontology terms.

The rule for agents is simple: when adding an ontology term, provide both the ID
and the exact canonical label. The validator should fail if either half is wrong.

## 6. Configure Reference Validation

Use `linkml-reference-validator` when records contain quoted text or snippets.
DisMech keeps this configuration in
[conf/reference_validator_config.yaml](https://github.com/monarch-initiative/dismech/blob/main/conf/reference_validator_config.yaml);
ai-gene-review uses
[conf/reference_validator_config.yaml](https://github.com/ai4curation/ai-gene-review/blob/main/conf/reference_validator_config.yaml).
This catches fabricated quotes and mismatched citations.

```yaml
unknown_prefix_severity: WARNING
cache_dir: references_cache
skip_prefixes:
  - DOI
  - file
  - GO_REF
```

For a paper-backed curation repository, prefer this pattern:

- Fetch or cache publication text deterministically.
- Require snippets to be exact substrings, with documented support for ellipses
  or bracketed clarifications if your validator allows them.
- Treat reference validation failures as curation errors, not style issues.
- Skip non-literature accessions explicitly so the validator output stays clean.

In ai-gene-review, publication caches live in
[publications](https://github.com/ai4curation/ai-gene-review/tree/main/publications),
and `file:` references are resolved relative to the
[genes](https://github.com/ai4curation/ai-gene-review/tree/main/genes)
directory. In DisMech, reference validation checks evidence snippets in disorder
YAML files against cached or fetched references.

## 7. Add Valid and Invalid Examples

Do not rely only on real production data. Add small example files that prove the
schema and validators reject the mistakes you care about.

```text
tests/data/
  valid/
    minimal_record.yaml
  invalid/
    missing_id.yaml
    wrong_label.yaml
    wrong_branch.yaml
    bad_reference_snippet.yaml
```

Then add a `test-examples` target that requires valid examples to pass and
invalid examples to fail. This is especially useful when changing the schema,
because it tells you whether your guardrails still work.

## 8. Turn YAML Into a Knowledge Graph Product

Once the YAML is valid, export it.

For a graph-oriented repository, write explicit exporters rather than making
agents edit graph serialization directly. DisMech does this in several ways:

- HTML pages generated from YAML for human browsing.
- Browser data generated from YAML for a lightweight app.
- KGX edges generated from YAML for knowledge graph integration.
- CX2 networks generated from pathophysiology causal chains for NDEx-style
  network visualization.

A minimal `just` target might look like:

```make
export-kgx:
    mkdir -p output/kgx
    uv run koza transform src/my_kb/export/kgx_export.py -o output/kgx -f jsonl kb/records/*.yaml
```

Keep exported files reproducible. If they are committed, add CI checks that fail
when generated files are stale. If they are not committed, publish them from a
release or deployment workflow.

## 9. Write Agent Instructions and Skills

Add a top-level `CLAUDE.md` or equivalent agent instruction file. It should say:

- what the repository is for
- where the schema lives
- where records live
- which files are generated
- which commands must pass before a PR is ready
- how to add ontology terms
- how to cite evidence
- what not to edit manually

Use a browseable file path when you point people to examples, for example
[DisMech CLAUDE.md](https://github.com/monarch-initiative/dismech/blob/main/CLAUDE.md)
or
[ai-gene-review CLAUDE.md](https://github.com/ai4curation/ai-gene-review/blob/main/CLAUDE.md).

For example:

```markdown
# AI instructions

The source of truth is `kb/records/*.yaml`.

Before opening a PR:

- Run `just validate <changed-yaml-file>` for each changed record.
- Run `just validate-terms-schema` after schema enum changes.
- Run `just test-examples` after schema or validator changes.
- Do not invent ontology IDs, labels, PMIDs, or supporting quotes.
- When adding ontology terms, use the exact label returned by OAK.
- When adding evidence, include an exact snippet from the cited source.
```

Do not put every detailed workflow in the top-level instructions. Use
[skills](../reference/claude-skills.md) for task-specific procedures that agents
can load when relevant. DisMech has skills for
[ontology term work](https://github.com/monarch-initiative/dismech/blob/main/.claude/skills/dismech-terms/SKILL.md),
[reference validation and repair](https://github.com/monarch-initiative/dismech/blob/main/.claude/skills/dismech-references/SKILL.md),
[compliance improvement](https://github.com/monarch-initiative/dismech/blob/main/.claude/skills/dismech-compliance/SKILL.md),
[PR review](https://github.com/monarch-initiative/dismech/blob/main/.claude/skills/dismech-pr-review/SKILL.md),
and
[new disorder creation](https://github.com/monarch-initiative/dismech/blob/main/.claude/skills/initiate-new-disorder-creation/SKILL.md).
ai-gene-review has skills for
[gene review](https://github.com/ai4curation/ai-gene-review/blob/main/.claude/skills/review/SKILL.md),
[annotation review](https://github.com/ai4curation/ai-gene-review/blob/main/.claude/skills/annotation-reviewer/SKILL.md),
[PR review](https://github.com/ai4curation/ai-gene-review/blob/main/.claude/skills/aigr-pr-review/SKILL.md),
and
[multi-agent orchestration](https://github.com/ai4curation/ai-gene-review/blob/main/.claude/skills/boss/SKILL.md).

The top-level instruction file should tell the agent which skills exist and when
to use them. The skill should hold the detailed checklist, examples, validation
commands, and edge cases for that one workflow.

## 10. Put the Agent Behind Pull Requests, Reviews, and CI

Use GitHub branch protection. Agents should not write directly to `main`.
See [How to create an AI agent for GitHub actions](set-up-github-actions.md)
for the basic agent setup and repository secrets.

A basic CI workflow should:

1. Install Python dependencies with `uv`.
2. Install `just`.
3. Run schema and term validation.
4. Validate changed YAML records.
5. Run example tests.
6. Run unit tests for any supporting code.

DisMech's
[main.yaml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/main.yaml)
optimizes CI by validating only changed disease and comorbidity YAML files in
pull requests, while still validating schema term references and source code
tests. ai-gene-review's
[main.yaml](https://github.com/ai4curation/ai-gene-review/blob/main/.github/workflows/main.yaml)
runs `just validate-all` and `just test-examples`.

Once the baseline validation gate works, add optional GitHub Actions around it:

- **Mention-driven agent action**: lets authorized curators invoke an agent from
  issues, PRs, and review comments. DisMech uses
  [dragon-ai.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/dragon-ai.yml).
  This is the action covered by the
  [GitHub agent setup guide](set-up-github-actions.md).
- **Reviewer action**: runs an independent AI review on pull requests, for
  example DisMech's
  [claude-code-review.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/claude-code-review.yml).
  This is one of the most important optional actions for curation repositories:
  the authoring agent can miss ontology specificity problems, unsupported
  evidence, stale generated files, or malformed YAML that a second review pass
  catches before a human spends time on it.
- **Post-review action**: scans recent PR review comments and asks an agent to
  address actionable feedback, as in DisMech's
  [post-review-agent.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/post-review-agent.yml).
  This should treat human curator feedback as higher authority than bot
  feedback.
- **Scheduled compliance action**: uses compliance reports to select a small
  number of low-scoring records for incremental improvement. DisMech's
  [weekly-compliance.yaml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/weekly-compliance.yaml)
  is an example.
- **Issue triage and summarization actions**: help maintain the queue without
  editing curated data. DisMech has
  [claude-issue-triage.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/claude-issue-triage.yml)
  and
  [claude-issue-summarize.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/claude-issue-summarize.yml).
- **Regeneration and publication actions**: rebuild derived pages, browser data,
  dashboards, schema docs, and releases. Examples include DisMech's
  [generate-pages.yaml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/generate-pages.yaml),
  [deploy-docs.yaml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/deploy-docs.yaml),
  and
  [kgx-release.yaml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/kgx-release.yaml).
- **Stale review follow-up**: reassigns old PRs with outstanding review feedback
  back to the agent queue, as in
  [stale-pr-reassign.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/workflows/stale-pr-reassign.yml).
- **Copilot setup**: if you use GitHub Copilot coding agent, add
  [copilot-setup-steps.yml](https://github.com/monarch-initiative/dismech/blob/main/.github/copilot-setup-steps.yml)
  so the agent has the right dependencies and firewall setup.

Do not enable every automation on day one. A good order is validation CI,
reviewer action, mention-driven agent action, regeneration actions for derived
files, then scheduled compliance or stale-review follow-up once the repository
has enough traffic.

For scheduled agent work, use compliance reports rather than broad prompts. A
weekly compliance workflow should:

- run `just compliance-all`
- select low-scoring records
- improve a small number of files
- validate each changed YAML file
- open PRs for human review

That pattern is safer than asking an agent to improve the whole repository at
once.

## 11. Keep a Human Driving the Loop

The practical pattern is not "turn the agent loose on the knowledge graph." It is
a curator-driven loop:

1. A human chooses the curation target, scope, and acceptance criteria.
2. The human invokes the agent from an issue, PR, project item, or local session.
3. The agent uses repository instructions and skills, edits YAML, runs validation,
   and opens or updates a PR.
4. CI checks the mechanical contract: LinkML schema, term labels, references,
   examples, tests, and generated products.
5. Reviewer actions add a second pass, especially for ontology specificity,
   unsupported claims, reference problems, and missed local conventions.
6. The human reviews the scientific judgment, decides which feedback matters,
   and asks the agent for another iteration if needed.
7. The human merges only after checks pass and the curated change is acceptable.
8. Compliance dashboards, issue queues, and project boards suggest the next loop,
   but the human still chooses what matters next.

This pattern keeps agency with the curator. The agent accelerates search,
drafting, validation, and review response, but the human decides the goal and
the merge.

## 12. Add Optional Shared Modules

Shared modules are useful when the same biological or social mechanism appears
across many records.

In DisMech,
[kb/modules/fibrotic_response.yaml](https://github.com/monarch-initiative/dismech/blob/main/kb/modules/fibrotic_response.yaml)
defines a conserved fibrotic response pattern. Disease records can state that a
pathophysiology node conforms to a module node:

```yaml
pathophysiology:
- name: Hepatic Stellate Cell Activation
  conforms_to: "fibrotic_response#Mesenchymal Cell Activation"
  cell_types:
  - preferred_term: Hepatic stellate cell
    term:
      id: CL:0000632
      label: hepatic stellate cell
```

Do not make modules magic inheritance unless you really need that. The simpler
pattern is:

- modules define reusable expectations
- records remain fully explicit
- validation and review check whether a claimed conformance is plausible

This is a good way to derive repositories such as `community-mech` from the
DisMech pattern while changing the domain model and content.

## 13. Touching Ontology Workflows

This YAML-first pattern works well beside ontology workflows, but it is not the
same as editing an ontology directly.

Use ontology tooling when you need to:

- request or add a missing ontology term
- change ontology hierarchy
- change definitions, synonyms, or axioms
- maintain OBO or OWL release products

Use the YAML curation pipeline when you need to:

- curate domain assertions against existing ontology terms
- review evidence
- build a task-specific knowledge graph
- let agents propose small, reviewable content changes
- score completeness and prioritize future curation

When a curator needs a term that does not exist yet, the clean workflow is:

1. Open the ontology issue or PR.
2. Wait for the ontology term and label to exist.
3. Add the term to the YAML record.
4. Run term validation.

This keeps ontology authority in the ontology project and curation authority in
the YAML knowledge base.

## A Minimal Build Order

If you are starting from scratch, build in this order:

1. Create the LinkML schema and one valid YAML record.
2. Add `just validate <file>` using `linkml-validate`.
3. Add term objects with `id` and `label`, then enable `linkml-term-validator`.
4. Add evidence snippets, then enable `linkml-reference-validator`.
5. Add valid and invalid example tests.
6. Add agent instructions and starter skills.
7. Add GitHub Actions for validation CI.
8. Add a reviewer action.
9. Add a mention-driven GitHub agent action or local agent workflow.
10. Add compliance scoring.
11. Add HTML, KGX, CX2, or other exports.
12. Add scheduled agent workflows only after the validation
    suite is stable.

The key is to make the repository useful before it is autonomous. Once the YAML
contract and validators are strong, agents become another contributor to the
same review pipeline rather than a separate unchecked system.
