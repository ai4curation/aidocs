# Shared control

**Use it when** curation happens in a web tool, not in files.

Much curation does not live in a Git repository. It lives in a curation
application backed by a database: Noctua for GO-CAM models, and similar tools
elsewhere. You cannot give an agent a pull request workflow for these.

## The pattern

Give the agent an MCP server that wraps the same API the curation interface
already uses. The agent and the curator then write to the same database through
the same path.

The curator keeps the interface they know. When the agent makes a change, it
appears in that interface. The curator can edit alongside the agent, in the same
session, and see the result of each agent action as it happens.

This is different from an agent that edits files and hands you a diff. Nothing
is staged. You watch it happen and you can intervene.

## Why the existing API matters

Wrapping the API the interface already uses means the agent is subject to the
same rules the interface is: the same validation, the same permissions, the same
data model. An agent given direct database access has none of that.

## Point it at a test server first

An agent with write access to a production curation database can do real damage.
Restrict the credentials to a development or test server while you are learning
what the agent does, and say so in your agent instructions as well as enforcing
it in the token.

Credentials are the control that works. Instructions alone are not enough.

## Who does this

* [noctua-mcp](https://github.com/geneontology/noctua-mcp) wraps the
  Noctua and Barista API for GO-CAM editing.
* [oak-mcp](https://github.com/monarch-initiative/oak-mcp) gives agents ontology
  search and traversal through the Ontology Access Kit.
* [EFO](../case-studies/efo.md) declares the EBI Ontology Lookup Service MCP
  server in `.mcp.json`, so every session gets the same term lookup tool.

## Read more

* [Agentic tools](../reference/agentic-tools.md)
