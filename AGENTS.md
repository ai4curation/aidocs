# AGENTS.md for aidocs

This file provides guidance to AI coding agents working in this repository.

## Project overview

`aidocs` is a documentation repository for AI4Curators. It provides practical
guides for curators and maintainers of knowledge bases who want to integrate AI
agents into their workflows.

The project focuses on immediately usable guidance rather than theoretical
discussion. Most content should help practitioners set up or improve real
GitHub-based curation workflows.

## Repository structure

```text
aidocs/
├── docs/                     # MkDocs documentation source
│   ├── how-tos/              # Practical task-oriented guides
│   ├── tutorials/            # Learning-oriented walkthroughs
│   ├── reference/            # Technical reference material
│   │   └── clients/          # AI client documentation
│   └── overrides/            # MkDocs theme customizations
├── src/aidocs/               # Python package source
├── ai.just                   # AI setup helper recipes
├── mkdocs.yml                # MkDocs configuration
└── pyproject.toml            # Python project configuration
```

## Repo management

This repo uses `uv` for managing dependencies. Never use commands like `pip` to
add or manage dependencies.

Use `uv run` to run Python tools, unless a `justfile`, `*.just`, or `makefile`
target is the established entry point for the task.

MkDocs is used for documentation. Use `uv run mkdocs build` to check the site.
Use `uv run mkdocs build --strict` when making documentation changes that should
not introduce warnings.

## Documentation standards

- Prefer practical, immediately actionable content.
- Provide step-by-step guides over abstract discussion when writing how-tos.
- Include real-world examples and curation use cases.
- Keep terminology consistent with existing pages in `docs/glossary.md`.
- Preserve the existing MkDocs Material style and navigation patterns.

## Content categories

- `docs/how-tos/`: task-oriented implementation guides.
- `docs/tutorials/`: comprehensive walkthroughs for learning.
- `docs/reference/`: technical reference material and tool descriptions.
- `docs/glossary.md`: domain-specific terminology.

## Target audience

The primary audience is curators and maintainers of knowledge bases and
ontologies. The secondary audience is developers integrating AI into existing
curation workflows.

## Contributing guidance

- Prioritize practical value in every guide.
- Test commands, links, and examples before committing.
- Follow existing documentation structure instead of creating new sections
  unnecessarily.
- Emphasize how AI improves existing workflows rather than replacing curators.

## Site structure

The site has two sections that carry most of its value:

- `docs/case-studies/`: one page per repository that runs agents on real
  curation. Each page follows the same shape: what to look at, what works, what
  to copy first, and gaps.
- `docs/patterns/`: practices that appear in more than one repository. Each page
  names at least two repositories that use it.

Do not centralize material that belongs in another repository. Link to the file
or folder instead. If a page disagrees with the repository it describes, the
repository is right.

Counts of skills, subagents, and workflows come from
[agent-watcher](https://github.com/ai4curation/agent-watcher). Cite the dated
report you took them from, as `docs/evidence.md` does.

## Checks

Run `uv run mkdocs build --strict` before committing. The `docs-checks.yml`
workflow runs the same build and a link check on every pull request, and the
link check also runs weekly to catch links that rot in the repositories this
site points at.
