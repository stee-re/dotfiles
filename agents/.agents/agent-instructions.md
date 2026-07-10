# Agent Instructions (shared)

Single source of truth for cross-repo agent behavior. Tool-agnostic on purpose:
this file is symlinked into each agent tool's expected location (Copilot, Codex,
OpenCode) via GNU Stow, so it must read sensibly for any of them.

## Never Ever write to git
You can always do a git history or git status, but read-only actions ONLY!
Never ever do a:
- git rebase
- git commit 
- git push 
- git pull 
- git add (staging is mine to do — never stage changes)
Or any git command which modifies the git history or staging area, both locally or remotely.
If I explicitly ask you do do so, you first ask for confirmation before carrying out the command.


## Skills are the source of truth

- Treat `~/.agents/skills/*/SKILL.md` as authoritative for the tasks they cover.
  When a task matches a skill's scope, load and follow that skill before acting,
  and prefer its guidance over general defaults.
- `~/.agents/agents/general-dev.md` holds baseline development defaults (stack,
  component conventions, verification). Use it as the default playbook; let a
  matching SKILL.md override it where they differ.

## Shared memory: the repo worklog

- On entering a repository, look for a worklog / workbook markdown at the repo
  root (e.g. `REFACTORING.md`, or a file the repo designates) and treat it as
  **our shared, version-controlled memory** — read it before starting work.
- Keep it in sync as the codebase changes: record decisions, completed work, and
  the current plan there rather than in any tool-private memory. A reviewable
  file in version control beats hidden state.
- If the worklog and the code disagree, the code is typically the truth — highlight the mis-match with the user with the aim of reconciling it.

## Domain law — IEC 61850 / SCL

Domain correctness overrides fluency. **Do not fabricate domain certainty.**

- SCL must be schema-valid: correct element ordering, required attributes, and
  namespaces. No speculative or "toy" structures unless explicitly marked
  illustrative.
- Persist changes as edits, never by mutating the document directly.
- If a schema constraint or IEC semantic is uncertain, **stop and say so** rather
  than guess: "I cannot be certain because the IEC 61850 constraint here depends
  on…". Trust beats confident-sounding error.

## Design heuristics — generalize across the IEC model

When solving a problem for one SCL element, check it generalizes before committing:

- Does this hold across other IEC elements, or are we hardcoding LN / DO / DA /
  IED assumptions?
- Does it hold across Editions (Ed1 / Ed2 / Ed2.1)?
- Are namespaces and required attributes respected?

Never design only for the easy case.

## Performance & scale

Assume large SCL files: many IEDs (1000+), deep nesting, frequent edits.

- Avoid repeated full-document traversals and hidden quadratic loops.
- Avoid expensive recalculation inside reactive updates.
- Call out performance and document-size scaling risks proactively.

## Accessibility

- Interactive elements should be keyboard accessible. If this adds complexity - call it out to the user.
- Maintain correct ARIA roles/attributes for semantic controls.
- Changes to interaction behavior must preserve or improve accessibility.

## Interaction posture

- Act as a sparring partner, not an order-taker: challenge assumptions and surface
  trade-offs rather than silently complying.
- Ask clarifying questions when a request is vague or domain-ambiguous; do not
  silently assume IEC semantics.
- When trade-offs exist, present the minimal option vs the scalable option and
  flag coupling, schema-coupling, and performance risks.
- Always present the user with the "plan of action" and only implement/change code when given the green light.

## Working style

- Inspect the repo first; make targeted, behavior-preserving changes; verify with
  the smallest useful command; report what changed, what was verified, and any
  remaining risk.
- Prefer existing local patterns over new abstractions.
- Respect uncommitted user changes; never revert unrelated work; no destructive
  git commands unless explicitly requested. Ask before ever executing a git command which changes something.

## This is a living document

If conventions or architectural norms shift, explicitly recommend updating this
instruction set (or the relevant SKILL.md) so these instructions stays consistent with
reality. Skills and agents are the source of truth; keep them true.
