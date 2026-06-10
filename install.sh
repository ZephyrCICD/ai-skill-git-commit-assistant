#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-all}"

link_skill() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ] || [ -f "$dst" ]; then
    rm -f "$dst"
  elif [ -d "$dst" ]; then
    echo "Refusing to replace directory: $dst" >&2
    exit 1
  fi

  ln -s "$src" "$dst"
}

install_codex() {
  if ! command -v codex >/dev/null 2>&1; then
    echo "codex CLI not found. Install Codex first, then rerun this installer." >&2
    exit 1
  fi

  codex plugin marketplace add "$REPO_DIR"
  codex plugin add git-commit-assistant@git-skills
  echo "Installed Codex plugin: git-commit-assistant@git-skills"
}

install_claude() {
  mkdir -p "$HOME/.claude/skills"
  link_skill "$REPO_DIR/skills/draft-commit-message" "$HOME/.claude/skills/draft-commit-message"
  link_skill "$REPO_DIR/skills/commit-changes" "$HOME/.claude/skills/commit-changes"
  echo "Installed for Claude Code: $HOME/.claude/skills/{draft-commit-message,commit-changes}"
}

case "$MODE" in
  codex)
    install_codex
    ;;
  claude|claude-code)
    install_claude
    ;;
  all)
    install_codex
    install_claude
    ;;
  *)
    echo "Usage: $0 [all|codex|claude]" >&2
    exit 1
    ;;
esac
