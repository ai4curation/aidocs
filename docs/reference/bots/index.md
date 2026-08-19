# Bots

A **bot** is the GitHub identity that agent work appears under. It is the name
in the byline on an issue, a comment, a commit, or a pull request.

Keep it separate from the agent:

* The **agent** is the software that does the work. See
  [Harnesses](../harnesses.md).
* The **bot** is the identity it works under.

The same agent can work under different bots in different repositories. Claude
Code runs as `claude[bot]` in one repository and as `ai4c-agent[bot]` in
another. The agent is the same. The permissions are not.

## Bots in use

| Bot | Kind | Job | Repositories |
| --- | --- | --- | --- |
| [`ai4c-agent`](ai4c-agent.md) | GitHub App | Does curation work | GO, DisMech, AI Gene Review |
| [`ai4c-reviewer`](ai4c-reviewer.md) | GitHub App | Reviews pull requests | GO, DisMech, AI Gene Review |
| [`claude`](claude.md) | GitHub App | Runs Claude Code from issues and pull requests | Many |
| [`copilot-swe-agent`](copilot.md) | GitHub App | Works an issue, opens a draft pull request | EFO, Uberon |
| [`dragon-ai-agent`](dragon-ai-agent.md) | Machine account | Older curation bot, being retired | Mondo |

Two more appear in bylines but are not curation bots. `github-actions[bot]` is
the built-in identity for workflow runs, so it authors anything a workflow
commits. `ontobot` runs GO's automated refresh jobs, which produce large
mechanical diffs.

## The two kinds

### GitHub Apps

An App is installed into a repository or an organization. A workflow mints a
token for it at the start of each run, and that token expires when the run
ends. Nothing long-lived sits in your secrets except the App's private key.

GitHub appends `[bot]` to an App's byline, so you see `ai4c-agent[bot]`.

Apps do not use a seat in your organization, and you grant each one only the
permissions it needs.

### Machine accounts

A machine account is an ordinary GitHub user account that a program logs in as.
GitHub calls these machine users.

A machine account looks like a person. There is no `[bot]` suffix, it can join
teams, it uses a seat, and it authenticates with a personal access token that is
long-lived and sits in your repository secrets.

Prefer an App for anything new.

## You cannot mention an App

This surprises people, so it is worth stating plainly.

**GitHub Apps cannot be @-mentioned.** Typing `@ai4c-agent` in a comment does
nothing on its own. It is plain text. GO's workflow says so directly:

> The handle curators type to invoke the agent. Note this is NOT a real GitHub
> account: the app's login is AGENT_LOGIN (`<name>[bot]`), and apps cannot be
> @-mentioned, so "@ai4c-agent" renders as plain text.

So every "mention" of a bot is really a **trigger keyword**. A workflow watches
comment text, matches the string, checks that you are authorized, and starts a
run. The App is what the run then authenticates as.

Two consequences:

* You can change the keyword without changing the identity. GO honours both
  `@ai4c-agent` and the older `@dragon-ai-agent` while curators move across.
* A keyword in an old issue thread tells you a workflow ran. It does not tell
  you which identity did the work. Check the byline on the resulting pull
  request.

## Why a project runs two of its own

GO, DisMech, and AI Gene Review each run both `ai4c-agent` and `ai4c-reviewer`.
The reason matters before you copy the setup.

**GitHub does not let an identity approve its own pull request.**

These projects require an approving review before a pull request merges. If the
bot that opened the pull request were also the bot that reviewed it, the
approval would not count, and every agent pull request would need a human.

So the work is split:

* `ai4c-agent` writes. It responds to keywords and pushes branches.
* `ai4c-reviewer` reviews. It applies the review rubric and supplies the
  approving review.

Two identities, one boundary. This is what lets a project say that contributors
are not expected to check their own agent's output. See
[One review checklist](../../patterns/review-checklists.md).

## Make commits attribute correctly

An App token does not set the commit author. Configure it, or commits land
under whatever Git identity the runner happens to have.

The address form GitHub recognises for App commits needs the bot account's
numeric user id:

```bash
APP_USER_ID="$(gh api "/users/${APP_SLUG}[bot]" --jq .id)"
git config --global user.name "${APP_SLUG}[bot]"
git config --global user.email "${APP_USER_ID}+${APP_SLUG}[bot]@users.noreply.github.com"
```

!!! warning "The app id is not the user id"

    An App has two different numbers. The **app id** identifies the App and goes
    with the private key when you mint a token. The **user id** identifies the
    `name[bot]` account and is what commit attribution needs. GO's workflow
    warns about this in a comment, because using the wrong one silently breaks
    the link between commits and the App.

Get the user id with `gh api /users/ai4c-agent%5Bbot%5D --jq .id`.

## Let your reviewer see bot pull requests

Review actions ignore bot-authored pull requests by default, which is exactly
backwards when the bot is your editing agent. GO has to list it explicitly:

```yaml
allowed_bots: 'claude,github-actions,ai4c-agent'
```

Its comment explains why:

> ai4c-agent must be listed, or PRs opened by the editing agent -- the main
> reason this workflow exists -- would be ignored as bot noise.

Reviewing agent work is the highest-value case. It catches fabricated
identifiers before a curator spends time on them.

## Restrict who can trigger a bot

A bot with write access, started by a comment, is reachable by anyone who can
comment. Control both halves:

* **Who may trigger it.** GO keeps a list of authorized usernames in
  `.github/ai-controllers.json` and checks the commenter against it before the
  agent runs.
* **What it may do.** This is the App's permission set, not a matter of
  instructions. Grant each App the narrowest permissions for its job. A reviewer
  needs to read code and write reviews. It does not need to push branches.

See [Guard the untrusted surface](../../patterns/guard-untrusted-input.md).

## Reading a byline

| You see | It means |
| --- | --- |
| `name[bot]` | A GitHub App |
| A plain login | A person, or a machine account |
| `github-actions[bot]` | A workflow, using the built-in token |
| `@name` in comment text | A trigger keyword, not necessarily that identity |

A byline tells you the identity. It does not tell you the model, the harness, or
who asked. For that you need the execution trace. See
[Evidence](../../evidence.md).
