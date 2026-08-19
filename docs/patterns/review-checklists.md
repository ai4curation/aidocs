# One review checklist

**Use it when** different reviewers apply different standards.

Once you have an automated reviewer, the checklist it applies becomes the real
quality standard of your project. It is worth treating as a curated artifact.

## The pattern

Keep the checklist in one file. Point every reviewer at it.

[EFO](../case-studies/efo.md) has three reviewers: Claude, GitHub Copilot, and
Codex. All three apply `docs/agents-documentation/efo-pr-review-checklist.md`.
The Codex reviewer has its own procedure file, and that file points at the same
checklist. When the standard changes, one file changes.

[DisMech](../case-studies/dismech.md) keeps its rubric in a skill,
`dismech-pr-review`, and configures which model runs it in
`.github/agent-config.yaml`. [GO](../case-studies/go-ontology.md) and
[AI Gene Review](../case-studies/ai-gene-review.md) both have review skills too,
called `pr-review` and `aigr-pr-review`.

## Separate the review from the model

Two things change at different rates. The checklist changes when your standards
change. The model changes when a better one appears. Keep them in different
files so neither change disturbs the other.

## The review decides something

An automated review that leaves a comment is advice. An automated review that
marks a pull request "changes requested" or "ready to merge" is a gate. DisMech
does the second. This is what makes it possible for contributors not to check
their own agent's work.

Make it a gate only when you trust the checklist. That trust has to be earned by
reading its reviews for a while, which is the point of
[reviewing the reviews](human-regulating-the-loop.md).

## Automated review does not work on forks

GitHub does not give repository secrets to workflows triggered from a fork, so a
fork-based pull request gets no automated review.

Projects that depend on automated review have to handle this. DisMech asks
contributors to push branches to the origin repository instead of forking, and
closes fork pull requests automatically. That means granting branch access to
contributors, which is a governance decision, not a technical one.
