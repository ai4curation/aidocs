# One source of instructions

**Use it when** you have more than one agent instructions file.

Different agents read different files. Claude Code reads `CLAUDE.md`. Codex and
several others read `AGENTS.md`. GitHub Copilot reads
`.github/copilot-instructions.md`. The obvious response is to put the same text
in all of them, and then keep them in sync by hand.

That does not hold. In practice one file gets updated and the others do not, and
your agents start behaving differently for reasons nobody can see.

## The pattern

Pick one authoritative file. Make the others short pointers to it.

[EFO](../case-studies/efo.md) does this. Its `AGENTS.md` is about twenty lines,
and it says where the real instructions are:

> The authoritative curation workflow, routing, and domain rules live in
> **`.github/copilot-instructions.md`** (full guide) and **`CLAUDE.md`**
> (orchestration). Read the relevant one before making ontology changes.

The pointer file can still carry anything genuinely specific to that agent. EFO
uses `AGENTS.md` to tell Codex where its own read-only review procedure lives.

This site follows the same pattern: `AGENTS.md` holds the guidance and
`CLAUDE.md` points at it.

## What this replaces

As of August 2026, [GO](../case-studies/go-ontology.md),
[Mondo](../case-studies/mondo.md), and [Uberon](../case-studies/uberon.md) each
keep `CLAUDE.md` and `.github/copilot-instructions.md` with the same text in
both. Nothing cross-references anything. Every guidance change needs two edits.

[Cell Ontology](../case-studies/cell-ontology.md) avoids the problem by having
only one file.

## The same rule applies to subagents

EFO defines its specialists twice, once under `.claude/agents/` and once under
`.github/agents/`, with names that differ only in case. The two sets can drift
in the same way.

EFO has already solved this for review: the Claude, Copilot, and Codex reviewers
all read one checklist file. Apply that fix to specialists too. Generate the
copies from one source, or make one a pointer.

## How to do it today

1. Choose the file that has the best content. Make it authoritative.
2. Replace the others with a pointer of a few lines.
3. Keep only agent-specific notes in the pointer files.

This takes about ten minutes and removes a whole class of drift.
