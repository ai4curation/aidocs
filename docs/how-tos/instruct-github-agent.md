# AI Instructors Guide: GitHub Agents

This is a guide for instructing the [AI agent](../glossary.md#ai-agent) that lives in GitHub repo. This assumes your AI controller has [set up [GitHub actions](../glossary.md#github-actions)](set-up-github-actions) in your repo.

## How it works

### Graphical Overview

![img](https://ai4curation.github.io/odk-ai/figures/intro.svg)

## How to use it

### Invocation

The AI agent is invoked by an exact string such as `@dragon-ai-agent
please` (check your local repo documentation). Anything that follows as well as other content from the issue/PR is passed to the AI.

The AI has tools to read the issue/PR, as well as follow up on any
linked issues/PRs.

Note: the string `please` has to follow exactly. This part is
deterministic, it is not an AI that controls the invocation. The
choice of "please" is not just about politeness, we need a special
keyword to avoid accidental invocation.

### Authorization

Note that the agent will **NOT** respond to you if you are not an authorized *controller*.

To check if you are authorized, see the file 
`~/.github/ai-controllers.json`. 

You can make a PR on this to add yourself (be sure to follow JSON syntax),
but check with your repo maintainer first for local procedures.

### AI system instructions

See the file `~/CLAUDE.md` in the top level of the repo. Other AI
applications may use different files -- for example, [goose](../glossary.md#goose) uses
`~/.goosehints`, but these will typically be symlinked.

The instructions are in natural language and should be equally
readable by humans or AI.

More advanced users should feel free to make PRs on this file

### Tools usable by the AI

Depending on what AI host runner is used, the configuration file that
controls which agents are available may be in different places.

- For claude code, this will be in `.claude/settings.json`
- For goose, this will be in `.config/goose/config.yaml`

## Prompting guide

### Start Simple

For a first task, find an issue that is very straightforward, where
the user has done the bulk of the "thinking" work, and the issue is
fairly rote and mechanical.

Go to the issue you want resolved and make a new comment and say

    @dragon-ai-agent please resolve this issue

You can also add your own commentary - for example, if the original
issue isn't completely clear or is missing key information the AI is
not likely to infer.

For example:

    @dragon-ai-agent please resolve this issue, making sure the term has a parent

### Deep Research

You can always ask the AI to do a background research on an issue. We
are exploring the best tools to use for Deep Research, in the interim,
the AI has access to basic web search tools which are good enough for
many purposes.

One usage pattern is to find an issue that depends on a lot of cutting
edge science and to ask the AI to do background reading on the subject
(you can ask it to hold off on implementing anything)

An example:

    @dragon-ai-agent please help us resolve this issue, we are unsure how to proceed,
    please read the latest literature on the topic


### Accessing [PMIDs](../glossary.md#pmid-pubmed-id)

The AI should be able to download and read full text for a subset of
PMIDs (including those on PMC). Currently we are exploring the best
tools to use, so be aware there may be some temporary limitations,
such as not being able to view images.

The prompt the AI receives should tell it to use PMIDs as provenance
(e.g. in definitions, in synonyms), but we are still figuring the best
way to prompt, and you might need to occasionally give more detailed
instructions.

### Complex refactoring tasks

The AI is capable of writing ad-hoc code to perform certain kinds of
tasks. This is generally easier when the source of the [ontology](../glossary.md#ontology) is in
[obo format](../glossary.md#obo-format). For some more complex tasks, the AI may not have been
provided with the right tools or software libraries.

Examples:

 - https://github.com/obophenotype/uberon/issues/3548

### Tuning the AI

You can make PRs on the `CLAUDE.md` or equivalent to add new instructions.

### Magic keywords

If your repo admin has set up your agent to use a Claude code, then some keywords
deterministically trigger more detailed chain of thought thinking:

- "think hard"
- "ultrathink"

We are still investigating equivalent behavior in other AI apps.

See [this guide](https://www.anthropic.com/engineering/claude-code-best-practices) for some tips on using Claude.

Even if there are no deterministic triggers, in general, it can help
to tell the AI to think longer or harder on tasks that require
additional effort.

### Be respectful of the user who created the issue

Different issue trackers have different user communities - for some,
requests come in entirely from the curator community, others may have
broader users.

While the core curator community who uses the issue tracker should be
educated in how the tracker is used (including the use of AI), users
from outside this community may not be aware - and some of these
people may not like having their request seemingly handled by an AI,
so use situational awareness in when to invoke AI.

## NEW: Invocation via GitHub Copilot

Some repos now have been set up configured to use GitHub Copilot.

You can now assign an issue OR PR to Copilot. Assigning an issue will create a PR. Assigning a PR will trigger a review

see <https://docs.github.com/en/copilot/how-tos/agents/copilot-coding-agent/using-copilot-to-work-on-an-issue>

Note: requires GitHub Pro (free for educational users); see next subsection.

### GitHub Copilot Pro coupon through GitHub Education

This section covers getting Education Benefits through GitHub Education for academic users. One of the benefits is a coupon for Copilot Pro.

- Prerequisites:
  - Your institutional email address needs to be a "verified" email address (https://github.com/settings/emails)
  - You _may_ need a photo of your institutional ID
  - You _may_ need to allow location services in your browser for verification
- Go to: https://github.com/settings/education/benefits
- Click "Start an application"
- Select "Teacher"
- Select your institution from the autocomplete menu
  - Depending on the requirements for your institution, you may get different instructions for the next steps
- Select your email address from the dropdown
- Upload a photo of your institutional ID, if necessary,
- Click "Submit Application"

Once approved (this may vary from minutes to being denied), opening the "Approved" widget on https://github.com/settings/education/benefits will contain a link in the line "To redeem your Copilot Pro coupon, please sign up via this link." (Note: it may take up to 72 hours for the information to propagate through GitHub's system.)

## Learning More

### Local experimentation

## Troubleshooting

### Timeouts

If you ask the AI to do a task that is long running, there is more
chance that either the action will time out, or the running of the AI
app within the action will hit a limit.

If your repo is configured to use cborg.lbl.gov as a proxy, then a
known issue is timeouts.

Timeouts might not be obvious - by their nature, they time out before
providing an update on the issue. The only way to debug is to go to
the "actions" tab in GitHub and debug from there.

If you have a task that is likely to be long running - for example, if
you want the AI to update 100s of terms - you might want to try
asking the AI to make an initial PR after doing only a dozen or so,
and then iterate.

### Debugging Actions

You can go to the "actions" tab in GitHub, and look for the job that
was triggered by your invocation. Clicking on this will show you a
full log. There may be a lot of information here - using ChatGPT can
help you debug. Usually it helps to scroll to the end and see the most
recent messages to have a clue about what went wrong.

### Running out of credits

Different repos may be configured in different ways for recharging
credits. Typically things will be set up such that a proxy is used
(e.g. cborg.lbl.gov) with an API key tied to a project code.

In general you should ask the AI admin for your repo if you see
messages that credit is too low.
