# AI Gene Review

A review of existing Gene Ontology annotations, one file per gene, with a public
voting interface for feedback.

**Repository**: [ai4curation/ai-gene-review](https://github.com/ai4curation/ai-gene-review)
**App**: [Browse gene reviews](https://ai4curation.io/ai-gene-review/app/index.html)
**Product**: `genes/<organism>/<GENE>/<GENE>-ai-review.yaml`
**Agent surface**: local sessions, GitHub mention, pull request review

## What to look at

| Path | What it is |
| --- | --- |
| [`.claude/skills/`](https://github.com/ai4curation/ai-gene-review/tree/main/.claude/skills) | Fifteen skills, including `annotation-reviewer`, `core-function-synthesizer`, `gocam-curation`, and `aigr-pr-review` |
| [`.claude/hooks/`](https://github.com/ai4curation/ai-gene-review/tree/main/.claude/hooks) | Hooks that run around agent actions |
| `genes/` | One directory per gene, holding the review and its cached references |
| `src/ai_gene_review/schema/` | The LinkML schema |

## What works

### Every annotation gets a verdict and a reason

A review does not rewrite an annotation. It records an action against the
existing one, such as `ACCEPT`, `MODIFY`, or `REMOVE`, together with the reason:

```yaml
existing_annotations:
  - term:
      id: GO:0005515
      label: protein binding
    action: MODIFY
    reason: "While evidence is strong, 'protein binding' is uninformative..."
```

This is reviewable in a way that a rewritten file is not. A curator reads the
verdict and the reason, and does not have to reconstruct what changed.

### Identifiers carry their labels

Every term appears as an identifier and a label together. A wrong pair fails
validation, because an agent would have to fabricate both consistently to get
past the check. See
[Make identifiers hard to fake](../patterns/ground-identifiers.md).

### Non-curators can give feedback

The generated pages carry thumbs-up and thumbs-down controls, and there is a
longer [evaluation form](https://go.lbl.gov/gene-eval) for detailed review. A
domain expert can disagree with an agent without learning Git.

This is the part most projects skip. Validation catches fabricated evidence.
Only a human who knows the gene catches a claim that is well-cited and wrong.

### Skills split reviewing from synthesizing

`annotation-reviewer` judges what exists. `core-function-synthesizer` writes what
the gene does. `aigr-pr-review` reviews the pull request. Three jobs, three
skills, three sets of instructions that do not interfere.

## What to copy first

Copy the action-and-reason record shape. If your agents change existing curated
statements, record the verdict and the reason next to the original instead of
replacing it. Review gets much cheaper.

## Gaps

The public voting data is feedback, not yet a measurement. Turning votes into a
number you can track over releases is still open work, and it is the obvious
next step for anyone copying this pattern.
