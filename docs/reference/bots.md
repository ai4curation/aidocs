# Bots

A **bot** is the GitHub identity that agent work appears under. It is the name in
the byline on an issue, a comment, a commit, or a pull request.

Keep this separate from the agent itself:

* The **agent** is the software that does the work. See
  [Harnesses](harnesses.md).
* The **bot** is the identity it works under.

The same agent can work under different bots in different repositories. Claude
Code runs as `claude[bot]` in one repository and as `ai4c-agent[bot]` in
another. The agent is the same. The permissions are not.

## The bots you will meet

| Bot | Kind | What it does | Repositories |
| --- | --- | --- | --- |
| [`ai4c-agent`](https://github.com/apps/ai4c-agent) | GitHub App | Does curation work: responds to mentions, moves stalled pull requests forward | DisMech, AI Gene Review |
| [`ai4c-reviewer`](https://github.com/apps/ai4c-reviewer) | GitHub App | Reviews pull requests and supplies the approving review | DisMech, AI Gene Review |
| [`claude`](https://github.com/apps/claude) | GitHub App | Runs Claude Code from issues and pull requests | Many |
| `copilot-swe-agent` | GitHub App | Works an issue and opens a draft pull request | EFO, Uberon |
| `github-actions` | GitHub App | The built-in identity for workflow runs | Everywhere |
| `dragon-ai-agent` | Machine account | Older curation bot, now semi-retired | Mondo |

## The two kinds

### GitHub Apps

Most of the list above. An App is installed into a repository or an
organization. A workflow mints a short-lived token for it at the start of each
run, and the token expires when the run ends. Nothing long-lived sits in your
secrets except the App's private key.

You can tell an App by its byline. GitHub appends `[bot]`, so you see
`ai4c-agent[bot]`, not `ai4c-agent`.

Apps do not use a seat in your organization, and you grant each one only the
permissions it needs.

### Machine accounts

A machine account is an ordinary GitHub user account that a program logs in as.
GitHub calls these machine users. `dragon-ai-agent` is one.

A machine account looks like a person in the interface. There is no `[bot]`
suffix, it can join teams, and it uses a seat. It authenticates with a personal
access token, which is long-lived and sits in your repository secrets.

Prefer an App for anything new. Shorter-lived credentials and per-repository
permissions are both worth having.

## Why a project runs more than one bot

DisMech runs two of its own, and the reason is worth understanding before you
copy the setup.

**GitHub does not let an identity approve its own pull request.**

DisMech requires one approving review before a pull request can merge. If the
bot that opened the pull request were also the bot that reviewed it, the
approval would not count, and every agent pull request would need a human
approval.

So the work is split:

* `ai4c-agent` writes. It responds to mentions and pushes branches.
* `ai4c-reviewer` reviews. It applies the review rubric and supplies the
  approving review that branch protection requires.

Two identities, one boundary. This is what makes it possible for the project to
say that contributors are not expected to check their own agent's output. See
[One review checklist](../patterns/review-checklists.md).

## The dragon-ai-agent case

`@dragon-ai-agent` means two different things depending on which repository you
are in. This trips people up, so it is worth stating plainly.

**In [Mondo](../case-studies/mondo.md), the machine account is live.**
`.github/workflows/ai-agent.yml` runs `dragon-ai-agent/run-goose-obo` and
authenticates with a personal access token stored as `PAT_FOR_PR`. The account
is doing the work.

**In [DisMech](../case-studies/dismech.md), the account is retired.** The
workflow says so in a comment. What survives is the *phrase*: writing
`@dragon-ai-agent please ...` in an issue is a trigger keyword that starts a
workflow. The work is then done by the `ai4c-agent` App under a short-lived
token.

If you are reading an old issue thread, the mention tells you a workflow ran. It
does not tell you which identity did the work. Check the byline on the resulting
pull request.

## Make commits attribute correctly

An App token alone does not set the commit author. If you do not configure it,
commits land under whatever Git identity the runner happens to have.

DisMech sets it explicitly in `pr-shepherd.yml`, using the address form GitHub
recognizes for App commits:

```bash
APP_USER_ID="$(gh api "/users/${APP_SLUG}[bot]" --jq .id)"
git config --global user.name "${APP_SLUG}[bot]"
git config --global user.email "${APP_USER_ID}+${APP_SLUG}[bot]@users.noreply.github.com"
```

Do this. Without it you cannot tell from `git log` which bot wrote a line, and
tools that measure agent contribution have nothing to work from. See
[Evidence](../evidence.md).

## Restrict who can summon a bot

A bot with write access, triggered by a comment, is reachable by anyone who can
comment. Both parts need controlling:

* **Who may trigger it.** DisMech checks the commenter against a list of
  authorized controllers before the agent runs.
* **What it may do once triggered.** This is the App's permission set, not a
  matter of instructions. Grant each App the narrowest permissions that let it
  do its job.

Separate identities help here too. A reviewer bot needs to read code and write
reviews. It does not need to push branches.

See [Guard the untrusted surface](../patterns/guard-untrusted-input.md).

## Working out who did what

| You see | It means |
| --- | --- |
| `name[bot]` | A GitHub App |
| A plain login | A person, or a machine account |
| `github-actions[bot]` | A workflow, using the built-in token |
| `@dragon-ai-agent` in comment text | A trigger keyword, not necessarily that account |

A byline tells you the identity. It does not tell you the model, the harness, or
who asked. For that you need the execution trace. See
[Evidence](../evidence.md).
