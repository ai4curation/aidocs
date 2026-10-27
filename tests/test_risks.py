import shutil
from pathlib import Path

import pytest
from typer.testing import CliRunner

from aidocs import risks
from aidocs.cli import app

GOOD = """---
id: airisk:example
title: Example
threat_class: supply-chain
agent_specific: false
contexts: [development]
patterns: [guard-untrusted-input]
sources:
  owasp_llm_2025: [LLM03]
---
# Example
"""


@pytest.fixture
def docs_dir(tmp_path: Path) -> Path:
    """A minimal docs tree with one valid risk page and one pattern page."""
    (tmp_path / "patterns").mkdir()
    (tmp_path / "patterns" / "guard-untrusted-input.md").write_text("# Guard\n")
    (tmp_path / "risks").mkdir()
    (tmp_path / "risks" / "example.md").write_text(GOOD)
    (tmp_path / "risks" / "index.md").write_text(
        f"# Risks\n\n{risks.TABLE_START}\n{risks.TABLE_END}\n"
    )
    risks.write_table_to_index(risks.load_risk_pages(tmp_path), tmp_path)
    return tmp_path


def test_real_catalog_is_valid():
    pages = risks.load_risk_pages()
    assert len(pages) >= 20
    assert risks.check_pages(pages) == []
    assert risks.table_in_index() == risks.risk_table(pages)


def test_fixture_is_valid(docs_dir):
    assert risks.check_pages(risks.load_risk_pages(docs_dir), docs_dir) == []


@pytest.mark.parametrize(
    "old,new,expected",
    [
        ("id: airisk:example", "id: airisk:other", "id should be airisk:example"),
        ("# Example", "# Something else", "does not match title"),
        ("threat_class: supply-chain", "threat_class: vibes", "vibes"),
        ("[guard-untrusted-input]", "[no-such-pattern]", "no pattern page named no-such-pattern"),
        ("[LLM03]", "[LLM11]", "LLM11"),
        ("contexts: [development]", "contexts: [staging]", "staging"),
        ("agent_specific: false\n", "", "agent_specific"),
    ],
)
def test_bad_frontmatter_is_reported(docs_dir, old, new, expected):
    page = docs_dir / "risks" / "example.md"
    page.write_text(page.read_text().replace(old, new))
    errors = risks.check_pages(risks.load_risk_pages(docs_dir), docs_dir)
    assert any(expected in e for e in errors), errors


def test_unknown_related_risk_is_reported(docs_dir):
    page = docs_dir / "risks" / "example.md"
    page.write_text(page.read_text().replace("contexts:", "related: [missing]\ncontexts:"))
    errors = risks.check_pages(risks.load_risk_pages(docs_dir), docs_dir)
    assert errors == ["risks/example.md: no risk page named missing"]


def test_cli_validate(docs_dir):
    result = CliRunner().invoke(app, ["risks", "validate", "--docs-dir", str(docs_dir)])
    assert result.exit_code == 0, result.output
    assert "1 risk pages OK" in result.output


def test_cli_validate_reports_stale_table(docs_dir):
    shutil.copy(docs_dir / "risks" / "example.md", docs_dir / "risks" / "second.md")
    page = docs_dir / "risks" / "second.md"
    page.write_text(page.read_text().replace("airisk:example", "airisk:second"))
    result = CliRunner().invoke(app, ["risks", "validate", "--docs-dir", str(docs_dir)])
    assert result.exit_code == 1
    assert "table is out of date" in result.output


def test_cli_table_write(docs_dir):
    runner = CliRunner()
    shutil.copy(docs_dir / "risks" / "example.md", docs_dir / "risks" / "second.md")
    page = docs_dir / "risks" / "second.md"
    page.write_text(page.read_text().replace("airisk:example", "airisk:second"))
    assert runner.invoke(app, ["risks", "table", "--write", "--docs-dir", str(docs_dir)]).exit_code == 0
    assert "[Example](second.md)" in risks.table_in_index(docs_dir)
