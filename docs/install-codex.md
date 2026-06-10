# Install for Codex

Codex and Claude Code do not share marketplace registrations automatically. This repository includes
Codex-specific metadata in `.agents/plugins/marketplace.json` and
`plugins/git-commit-assistant/.codex-plugin/plugin.json`.

## Installation

```bash
codex plugin marketplace add ZephyrCICD/ai-skill-git-commit-assistant
codex plugin add git-commit-assistant@git-skills
```

Start a new Codex thread after installing so Codex loads the bundled skills.

## Local Development Install

If you are developing this repository locally, add the local clone as the marketplace source:

```bash
git clone https://github.com/ZephyrCICD/ai-skill-git-commit-assistant ~/ai/skills/ai-skill-git-commit-assistant
codex plugin marketplace add ~/ai/skills/ai-skill-git-commit-assistant
codex plugin add git-commit-assistant@git-skills
```

Restart Codex or start a new thread after reinstalling during local development.

## Use It

Use the plugin from the Codex plugin picker, or ask for the bundled skills by name. Codex may expose
them with the plugin namespace:

- `git-commit-assistant:draft-commit-message`
- `git-commit-assistant:commit-changes`

The legacy shorthand terms `ggm` and `ggm-p` remain in the skill descriptions for compatibility
with older prompts, but new installs should use the clearer names above.

## Update

```bash
codex plugin marketplace upgrade git-skills
codex plugin add git-commit-assistant@git-skills
```
