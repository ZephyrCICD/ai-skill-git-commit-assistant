# Install for OpenCode

This guide follows the git-based install style used by Superpowers for OpenCode: clone the repo into your OpenCode config area, then symlink the skill folder so OpenCode can discover it natively.

## Prerequisites

- OpenCode installed
- Git installed

## Installation

### 1. Clone the repository

```bash
mkdir -p ~/.config/opencode
git clone https://github.com/ZephyrCICD/ai-skill-git-commit-assistant ~/.config/opencode/git-commit-assistant
```

### 2. Symlink the skills

```bash
mkdir -p ~/.config/opencode/skills
rm -rf ~/.config/opencode/skills/git-commit-assistant
ln -s ~/.config/opencode/git-commit-assistant/skills ~/.config/opencode/skills/git-commit-assistant
```

## Usage

Use OpenCode's native skill loading/discovery flow and load:

- `git-commit-assistant/draft-commit-message`
- `git-commit-assistant/commit-changes`

## Update

```bash
cd ~/.config/opencode/git-commit-assistant
git pull
```

The symlink can stay as-is after updates.
