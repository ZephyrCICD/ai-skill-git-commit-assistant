# Git Commit Message Skills

English | [简体中文](README.zh-CN.md)

A shareable AI skill repo for generating Git commit messages from conversation context and the current git diff.

Recommended install style: use the native marketplace flow when the tool supports it. Claude Code
and Codex use separate marketplace metadata in this repo; their marketplace registrations are not
shared automatically.

It ships two related skills:

- `ggm` - generate a concise commit message only
- `ggm-p` - generate a commit message, check the relevant files, and commit automatically when the privacy check passes

## What These Skills Do

These skills help an AI agent combine:

- the latest task discussed in the conversation
- the actual staged or unstaged git changes in the repository
- Conventional Commit best practices
- optional scoped commit style such as `feat(ship): ...`

`ggm-p` adds an extra guarded flow:

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
- Keeps `ggm` and `ggm-p` separate so message-only and commit-assisted flows stay explicit

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
claude plugin marketplace add zephyrcicd/ai-skill-git-commit-message
claude plugin install git-commit-message@git-skills
```

### Codex

Codex uses the `.agents/plugins/marketplace.json` marketplace and the plugin manifest under
`plugins/git-commit-message/.codex-plugin/plugin.json`. Add the marketplace, then install the
plugin:

```bash
codex plugin marketplace add zephyrcicd/ai-skill-git-commit-message
codex plugin add git-commit-message@git-skills
```

Start a new Codex thread after installing so the bundled skills are available.

Detailed guide: `docs/install-codex.md`

### OpenCode

Tell OpenCode:

```text
Fetch and follow instructions from https://raw.githubusercontent.com/zephyrcicd/ai-skill-git-commit-message/refs/heads/main/.opencode/INSTALL.md
```

Detailed guide: `docs/install-opencode.md`

### Gemini CLI

```bash
gemini extensions install https://github.com/zephyrcicd/ai-skill-git-commit-message
```

To update:

```bash
gemini extensions update git-commit-message
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
$ggm
```

```text
$ggm-p
```

When installed as a Codex plugin, Codex may show the skills with the plugin namespace:
`git-commit-message:ggm` and `git-commit-message:ggm-p`.

## Repository Layout

```text
.
├── skills/ggm/                    # generate commit message
├── skills/ggm-p/                  # generate message and auto-commit
├── .agents/plugins/marketplace.json # Codex marketplace entry
├── plugins/git-commit-message/    # Codex plugin package
│   ├── .codex-plugin/plugin.json
│   └── skills/
├── .claude-plugin/plugin.json     # Claude Code plugin entry
├── .claude-plugin/marketplace.json
├── .codex/INSTALL.md              # Codex install instructions
├── docs/                          # platform-specific install guides
└── install.sh                     # local helper installer
```

## Choosing Between Them

Use `ggm` when you only want the commit message.

Use `ggm-p` when you want the model to:

- generate the message
- narrow the commit to relevant files
- check those selected files for likely privacy leakage
- run `git commit` automatically when the privacy check passes

## License

MIT. See `LICENSE`.
