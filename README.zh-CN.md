# Git Commit Assistant

[English](README.md) | 简体中文

这是一个可分享的 AI skill 仓库，用于根据最近一次对话上下文和当前仓库的 git diff 生成 Conventional Commit message，并在需要时创建聚焦的 Git commit。

推荐安装方式：优先使用目标工具自己的 marketplace 流程。本仓库同时包含 Claude Code 和
Codex 的 marketplace 元数据，但两者不会自动共用同一个插件市场配置。

仓库包含两个相关 skill：

- `draft-commit-message` - 只生成简洁的 commit message
- `commit-changes` - 选择相关文件，检查疑似隐私泄漏，并创建 commit

## 这两个 Skill 的作用

这两个 skill 会综合以下信息：

- 当前对话里最近一次任务目标
- 仓库里实际 staged 或 unstaged 的 git 改动
- Conventional Commits 最佳实践
- 可选的 scope 风格，例如 `feat(ship): ...`

其中 `commit-changes` 会额外提供一层保护流程：

- 只选择和本次改动相关的文件
- 在 commit 前检查这些文件中是否可能包含个人隐私信息
- 如果没有隐私风险就自动执行 `git commit`
- 如果发现疑似隐私信息就跳过 commit 并告警
- 不会自动执行 `git push`

## 特点

- 生成简洁的 Conventional Commit 信息，例如 `feat:`、`fix:`、`refactor:`、`chore:`
- 当改动领域明确时自动补 scope，例如 `feat(ship): ...`
- 当对话描述与实际 diff 冲突时，优先相信真实代码改动
- 生成 commit message 时会优先跟随最近 3 轮用户消息的主语言，必要时再回退到更宽的最近对话上下文
- 同时支持 Claude Code 和 Codex 的 marketplace 安装流程
- 将“仅生成 message”和“创建 commit”分开，便于明确表达用户意图

## 示例输出

```text
feat(ship): add batch label sync
fix(auth): prevent refresh token loop
refactor(search): extract query normalization
chore: clean up unused feature flags
```

## 安装

不同平台的安装方式不同。Claude Code 和 Codex 分别使用自己的 marketplace 流程；
OpenCode 更适合直接把一句安装指令复制给对应 AI；Gemini CLI 使用它自己的 extension
安装方式。

### Claude Code

```bash
claude plugin marketplace add zephyrcicd/ai-skill-git-commit-message
claude plugin install git-commit-assistant@git-skills
```

### Codex

Codex 使用本仓库里的 `.agents/plugins/marketplace.json` marketplace，以及
`plugins/git-commit-assistant/.codex-plugin/plugin.json` 插件 manifest。先添加 marketplace，
再安装插件：

```bash
codex plugin marketplace add zephyrcicd/ai-skill-git-commit-message
codex plugin add git-commit-assistant@git-skills
```

安装后新开一个 Codex 会话，让 bundled skills 生效。

详细说明见：`docs/install-codex.md`

### OpenCode

直接告诉 OpenCode：

```text
Fetch and follow instructions from https://raw.githubusercontent.com/zephyrcicd/ai-skill-git-commit-message/refs/heads/main/.opencode/INSTALL.md
```

详细说明见：`docs/install-opencode.md`

### Gemini CLI

```bash
gemini extensions install https://github.com/zephyrcicd/ai-skill-git-commit-message
```

更新：

```bash
gemini extensions update git-commit-assistant
```

详细说明见：`docs/install-gemini-cli.md`

### 更新

详见：`docs/update.md`

### Release 发布

每次发布 GitHub Release 时，都会自动生成 release notes，并附带一个 `skills-<tag>.zip` 压缩包，其中包含 `skills/` 目录。

### 让其他 AI 帮你安装

请直接使用和目标 CLI 对应的文件：

- Codex：`docs/tell-ai-codex.md`
- Claude Code：`docs/tell-ai-claude-code.md`
- OpenCode：`docs/tell-ai-opencode.md`
- Gemini CLI：`docs/tell-ai-gemini-cli.md`

每个文件都只包含该平台专用的一段可直接复制给 AI 的提示词。

## 使用方式

```text
$draft-commit-message
```

```text
$commit-changes
```

通过 Codex 插件方式安装时，Codex 可能会以插件命名空间显示这两个 skill：
`git-commit-assistant:draft-commit-message` 和 `git-commit-assistant:commit-changes`。

旧版本使用过更短的 `ggm` 和 `ggm-p` 名称。新版本的 skill description 仍保留这些词作为
兼容触发线索，但新安装建议使用上面的清晰名称。

## 仓库结构

```text
.
├── skills/draft-commit-message/   # 生成 commit message
├── skills/commit-changes/         # 生成 message 并创建 commit
├── .agents/plugins/marketplace.json # Codex marketplace 入口
├── plugins/git-commit-assistant/  # Codex 插件包
│   ├── .codex-plugin/plugin.json
│   └── skills/
├── .claude-plugin/plugin.json     # Claude Code 插件入口
├── .claude-plugin/marketplace.json
├── .codex/INSTALL.md              # Codex 安装说明
├── docs/                          # 平台相关安装文档
└── install.sh                     # 本地安装辅助脚本
```

## 如何选择

需要“只生成 commit message”时，使用 `draft-commit-message`。

需要模型进一步：

- 生成 commit message
- 缩小到本次改动相关文件
- 检查这些文件是否可能包含隐私信息
- 在隐私检查通过时自动执行 `git commit`

则使用 `commit-changes`。

## License

MIT，详见 `LICENSE`。
