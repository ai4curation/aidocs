# PR Reviews as an Archimedes Lever for Agent Improvement

Pull request reviews serve as a powerful mechanism for improving AI agent workflows in knowledge base curation. This guide outlines best practices for using PR reviews to systematically enhance agent performance and maintain code quality.

## Why PR Reviews Matter for AI Agents

PR reviews provide targeted, contextual feedback that helps agents learn from their mistakes and improve future performance. They serve as an "Archimedes lever" - a small amount of focused effort that yields disproportionate improvements across the entire system.

### Benefits of Disciplined PR Review

- **Targeted improvement**: Reviews provide specific, actionable feedback for agent enhancement
- **Quality assurance**: Ensures all changes meet project standards before integration
- **Knowledge transfer**: Human reviewers share domain expertise with agents
- **Training data**: Review comments can be used to train LLM-as-judge systems

## Best Practices for PR Reviews

### Separation of Concerns

Every PR should adhere to strict separation of concerns:

- **Single issue focus**: Each PR should address only one specific issue or feature
- **No spurious diffs**: Avoid including unrelated formatting changes or refactoring
- **Clear scope**: Changes should be directly related to the stated issue being addressed

**Example of good separation**:
```
✅ PR: "Fix term hierarchy for GO:0008150"
- Only contains changes related to GO:0008150
- No formatting changes to unrelated files
- Clear diff showing the specific hierarchy fix
```

**Example of poor separation**:
```
❌ PR: "Fix term hierarchy and update several definitions"
- Mixes hierarchy fixes with definition updates
- Includes formatting changes to multiple files
- Addresses multiple unrelated issues
```

### Review Process Standards

#### All PRs Must Be Reviewed

- **No exceptions**: Every PR requires review, regardless of size or author
- **Different reviewer**: Ideally, reviewer should be different from the PR author
- **Big picture perspective**: Reviewer should have project-wide view and understand guidelines

#### Effective Review Comments

Reviews should include:

- **Informative feedback**: Comments should explain the reasoning behind suggestions
- **Concise clarity**: Keep comments brief but thorough
- **Constructive tone**: Focus on improving the code, not criticizing the author
- **Specific references**: Point to exact lines, files, or sections when providing feedback

**Example of effective review comment**:
```markdown
The hierarchy change looks correct, but please also update the definition 
to reflect the new parent relationship. See lines 45-47 in the original 
term definition.
```

### GitHub Workflow Considerations

#### Self-Review Limitations

GitHub workflows present challenges when the person creating a PR wants to use the review mechanism:

- **Ownership issue**: GitHub treats agent-created PRs as belonging to the triggering user
- **Review limitations**: Users typically cannot formally review their own PRs
- **Workaround options**:
  - Use PR comments for self-review feedback
  - Request another team member to conduct the review
  - Implement pre-commit review processes

#### Alternative Review Strategies

When formal reviews aren't possible:

1. **Pre-implementation review**: Human reviews agent plans before code generation
2. **Comment-based feedback**: Use PR comments instead of formal review system
3. **Iterative refinement**: Create draft PRs for review before marking as ready

## Implementation Guidelines

### For Human Reviewers

1. **Check separation of concerns**: Verify PR addresses only stated issue
2. **Validate completeness**: Ensure all necessary changes are included
3. **Review for quality**: Check code style, documentation, and testing
4. **Provide learning opportunities**: Explain best practices in review comments
5. **Consider maintainability**: Evaluate long-term impact of changes

### For Agent Improvement

1. **Document patterns**: Keep records of common review feedback
2. **Update system prompts**: Incorporate frequent review comments into agent instructions
3. **Create validation rules**: Implement automated checks for common issues
4. **Training data collection**: Use review conversations to improve LLM-as-judge systems

### For Repository Maintainers

1. **Establish review requirements**: Make PR reviews mandatory in repository settings
2. **Create review templates**: Provide checklists for consistent reviews
3. **Train reviewers**: Ensure team understands both domain expertise and review process
4. **Monitor effectiveness**: Track how reviews impact agent performance over time

## Tools and Automation

### Automated Pre-Review Checks

Consider implementing automated checks that run before human review:

- **Linting and formatting**: Ensure code style consistency
- **Test validation**: Verify all tests pass
- **Diff analysis**: Flag PRs with unexpected scope or spurious changes
- **Documentation updates**: Check if changes require documentation updates

### Review Analytics

Track review effectiveness:

- **Review completion rates**: Ensure all PRs receive reviews
- **Feedback patterns**: Identify common issues for agent training
- **Time to review**: Monitor review process efficiency
- **Agent improvement metrics**: Measure reduction in review feedback over time

## Common Pitfalls to Avoid

1. **Rubber stamp reviews**: Avoid approving without thorough examination
2. **Scope creep**: Don't allow PRs to expand beyond original intent
3. **Inconsistent standards**: Apply review criteria consistently across all PRs
4. **Delayed feedback**: Provide timely reviews to maintain momentum
5. **Missing context**: Ensure reviewers understand the broader issue being addressed

## Measuring Success

Track the effectiveness of your PR review process:

- **Reduction in post-merge issues**: Fewer bugs and problems after PR integration
- **Agent learning velocity**: Faster improvement in agent performance
- **Review feedback trends**: Decreasing frequency of similar review comments
- **Code quality metrics**: Improved maintainability and consistency scores

## Related Resources

- [Instruct the GitHub Agent](instruct-github-agent.md)
- [Set up GitHub Actions](set-up-github-actions.md)
- [Integrate AI into your KB](integrate-ai-into-your-kb.md)