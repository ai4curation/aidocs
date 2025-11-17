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

## You Need Tooling for This

This pattern only works if you have validation tools that can actually check the identifiers against authoritative sources. You need:

1. **Format validation**: Check that IDs follow the right patterns (GO:1234567, PMID:12345678, etc.)
2. **Existence validation**: Query authoritative APIs to verify IDs exist
3. **Label matching**: Compare provided labels against canonical ones
4. **Consistency checking**: Make sure everything matches up

## Two Key Validation Strategies

There are two complementary approaches to preventing hallucinations in AI-assisted curation:

### Validating Ontology Terms

When AI systems generate ontology terms, you need to verify that:

- The term IDs actually exist in the ontology
- The labels match the canonical labels in the source ontology
- Both the ID and label are consistent with each other

This **dual validation approach** (ID + label) makes it much harder for language models to fabricate plausible-looking but fake terms. The model would have to hallucinate both a valid ID and its correct label simultaneously, which is statistically unlikely.

The validation process typically involves:

1. **Schema validation**: Checking that data structures properly reference ontology terms
2. **Dynamic lookup**: Querying ontology sources in real-time to verify terms exist
3. **Multi-level caching**: Using in-memory and file-based caches to optimize performance
4. **Binding validation**: Ensuring nested object fields maintain structural integrity

### Validating Text Excerpts

When AI extracts or generates text excerpts that are supposed to come from published sources, you need to verify that the text actually appears in the cited publication. This prevents:

- Paraphrasing that changes the meaning
- Fabricated quotes attributed to real papers
- Misattributions where real text is assigned to wrong papers

This **deterministic matching approach** emphasizes exact textual correspondence rather than fuzzy or AI-based approximation. The key principles:

1. **Substring matching**: Look for exact matches between the excerpt and source material
2. **Editorial conventions**: Handle legitimate variations like bracketed clarifications `[...]` and ellipsis `...`
3. **Source fetching**: Retrieve publication content from authoritative APIs (PubMed/PMC)
4. **Local caching**: Store retrieved publications to minimize repeated API requests

This approach prioritizes accuracy and reproducibility over convenience, making it suitable for rigorous curation where precision matters.

### Useful APIs for Validation

- **OLS (Ontology Lookup Service)**: EBI's comprehensive API for biomedical ontologies
- **OAK (Ontology Access Kit)**: Python library that can work with multiple ontology sources
- **PubMed/PMC APIs**: For fetching publication content and validating excerpts
- **Individual ontology APIs**: Many ontologies have their own REST APIs

### Implementation Notes

- **Cache responses** to avoid hitting APIs repeatedly for the same IDs or publications
- **Handle network failures** gracefully - you don't want validation failures to break your workflow
- **Consider performance** - real-time validation can slow things down, so you might need to batch or background the checks
- **Plan for errors** - decide how to handle cases where validation fails (reject, flag for review, etc.)
- **Use deterministic methods** - prefer exact matching over probabilistic approaches for reproducibility

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

If you're working with LinkML schemas and data, there are ready-to-use validation plugins that implement these concepts:

### For Ontology Term Validation

The [**linkml-term-validator**](https://linkml.io/linkml-term-validator/) plugin validates that LinkML schemas and datasets properly reference external ontology terms. It implements the dual validation (ID + label) approach described above and works with multiple ontology sources through the Ontology Access Kit (OAK). It's particularly useful for preventing AI-generated hallucinations in automated curation workflows.

### For Text Excerpt Validation

The [**linkml-reference-validator**](https://linkml.io/linkml-reference-validator/) plugin validates that text excerpts in datasets accurately match their cited source publications. It fetches references from PubMed/PMC and performs deterministic substring matching to verify quotes. The validator also includes [guidance for validating OBO format files](https://linkml.io/linkml-reference-validator/how-to/validate-obo-files/), making it useful for ontology curation workflows.

Both tools integrate as plugins within LinkML's validation framework, support multi-level caching for performance, and can be used in CI/CD pipelines or programmatically in Python.