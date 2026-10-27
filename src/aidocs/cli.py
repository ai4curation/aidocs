"""Command line for aidocs maintenance tasks."""

from __future__ import annotations

from pathlib import Path

import typer

from aidocs import risks

app = typer.Typer(help="Maintenance commands for the aidocs site.", no_args_is_help=True)
risks_app = typer.Typer(help="Check and render the risk catalog.", no_args_is_help=True)
app.add_typer(risks_app, name="risks")

DocsDir = typer.Option(risks.DOCS_DIR, help="The docs directory.")


@risks_app.command("validate")
def validate_risks(docs_dir: Path = DocsDir) -> None:
    """Check risk page frontmatter, links, and the index table."""
    pages = risks.load_risk_pages(docs_dir)
    errors = risks.check_pages(pages, docs_dir)
    if risks.table_in_index(docs_dir) != risks.risk_table(pages):
        errors.append("risks/index.md: table is out of date; run `aidocs risks table --write`")
    for error in errors:
        typer.echo(error, err=True)
    if errors:
        raise typer.Exit(1)
    typer.echo(f"{len(pages)} risk pages OK")


@risks_app.command("table")
def table(
    docs_dir: Path = DocsDir,
    write: bool = typer.Option(False, help="Write the table into docs/risks/index.md."),
) -> None:
    """Print the risk index table, or write it into the index page."""
    pages = risks.load_risk_pages(docs_dir)
    if write:
        risks.write_table_to_index(pages, docs_dir)
    else:
        typer.echo(risks.risk_table(pages))
