import 'ai.just'

default:
    @just --list

# Run pytest and the doctests in src/
test:
    uv run pytest
    uv run pytest --doctest-modules src

# Check risk page frontmatter, links, and the index table
risks-validate:
    uv run aidocs risks validate

# Regenerate the risk table in docs/risks/index.md
risks-table:
    uv run aidocs risks table --write

# Build the site, failing on warnings
docs:
    uv run mkdocs build --strict
