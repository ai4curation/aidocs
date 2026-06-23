# Literature-Assisted Curation with AI

This tutorial shows how to use AI to find, validate, and incorporate literature references into ontology curation. You'll learn to leverage AI for literature review while maintaining rigorous provenance standards.

## Prerequisites

- Basic familiarity with ontology curation
- Access to an AI tool (Claude Code, Goose, or GitHub agent)
- Understanding of citation requirements for your ontology

## The Challenge

Ontology terms need literature support for:
- Definitions
- Synonym assertions
- Relationship claims
- Comments and notes

Finding appropriate citations is time-consuming. AI can help by:
- Searching literature for relevant papers
- Extracting key information from papers
- Suggesting definitions based on literature
- Validating that citations support claims

## Workflow Overview

```
1. Identify what needs citations
2. Use AI for literature search
3. Validate citations (AI can hallucinate!)
4. Extract supporting text
5. Incorporate into ontology with provenance
```

## Step 1: Identify Citation Needs

Start by identifying terms that need literature support:

```
Please review the following terms and identify which ones lack
proper literature citations in their definitions:

- regulatory T cell (CL:0000815)
- T follicular helper cell (CL:0002038)
- memory B cell (CL:0000787)

For each, note what kind of citation would be helpful.
```

AI might respond:

```
Citation needs:

1. regulatory T cell - Has PMID but from 2005, may benefit from
   updated review citation

2. T follicular helper cell - Definition lacks PMID, needs citation
   for the defining characteristics (CXCR5 expression, B cell help)

3. memory B cell - Has PMID:12345678, adequate
```

## Step 2: Literature Search

Ask AI to find relevant literature:

### Basic Search

```
Find recent review articles (2020-2024) that describe T follicular
helper cells and their key characteristics. I need citations that
support a definition emphasizing:
- CXCR5 expression
- Localization to B cell follicles
- Role in B cell help and antibody responses
```

### Targeted Search

```
I need a PMID that specifically supports the claim that regulatory
T cells express FOXP3 constitutively. Please find a primary research
paper or authoritative review that makes this claim explicitly.
```

### Deep Research (for complex topics)

For comprehensive literature review, use deep research capabilities:

```
@deep-research please provide a comprehensive review of the current
understanding of T follicular helper cell biology, including:
1. Defining markers and transcription factors
2. Development pathway
3. Functional subsets
4. Role in disease

Focus on finding authoritative reviews from the past 3 years.
```

## Step 3: Validate Citations

**Critical:** AI can hallucinate citations. Always validate:

### Manual Validation

For important citations:
1. Check the PMID exists on PubMed
2. Verify the paper's title and authors match
3. Confirm the paper actually supports the claim

### AI-Assisted Validation

Ask AI to validate its own citations:

```
For each PMID you suggested, please:
1. Confirm the paper exists by providing its exact title
2. Quote the specific passage that supports our definition
3. Note the year and journal
```

### Batch Validation

For many citations:

```
I have the following PMIDs that need validation. For each, confirm
it exists and briefly state what the paper is about:

PMID:35123456
PMID:34567890
PMID:33456789
```

## Step 4: Extract Supporting Text

Once citations are validated, extract relevant passages:

```
Please read PMID:35123456 and extract:
1. Any sentences that define what a T follicular helper cell is
2. Key characteristics mentioned (markers, location, function)
3. Specific claims that could support ontology assertions
```

### For Definition Writing

```
Based on PMID:35123456, draft a genus-differentia definition for
"T follicular helper cell" that:
- States the parent type (T cell)
- Lists defining characteristics
- Is supported by claims in the paper
- Follows Cell Ontology style guidelines
```

### For Relationship Support

```
Does PMID:35123456 support the assertion that T follicular helper
cells are part_of germinal centers? Quote any relevant text.
```

## Step 5: Incorporate with Provenance

Add citations to your ontology with proper attribution:

### OBO Format Example

