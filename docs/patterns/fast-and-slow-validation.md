# Fast and slow validation

**Use it when** full validation is too slow to run while curating.

Checking that quoted evidence appears in the cited papers is slow. It may fetch
full text. Ontology term checking can pull down large databases. If the only
validation command you have takes several minutes, agents stop running it, and
errors reach the pull request.

## The pattern

Provide two commands.

**A fast check for the curation loop.** It runs in seconds, uses the local
cache, and takes any number of files. Agents and curators run it constantly.

**A slow sweep before the pull request.** It runs everything, and it is the same
thing continuous integration runs. You run it once, at the end.

[DisMech](../case-studies/dismech.md) does exactly this:

```bash
# Fast: check evidence snippets against the local reference cache.
just count-verified-snippets kb/disorders/YourFile.yaml

# Slow: the batched schema, terms, and references sweep that CI runs.
just validate-disorders kb/disorders/YourFile.yaml
```

Its `CLAUDE.md` labels them, so the agent knows which one belongs in the loop
and which one belongs at the end.

## Cache the expensive things

The fast check only works if the reference text is already local. DisMech keeps
a reference cache and gives you one command to fill it:

```bash
just fetch-reference PMID:12345678
```

The instructions then say never to create a cache file by hand. That rule
matters: a hand-written cache file would let fabricated evidence pass the check
that exists to catch fabricated evidence.

## Watch out for large downloads

Ontology term checking backed by OAK downloads SQLite databases on demand. Some
are large: `ncbitaxon` is around 13.5 GB unpacked. In a cloud session or on a
metered connection, an interrupted download can kill a validation run.

Two things help:

* Make single-file validation trust the committed caches, and only query the
  ontology for terms that are not cached yet.
* Provide a command that fetches the databases deliberately, with resume and
  retry, so you can do it before you need it.

DisMech has `just fetch-ontology-dbs` for the second.

## Who does this

* [DisMech](../case-studies/dismech.md): `count-verified-snippets` and
  `validate-disorders`.
* [CommunityMech](../case-studies/communitymech.md) and the other CultureBot
  mechs use the same split, with `just validate` and `just validate-references`.
