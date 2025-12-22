# PR Reviews as a Lever for Agent Improvement

Disciplined pull request review processes serve as a powerful mechanism for improving AI agent performance in ontology curation workflows. This guide outlines best practices for leveraging PR reviews to create feedback loops that enhance both code quality and agent behavior.

## Why PR Reviews Matter for AI Agents

PR reviews provide structured feedback that can be used to:

- **Identify failure patterns**: Repeated issues across PRs reveal systematic problems in agent behavior
- **Train LLM-as-judge systems**: Human review feedback creates training data for automated quality assessment
- **Refine agent instructions**: Patterns in reviewer comments inform updates to `CLAUDE.md` and similar configuration files
- **Document best practices**: Reviews capture institutional knowledge about curation standards

## Best Practices

### Separation of Concerns

Each PR should address a single issue. This principle is critical for AI-generated PRs:

- **One issue per PR**: Avoid combining unrelated changes, even if they seem small
- **No spurious diffs**: Changes should be limited to what's necessary to resolve the issue
- **No scope creep**: If an agent discovers related issues while working, those should become separate issues/PRs

Benefits for agent improvement:
- Easier to identify which agent behaviors led to which outcomes
- Simpler to correlate reviewer feedback with specific agent actions
- Cleaner training signal for reinforcement learning from human feedback

### Review Standards

All PRs require review, with specific considerations for AI-generated content:

- **Different reviewer than author**: When possible, the person who invoked the agent should not be the sole reviewer
- **Review the diff, not just the result**: Check that changes match the stated objective
- **Verify content-objective alignment**: Ensure the PR title and description accurately reflect the actual changes

### Comment Quality

Reviewer comments should be informative and actionable:

- **Be specific**: Instead of "this is wrong," explain what's wrong and why
- **Reference standards**: Link to documentation, ontology design patterns, or prior examples
- **Be concise**: Comments should be machine-parseable for potential automated analysis
- **Categorize feedback**: Distinguish between blocking issues vs. suggestions vs. nitpicks

Example of a good review comment:
```
This definition lacks a genus-differentia structure. The term "hepatocyte"
should be defined as "A [cell type] that [differentiating characteristics]".
See the CL style guide: [link]
```

### Handling GitHub Attribution

When humans create PRs via Claude or other AI tools, GitHub attributes the PR to the human, which can complicate the standard review workflow. Workarounds include:

- **Structured comments**: Even without formal approval mechanisms, leave detailed review comments
- **Explicit labeling**: Use labels like `ai-generated` or `needs-human-review` to flag PRs for additional scrutiny
- **Review checklists**: Include a checklist in PR templates specifically for AI-generated content

## Creating a Feedback Loop

To systematically improve agent performance from PR reviews:

1. **Collect review data**: Track common issues raised in reviews of AI-generated PRs
2. **Categorize by failure mode**: Group issues (e.g., "formatting errors," "incorrect relationships," "missing provenance")
3. **Prioritize by impact**: Focus on failure modes that cause the most reviewer burden
4. **Update agent instructions**: Modify `CLAUDE.md` or equivalent to address top issues
5. **Measure improvement**: Track whether specific failure modes decrease after instruction updates

## Empirical Insights

Analysis of AI agent PRs across ontology projects has revealed common patterns:

| Failure Mode | Impact | Mitigation |
|--------------|--------|------------|
| Duplicate PRs for single issues | High | Enforce one-PR-per-issue with pre-flight checks |
| Content-objective mismatch | High | Require `git diff` verification before submission |
| Missing provenance (PMIDs) | Medium | Add explicit provenance requirements to agent instructions |
| Style violations | Medium | Include project-specific style guides in agent context |
| Scope creep | Low | Instruct agents to file separate issues for discovered problems |

## Related Resources

- [Instruct the GitHub Agent](instruct-github-agent.md) - Guide for working with AI agents in GitHub
- [Set up GitHub Actions](set-up-github-actions.md) - Configure AI agents in your repository
