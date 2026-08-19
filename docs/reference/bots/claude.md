# claude

Anthropic's own GitHub App. It runs Claude Code from issues and pull requests.

**Kind**: GitHub App
**Install page**: [github.com/apps/claude](https://github.com/apps/claude)
**Owner**: Anthropic
**Byline**: `claude[bot]`
**Used in**: many repositories, including this one

## What it does

It is the default identity when you add Claude Code to a repository with
`claude install-github-app`. Work appears under `claude[bot]`: review comments,
pull requests, and replies to mentions.

## How it is wired

You can authenticate the action two ways.

**With an App token minted from OIDC.** The workflow passes no `github_token`
and sets `id-token: write`, and the action obtains a Claude App token itself.
DisMech's `claude.yml` does this. Note that job-level `permissions:` then scopes
the unused `GITHUB_TOKEN`, not the App token, so anything the agent needs to
read has to be granted through `additional_permissions`.

**With your own App token.** Mint a token for a different App and pass it as
`github_token`. This is how GO and DisMech run the review workflow under
[ai4c-reviewer](ai4c-reviewer.md) instead of `claude`.

The model credential is separate from the identity: either `ANTHROPIC_API_KEY`
or `CLAUDE_CODE_OAUTH_TOKEN`.

## When to use your own App instead

Use `claude` when you want the quickest working setup.

Use your own App when you want:

* **A name that says what it does.** `ai4c-reviewer[bot]` in a byline is clearer
  than `claude[bot]` when several different jobs all run Claude Code.
* **Two identities.** You need a second App if one bot opens pull requests and
  another approves them.
* **Your own permission set,** scoped per repository.

## Notes

* `CLAUDE_CODE_OAUTH_TOKEN` expires. When it does, every run fails with
  `API Error: 401 ... OAuth access token has expired` before reaching the model,
  and the job posts "Claude encountered an error" with no detail. Check the job
  log rather than the comment. Refresh with `claude setup-token`.
* Bot-authored pull requests are skipped by review actions unless listed in
  `allowed_bots`.
