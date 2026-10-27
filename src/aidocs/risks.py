"""Load and check the risk pages under ``docs/risks/``.

Each risk page is a Markdown file whose YAML frontmatter is the page's metadata.
The page is the source of truth; ``schema/ai_risk.yaml`` describes the
frontmatter, and this module checks it and the links between pages.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

import yaml
from linkml.validator import validate

REPO_ROOT = Path(__file__).resolve().parents[2]
DOCS_DIR = REPO_ROOT / "docs"
SCHEMA_PATH = REPO_ROOT / "schema" / "ai_risk.yaml"

TABLE_START = "<!-- risk-table:start -->"
TABLE_END = "<!-- risk-table:end -->"

THREAT_CLASS_TITLES = {
    "instruction-manipulation": "Instruction manipulation",
    "agency-and-action": "Agency and action",
    "secrets-and-data-exposure": "Secrets and data exposure",
    "supply-chain": "Supply chain",
    "output-integrity": "Output integrity",
    "oversight-and-accountability": "Oversight and accountability",
    "resources-and-sustainability": "Resources and sustainability",
}


@dataclass
class RiskPage:
    slug: str
    path: Path
    meta: dict
    heading: str


def split_frontmatter(text: str) -> tuple[dict, str]:
    """Split a Markdown document into its YAML frontmatter and its body.

    >>> meta, body = split_frontmatter("---\\ntitle: X\\n---\\n# X\\n")
    >>> meta
    {'title': 'X'}
    >>> body
    '# X\\n'
    >>> split_frontmatter("# No frontmatter\\n")
    ({}, '# No frontmatter\\n')
    """
    if not text.startswith("---\n"):
        return {}, text
    end = text.index("\n---\n", 4)
    return yaml.safe_load(text[4:end]) or {}, text[end + 5 :]


def first_heading(body: str) -> str:
    """Return the text of the first level-one heading.

    >>> first_heading("intro\\n# Prompt injection\\n## More")
    'Prompt injection'
    >>> first_heading("no heading")
    ''
    """
    for line in body.splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return ""


def load_risk_pages(docs_dir: Path = DOCS_DIR) -> list[RiskPage]:
    """Load every risk page (all of ``docs/risks/*.md`` except ``index.md``)."""
    pages = []
    for path in sorted((docs_dir / "risks").glob("*.md")):
        if path.name == "index.md":
            continue
        meta, body = split_frontmatter(path.read_text())
        pages.append(RiskPage(path.stem, path, meta, first_heading(body)))
    return pages


def check_pages(pages: list[RiskPage], docs_dir: Path = DOCS_DIR) -> list[str]:
    """Return one message per problem found; an empty list means all is well."""
    errors = []
    slugs = {p.slug for p in pages}
    for page in pages:
        where = f"{page.path.relative_to(docs_dir)}"
        report = validate(page.meta, str(SCHEMA_PATH), "Risk")
        errors += [f"{where}: {r.message}" for r in report.results]
        if page.meta.get("id") != f"airisk:{page.slug}":
            errors.append(f"{where}: id should be airisk:{page.slug}")
        if page.heading != page.meta.get("title"):
            errors.append(f"{where}: heading {page.heading!r} does not match title")
        for pattern in page.meta.get("patterns", []):
            if not (docs_dir / "patterns" / f"{pattern}.md").exists():
                errors.append(f"{where}: no pattern page named {pattern}")
        for other in page.meta.get("related", []):
            if other not in slugs:
                errors.append(f"{where}: no risk page named {other}")
    return errors


def headline_sources(sources: dict) -> str:
    """Summarize the OWASP LLM 2025, OWASP Agentic and NIST entries for a risk.

    >>> headline_sources({"owasp_llm_2025": ["LLM01"], "owasp_agentic_top10": ["ASI01"],
    ...     "nist_ai_600_1": ["2.9"], "mitre_atlas": ["AML.T0051"]})
    'LLM01, ASI01, NIST 2.9'
    >>> headline_sources({})
    '—'
    """
    parts = sources.get("owasp_llm_2025", []) + sources.get("owasp_agentic_top10", [])
    parts += [f"NIST {s}" for s in sources.get("nist_ai_600_1", [])]
    return ", ".join(parts) or "—"


def risk_table(pages: list[RiskPage]) -> str:
    """Render the index table of risks, grouped by threat class.

    >>> page = RiskPage("x", Path("x.md"), {"title": "X", "threat_class":
    ...     "supply-chain", "agent_specific": True, "taxonomy_gap": True,
    ...     "sources": {"owasp_llm_2025": ["LLM03"], "nist_ai_600_1": ["2.12"]}}, "X")
    >>> print(risk_table([page]))
    | Class | Risk | Agent-specific | Gap in published taxonomies | Main entries elsewhere |
    | --- | --- | --- | --- | --- |
    | Supply chain | [X](x.md) | yes | yes | LLM03, NIST 2.12 |
    """
    rows = [
        "| Class | Risk | Agent-specific | Gap in published taxonomies | Main entries elsewhere |",
        "| --- | --- | --- | --- | --- |",
    ]
    order = list(THREAT_CLASS_TITLES)
    for page in sorted(pages, key=lambda p: (order.index(p.meta["threat_class"]), p.slug)):
        meta = page.meta
        rows.append(
            f"| {THREAT_CLASS_TITLES[meta['threat_class']]} "
            f"| [{meta['title']}]({page.slug}.md) "
            f"| {'yes' if meta['agent_specific'] else 'no'} "
            f"| {'yes' if meta.get('taxonomy_gap') else 'no'} "
            f"| {headline_sources(meta.get('sources', {}))} |"
        )
    return "\n".join(rows)


def table_in_index(docs_dir: Path = DOCS_DIR) -> str:
    """Return the table currently between the markers in ``docs/risks/index.md``."""
    text = (docs_dir / "risks" / "index.md").read_text()
    return text.split(TABLE_START)[1].split(TABLE_END)[0].strip()


def write_table_to_index(pages: list[RiskPage], docs_dir: Path = DOCS_DIR) -> None:
    """Replace the table between the markers in ``docs/risks/index.md``."""
    path = docs_dir / "risks" / "index.md"
    before, rest = path.read_text().split(TABLE_START)
    after = rest.split(TABLE_END)[1]
    path.write_text(f"{before}{TABLE_START}\n{risk_table(pages)}\n{TABLE_END}{after}")
