# Integrating Deep Research into Repositories

This guide covers how to integrate deep research capabilities into ontology repositories, enabling AI agents to perform comprehensive literature reviews and knowledge synthesis.

## What is Deep Research?

Deep research goes beyond simple web search + summarization ("deep research lite") to provide:

- **Comprehensive literature review**: Systematic search across academic databases
- **Multi-source synthesis**: Combining information from papers, databases, and web sources
- **Citation tracking**: Following reference chains to find related work
- **Structured output**: Reports with proper citations and reasoning chains

## Available Providers

Several providers offer deep research capabilities:

| Provider | Strengths | Cost Model |
|----------|-----------|------------|
| OpenAI Deep Research | Comprehensive, high quality | Pay-per-use (higher cost) |
| Perplexity Pro | Good balance of speed/depth | Subscription + usage |
| Edison | Research-focused | API-based |
| Gemini Deep Research | Google ecosystem integration | API-based |

## Using the Deep Research Client

The [`deep-research-client`](https://github.com/ai4curation/deep-research-client) provides a unified command-line interface for multiple providers.

### Installation

```bash
pip install deep-research-client
# or
uvx deep-research-client
```

### Basic Usage

```bash
# Using OpenAI
deep-research --provider openai "What is the current understanding of cell fate determination in neural stem cells?"

# Using Perplexity
deep-research --provider perplexity "Review recent advances in ontology alignment techniques"
```

### Configuration

Set API keys via environment variables:

```bash
export OPENAI_API_KEY="sk-..."
export PERPLEXITY_API_KEY="pplx-..."
```

Or configure via a config file at `~/.config/deep-research/config.yaml`:

```yaml
default_provider: perplexity
providers:
  openai:
    api_key: ${OPENAI_API_KEY}
    model: gpt-4-turbo
  perplexity:
    api_key: ${PERPLEXITY_API_KEY}
```

## GitHub Integration Patterns

### Pattern 1: On-Demand via Issue Comments

Allow controllers to trigger deep research from issue comments:

```yaml
# .github/workflows/deep-research.yml
name: Deep Research
on:
  issue_comment:
    types: [created]

jobs:
  research:
    if: contains(github.event.comment.body, '@deep-research')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run deep research
        env:
          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
        run: |
          pip install deep-research-client
          # Extract query from comment and run research
          deep-research --output report.md "$QUERY"
      - name: Post results
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const report = fs.readFileSync('report.md', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: report
            });
```

### Pattern 2: Agent-Initiated Research

Configure your AI agent to use deep research tools when needed. In `CLAUDE.md`:

```markdown
## Deep Research

When you need comprehensive literature review for an issue:

1. Use the `deep-research` tool for complex scientific questions
2. Always include the query and provider in your reasoning
3. Cite sources from the research output in your PR

For ontology term requests with scientific backing, consider running
deep research on the underlying biology/chemistry before proposing definitions.
```

### Pattern 3: Scheduled Research Reports

Generate periodic research reports on topics relevant to your ontology:

```yaml
name: Weekly Research Digest
on:
  schedule:
    - cron: '0 9 * * 1'  # Every Monday at 9am

jobs:
  digest:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Generate research digest
        run: |
          deep-research --provider perplexity \
            --output docs/research/$(date +%Y-%m-%d).md \
            "Recent advances in [your ontology domain]"
      - name: Create PR with digest
        run: |
          git add docs/research/
          git commit -m "Add weekly research digest"
          gh pr create --title "Weekly research digest" --body "Automated research summary"
```

## Cost Management

Deep research can be expensive. Implement these controls:

### Restrict Access

Limit who can trigger deep research via the controllers file:

```json
// .github/ai-controllers.json
{
  "controllers": ["curator1", "curator2"],
  "deep_research_controllers": ["senior-curator"]
}
```

### Set Budget Limits

Configure spending limits at the provider level:

```yaml
# .github/workflows/deep-research.yml
env:
  MAX_TOKENS: 10000
  MAX_COST_PER_QUERY: 5.00
```

### Use Appropriate Providers

- **Quick questions**: Use Perplexity or web search (lower cost)
- **Literature reviews**: Use OpenAI Deep Research (higher quality, higher cost)
- **Exploratory**: Start with cheaper options, escalate if needed

## Output Handling

Deep research typically produces:

1. **Main report**: Synthesized findings in markdown
2. **Citations**: List of sources with URLs/DOIs
3. **Reasoning steps**: (Some providers) Chain of thought showing research process

### Storing Results

For ontology repositories, consider:

```
docs/
  research/
    2024-01-15-cell-fate-review.md
    2024-01-20-neural-markers.md
```

Or attach to issues/PRs as comments for context.

### Extracting Citations

When using research for ontology definitions, extract PMIDs:

```python
# Example: Parse PMIDs from research output
import re

def extract_pmids(text):
    """Extract PubMed IDs from research report."""
    patterns = [
        r'PMID:\s*(\d+)',
        r'pubmed/(\d+)',
        r'ncbi\.nlm\.nih\.gov/pubmed/(\d+)'
    ]
    pmids = set()
    for pattern in patterns:
        pmids.update(re.findall(pattern, text))
    return list(pmids)
```

## Best Practices

1. **Be specific**: Vague queries produce vague results. Include relevant terms, species, time frames.

2. **Verify citations**: Deep research can hallucinate citations. Validate PMIDs before including in ontology annotations.

3. **Iterative refinement**: Start with a broad query, then narrow based on initial results.

4. **Document provenance**: When using research output for ontology changes, link to the research report in commit messages or PR descriptions.

5. **Cache results**: For expensive queries, store results to avoid re-running identical research.

## Troubleshooting

### Timeouts

Deep research can take several minutes. For GitHub Actions:

```yaml
jobs:
  research:
    timeout-minutes: 30  # Increase from default
```

### Rate Limits

Implement backoff for high-volume usage:

```bash
deep-research --retry-count 3 --retry-delay 60 "query"
```

### Quality Issues

If results are too shallow:
- Try a different provider
- Add more context to the query
- Specify desired depth: "Provide a comprehensive review with at least 20 citations"

## Related Resources

- [Instruct the GitHub Agent](instruct-github-agent.md) - General agent usage
- [PMID Validation](make-ids-hallucination-resistant.md) - Verifying citations
- [deep-research-client repository](https://github.com/ai4curation/deep-research-client)
