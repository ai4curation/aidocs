# ai-blame: AI Provenance Tracking Tool

ai-blame is a command-line tool for extracting provenance and audit trails from AI agent execution traces. It functions like `git blame` but specifically for AI-generated edits, helping track which AI agents made what changes to your knowledge base files.

## What is ai-blame?

ai-blame addresses the provenance tracking challenge discussed in [Issue #62](https://github.com/ai4curation/aidocs/issues/62). When AI agents assist with knowledge base curation tasks, it's crucial to maintain an audit trail of which agent made what changes, when, and ideally why.

Key features:
- **Trace Analysis**: Scans AI execution traces in JSONL format
- **Provenance Extraction**: Identifies successful Edit and Write operations  
- **Metadata Injection**: Adds `curation_history` sections to YAML files
- **Claude Code Integration**: Currently supports Claude Code execution traces

## Installation

### Via pip/uv (Recommended)
```bash
uv pip install ai-blame
```

### From Source
```bash
git clone https://github.com/ai4curation/ai-blame
cd ai-blame
uv pip install -e .
```

## Usage

### Basic Commands

**Show available traces:**
```bash
ai-blame stats
```

**Preview potential changes:**
```bash
ai-blame mine --initial-and-recent
```

**Apply changes to files:**
```bash
ai-blame mine --apply --initial-and-recent
```

### How It Works

1. **Scan Traces**: ai-blame examines trace files in JSONL format (typically in `~/.claude/projects/`)
2. **Identify Operations**: Finds successful Edit and Write operations that modified files
3. **Extract Metadata**: Captures timestamps, model information, and file paths
4. **Update Files**: Appends provenance information to affected YAML files

### Example Output

After running ai-blame, your YAML files will include provenance tracking:

```yaml
# Original content remains unchanged
disease_name: "Asthma"
description: "Chronic respiratory condition"

# ai-blame adds this section
curation_history:
  - timestamp: "2025-12-01T08:00:00Z"
    model: "claude-opus-4-5"
    action: "CREATED"
  - timestamp: "2025-12-15T14:30:00Z" 
    model: "claude-sonnet-4-5"
    action: "UPDATED"
    description: "Added PMID:12345678 evidence"
```

## Integration with Curation Workflows

ai-blame is particularly valuable for:

### Knowledge Base Maintenance
- Track which AI models contributed to ontology terms
- Identify systematic issues across model versions
- Maintain audit trails for compliance

### Quality Assurance  
- Review AI-generated content by model and timeframe
- Calibrate trust based on model performance history
- Debug curation workflows when issues arise

### Research Applications
- Study AI model behavior in curation tasks
- Compare performance across different model versions
- Generate training data for improving curation models

## Configuration Options

ai-blame supports several configuration options:

- `--initial-and-recent`: Only track creation and most recent modification (reduces file bloat)
- `--apply`: Actually modify files (default is dry-run mode)
- Custom trace directory paths
- Filter by date ranges or specific models

## Related Tools and Approaches

ai-blame implements one approach to the provenance tracking design space:

- **Inline provenance**: Adds metadata directly to content files
- **Post-hoc extraction**: Analyzes logs after curation sessions
- **Lightweight approach**: Focuses on essential provenance without full audit trails

For alternative approaches, see [Provenance Tracking Design Considerations](https://github.com/ai4curation/aidocs/issues/62).

## Resources

- **GitHub Repository**: [https://github.com/ai4curation/ai-blame](https://github.com/ai4curation/ai-blame)
- **PyPI Package**: [https://pypi.org/project/ai-blame/](https://pypi.org/project/ai-blame/)
- **License**: BSD-3-Clause
- **Related Discussion**: [Issue #62 - Provenance tracking design considerations](https://github.com/ai4curation/aidocs/issues/62)

## Contributing

ai-blame uses the monarch-project-copier template and follows standard open-source contribution practices. See the GitHub repository for development setup and contribution guidelines.