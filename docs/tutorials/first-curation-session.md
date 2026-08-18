# Your first curation session

This tutorial takes about thirty minutes. At the end you will have asked an
agent to do a real curation task and opened a pull request with the result.

You do not need to install anything, and you do not need to be able to program.

## Before you start

You need:

* A GitHub account.
* A Claude account on a paid plan. The free plan cannot run Claude Code.
* Write access to a repository that welcomes agent contributions. If you do not
  have one, ask on the issue tracker of a project in our
  [case studies](../case-studies/index.md). Several add new contributors on
  request.

## 1. Open a session in the cloud

Go to [claude.ai/code](https://claude.ai/code) and choose to continue on the
web. Connect your GitHub account when you are asked, then select the repository
you want to work in.

This runs the agent in a cloud container. The repository is cloned for you, and
when you are finished you press **Create PR** and the commits and pull request
are handled for you.

Curating in the cloud avoids the two problems that stop most curators: you do
not install software, and your institution's IT rules do not apply to a browser
tab. For local installation instead, see [Harnesses](../reference/harnesses.md).

## 2. Set up your environment once

An environment holds the network settings, environment variables, and setup
commands your sessions run with. You configure it once, and every later session
reuses it.

The settings that matter:

* **Network access.** The default only allows GitHub and package registries. If
  your curation reads PubMed, ClinicalTrials.gov, or another external source,
  you need broader access.
* **Environment variables.** Any API keys your project's tools need go here, one
  `KEY=value` per line, with no quotes.
* **Setup script.** Anything that should be installed before each session
  starts, such as a task runner.

Your project should tell you what to put in each field. DisMech's
[`CONTRIBUTING.md`](https://github.com/monarch-initiative/dismech/blob/main/CONTRIBUTING.md)
has a worked example with screenshots.

## 3. Ask the agent to explain the project

Start with this:

```
Give me a tour of this project
```

Then ask what you actually want to know:

```
I want to contribute. How?
```

This is not a warm-up exercise. The repository is the current description of how
the project works, and human documentation goes out of date. Asking the agent is
usually faster and more accurate than reading a guide.

Ask follow-up questions until you understand what a good contribution looks
like.

## 4. Do one small task

Pick something narrow. A single term, a single record, one missing definition.

Many projects give you a command for their main curation job. DisMech has one:

```
/curate Parkinson Disease
```

If your project has no command, describe the task in plain language and name
the file:

```
Add a definition for the term in src/ontology/xxx-edit.obo with id XXX:0000123.
Use the reference cited in issue 456.
```

Watch what the agent does. It will run commands, and some of them will fail.
This is normal. Agents try an option, read the error, and try another. Red text
in the output is usually the agent working, not the session breaking.

## 5. Check the identifiers

This is the part that needs you.

Agents produce ontology term identifiers and citations that look right and are
wrong. Most projects on this site have automated checks for this, and you should
run them. Look for a validation command in the project's `CLAUDE.md`, or ask:

```
How do I validate what you just changed?
```

Then read the result yourself. Check that the term labels match what you would
expect, and that quoted evidence says what the entry claims it says.

See [Make identifiers hard to fake](../patterns/ground-identifiers.md) for why
this failure mode is so common.

## 6. Open the pull request

Press **Create PR**.

On many projects an automated reviewer now reads your pull request and either
requests changes or marks it ready to merge. If it requests changes, you can ask
your agent to address them in the same session.

## 7. Start a new session for the next task

Each session accumulates context: files it has read, commands it has run, output
it has kept. As that grows, the agent starts to lose track of your earlier
instructions.

The fix is simple. Start a new session for each task, or each small group of
related tasks. Sessions are free to create, and your environment configuration
is reused.

## What to do next

* Read the [case study](../case-studies/index.md) for the repository you worked
  in, to understand its setup.
* Read [Instruct the GitHub agent](../how-tos/instruct-github-agent.md) to ask
  for work from an issue rather than a session.
* Read [Training materials for curators](tutorials-for-curators.md) for recorded
  seminars and workshop material.
