# Install for OpenCode

## Steps

```bash
mkdir -p ~/.config/opencode
git clone https://github.com/ZephyrCICD/ai-skill-git-commit-assistant ~/.config/opencode/git-commit-assistant
mkdir -p ~/.config/opencode/skills
rm -rf ~/.config/opencode/skills/git-commit-assistant
ln -s ~/.config/opencode/git-commit-assistant/skills ~/.config/opencode/skills/git-commit-assistant
```

## Verify

```bash
ls -l ~/.config/opencode/skills/git-commit-assistant
```
