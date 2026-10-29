# Ask for a visual explainer

**Use it when** you have to understand a long thread, a large pull request, or
a tangle of related terms before you can make a decision.

A term request with sixty comments, an ontology pull request that touches
forty classes, or a GO-CAM that a colleague changed while you were away all
take a long time to read in GitHub. Most of that time goes into rebuilding the
structure in your head: which terms are involved, how they relate, who
proposed what, and what is still open.

An agent can do that rebuilding for you and draw it. Instead of asking for a
summary, ask for a **visual explainer**: a single page with a diagram of the
terms or the model, a table of the proposals, and the open questions. In
Claude this page is an
[artifact](https://support.claude.com/en/articles/17153992-what-are-artifacts-and-how-do-i-use-them),
which opens beside the conversation and can be shared as a link.

## What it looks like

[Post-Phagocytic Programmes in GO](https://claude.ai/artifact/8MJjKA2M2SDjcZAs9dL1ET)
is a curator's example: an explainer of how GO covers what happens after
phagocytosis.

For a longer example aimed at developers rather than curators, see
[this conversation and its artifact](https://claude.ai/chat/e1ada01d-d932-420a-86da-b78318d61927?artifact=02593a6c-e90d-4b4c-a6f4-918bb0dd3f4d).

Both links open in claude.ai and may ask you to sign in.

## How to ask

1. Give the agent the source. In Claude Code, or on the
   [GO AI Hub](../case-studies/go-ai-hub.md), paste the issue or pull request
   URL; the agent can read it with `gh`. In a claude.ai chat, paste the thread
   or attach the files.
2. Say what decision you need to make, so the explainer is organized around
   it.
3. Ask for an artifact, and say what it should contain.

For example:

```text
Read geneontology/go-ontology issue <number> and every issue it links to.
Make me a visual explainer as an artifact. I need to decide whether to
merge the proposed terms.

Include:
- a diagram of the current hierarchy and the proposed one, side by side
- a table of each proposal: who made it, the terms involved (ID and label),
  and whether it was agreed, disputed, or left open
- the open questions, each linked to the comment that raised it
```

Other requests that work well:

* "Explain this pull request's changes to the hierarchy as a before-and-after
  diagram. List every term whose parents changed."
* "Draw this GO-CAM as a pathway diagram, and mark each edge with its evidence
  code and reference."
* "Lay out the annotations for this gene by aspect, flag the ones with only
  IEA evidence, and show which papers they come from."

Then ask follow-up questions in the same conversation. The agent can update
the artifact as you go.

## Treat it as a view, not a source

An explainer is the agent's reading of the sources. It can be wrong in the
same ways a summary can: a term with the wrong label, a comment attributed to
the wrong person, a disagreement drawn as a consensus.

* **Ask for receipts.** Have it show identifiers with labels, and link each
  claim to the comment, commit, or paper it came from, so you can check the
  ones that matter. See
  [Make identifiers hard to fake](../patterns/ground-identifiers.md).
* **Decide from the source.** Use the explainer to find what to read, then
  read it. The record of the decision belongs in the issue or pull request,
  not in the artifact.
* **Prefer one page to a dashboard.** A static page that answers your question
  is easier to check than an interactive app. Ask for interaction only when
  you need it, such as filtering a long table.

## Sharing it

An artifact is private until you share it. When you share one, anyone with the
link can see it, so check that it contains nothing that should not leave your
group, such as unpublished results or a draft paper.

To show an explainer in a GitHub discussion, post the link in a comment with a
sentence saying what it is and that an agent drew it. If the picture needs to
live in the repository, ask the agent for a
[Mermaid](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams)
diagram instead. GitHub renders Mermaid in issues, pull requests, and Markdown
files, so the diagram stays next to the discussion it explains.

## Read more

* [Your first curation session](../tutorials/first-curation-session.md)
* [Shared control](../patterns/shared-control.md): watching an agent work in
  Noctua is another way to see a GO-CAM rather than read about it.
