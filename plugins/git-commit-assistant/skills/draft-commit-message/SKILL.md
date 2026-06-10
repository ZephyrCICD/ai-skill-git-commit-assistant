---
name: draft-commit-message
description: "Use when the user wants a Git commit message for the current repository changes, including requests like commit message, conventional commit, what should I commit this as, or the older shorthand ggm. Produces message text only and does not stage, commit, or push."
---

# Draft Commit Message

## Goal

Draft the best commit message for the current change. Use the real git diff as the source of truth and return only the message text.

## Workflow

1. Identify the latest user task from the conversation.
2. Inspect repository state:
   - prefer staged diff
   - use unstaged diff when nothing is staged
   - check file paths and nearby history only when the diff is ambiguous
3. Infer the dominant change type from the code or docs that changed.
4. Write one Conventional Commit message.

If the conversation and diff disagree, trust the diff.

## Message Shape

- Return the commit message only.
- Do not add labels, backticks, quotes, bullets, or explanation.
- Default to one subject line under 72 characters when practical.
- Add a body only when the change is multi-part, risky, or non-obvious.
- Use imperative wording: `add`, `fix`, `refactor`, `remove`, `rename`, `update`.
- Do not end the subject with punctuation.
- Keep Conventional Commit type and optional scope lowercase.

## Type Selection

- `feat:` for new user-facing behavior or capability
- `fix:` for bug fixes, guards, validation, retries, regressions, or correctness repairs
- `refactor:` for structural changes with preserved behavior
- `perf:` for measurable performance work
- `test:` for test-only changes
- `docs:` for documentation-only changes
- `build:` for build tooling or dependency changes used by builds
- `ci:` for CI workflows
- `chore:` for maintenance that fits nowhere better

Prefer `refactor:` over `chore:` when the code shape meaningfully changes.

## Scope

Add a scope only when it is obvious and useful:

- `feat(auth): add passkey enrollment`
- `fix(api): handle empty pagination cursors`
- `refactor(search): extract query normalization`

Omit scope for broad or cross-cutting changes.

## Language

- Match the dominant language in the last 3 user messages.
- If that signal is unclear, use the broader recent conversation.
- If still unclear, use English.
- Keep Conventional Commit type and scope in standard form even for Chinese messages, for example `fix(auth): 修复刷新 token 死循环`.
- Preserve established product, module, and domain terms from the code.

## Examples

```text
feat(ship): add batch label sync
fix(auth): 修复刷新 token 死循环
refactor(search): extract query normalization
chore: clean up unused feature flags
```

Use a body only when needed:

```text
feat(checkout): add retry handling for address sync

Retry transient provider failures during address sync
Fall back to cached address data to keep checkout responsive
```

## Final Check

Before answering, verify that:

- the message matches the actual diff
- the type and scope are not invented
- the subject is specific and concise
- the answer contains only the commit message
