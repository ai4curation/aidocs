# ai4c-reviewer

The review bot. It reads pull requests, applies the project's review rubric, and
supplies the approving review that branch protection requires.

**Kind**: GitHub App
**Install page**: [github.com/apps/ai4c-reviewer](https://github.com/apps/ai4c-reviewer)
**Byline**: `ai4c-reviewer[bot]`
**Used in**: [GO](../../case-studies/go-ontology.md),
[DisMech](../../case-studies/dismech.md),
[AI Gene Review](../../case-studies/ai-gene-review.md)

## Why it is separate from ai4c-agent

GitHub does not let an identity approve its own pull request. If the bot that
opened a pull request also reviewed it, the approval would not count.

Splitting the two means an agent pull request can reach a mergeable state
without a human approval, which is what lets these projects treat review as a
process rather than a personal duty. See
[One review checklist](../../patterns/review-checklists.md).

## How it is wired

```yaml
- name: Generate ai4c-reviewer token
  id: reviewer-token
  uses: actions/create-github-app-token@v2
  with:
    app-id: ${{ secrets.AI4C_REVIEWER_APP_ID }}
    private-key: ${{ secrets.AI4C_REVIEWER_PRIVATE_KEY }}
```

**Secrets you need**: `AI4C_REVIEWER_APP_ID`, `AI4C_REVIEWER_PRIVATE_KEY`, and a
model credential.

**Where to read it**:
[GO's `claude-code-review.yml`](https://github.com/geneontology/go-ontology/blob/master/.github/workflows/claude-code-review.yml).

## The rubric lives outside the workflow

GO keeps the review criteria in the `pr-review` skill, not in the workflow
prompt. Its comment gives the reason:

> The review substance lives in the `pr-review` skill
> (.claude/skills/pr-review/SKILL.md), not in the prompt below, so the same
> criteria apply when a human reviews a PR locally.

The workflow prompt carries only what is specific to running in CI: what is
installed on the runner, and how to submit the verdict. Copy this split. It
keeps one standard for humans and bots.

## What it reviews, and what it skips

GO reviews every same-repo pull request except those from `ontobot`, whose
automated refresh jobs produce large mechanical diffs. It deliberately does
review pull requests opened by `ai4c-agent[bot]`:

> self-review of agent work is the highest-value case, since it catches
> hallucinated PMIDs and bogus axioms before a curator spends time on them.

For that to work, the editing bot must be listed in `allowed_bots`. Review
actions skip bot-authored pull requests by default.

## Notes

* Fork pull requests cannot be reviewed automatically, because secrets are not
  available. GO's documented route for those is `workflow_dispatch`, or a
  `/review` comment.
* It finds its own earlier comments by matching
  `.user.login == "ai4c-reviewer[bot]"`, which is another reason to get commit
  and comment identity right.
* Give it read access to code and write access to reviews. It does not need to
  push branches.
