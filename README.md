# Git Commit Assistant

English | [简体中文](README.zh-CN.md)

A shareable AI skill repo for drafting Conventional Commit messages and creating focused git commits from conversation context and the current git diff.

Recommended install style: use the native marketplace flow when the tool supports it. Claude Code
and Codex use separate marketplace metadata in this repo; their marketplace registrations are not
shared automatically.

It ships two related skills:

- `draft-commit-message` - generate a concise commit message only
- `commit-changes` - select relevant files, check likely privacy leakage, and create a commit

## What These Skills Do

These skills help an AI agent combine:

- the latest task discussed in the conversation
- the actual staged or unstaged git changes in the repository
- Conventional Commit best practices
- optional scoped commit style such as `feat(ship): ...`

`commit-changes` adds an extra guarded flow:

- selects only files relevant to the current change
- checks selected files for likely personal privacy leakage before commit
- runs `git commit` automatically if no likely privacy issue is found
- skips commit and warns if likely privacy leakage is detected
- never runs `git push`

## Features

- Generates concise Conventional Commit messages such as `feat:`, `fix:`, `refactor:`, and `chore:`
- Adds scope when the changed domain is clear, such as `feat(ship): ...`
- Prefers the real git diff over vague conversational intent when they conflict
- Follows the dominant language used in the last 3 user messages when generating commit messages, with fallback to broader recent context
- Works with both Claude Code and Codex marketplace flows
- Keeps message-only and commit-assisted flows separate so the user's intent stays explicit

## Example Outputs

```text
feat(ship): add batch label sync
fix(auth): prevent refresh token loop
refactor(search): extract query normalization
chore: clean up unused feature flags
```

## Install

Installation differs by platform. Claude Code and Codex each use their own marketplace flow.
OpenCode is best installed by telling the agent to fetch platform-specific instructions. Gemini CLI
uses its native extension install flow.

### Claude Code

```bash
claude plugin marketplace add ZephyrCICD/ai-skill-git-commit-assistant
claude plugin install git-commit-assistant@git-skills
```

### Codex

Codex uses the `.agents/plugins/marketplace.json` marketplace and the plugin manifest under
`plugins/git-commit-assistant/.codex-plugin/plugin.json`. Add the marketplace, then install the
plugin:

```bash
codex plugin marketplace add ZephyrCICD/ai-skill-git-commit-assistant
codex plugin add git-commit-assistant@git-skills
```

Start a new Codex thread after installing so the bundled skills are available.

Detailed guide: `docs/install-codex.md`

### OpenCode

Tell OpenCode:

```text
Fetch and follow instructions from https://raw.githubusercontent.com/ZephyrCICD/ai-skill-git-commit-assistant/refs/heads/main/.opencode/INSTALL.md
```

Detailed guide: `docs/install-opencode.md`

### Gemini CLI

```bash
gemini extensions install https://github.com/ZephyrCICD/ai-skill-git-commit-assistant
```

To update:

```bash
gemini extensions update git-commit-assistant
```

Detailed guide: `docs/install-gemini-cli.md`

### Updating

See `docs/update.md`.

### Releases

Each published GitHub Release automatically generates release notes and attaches a `skills-<tag>.zip` archive containing the `skills/` directory.

### Tell Another AI To Install It

Use the file that matches the target CLI:

- Codex: `docs/tell-ai-codex.md`
- Claude Code: `docs/tell-ai-claude-code.md`
- OpenCode: `docs/tell-ai-opencode.md`
- Gemini CLI: `docs/tell-ai-gemini-cli.md`

Each file contains a single copy-ready prompt for that specific platform.

## Usage

```text
$draft-commit-message
```

```text
$commit-changes
```

When installed as a Codex plugin, Codex may show the skills with the plugin namespace:
`git-commit-assistant:draft-commit-message` and `git-commit-assistant:commit-changes`.

Previous versions exposed the shorter `ggm` and `ggm-p` names. Those names are still recognized in
the skill descriptions as legacy shorthands, but new installs should use the clearer names above.

## Repository Layout

```text
.
├── skills/draft-commit-message/   # generate commit message
├── skills/commit-changes/         # generate message and auto-commit
├── .agents/plugins/marketplace.json # Codex marketplace entry
├── plugins/git-commit-assistant/  # Codex plugin package
│   ├── .codex-plugin/plugin.json
│   └── skills/
├── .claude-plugin/plugin.json     # Claude Code plugin entry
├── .claude-plugin/marketplace.json
├── .codex/INSTALL.md              # Codex install instructions
├── docs/                          # platform-specific install guides
└── install.sh                     # local helper installer
```

## Choosing Between Them

Use `draft-commit-message` when you only want the commit message.

Use `commit-changes` when you want the model to:

- generate the message
- narrow the commit to relevant files
- check those selected files for likely privacy leakage
- run `git commit` automatically when the privacy check passes

## License

MIT. See `LICENSE`.
