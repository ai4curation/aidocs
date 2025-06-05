# Using local AI tools

This tutorial walks through how to use AI tools locally. This is aimed at mostly non-technical editors of
OBO ontologies that have adopted standardized ODK workflows. There are some technical steps required but these should be straightforward. This will work best with a Mac or Linux.

## Background

Most people have by now used web-based chat interfaces such as ChatGPT, or more powerful deep research models (o3, Perplexity Deep Research). These can now take advantage of information online as well as what is already "known" by the model. However, they can't interface with files and tools that you might have locally, e.g.

- your local copy of the ontology edit file, checked out from GitHub
- Protege
- Reasoners
- Validation/QC workflows

Agentic AI is a paradigm where an AI application can make use of *tools* to achieve some objective. For ontology editing, this might be tools to edit the ontology or run a reasoner or workflow. These tools could include command line tools (e.g what you have available via ODK), or tools made available via the [Model Context Protocol](glossary.md#MCP)

There are a growing number of general-purpose applications that allow for easy plug and play of different tools. Many of these are aimed at developers, and hook into existing Integrated Development Environments (IDEs). These are not ideal for non-technical users.

Two of the main easy-to-use Desktop applications are **Claude Desktop** (not to be confused with Claude Code, or the web interface to Claude) and **Goose**. We focus here on Goose, as it allows for easy configurability

## Install Goose

Go to the [install page](https://block.github.io/goose/docs/getting-started/installation/) for Goose. Choose the Desktop app (more ambitious or technical users may want to also install the CLI app)

## Set up your LLM

Select settings/advanced, and select a Model. We recommend Anthropic/Claude Sonnet. You will need an API key. We recommend speaking to your supervisor about getting an API key that is charged to a project you work on.

## Try it out

You should be able to use the UI the same way as a normal AI chat, try asking some questions about your favorite topics.

However, you can do more here, including with local files. Try giving it a folder full of PDFs and asking it to list the contents. Try finding a particular PDF, and then asking it to summarize it.

## Install xcode (mac users)

In order to use most of the useful features of agents, you will need to certain things installed locally. For macs, this means installing Xcode:

* [Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12)

You can just ask Goose to walk you through the installation.

## Try it out more advanced features

Some things you can try:

* `clone the OBO cell ontology repo from github`
* `create a web page for many ontology`
* `create a web app for annotating single-cell experiments, use the OLS API to implement autocomplete over CL`

## Install OWL-MCP extension

Next we will try installing an ontology-specific MCP

You can either install directly from this link:

 * ⬇️ [Install OWL-MCP](goose://extension?cmd=uvx&arg=owl-mcp&id=owl_mcp&name=OWL%20MCP)

 Or to do this manually, in the Extension section of Goose, add a new entry for owlmcp:

 `uvx owl-mcp`

 This video shows how to do this manually:

<iframe 
  width="500" 
  height="560" 
  src="https://www.youtube.com/embed/509qVPEbv0Q" 
  title="YouTube video player" 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
  allowfullscreen>
</iframe>
 
## Try it out

You can ask to create an ontology, and add axioms to an ontology. This video walks you through the process end-to-end. We will outline the steps below

<iframe 
  width="500" 
  height="560" 
  src="https://www.youtube.com/embed/sAXs3djX854" 
  title="YouTube video player" 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
  allowfullscreen>
</iframe>


 
