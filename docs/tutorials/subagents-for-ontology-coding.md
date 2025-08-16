# Using Subagents for Ontology Coding: A Mondo Case Study

This guide explores advanced AI-assisted ontology development using **subagents** - specialized AI assistants that handle specific aspects of ontology work. We'll examine how the [MONDO Disease Ontology](https://github.com/monarch-initiative/mondo) project has implemented subagents to create a robust, systematic approach to ontology curation.

## Background: What are Subagents?

Subagents are specialized AI assistants that operate within AI coding environments like [Claude Code](../reference/clients/claude-code.md) and [Goose](../reference/clients/goose.md). Unlike general-purpose AI assistants, subagents are:

- **Domain-specific**: Configured with specialized knowledge and constraints
- **Role-focused**: Designed to handle specific types of tasks
- **Context-isolated**: Operate in separate conversation contexts to maintain focus
- **Tool-constrained**: Given access only to the tools they need

For ontology coding, subagents enable systematic, quality-controlled approaches to complex curation workflows.

## The Role vs. Workflow Question

As noted in the original issue, there's an important design decision when organizing subagents:

> **Role-based**: Organizing by what agents do (e.g., "metadata-checker", "reasoner")  
> **Workflow-based**: Organizing by specific processes (e.g., "new-term-request-agent", "metadata-change-review-agent")

The MONDO project demonstrates that **both approaches are valuable**, but they chose a **role-based architecture** with workflow coordination. Here's why this works well for ontology coding.

## MONDO's Subagent Architecture

The MONDO project has implemented 6 specialized subagents organized in a hierarchical structure:

### Orchestration Layer
- **task-coordinator**: The master planner that orchestrates all ontology work

### Specialist Agents
- **deep-research-specialist**: Comprehensive literature research and evidence synthesis
- **design-pattern-advisor**: Ontology design pattern identification and application
- **identifier-validator**: External identifier verification and validation
- **metadata-checker**: Metadata compliance and quality assurance
- **ontology-reasoner**: Logical consistency validation and reasoning

## Detailed Agent Analysis

### 1. Task Coordinator (The Orchestrator)

**Purpose**: Acts as the master planner for all ontology modifications.

**Key Responsibilities**:
- Breaking down complex tasks into sequential steps
- Selecting and coordinating specialist agents
- Ensuring proper validation workflows
- Risk management for ontology changes

**Critical Rule**: This agent **must be used first** for any ontology task to ensure proper planning and execution sequence.

**Example Workflow**:
```
User Request: "Add a new term for BRCA1-related breast cancer"
↓
Task Coordinator:
1. Analyzes requirements
2. Plans sequence: research → design pattern → validation → metadata
3. Coordinates specialist agents in proper order
4. Ensures all validation steps are completed
```

### 2. Deep Research Specialist

**Purpose**: Provides comprehensive, scientifically-rigorous research with meticulous documentation.

**Key Capabilities**:
- Systematic literature searches
- Evidence synthesis and evaluation
- Citation management and provenance tracking
- Gap analysis and research recommendations

**Ontology Application**: Essential for creating well-evidenced ontology terms with proper scientific backing.

**Example Output Structure**:
- Executive summary
- Detailed methodology
- Findings with complete citations
- Evidence quality assessment
- Limitations and uncertainties

### 3. Design Pattern Advisor

**Purpose**: Ensures consistent application of ontology design patterns.

**Key Functions**:
- Searching existing pattern libraries (YAML pattern files)
- Analyzing current ontology structure (mondo-edit.obo)
- Recommending appropriate patterns for new terms
- Ensuring logical consistency and reasoning compliance

**Critical for**:
- Complex term creation (e.g., gene-disease relationships)
- Maintaining ontological consistency
- Enabling proper automated reasoning

### 4. Identifier Validator

**Purpose**: Verifies accuracy and appropriateness of external identifiers.

**Validation Scope**:
- **Publications**: PMID verification and relevance checking
- **Database Cross-references**: OMIM, HGNC, Orphanet, etc.
- **Ontology Terms**: MONDO, HPO, UBERON ID validation
- **Format Compliance**: Ensuring proper identifier formatting

**Core Principle**: "Never guess or assume identifier validity" - always use verification tools.

### 5. Metadata Checker

**Purpose**: Ensures compliance with MONDO's strict metadata standards.

**Quality Control Areas**:
- Creator attribution tracking
- Required metadata element verification
- Source attribution validation
- Design pattern compliance checking
- Term tracker link verification

**Integration Point**: Used after any term creation or modification to verify proper metadata attribution.

