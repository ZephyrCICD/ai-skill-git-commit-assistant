---
name: ggm
description: "Use when the user wants a Git commit message for the latest task in the current conversation, based on the current repository diff or staged changes, especially when they want concise Conventional Commit output such as feat:, fix:, refactor:, or scoped forms like feat(ship):"
---

# GGM

## Overview

Generate a commit message from the latest conversation goal and the actual git changes in the current repo. Prefer Conventional Commits and return only the final commit message with no explanation.

## Workflow

1. Identify the latest user-requested task in the current conversation.
2. Inspect the current repository state, prioritizing staged changes and then unstaged diff if needed.
3. Infer the dominant change type from the code changes, not from vague intent alone.
4. Output the best commit message and nothing else.

If conversation intent and diff disagree, trust the diff.

## Message Rules

- Return only the commit message text.
- Do not add backticks, quotes, bullets, labels, or commentary.
- Default to a single-line subject.
- Upgrade to `subject + blank line + body` only when the change is clearly multi-part, risky, or non-obvious.
- Keep the subject concise, concrete, and ideally under 72 characters.
- Use imperative, repository-style wording such as `add`, `fix`, `refactor`, `remove`, `rename`, `update`.
- Do not end the subject with punctuation.
- Use lowercase type and scope.
- Detect the dominant language used in the last 3 user messages and write the final commit message in that language.
- If those 3 user messages are mixed, too short, or unclear, fall back to the broader recent conversation.
- If the language signal is still unclear after fallback, default to English.
- Language signal priority: last 3 user messages > broader recent conversation > English fallback.
- When writing Chinese commit messages, keep the Conventional Commit type and optional scope in their standard repository form such as `feat:` or `fix(auth):`, and localize only the subject/body text as needed.

## Type Selection

Choose the closest Conventional Commit type:

- `feat:` new user-facing behavior or new capability
- `fix:` bug fix or behavior correction
- `refactor:` internal restructuring without intended behavior change
- `perf:` measurable performance improvement
- `test:` adding or improving tests
- `docs:` documentation-only changes
- `build:` build tooling, packaging, dependencies used by builds
- `ci:` CI workflow or automation pipeline changes
- `chore:` maintenance, cleanup, or changes that do not fit better elsewhere

When unsure between `refactor:` and `chore:`, use `refactor:` for meaningful code reshaping and `chore:` for housekeeping.

## Scope Rules

Add scope only when the changed area is obvious and useful:

- `feat(ship): add bulk shipment retry support`
- `fix(auth): handle expired refresh tokens`
- `refactor(api): extract order validation helper`

Omit scope when the change is broad, cross-cutting, or the scope would be guessy.

## Signal Priority

Rank evidence in this order:

1. Staged diff
2. Unstaged diff
3. File names and changed modules
4. Latest conversation request
5. Recent commit style in the repository if easy to observe

Prefer the dominant change. Do not enumerate every touched file in the subject.

## Subject vs Body

Use subject only for:

- one clear feature
- one clear fix
- straightforward refactor
- simple docs, test, or chore changes

Add a body only when needed to preserve important context, such as:

- mixed but tightly related changes
- migrations, breaking edges, or rollback-sensitive work
- hidden intent that is not obvious from the subject

Body rules:

- one blank line after the subject
- short bullet-free lines
- explain why or the major grouped changes
- keep it brief

## Heuristics

- New endpoints, UI flows, commands, or user-visible options usually mean `feat:`
- Correctness fixes, guards, null handling, retries, validation fixes, and regression repairs usually mean `fix:`
- File moves, extraction, renames, dead-code removal, and structural cleanup with preserved behavior usually mean `refactor:`
- Dependency bumps alone usually mean `build:` or `chore:`
- Formatting-only changes usually mean `chore:`

## Conversation Language Handling

- Read Chinese or English task descriptions, code comments, and conversation context normally.
- Infer the engineering intent first, then express it in the dominant language used by the last 3 user messages.
- If those 3 user messages do not provide a clear signal, fall back to the broader recent conversation.
- Apply the language signal priority consistently: last 3 user messages > broader recent conversation > English fallback.
- Preserve product or domain terms that are already established in code, such as `ship`, `checkout`, `ledger`, or `auth`.
- If the last 3 user messages are mainly Chinese, prefer concise Chinese engineering phrasing in the subject/body text.
- If the last 3 user messages are mainly English, prefer natural engineering English rather than literal translation.
- If the last 3 user messages are mixed but clearly lean one way, follow that language.
- If the signal is ambiguous, default to English.

## Output Examples

`feat(ship): add batch label sync`

`fix(auth): 修复刷新 token 死循环`

`fix(payments): prevent duplicate webhook capture`

`refactor(search): extract query normalization`

`chore: clean up unused feature flags`

`feat(checkout): add retry handling for address sync

Retry the external sync when the provider returns a transient failure
Keep the checkout flow responsive by falling back to cached address data`

## Final Check

Before answering, ensure:

- the type matches the actual diff
- the scope is useful, not invented
- the subject is specific and short
- the output contains nothing except the commit message
