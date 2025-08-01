---
title: Codex CLI
url: https://github.com/openai/codex
logo: https://openai.com/favicon.ico
models: OpenAI GPT-4, Claude, and others
ui_type: CLI
ease_of_use_for_non_technical: 3
github: https://github.com/openai/codex
---

Codex CLI is OpenAI's official command-line tool that brings the power of their latest reasoning models directly to your terminal. It's built for developers who already live in the terminal and want ChatGPT-level reasoning plus the power to actually run code, manipulate files, and iterate - all under version control.

## Key Features

- **Multimodal inputs** – Pass text, screenshots, or diagrams and let the agent generate or edit code accordingly
- **Code execution** – Scaffolds files, runs them inside a sandbox, installs missing dependencies, and shows live results
- **Sandbox safety** – Runs model-generated commands in a sandbox with approval workflow
- **Version control integration** – All work happens under version control for easy tracking and rollback

## Installation

Install globally with npm:
```bash
npm install -g @openai/codex
```

Or using Homebrew:
```bash
brew install codex
```

## Alternative Options

Several community forks and alternatives are available:

- **[open-codex](https://github.com/ymichael/open-codex)** - Fork with expanded model support including OpenAI, Gemini, OpenRouter, and Ollama
- **[open-codex by codingmoh](https://github.com/codingmoh/open-codex)** - Fully open-source version supporting local language models
- **[ZSH Codex Plugin](https://github.com/tom-doerr/zsh_codex)** - ZSH plugin for AI-powered code completion

## Use Cases

- Code generation and editing
- File manipulation and scaffolding
- Dependency management
- Interactive development workflows
- AI-assisted debugging and refactoring