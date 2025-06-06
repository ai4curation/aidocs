# How to integrate AI into your [Knowledge Base](glossary.md#knowledge-base-kb)

This is a high level advanced guide for maintainers of knowledge bases with some high level pointers on how to start effectively using AI to enhance curation.

## Tip 1: No fancy frameworks needed - just simple MCPs or command line tools

Intimidated by the growing number of agent frameworks? Don't worry, you don't need
most of these.

All you really need are a handful of simple [MCPs](glossary.md#model-context-protocol-mcp) servers or command line tools. These can be hooked up to generic frameworks.

The command line tools could be wrapped in a Docker container; this is the strategy for [ODK-AI](https://ai4curation.github.io/odk-ai/).

You should rely on existing tools for doing things like literature search - you only need to write MCPs that are specific to read/write/validation on your KB.

This is much easier if you follow [O3 guidelines](glossary.md#o3-guidelines) and manage your content in GitHub. In fact if your content is small enough, you might not need any new tools!

## Tip 2: Keep AI instructions checked in at the root of your GitHub repo

Examples:

 - [CLAUDE.md in Uberon repo](https://github.com/obophenotype/uberon/blob/master/CLAUDE.md)

## Tip 3: Train curators to use simple tool-enabled AI applications (e.g [Goose](glossary.md#goose))

Many AI hosts such as Claude Code or various VS code plugins are suboptimal for non-technical users. AI applications such as Claude Desktop may be better, but currently it's hard to configure.

At the time of writing, we recommend Goose as an AI app/host, due to these features:

- Ease of configuring MCPs
- Choice of either Desktop version (for non-devs) or Command Line (for devs)
- Ability to use multiple models including proxies.

See the [Installation Guide](https://block.github.io/goose/docs/getting-started/installation/)

As an example, this video shows how to configure:

<iframe 
  width="500" 
  height="560" 
  src="https://www.youtube.com/embed/509qVPEbv0Q" 
  title="YouTube video player" 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
  allowfullscreen>
</iframe>

## Set up [GitHub actions](glossary.md#github-actions)

See some of the actions in this org. Again this works best if your content is managed
according to O3 guidelines.

## Document and Train

## Continuous evaluation.
