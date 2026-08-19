# ai4c-agent

The curation bot. It responds to trigger keywords, edits files, pushes branches,
and opens pull requests.

**Kind**: GitHub App
**Install page**: [github.com/apps/ai4c-agent](https://github.com/apps/ai4c-agent)
**Byline**: `ai4c-agent[bot]`
**Used in**: [GO](../../case-studies/go-ontology.md),
[DisMech](../../case-studies/dismech.md),
[AI Gene Review](../../case-studies/ai-gene-review.md)

## What it does

It is the identity that does the work, as opposed to the one that reviews it.
Across the repositories that run it, that means:

* Responding when an authorized user writes `@ai4c-agent please ...` in an issue
  or a pull request comment.
* Moving stalled pull requests forward.
* Editing curated files, pushing branches, and opening pull requests.

The agent behind it is Claude Code, run through
[`anthropics/claude-code-action`](https://github.com/anthropics/claude-code-action).
The App is the identity, not the agent.

## How it is wired

Each job mints its own installation token:

```yaml
- name: Generate ai4c-agent token
  id: ai4c-token
  uses: actions/create-github-app-token@v2
  with:
    app-id: ${{ secrets.AI4C_AGENT_APP_ID }}
    private-key: ${{ secrets.AI4C_AGENT_PRIVATE_KEY }}
```

The token lasts for the run. The only long-lived secret is the private key.

**Secrets you need**: `AI4C_AGENT_APP_ID`, `AI4C_AGENT_PRIVATE_KEY`, and a model
credential, either `ANTHROPIC_API_KEY` or `CLAUDE_CODE_OAUTH_TOKEN`.

**Where to read it**:
[GO's `ai-agent.yml`](https://github.com/geneontology/go-ontology/blob/master/.github/workflows/ai-agent.yml)
is the best-documented version. Its header comments explain each choice.

## Triggering it

`@ai4c-agent` is a keyword, not a mention. Apps cannot be @-mentioned, so the
workflow matches the string in the comment body and checks the author against a
list of authorized users. GO keeps that list in `.github/ai-controllers.json`.

GO also honours `@dragon-ai-agent` as a legacy keyword while curators move
across. See [dragon-ai-agent](dragon-ai-agent.md).

## Commit attribution

GO sets the commit identity from the bot account's numeric user id:

```yaml
AGENT_LOGIN: ai4c-agent[bot]
AGENT_USER_ID: 242316268
```

That number is the `ai4c-agent[bot]` **account** id, not the app id in
`AI4C_AGENT_APP_ID`. They are different numbers, and using the wrong one
silently unlinks the commits from the App.

## Notes

* Pair it with [ai4c-reviewer](ai4c-reviewer.md). A single identity cannot both
  open a pull request and supply its approving review.
* List it in your review action's `allowed_bots`, or its pull requests are
  skipped as bot noise.
* It cannot run on pull requests from forks, because GitHub withholds secrets
  from fork workflows.
