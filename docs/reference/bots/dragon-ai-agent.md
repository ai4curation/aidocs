# dragon-ai-agent

The original OBO curation bot. It is being retired in favour of
[ai4c-agent](ai4c-agent.md), and `@dragon-ai-agent` now means different things
in different repositories.

**Kind**: Machine account
**Byline**: `dragon-ai-agent`, with no `[bot]` suffix
**Still live in**: [Mondo](../../case-studies/mondo.md)
**Retired in**: [GO](../../case-studies/go-ontology.md),
[DisMech](../../case-studies/dismech.md)

## What it was

A machine account that ran [DRAGON-AI](https://pubmed.ncbi.nlm.nih.gov/39415214/)
against OBO repositories. A curator wrote `@dragon-ai-agent please ...` on an
issue, a workflow picked it up, and the agent produced a pull request.

Because it is an ordinary user account, it can be @-mentioned like a person, it
shows no `[bot]` suffix, it uses a seat, and it authenticates with a personal
access token stored in repository secrets.

## Where it stands now

**In Mondo, the account is live.** `.github/workflows/ai-agent.yml` runs
`dragon-ai-agent/run-goose-obo` and authenticates with a personal access token
held as `PAT_FOR_PR`. The agent is Goose. The account does the work.

**In DisMech, the account is retired.** The workflow says so:

> Trigger is a `@dragon-ai-agent please …` mention from an authorized controller
> (a text keyword — the dragon-ai-agent machine account is retired).

The phrase survives as a trigger keyword. The work is done by `ai4c-agent`.

**In GO, the keyword is deprecated but still honoured.** The workflow lists it
as a legacy handle, to be dropped once curators have moved to `@ai4c-agent`.

## Why this matters when reading old threads

A `@dragon-ai-agent` mention tells you a workflow ran. It does not tell you
which identity did the work, and the answer differs by repository and by date.

Check the byline on the resulting pull request. If it ends in `[bot]`, an App
did the work.

## Migrating away from it

The move is from a machine account with a long-lived token to a GitHub App with
a token minted per run. Steps:

1. Install [ai4c-agent](ai4c-agent.md), or your own App, and add its app id and
   private key as secrets.
2. Change the workflow to mint an installation token with
   `actions/create-github-app-token`.
3. Set the commit identity to the bot account, using its numeric user id.
4. Keep the old keyword as a legacy trigger while curators adjust. GO does this
   with a separate `AGENT_MENTION_LEGACY` variable.
5. Once nobody uses the old keyword, drop it and remove the account's token.

You gain shorter-lived credentials, per-repository permissions, and a freed
seat.
