# Update Guide

## Claude Code

```bash
claude plugin update git-commit-assistant
```

If you installed a pre-0.2.0 version, install the renamed plugin:

```bash
claude plugin install git-commit-assistant@git-skills
```

If you want to refresh the marketplace metadata too:

```bash
claude plugin marketplace update git-skills
```

## Codex

```bash
codex plugin marketplace upgrade git-skills
codex plugin add git-commit-assistant@git-skills
```

Start a new Codex thread after reinstalling so the refreshed skills are loaded.

If you installed a pre-0.2.0 version, reinstall with the new plugin name above. The old plugin name
was `git-commit-message`.

## OpenCode

```bash
cd ~/.config/opencode/git-commit-assistant
git pull
```

Your existing link in `~/.config/opencode/skills/git-commit-assistant` continues to work.

For pre-0.2.0 installs, either keep the old clone and update your skill references to
`draft-commit-message` and `commit-changes`, or move the clone and symlink to the new
`git-commit-assistant` path shown in `docs/install-opencode.md`.

## Gemini CLI

```bash
cd ~/.gemini/git-commit-assistant
git pull
```

For pre-0.2.0 installs, update `~/.gemini/GEMINI.md` to point at
`skills/draft-commit-message/SKILL.md` and `skills/commit-changes/SKILL.md`.