```
[Term]
id: CL:0002038
name: T follicular helper cell
def: "A CD4-positive, alpha-beta T cell that expresses CXCR5, is
located in B cell follicles, and provides help to B cells for
antibody production and class switching." [PMID:35123456]
synonym: "Tfh cell" EXACT []
is_a: CL:0000624 ! CD4-positive, alpha-beta T cell
relationship: part_of UBERON:0001744 ! lymphoid follicle
```

### Multiple Citations

When multiple papers support a definition:

```
def: "A CD4-positive T cell that..." [PMID:35123456, PMID:34567890]
```

### Citation for Specific Claims

```
comment: "Recent evidence suggests Tfh cells can also arise from
regulatory T cell precursors (PMID:36789012)."
```

## Practical Examples

### Example 1: Updating an Outdated Definition

```
The definition of "plasma cell" references a 2003 paper. Please:

1. Find a current (2020+) review on plasma cell biology
2. Check if the existing definition is still accurate
3. Suggest any updates based on current understanding
4. Provide the new PMID for the updated definition
```

### Example 2: Adding a New Term with Literature Support

```
I need to add "tissue-resident memory T cell" to the Cell Ontology.

Please:
1. Find 2-3 key papers that define this cell type
2. Identify the consensus defining characteristics
3. Draft a definition with proper genus-differentia structure
4. Suggest appropriate parent terms and relationships
5. List synonyms mentioned in the literature
```

### Example 3: Validating Existing Citations

```
Please audit the following term for citation accuracy:

[Term]
id: CL:0000815
name: regulatory T cell
def: "A T cell that regulates..." [PMID:12034567]

Check:
1. Does this PMID exist?
2. Does it support the current definition?
3. Is there a better (more recent/authoritative) citation?
```

## Common Patterns

### Pattern: Definition with Recent Review

```
Please find the most recent (2022-2024) comprehensive review of
[cell type] and use it as the primary definition source.
```

### Pattern: Original Research Citation

```
For the claim that [specific characteristic], find the original
research paper that first described this, not a review.
```

### Pattern: Multiple Supporting Citations

```
This definition makes 3 claims:
1. [Claim A]
2. [Claim B]
3. [Claim C]

Find a PMID that supports each claim. They can be different papers.
```

## Avoiding Common Pitfalls

### Hallucinated Citations

**Problem:** AI invents PMIDs that don't exist.

**Solution:** Always validate. Use this prompt:
```
For PMID:XXXXXXXX, please confirm:
- The exact paper title
- First author's last name
- Publication year
- Journal name

If you cannot confirm all of these, say "UNABLE TO VERIFY".
```

### Outdated Citations

**Problem:** AI suggests old papers when newer evidence exists.

**Solution:** Specify recency:
```
Find citations from 2020-2024 only. If the field has evolved,
note any changes from earlier understanding.
```

### Unsupported Claims

**Problem:** Citation doesn't actually support the claim.

**Solution:** Request quotes:
```
Quote the specific sentence from the paper that supports this
definition. If no such sentence exists, say so.
```

### Over-Reliance on Reviews

**Problem:** Only using review articles, missing primary sources.

**Solution:** Request mix:
```
Provide one primary research paper and one review article to
support this term.
```

## Tools and Resources

### PubMed Integration

Some AI setups can search PubMed directly:
```
Search PubMed for: "T follicular helper" AND "definition" AND review[pt]
Filter: 2020-2024
```

### Full-Text Access

For papers with full text available:
```
Please read the full text of PMID:35123456 (it should be on PMC)
and summarize the methodology section.
```

### Reference Tracking

```
What papers does PMID:35123456 cite for its definition of Tfh cells?
These might be good primary sources.
```

## Next Steps

- [Batch Term Addition](batch-term-addition.md) - Apply literature findings to add terms
- [Make IDs Hallucination-Resistant](../how-tos/make-ids-hallucination-resistant.md) - Validation techniques
- [Deep Research Integration](../how-tos/deep-research-integration.md) - Advanced literature review
