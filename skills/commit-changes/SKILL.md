---
name: commit-changes
description: "Use when the user wants the agent to create a Git commit for the current task, including requests like commit this, run git commit, commit relevant files, or the older shorthand ggm-p. Selects relevant files, checks likely privacy leakage, creates the commit, and never pushes."
---

# Commit Changes

## Goal

Create one focused git commit for the current task. Generate a Conventional Commit message, stage only relevant files, run a privacy check, and commit only when the selected files are safe to commit.

Never run `git push` from this skill.

## Workflow

1. Read `git status --short --branch`.
2. Inspect staged diff first. If nothing is staged, inspect unstaged changes.
3. Identify the files that belong to the latest user-requested task.
4. Exclude unrelated dirty files, generated noise, local scratch files, and files outside the task scope.
5. Draft a Conventional Commit message from the selected diff.
6. Check the selected files and selected diff for likely privacy leakage.
7. If the check passes, stage only selected files and run `git commit`.
8. Report the message and a brief commit result.

If no relevant changes exist, stop and say there is nothing to commit.

## File Selection Rules

- Do not use `git add .` unless every dirty file is confirmed relevant.
- Prefer explicit path staging, for example `git add -- path/to/file`.
- Preserve user or agent work that is unrelated to the current task.
- If staged files already exist, treat them as the user's intended commit set unless the conversation clearly narrows the scope.
- If staged files include unrelated or suspicious content, stop and explain the mismatch before committing.

## Privacy Check

Before committing, inspect the selected files for likely leakage:

- API keys, tokens, passwords, private keys, credentials, or session cookies
- personal email addresses, phone numbers, or profile data
- local absolute paths, machine names, private URLs, internal hostnames
- pasted secrets in docs, examples, fixtures, or logs

If likely leakage is found:

- do not commit
- name the suspicious file or files
- briefly state that the commit was skipped

If no likely leakage is found, do not mention the privacy check.

## Commit Message Rules

- Use Conventional Commit format.
- Default to one subject line under 72 characters when practical.
- Add a body only when the change is multi-part, risky, or non-obvious.
- Use imperative wording: `add`, `fix`, `refactor`, `remove`, `rename`, `update`.
- Keep type and optional scope lowercase.
- Match the dominant language in the last 3 user messages; fall back to broader recent conversation, then English.
- Keep Conventional Commit type and scope in standard form even for Chinese messages.

Common types:

- `feat:` new user-facing behavior or capability
- `fix:` bug fix, validation, guard, retry, or regression repair
- `refactor:` structural change with preserved behavior
- `perf:` measurable performance work
- `test:` test-only changes
- `docs:` documentation-only changes
- `build:` build tooling or dependency changes used by builds
- `ci:` CI workflows
- `chore:` maintenance that fits nowhere better

Add a scope only when it is obvious and useful.

## Commit Execution

- Stage only selected paths with `git add -- <paths>`.
- For a subject-only message, run `git commit -m "<subject>"`.
- For a message with a body, use multiple `-m` arguments or a temporary message file.
- Do not amend, rebase, tag, or push unless the user explicitly asks outside this skill.

## Output

On success, output only:

1. the final commit message
2. one brief sentence confirming that the commit was created for the relevant files

If skipped, output only:

1. the proposed commit message when one was drafted
2. the concise reason the commit was skipped
