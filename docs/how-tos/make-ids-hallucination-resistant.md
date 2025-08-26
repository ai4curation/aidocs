# How to Make Identifiers Hallucination-Resistant

When you're using AI to help with knowledge curation, one of the biggest problems you'll run into is that language models love to make up identifiers that look real but aren't. They'll confidently generate fake gene IDs, ontology terms, or publication IDs that seem plausible but don't actually exist.

This is a serious problem because these fake identifiers can easily slip through into your knowledge base, undermining the whole point of careful curation.

## The Problem in Practice

Large language models frequently hallucinate identifiers like:

- **Ontology term IDs**: GO:0005515, HP:0001250, MONDO:0007739
- **Gene/protein identifiers**: HGNC:1234, UniProt:P12345
- **Publication IDs**: PMID:12345678, DOI:10.1000/fake.doi

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
  pmid: 15215856
  title: "The Gene Ontology (GO) database and informatics resource"

# Would catch mismatches like:
publication:
  pmid: 15215856  
  title: "Some other paper title"  # Wrong title for this PMID
```

## You Need Tooling for This

This pattern only works if you have validation tools that can actually check the identifiers against authoritative sources. You need:

1. **Format validation**: Check that IDs follow the right patterns (GO:1234567, PMID:12345678, etc.)
2. **Existence validation**: Query authoritative APIs to verify IDs exist
3. **Label matching**: Compare provided labels against canonical ones
4. **Consistency checking**: Make sure everything matches up

### Useful APIs for Validation

- **OLS (Ontology Lookup Service)**: EBI's comprehensive API for biomedical ontologies
- **OAK (Ontology Access Kit)**: Python library that can work with multiple ontology sources
- **PubMed APIs**: For validating PMIDs and retrieving titles
- **Individual ontology APIs**: Many ontologies have their own REST APIs

### Implementation Notes

- **Cache responses** to avoid hitting APIs repeatedly for the same IDs
- **Handle network failures** gracefully - you don't want validation failures to break your workflow
- **Consider performance** - real-time validation can slow things down, so you might need to batch or background the checks
- **Plan for errors** - decide how to handle cases where validation fails (reject, flag for review, etc.)

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