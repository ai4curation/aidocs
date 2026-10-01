# How agents changed software development

This page is about software, because software is where agents arrived first
and where the evidence is best. What happened to developers in 2026 is a
reasonable preview of what is happening to curators. The companion page,
[How agents change curation](curation-work.md), applies it to curation.

We use only evidence published in 2026. Earlier studies measured tools that no
longer exist in the same form.

## The short version

* The change is real and fast, but it is not uniform. Gains depend on the task,
  the codebase, and the team.
* Writing code is now cheap. Shipping correct, maintainable software is not.
  The bottleneck has moved to specification, review, and integration.
* There are still software developers. They spend more of their time deciding
  what to build, how the pieces fit together, and whether the agent's output is
  right, and they spend part of it managing several agents at once.
* Agent capability is uneven in ways that are hard to predict. That is the
  *jagged frontier*, and it is the main reason humans stay in the loop.
* So treat different parts of a system differently. Craft the core. Generate
  the periphery.

## Writing code got cheap; shipping it did not

The largest study so far followed more than 500,000 GitHub developers through
successive generations of AI tools. Autonomous agents raised commits by 240%.
That gain fell to 80% in the number of projects, and to 30% in actual releases
([Demirer, Musolff and Yang, NBER, 2026](https://www.nber.org/papers/w35275)).
In app marketplaces the authors saw "a sharp increase in the number of new apps
but no increase in total usage."

A single company that mandated a doubling of developer output got it: 2.09
times the baseline throughput by April 2026, across 802 developers. The cost
moved to review. Each reviewer's load roughly doubled, and automated review
overtook human review. Merge and revert rates held steady
([He et al., 2026](https://arxiv.org/abs/2607.01904), titled *AI Writes Faster
Than Humans Can Review*).

The lesson is that the gain is real, and it is captured only if the steps after
writing (review, testing, release) can absorb it.

## Felt speed and measured speed differ

METR has run the best-known controlled studies of developer productivity. In
February 2026 it reported that its latest experiment could no longer measure
the effect cleanly. Between 30% and 50% of developers would not submit tasks
they "did not want to do … without AI", and timing broke down for developers
running several agents at once
([METR, February 2026](https://metr.org/blog/2026-02-24-uplift-update/)). METR
believes the real speedup is larger than its measured numbers, but it cannot yet
say by how much.

Self-reports run much higher. Surveyed technical workers reported a median 3x
speedup in early 2026. METR's own caution is that "survey results are not
necessarily grounded in reality"
([METR, May 2026](https://metr.org/blog/2026-05-11-ai-usage-survey/)). A
transcript analysis of METR's own staff put the upper bound between 1.5x and
13x, and the highest figure came from the person running two to three agents in
parallel ([METR, February 2026](https://metr.org/notes/2026-02-17-exploratory-transcript-analysis-for-estimating-time-savings-from-coding-agents/)).

Speed on a task is also not value. When work gets cheap, people do more of it,
including work that was not worth doing before. "An arbitrarily high speedup on
observed tasks is consistent with an arbitrarily small uplift in value"
([Cunningham and Whitfill, METR, 2026](https://metr.org/blog/2026-05-08-task-substitution-and-uplift/)).

For a project, this means: count what ships and is used, not what is produced.

## The jagged frontier

The phrase comes from an experiment with 758 BCG consultants, first circulated
in 2023 and published in 2026
([Dell'Acqua et al., *Organization Science*](https://www.hbs.edu/ris/Publication%20Files/dell-acqua-et-al-2026-navigating-the-jagged-technological-frontier_5c589c8c-fbb5-458f-b285-c944746cd717.pdf)).
On tasks inside the AI's frontier, consultants with AI finished 12% more tasks,
25% faster, at higher quality. On a task just outside it, they were 19
percentage points less likely to get the right answer than consultants without
AI. The boundary was invisible to the people using it. In 2026 the frontier has moved a long way, and it is still
jagged.

**Passing tests is not the same as being right.** METR had maintainers of
scikit-learn, Sphinx, and pytest review 296 agent-written pull requests that
passed the SWE-bench tests. Maintainers would have merged about 24 percentage
points fewer of them than the automated grader passed, rejecting them for core
functionality, breaking other code, and code quality
([METR, March 2026](https://metr.org/notes/2026-03-10-many-swe-bench-passing-prs-would-not-be-merged-into-main/)).

**Long tasks are possible; reliable long tasks are not, yet.** METR measures
an agent's *time horizon*: the length of task, timed by skilled humans, that the
agent completes with a given success rate. The method is set out in
[Kwa et al., *Measuring AI Ability to Complete Long Software Tasks*](https://arxiv.org/abs/2503.14499)
(METR, 2025), which found the horizon doubling about every seven months since
2019. The paper is pre-2026, but it is the reference for what the numbers mean
and where they stop applying. With newer models the doubling has sped up to
roughly every three to four months
([METR, January 2026](https://metr.org/blog/2026-1-29-time-horizon-1-1/)).
For the strongest model on its
[current chart](https://metr.org/time-horizons/), the task length completed half
the time is around 17 hours, but the length completed 80% of the time is around
three. METR also notes that horizons differ "between domains by orders of
magnitude", and that "some (reliability-critical and poorly verifiable) tasks
require 98%+ success probabilities to be worth automating"
([METR, January 2026](https://metr.org/notes/2026-01-22-time-horizon-limitations/)).

**Usage data shows the same shape.** Anthropic's usage data shows success falling
from about 60% on tasks under an hour to about 45% on tasks of five hours or
more: "more complex tasks yield greater time savings, but this trades off
against reliability"
([Anthropic Economic Index, January 2026](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report)).
The 2026 AI Index gives the vivid version: models that win a gold medal at the
International Mathematical Olympiad "cannot reliably tell time"
([Stanford HAI, 2026](https://hai.stanford.edu/news/inside-the-ai-index-12-takeaways-from-the-2026-report)).

Two practical consequences:

1. **You cannot predict a failure from how hard a task looks.** An agent that
   writes a correct ontology reasoner wrapper can still get a date format
   wrong. Check
   by risk, not by apparent difficulty.
2. **Where the edge sits moves every few months.** Something an agent could not
   do in the spring may be routine by the autumn. Re-test your assumptions; do
   not carry last year's limits forward as policy.

## No one size fits all: craft the core, generate the periphery

The quality evidence is consistent. When open-source projects adopt coding
agents, static-analysis warnings rise by about 18% and code complexity by about
39%, and the extra complexity persists
([Agarwal, He and Vasilescu, 2026](https://arxiv.org/abs/2601.13597)). Whole
projects generated in an AI editor were 91% functionally correct and carried
thousands of design issues; the authors conclude they need "experienced
developer review before production use"
([Kashif et al., 2026](https://arxiv.org/abs/2604.06373)). A 2026 review of the
vibe-coding literature sums it up: "gains are real on new code and shrink or
reverse on mature codebases"
([Michels et al., 2026](https://arxiv.org/abs/2608.20446)).

This does not mean agent-written code is bad. One study found AI-written files
needed *less* frequent maintenance than human-written files, mostly feature
extensions rather than bug fixes
([Sawada et al., 2026](https://arxiv.org/abs/2605.06464)). It means the cost of
a design mistake depends on how much else depends on it.

So we sort components by how much rests on them:

| Kind of component | Examples in GO | How to build it |
| --- | --- | --- |
| **Core**: data models, identifiers, validators, anything other code and data depend on | LinkML schemas, GO-CAM model and its validation, ontology build, term and reference validators, the Noctua API | Human-designed interfaces and boundaries. Agents write code within them; people review every change; tests and validators are the contract. |
| **Middle**: pipelines, integrations, command-line tools | Report generators, ingest scripts, skill helper scripts | Agents write most of it against a clear spec. Review the interfaces and the tests closely, the internals lightly. |
| **Periphery**: things a person looks at and can throw away | Dashboards, one-off analyses, QC reports, internal UIs, editor front ends | Generate it. Check that it shows the right thing. Regenerate rather than maintain. |

Modularity is what makes this work. A dashboard can be vibe coded safely
because it reads from a well-defined API and cannot corrupt what lies behind it.
If the boundary is unclear, the periphery leaks into the core.

Two cautions. First, "periphery" is about consequences, not about the kind of
code. Anything exposed to the web is a security surface: a 2026 vendor
benchmark found models produce secure code about 55% of the time, the same rate
as two years earlier, even though nearly all of it now compiles
([Veracode, March 2026](https://www.veracode.com/blog/spring-2026-genai-code-security/)).
Second, write down the project's conventions where the agent will read them. In
441 repositories, those that committed agent configuration files (`CLAUDE.md`,
`AGENTS.md`) saw roughly half the complexity increase of those that did not
([Denisov-Blanch et al., 2026](https://arxiv.org/abs/2608.25241)). See
[One source of instructions](../patterns/one-source-of-instructions.md).

## How roles change

### There are still developers, but fewer junior ones

US software job postings rose nearly 15% after agentic coding tools became
widespread, while overall postings fell. 71% of the increase was in senior roles
([Indeed Hiring Lab, July 2026](https://hiringlab.indeed.com/2026/07/08/ai-and-job-postings-from-destruction-to-creation/)).
At the same time, employment among software developers aged 22 to 25 has fallen
nearly 20% since 2024
([Stanford HAI, 2026](https://hai.stanford.edu/news/inside-the-ai-index-12-takeaways-from-the-2026-report)),
mostly through less hiring rather than layoffs
([Stanford Digital Economy Lab, August 2026](https://digitaleconomy.stanford.edu/news/canariesaug26/)).

The demand is for people who can judge whether software is right. That is a
problem for how anyone becomes such a person, and curation has the same
problem.

### The job moves up a level

What developers do with agents, in rough order of how much time it now takes:

* **Specify.** Say what to build, with enough context that the agent does not
  guess. This is the work `CLAUDE.md` files and skills capture.
* **Review.** Decide whether the output is right. This is now the bottleneck
  (see above).
* **Design the boundaries.** Decide what the modules are and what each may
  depend on, so agents can work inside them.
* **Orchestrate.** Run several agents on separate tasks and switch between
  them. Telemetry from OpenAI's Codex shows more than 10% of users managing
  several concurrent agents each week, and requests for tasks of eight hours or
  more growing nearly tenfold in the first half of 2026
  ([Johnston et al., 2026](https://arxiv.org/abs/2606.26959); authors include
  OpenAI staff).
* **Write code by hand.** Still happens, mostly for the core and for debugging.

This is management work. Developers are now doing a version of what team
leads always did: delegate, check, integrate. As one slide put it at the
Biocuration 2026 workshop on AI: "Humans are programming less / But we still need
to engineer systems / Software engineers increasingly think of themselves as
agent managers"
([Mungall, *Staying in the Loop*, February 2026](https://zenodo.org/records/18614836)).

### Supervision is tiring, and it has a limit

A study of 1,488 US workers found that overseeing AI is the most mentally
taxing part of using it. 14% reported what the authors call "AI brain fry".
Heavy oversight meant 14% more mental effort and 19% more information overload,
and those affected reported more major errors. Productivity rose with up to
three AI tools and dipped after that
([Bedard et al., Harvard Business Review, March 2026](https://hbr.org/2026/03/when-using-ai-leads-to-brain-fry)).

Researchers studying developers who run agents in parallel describe five
supervisory practices: planning, isolating, logging, observing, and triaging
([Long et al., 2026](https://arxiv.org/abs/2609.33113)). They are the same
practices any manager uses, applied to agents.

### Skills can atrophy

In a randomised trial, junior developers learning a new library with AI help
scored 17% lower on a comprehension quiz than those who learned without it,
with the largest gap on debugging. Those who used the AI to ask conceptual
questions, rather than to write the code, did as well as the no-AI group
([Shen and Tamkin, Anthropic, January 2026](https://www.anthropic.com/research/AI-assistance-coding-skills)).
How you use the agent determines whether you learn.

## How processes change

**Review has to be designed, not assumed.** Most agent-written pull requests in
open source get no human review at all, and when they are reviewed, the
reviewers are mostly other agents
([Duma et al., 2026](https://arxiv.org/abs/2605.02273)). Whether quality holds
depends on how the team structures review
([Agarwal et al., 2026](https://arxiv.org/abs/2607.07980)).

**AI review helps, and it is noisy.** Developers accepted 36% of one AI
reviewer's comments and rejected 56%, mostly as false positives or out of scope
([2026 study of CodeRabbit reviews](https://arxiv.org/abs/2607.03316)). Human
reviewers raise things agents do not, about understanding, testing, and
knowledge transfer
([Zhong et al., 2026](https://arxiv.org/abs/2603.15911)). Use AI review as a
first pass that a human reads, not as a replacement for one. See
[One review checklist](../patterns/review-checklists.md).

**Verification is the line between core and casual contributors.** In 9,427
agent pull requests, occasional contributors were more likely to merge without
passing CI; core developers required it
([Cynthia, Das and Roy, 2026](https://arxiv.org/abs/2601.20106)). Make the check
mandatory and nobody has to remember. See
[Fast and slow validation](../patterns/fast-and-slow-validation.md).

## What we do in practice

These habits follow from the evidence above and from the repositories in our
[case studies](../case-studies/index.md). They are a starting point for
discussion, not a standard.

**Before delegating, ask three questions.**

1. What depends on this? (Core, middle, or periphery, from the table above.)
2. How will I know it is right? If you cannot say, write the test or the
   validator first, or do not delegate.
3. Is the agent likely to be good at this? You will not know from difficulty.
   Try it on one example and look.

**Managing several agents.**

* Keep to a number you can actually review. For most people that is two or
  three at a time. Beyond that, work piles up unreviewed.
* Isolate each agent's work: its own branch, its own worktree or session.
* Give each one a written task (an issue) so you can return to it cold.
* Batch review. Switching between agents every few minutes is where the fatigue
  comes from.

**Reviewing agent work.**

* Read the tests and the interfaces first. If they are right, the internals
  matter less.
* Look hardest at what the agent did *not* say: skipped steps, silenced errors,
  fallbacks. The GO AI Hub workshop's worst failure was an agent that quietly
  filled in missing data after a tool failed. See
  [GO AI Hub](../case-studies/go-ai-hub.md).
* When you see the same mistake twice, fix the instructions or the skill, not
  the output. See [Regulate the loop](../patterns/human-regulating-the-loop.md).

**Keeping your own skills.**

* Debug by hand sometimes.
* Ask the agent to explain, not only to do.
* Pair juniors with the agent *and* a person.
