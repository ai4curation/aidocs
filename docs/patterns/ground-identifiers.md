# Make identifiers hard to fake

**Use it when** agents write ontology terms, citations, or quotes.

An agent can produce `GO:0006954` when it means something else, or cite a paper
that does not contain the sentence it quotes. Both look right. Neither is
caught by a schema check that only tests the shape of the data.

## The pattern

Never record an identifier on its own. Record it with something that must match
it.

Instead of this:

```yaml
term: GO:0006954
```

Do this:

```yaml
term:
  id: GO:0006954
  label: inflammatory response
```

To pass a check, the agent now has to get both parts right and consistent with
the ontology. Guessing one is easy; guessing a matching pair is not.

Apply the same rule to evidence. A citation on its own is weak. A citation plus
the exact sentence it supports can be checked against the paper:

```yaml
evidence:
  - reference: PMID:12345678
    supports: SUPPORT
    snippet: "Exact quote from the paper"
    explanation: "Why this supports the claim"
```

## The tools

* [linkml-term-validator](https://github.com/linkml/linkml-term-validator)
  checks that a term exists and that the label matches.
* [linkml-reference-validator](https://github.com/linkml/linkml-reference-validator)
  checks that the quoted text appears in the cited reference.

Both run in continuous integration, so a pull request that fabricates a term or
a quote fails before a human reads it.

## Who does this

* [DisMech](../case-studies/dismech.md) runs both validators, plus a fast
  snippet check you can run while you curate.
* [AI Gene Review](../case-studies/ai-gene-review.md) pairs every term with its
  label throughout the schema.
* [HabitatMech](../case-studies/habitatmech.md) goes further: where no ontology
  term fits, it mints a local identifier instead of forcing a match.

## What this does not do

Validation proves that a citation exists, that a quote is exact, and that a
term is real. It does not prove that the claim is correct. Say so where your
readers can see it. DisMech puts this on its front page.

## Read more

* [Make identifiers hallucination-resistant](../how-tos/make-ids-hallucination-resistant.md)