### 6. Ontology Reasoner

**Purpose**: Validates logical consistency in OWL/OBO ontologies.

**Technical Functions**:
- Execute reasoning checks using ROBOT toolkit
- Identify unsatisfiable classes and reasoning errors
- Generate reasoned ontology versions
- Diagnose and resolve logical conflicts

**Workflow**:
1. Initial reasoning validation
2. Issue diagnosis and analysis
3. Solution recommendation
4. Re-validation after changes

## Why Role-Based Organization Works for Ontology Coding

The MONDO approach demonstrates several advantages of role-based subagent organization:

### 1. **Composability**
Different workflows can mix and match the same specialist agents:
- New term creation: coordinator → research → design pattern → reasoner → metadata
- Term obsolescence: coordinator → research → reasoner → metadata
- Batch updates: coordinator → design pattern → reasoner → metadata

### 2. **Expertise Concentration**
Each agent becomes highly specialized:
- The reasoner agent knows exactly how to work with ROBOT toolkit
- The metadata checker knows all MONDO-specific requirements
- The research specialist has refined methodology for evidence gathering

### 3. **Quality Assurance**
Systematic validation at each stage:
- Research quality controlled by research specialist
- Logical consistency guaranteed by reasoner
- Metadata compliance ensured by metadata checker

### 4. **Maintainability**
- Single point of change for each domain of expertise
- Clear separation of concerns
- Easier to update agent capabilities independently

## Implementing Subagents for Your Ontology Project

### Configuration Structure

Place subagent definitions in `.claude/agents/` (project-level) or `~/.claude/agents/` (user-level):

```
.claude/
├── settings.json          # Tool permissions and configuration
└── agents/
    ├── task-coordinator.md
    ├── research-specialist.md
    ├── design-pattern-advisor.md
    ├── identifier-validator.md
    ├── metadata-checker.md
    └── ontology-reasoner.md
```

### Essential Components for Ontology Subagents

Based on the MONDO analysis, consider these core agents:

1. **Coordinator Agent** (Required)
   - Master planner and orchestrator
   - Workflow coordination
   - Risk management

2. **Research Agent** (Highly Recommended)
   - Literature search and synthesis
   - Evidence documentation
   - Citation management

3. **Validation Agent** (Required)
   - Logical consistency checking
   - Format validation
   - Quality assurance

4. **Metadata Agent** (Project-Specific)
   - Compliance checking
   - Standard enforcement
   - Attribution tracking

### Best Practices

1. **Start with a Coordinator**: Always implement a master planning agent first
2. **Incremental Development**: Add specialist agents as needs become clear
3. **Clear Responsibilities**: Avoid overlap between agent roles
4. **Tool Constraints**: Limit each agent to only the tools it needs
5. **Version Control**: Keep agent definitions in your project repository
6. **Documentation**: Maintain clear examples of when to use each agent

## Integration with Ontology Development Workflows

### ODK Integration
For [ODK](../glossary.md#odk-ontology-development-kit)-based projects:
- Reasoner agents can integrate with ROBOT toolkit commands
- Validation agents can hook into ODK QC workflows
- Metadata agents can enforce ODK best practices

### GitHub Actions Integration
Subagents can be configured to work with [GitHub Actions workflows](../how-tos/set-up-github-actions.md):
- Automatic validation on pull requests
- Batch processing for maintenance tasks
- Quality control enforcement

### Local Development
When working locally (as described in [ontology editing with AI](ontology-editing-with-ai.md)):
- Subagents provide structured approaches to complex edits
- Systematic validation before commits
- Consistent application of project standards

## Conclusion

The MONDO project's subagent implementation demonstrates that role-based organization provides a powerful framework for systematic ontology development. By combining specialist expertise with coordinated workflows, subagents enable:

- **Higher Quality**: Systematic validation at every step
- **Consistency**: Standardized approaches across all ontology work
- **Scalability**: Reusable components for different workflows
- **Maintainability**: Clear separation of concerns and responsibilities

For ontology projects considering subagent implementation, the MONDO model provides a proven template that balances specialization with coordination, ensuring both quality and efficiency in AI-assisted ontology curation.

## Further Reading

- [Claude Code Subagents Documentation](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [Goose Subagents Documentation](https://block.github.io/goose/docs/experimental/subagents/)
- [MONDO Disease Ontology Project](https://github.com/monarch-initiative/mondo)
- [Ontology Development Kit (ODK)](../glossary.md#odk-ontology-development-kit)
- [Using AI for Ontology Editing Tutorial](ontology-editing-with-ai.md)