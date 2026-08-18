# How to Make Identifiers Hallucination-Resistant

When you're using AI to help with knowledge curation, one of the biggest problems you'll run into is that language models love to make up identifiers that look real but aren't. They'll confidently generate fake gene IDs, ontology terms, or publication IDs that seem plausible but don't actually exist.

This is a serious problem because these fake identifiers can easily slip through into your knowledge base, undermining the whole point of careful curation.

## The Problem in Practice

Large language models frequently hallucinate identifiers like:

- **Ontology term IDs**: GO:9999999, HP:9999999, MONDO:9999999
- **Gene/protein identifiers**: HGNC:9999999, UniProt:Z99999
- **Publication IDs**: PMID:99999999, DOI:10.9999/fake.doi

The models are good at following the format patterns (they know GO terms start with "GO:" followed by seven digits), but they often invent IDs that don't exist or pair real IDs with wrong labels.

## A Simple Pattern That Works

We've found that a straightforward approach works quite well: require both the ID and its canonical label, then validate both against authoritative sources.

### The Basic Pattern

Instead of just accepting an ID:

```yaml
# Don't do this - too easy to hallucinate
term: GO:0005515
```

Require both ID and label:

```yaml
# Do this - much harder to fake both correctly
term:
  id: GO:0005515
  label: protein binding
```

### Why This Helps

When you require both pieces, the AI has to get two things right instead of one:
- The ID has to be real
- The label has to match the canonical label for that ID
- Both have to be consistent with each other

It's much harder for a model to accidentally generate a valid ID/label pair for something that doesn't exist.

## Examples

### Ontology Terms

```yaml
# This would be caught as invalid
term:
  id: GO:0005515
  label: "DNA binding"  # Wrong - this is actually "protein binding"

# This passes validation
term:  
  id: GO:0005515
  label: "protein binding"  # Correct canonical label

# This would be flagged as fabricated
term:
  id: GO:9999999
  label: "made up function"  # Non-existent term
```

### Publications

```yaml
# Example for papers
publication:
  pmid: 10802651
  title: "Gene Ontology: tool for the unification of biology"

# Would catch mismatches like:
publication:
  pmid: 10802651
  title: "Some other paper title"  # Wrong title for this PMID
```

### Text Excerpts from Publications

When your curation includes quoted text or supporting evidence from papers, you can validate that the text actually appears in the cited source:

```yaml
# This would pass validation
annotation:
  term_id: GO:0005634
  supporting_text: "The protein localizes to the nucleus during cell division"
  reference: PMID:12345678
  # Validation checks that this exact text appears in PMID:12345678

# This would fail - text doesn't appear in the paper
annotation:
  term_id: GO:0005634
  supporting_text: "Made-up description that sounds plausible"
  reference: PMID:12345678
```

The validator supports standard editorial conventions:

```yaml
# These are valid - bracketed clarifications and ellipses are allowed
annotation:
  supporting_text: "The protein [localizes] to the nucleus...during cell division"
  # Matches: "The protein to the nucleus early during cell division"
```

## You Need Tooling for This

This pattern only works if you have validation tools that can actually check the identifiers against authoritative sources. You need:

1. **Format validation**: Check that IDs follow the right patterns (GO:1234567, PMID:12345678, etc.)
2. **Existence validation**: Query authoritative APIs to verify IDs exist
3. **Label matching**: Compare provided labels against canonical ones
4. **Consistency checking**: Make sure everything matches up

## Validation Concepts

There are two complementary approaches to preventing hallucinations in AI-assisted curation:

### 1. Term Validation (ID + Label Checking)

This is the approach we've been discussing: validating that identifiers and their labels are consistent with authoritative ontology sources. The key concept is **dual verification** - requiring both the ID and its canonical label makes it exponentially harder for an AI to accidentally fabricate a valid combination.

**Core principles:**
- Validate term IDs against ontology sources to ensure they exist
- Verify labels match the canonical labels from those sources
- Check consistency between related terms in your data
- Support dynamic enum validation for flexible controlled vocabularies

**When to use this:**
- You're working with ontology terms (GO, HP, MONDO, etc.)
- You're handling gene identifiers, chemical compounds, or other standardized entities
- You need to validate that AI-generated annotations use real, correctly-labeled terms

### 2. Reference Validation (Quote + Citation Checking)

A complementary approach validates that text excerpts or quotes in your data actually appear in their cited sources. This prevents AI from inventing supporting text or misattributing quotes to publications.

**Core principles:**
- Fetch the actual publication content from authoritative sources
- Perform deterministic substring matching (not fuzzy matching)
- Support legitimate editorial conventions (bracketed clarifications, ellipses)
- Reject any text that can't be verified in the source

**When to use this:**
- Your curation workflow includes extracting text from publications
- You're building datasets with quoted material and citations
- AI systems are summarizing or extracting information from papers
- You need to verify that supporting text for annotations comes from real sources

### Why Both Matter

These validation approaches protect against different types of hallucinations:
- **Term validation** prevents fabricated identifiers and misapplied terms
- **Reference validation** prevents fabricated quotes and misattributed text

