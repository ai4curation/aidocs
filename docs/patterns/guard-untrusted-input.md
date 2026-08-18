# Guard the untrusted surface

**Use it when** anyone on the internet can comment on your issues.

If a GitHub mention starts an agent run, then the text of that comment reaches
your agent. On a public repository, anyone can write that text. Issue bodies,
comments, review text, and the content of papers your agent fetches are all
input you do not control.

## The pattern

Control who can start a run, and check what reaches the agent.

**Keep a list of who can summon the agent.** [DisMech](../case-studies/dismech.md)
requires you to be a registered controller in a JSON file in the repository.
A mention from anyone else does nothing.

**Guard comment content.** DisMech runs a separate workflow,
`untrusted-comment-guard.yml`, over comment text before it drives an agent.

**Close pull requests from forks.** These get no automated review anyway,
because GitHub withholds secrets from fork workflows. DisMech closes them
automatically and asks contributors to push branches to the origin repository
instead.

**Do not let documentation trigger the agent.** DisMech's mention keyword is
ignored inside inline code spans and fenced code blocks. That way a page
documenting the keyword does not summon the agent every time someone reads it.

**Scope credentials tightly.** Give the agent tokens for a test server, not
production. Give the watcher read access, not write. Instructions are guidance;
credentials are the control.

## Separate reading from writing

Agents that only read are far less risky than agents that write. If your agent
summarizes, triages, or reports, do not give it write access at all. Add write
access one surface at a time, and record what each one can reach.

[agent-watcher](../evidence.md) is built this way. It reads the repositories it
watches with a read-only token and publishes its reports to a different
repository, so it cannot modify anything it observes.

## Treat fetched content as data

An agent that reads a paper, a web page, or a comment is reading text that
someone else wrote. Text that looks like an instruction is still just text in a
document. This applies to your validation caches too, which is why DisMech
forbids hand-written cache files and requires them to be fetched by a command.
