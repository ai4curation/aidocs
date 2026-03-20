# Batch Term Addition with AI Assistance

This tutorial walks through using AI to add multiple terms to an ontology efficiently. Instead of adding terms one by one, you'll learn to batch requests and let the AI handle the mechanical work while you focus on review and quality control.

## Prerequisites

- Familiarity with ontology structure and your target ontology
- Access to an AI tool (Claude Code, Goose, or GitHub agent)
- A list of terms to add (from literature, user requests, or gap analysis)

## Overview

Adding terms in batch is one of the most common curation tasks where AI excels. The workflow is:

1. Prepare your term list with key information
2. Provide context about placement and patterns
3. Let AI generate the additions
4. Review and refine

## Step 1: Prepare Your Term List

Create a structured list of terms to add. The more information you provide, the better the results.

### Minimal Format

```
- apoptotic cell
- necrotic cell
- senescent cell
```

### Better Format

```
Terms to add under "cell" (CL:0000000):

1. apoptotic cell
   - Definition hint: A cell undergoing programmed cell death
   - Related: caspase activation, DNA fragmentation

2. necrotic cell
   - Definition hint: A cell that has died through necrosis
   - Related: membrane rupture, inflammation

3. senescent cell
   - Definition hint: A cell that has ceased dividing but remains metabolically active
   - Related: SASP, p16, cell cycle arrest
```

### Best Format (with PMIDs)

```
Terms to add under "cell" (CL:0000000):

1. apoptotic cell
   - Parent: cell (CL:0000000)
   - Definition: A cell that is undergoing apoptosis, characterized by
     caspase activation, chromatin condensation, and membrane blebbing.
   - PMID: 12345678 (for definition support)
   - Synonyms: dying cell (broad)

2. necrotic cell
   - Parent: cell (CL:0000000)
   - Definition: A cell that has died through necrosis, typically
     characterized by membrane rupture and release of cellular contents.
   - PMID: 23456789
   - Note: Distinguish from necroptotic cell (programmed necrosis)
```

## Step 2: Provide Context

Before asking AI to add terms, establish the context:

### Pattern Examples

Point the AI to existing terms as templates:

```
Look at how "B cell" (CL:0000236) is defined in the Cell Ontology.
Use this as a pattern for the new immune cell types.
The definition should follow genus-differentia form:
"A [parent type] that [distinguishing characteristics]."
```

### Relationship Guidance

Specify the relationships you expect:

```
For each cell type:
- Add is_a relationship to the appropriate parent
- Add part_of relationship to the tissue where applicable
- Include has_part for key organelles if distinctive
```

### Ontology-Specific Conventions

Reference your ontology's style guide:

```
Follow CL conventions:
- Use lowercase for term labels
- Include exactly one textual definition
- Add database_cross_reference for PMIDs
- Use 'exact', 'broad', 'narrow', or 'related' for synonym types
```

## Step 3: Execute the Batch Addition

### Using Claude Code or Goose

Navigate to your ontology repository and use a prompt like:

```
I need to add the following cell types to the Cell Ontology.
Use the existing term "natural killer cell" (CL:0000623) as a pattern.

Terms to add:
1. invariant natural killer T cell
   - Parent: natural killer cell
   - Definition: A natural killer cell that expresses an invariant
     T cell receptor and responds to lipid antigens presented by CD1d.
   - PMID: 16034096

2. cytokine-induced killer cell
   - Parent: natural killer cell
   - Definition: A natural killer cell that has been activated ex vivo
     with cytokines and exhibits enhanced cytotoxic activity.
   - PMID: 19056535

Please:
1. Look at the existing pattern for natural killer cell
2. Add these terms following that pattern
3. Include proper provenance using the PMIDs
4. Show me the changes before committing
```

### Using GitHub Agent

Create an issue with your request:

```markdown
## Request: Add immune cell subtypes

Please add the following terms to CL:

### Terms

1. **invariant natural killer T cell**
   - Parent: natural killer cell (CL:0000623)
   - PMID: 16034096 for definition

2. **cytokine-induced killer cell**
   - Parent: natural killer cell (CL:0000623)
   - PMID: 19056535 for definition

### Instructions

- Follow existing patterns in CL for cell type definitions
- Use genus-differentia definitions
- Add database_cross_reference for PMIDs
```

Then invoke:
```
@dragon-ai-agent please resolve this issue
```

## Step 4: Review the Changes

AI will typically produce changes like this (OBO format example):

```
[Term]
id: CL:0001234
name: invariant natural killer T cell
def: "A natural killer cell that expresses an invariant T cell receptor
alpha chain and responds to lipid antigens presented by CD1d molecules."
[PMID:16034096]
is_a: CL:0000623 ! natural killer cell
synonym: "iNKT cell" EXACT []
synonym: "type I NKT cell" RELATED []
```

### Review Checklist

- [ ] IDs are correctly formatted (or placeholders for your ID scheme)
- [ ] Definitions follow genus-differentia pattern
- [ ] Parent relationships are correct
- [ ] PMIDs are valid (check they exist)
- [ ] Synonyms are appropriately typed
- [ ] No duplicate terms created
- [ ] Formatting matches ontology conventions

## Step 5: Iterate and Refine

If changes need adjustment:

```
The definition for "invariant natural killer T cell" should mention
that these cells bridge innate and adaptive immunity. Please update
the definition to include this characteristic.
```

Or for bulk refinements:

```
Please update all the new definitions to explicitly state the
cell's primary function or role, not just its markers.
```

## Tips for Large Batches

### Chunk Your Requests

For 50+ terms, break into logical groups:

```
Let's add these in phases:
1. First, add the 10 T cell subtypes
2. Then I'll review
3. Next, add the 15 B cell subtypes
4. And so on...
```

### Use Spreadsheets for Input

For very large batches, prepare a TSV/CSV:

```
label	parent_id	definition	pmid	synonyms
invariant natural killer T cell	CL:0000623	A natural killer cell that...	16034096	iNKT cell|type I NKT cell
```

Then:
```
Please read the file new_terms.tsv and add each row as a new term
to the ontology, following CL conventions.
```

### Validate Before Committing

Ask for validation:
```
Before committing, please:
1. Run the reasoner to check for logical errors
2. Verify no terms with these labels already exist
3. Check that all referenced parent IDs exist
```

## Common Issues and Solutions

### AI Invents Non-Existent Parents

**Problem:** AI creates relationships to terms that don't exist.

**Solution:** Explicitly list valid parent options:
```
Only use these as parents:
- cell (CL:0000000)
- native cell (CL:0000003)
- lymphocyte (CL:0000542)
Do NOT create new intermediate classes.
```

### Inconsistent Definition Style

**Problem:** Each definition has different structure.

**Solution:** Provide a template:
```
All definitions must follow this pattern:
"A [parent type] that [key characteristic], [additional features].
[Optional: functional description]."
```

### Missing Provenance

**Problem:** AI doesn't include PMIDs.

**Solution:** Make it explicit:
```
Every definition MUST have a database_cross_reference to a PMID.
If I didn't provide a PMID, please note that the term needs
literature support before it can be merged.
```

## Next Steps

- [Literature-Assisted Curation](literature-assisted-curation.md) - Find supporting citations
- [AI-Powered Quality Control](quality-control-with-ai.md) - Validate your additions
- [Ontology Editing with AI](ontology-editing-with-ai.md) - General AI workflow tutorial