For comprehensive AI guardrails, you often need both. For example, when curating gene-disease associations, you might validate:
1. That the gene IDs and disease term IDs are real and correctly labeled
2. That the supporting text cited from a paper actually appears in that paper

### Useful APIs for Validation

- **OLS (Ontology Lookup Service)**: EBI's comprehensive API for biomedical ontologies
- **OAK (Ontology Access Kit)**: Python library that can work with multiple ontology sources
- **PubMed APIs**: For validating PMIDs and retrieving titles
- **PMC (PubMed Central)**: For accessing full-text content to validate excerpts
- **Individual ontology APIs**: Many ontologies have their own REST APIs

### Implementation Notes

- **Cache responses** to avoid hitting APIs repeatedly for the same IDs or references
- **Handle network failures** gracefully - you don't want validation failures to break your workflow
- **Consider performance** - real-time validation can slow things down, so you might need to batch or background the checks
- **Plan for errors** - decide how to handle cases where validation fails (reject, flag for review, etc.)
- **Use deterministic validation** - avoid fuzzy matching that might accept AI-generated approximations

## Beyond Basic Ontologies

This pattern works for other identifier types too:

### Gene Identifiers
```yaml
gene:
  hgnc_id: HGNC:1100
  symbol: BRCA1
```

### Chemical Compounds
```yaml
compound:
  chebi_id: CHEBI:15377
  name: water
```

The key is always: require multiple pieces of information that have to be consistent with each other, and validate against authoritative sources.

## Making It Work in Practice

The validation needs to happen at the right time in your workflow:

- **During AI generation**: Have the AI system check its own outputs
- **Before committing**: Run validation as part of your review process  
- **In your tools**: Build validation into your curation interfaces
- **As a safety net**: Run periodic checks on your existing data

## Limitations

This isn't a perfect solution. The pattern works well for well-structured domains with good APIs, but it's harder to apply when:

- Authoritative sources don't have good APIs
- Identifiers are less standardized
- You're working with very new or rapidly changing data

But for most scientific curation workflows involving ontologies, genes, and publications, this straightforward approach can significantly reduce the number of hallucinated identifiers that slip through.

## Getting Started

1. **Pick one identifier type** that's important for your workflow
2. **Find the authoritative API** for that type
3. **Modify your prompts** to require both ID and label
4. **Build simple validation** that checks both pieces
5. **Expand gradually** to other identifier types

The key is to start simple and build up. You don't need a comprehensive system from day one - even basic validation on your most critical identifier types can make a big difference.

## Implementation Tools

The concepts described in this guide are implemented in several practical tools:

### LinkML Validator Plugins

The [LinkML](https://linkml.io) ecosystem provides validator plugins specifically designed for these hallucination prevention patterns:

#### linkml-term-validator

Validates ontology terms in LinkML schemas and datasets using the dual verification approach (ID + label checking):

- **Schema validation**: Verifies `meaning` fields in enum definitions reference real ontology terms
- **Dynamic enum validation**: Checks data against constraints like `reachable_from`, `matches`, and `concepts`
- **Binding validation**: Enforces constraints on nested object fields
- **Multi-level caching**: Speeds up validation with in-memory and file-based caching
- **Ontology Access Kit integration**: Works with multiple ontology sources through OAK adapters

**Learn more:** [linkml-term-validator documentation](https://linkml.io/linkml-term-validator/)

#### linkml-reference-validator

Validates that text excerpts match their source publications using deterministic verification:

- **Deterministic substring matching**: No fuzzy matching or AI approximations
- **Editorial convention support**: Handles bracketed clarifications and ellipses
- **PubMed/PMC integration**: Fetches actual publication content for verification
- **Smart caching**: Minimizes API requests with local caching
- **Multiple interfaces**: Command-line tool, Python API, and LinkML schema integration
- **OBO format support**: Can validate supporting text annotations in OBO ontology files

**Learn more:** [linkml-reference-validator documentation](https://linkml.io/linkml-reference-validator/)

### Using These Tools Together

For comprehensive AI guardrails, you can combine both validators in your workflow:

1. Use **linkml-term-validator** to ensure all ontology terms, gene IDs, and other identifiers are real and correctly labeled
2. Use **linkml-reference-validator** to verify that supporting text and quotes actually appear in their cited sources
3. Integrate both into your CI/CD pipeline to catch hallucinations before they enter your knowledge base

### Example: Validating OBO Ontology Files

If you're working with OBO format ontologies that include supporting text annotations, you can use regex-based validation:

```bash
linkml-reference-validator validate text-file my-ontology.obo \
  --regex 'ex:supporting_text="([^"]*)\[(\S+:\S+)\]"' \
  --cache-dir ./cache
```

This validates that supporting text annotations actually appear in their referenced publications.

**Learn more:** [Validating OBO files guide](https://linkml.io/linkml-reference-validator/how-to/validate-obo-files/)

### Getting Started with LinkML Validators

Both tools are available as Python packages and can be installed via pip:

```bash
pip install linkml-term-validator
pip install linkml-reference-validator
```

They work as both command-line tools and Python libraries, so you can integrate them into your existing workflows however makes sense for your use case.