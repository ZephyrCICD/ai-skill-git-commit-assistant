# Update Guide

## Claude Code

```bash
claude plugin update git-commit-message
```

If you want to refresh the marketplace metadata too:

```bash
claude plugin marketplace update git-skills
```

## Codex

```bash
codex plugin marketplace upgrade git-skills
codex plugin add git-commit-message@git-skills
```

Start a new Codex thread after reinstalling so the refreshed skills are loaded.

## OpenCode

```bash
cd ~/.config/opencode/git-commit-message
git pull
```

Your existing link in `~/.config/opencode/skills/git-commit-message` continues to work.

## Gemini CLI

```bash
cd ~/.gemini/git-commit-message
git pull
```
