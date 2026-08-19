# Regulate the loop

**Use it when** you cannot review every agent edit yourself.

"Human in the loop" means a person checks each item. That works until agents
produce more work than your curators can read. Then the person becomes the
bottleneck, and the usual result is that review turns into rubber-stamping.

[DisMech](../case-studies/dismech.md) uses a different phrase: *human
regulating the loop*. Curators work on the process that produces entries, not
on each entry.

## The pattern

Spend curator time on these three jobs.

**Find patterns, not errors.** One wrong entry is a fix. The same wrong entry
five times is a process problem. Look for the repeated kind, then curate
examples and counter-examples into the instructions or the skill that produced
them.

**Review the reviews.** Your automated reviewer has its own failure modes. It
misses some things and it fixates on others. Read a sample of its reviews and
ask what it did not catch, and what it complained about that did not matter.
Then change the checklist.

**Tune how eager each process is.** Scanners and automated reviewers each have a
cadence and a threshold. Some fire too often and create noise. Some never fire
and miss work. This is a dial, and someone has to be responsible for setting it.

## Say who is accountable

The hardest part is not technical. Projects break down when nobody has said
whether a contributor is answerable for what their agent wrote.

DisMech states its answer in `CONTRIBUTING.md`: contributors are not assumed to
have verified everything their agent produced, and the default assumption is
that issues and comments are AI-generated. If you write something yourself and
want that known, you mark it `[human authored]`.

You do not have to make the same choice. You do have to make one, and write it
down.

## Who does this

* [DisMech](../case-studies/dismech.md) states the policy in `CONTRIBUTING.md`
  and asks contributors to curate the process.
* [AI Gene Review](../case-studies/ai-gene-review.md) collects feedback from
  domain experts through voting and an evaluation form, so disagreement reaches
  the project without requiring Git.

## Read more

* [Pull request reviews for agent improvement](../how-tos/pr-reviews-for-agent-improvement.md)
