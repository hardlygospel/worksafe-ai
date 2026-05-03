<p align="center">
  <img src="https://img.shields.io/badge/100%25_Offline-No_Cloud-brightgreen?style=for-the-badge&logo=lock" />
  <img src="https://img.shields.io/badge/Powered_by-Ollama-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-GPL--3.0-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/macOS_%7C_Linux_%7C_Windows-Supported-purple?style=for-the-badge&logo=apple" />
  <img src="https://img.shields.io/badge/No_API_Key-Required-red?style=for-the-badge" />
</p>

<h1 align="center">🔒 Worksafe AI</h1>

<p align="center">
  <strong>A private AI assistant that runs entirely on your own machine.<br>
  No internet. No API keys. No subscriptions. No data ever leaves your device.</strong>
</p>

---

## 🏢 Why This Exists — The Company Policy Problem

Many workplaces have strict policies prohibiting employees from entering confidential information into AI tools like ChatGPT, Copilot, Gemini, or Claude. This is entirely reasonable — those services send your prompts to third-party servers where data could be:

- Logged and stored for model training
- Subject to data breaches
- Accessible to foreign jurisdictions
- In violation of NDAs, HIPAA, GDPR, or other compliance requirements

**Worksafe AI solves that problem.**

When you're at home and want AI assistance without worrying about data handling, this tool gives you a full-featured AI chat interface that never touches the internet after the model is downloaded. Use it for personal projects, learning, creative writing, coding help, and more — completely privately.

> **Everything runs on your own hardware.** Your prompts never leave your machine. There are no logs, no telemetry, no third-party servers involved — ever.

---

## ✨ Features

| Feature | Details |
|---|---|
| 🔒 **Fully Offline** | Zero internet required after first model download |
| 🚀 **One-Command Setup** | `setup.sh` (macOS/Linux) or `setup.ps1` (Windows) |
| 🎨 **Beautiful Terminal UI** | Rich interface with colours, progress bars, and streaming |
| 🤖 **25+ Curated Models** | Organised by use case with size & RAM requirements |
| 🖥️ **GPU Detection** | Auto-detects Apple Silicon, NVIDIA, AMD and recommends models |
| 💬 **Streaming Chat** | Responses appear token-by-token in real time |
| 📝 **Export to Markdown** | Save any conversation to a `.md` file with `/export` |
| ✏️ **Custom System Prompt** | Set your own AI persona with `/system <text>` |
| 🔄 **Model Switching** | Hot-swap models mid-session with `/models` |
| 🖥️ **Cross-Platform** | macOS, Linux, Windows (PowerShell & WSL) |
| 📜 **Free Software** | GNU GPL v3 — no lock-in, no fees, ever |

---

## 🚀 Quick Start

### macOS / Linux
```bash
git clone https://github.com/hardlygospel/worksafe-ai.git
cd worksafe-ai
chmod +x setup.sh
./setup.sh
```

### Windows (PowerShell)
```powershell
git clone https://github.com/hardlygospel/worksafe-ai.git
cd worksafe-ai
# If needed: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\setup.ps1
```

### Windows (WSL 2)
Follow the macOS/Linux instructions inside your WSL terminal.

The setup script will:
1. Detect your OS and install **Ollama** if it isn't already present
2. Install the required Python packages (`rich`, `requests`)
3. Launch the interactive hardware-detection, model-selection, and chat interface

---

## 🖥️ Hardware Detection & GPU Recommendations

On launch, Worksafe AI detects your hardware and recommends the best models for your machine:

```
╭─── Hardware Detected ───────────────────────────────────────────╮
│ 🍎  Apple M2 Pro                                                │
│     Unified Memory: 16 GB  (shared CPU + GPU)                  │
│                                                                 │
│  Recommended for this machine:                                  │
│   • llama3.1:8b  ★  Best everyday balance of speed & quality   │
│   • mistral:7b       Excellent reasoning, writing & summarisa…  │
│   • gemma3:4b        Compact & capable — great on Apple Silicon │
╰─────────────────────────────────────────────────────────────────╯
```

Supported:
- **Apple Silicon** (M1/M2/M3/M4) — unified memory detection
- **NVIDIA** — VRAM read via `nvidia-smi`
- **AMD** — ROCm detection on Linux
- **CPU-only** — conservative recommendations based on RAM

---

## 🤖 Model Catalogue

All models are free, open-weight, and run locally. Organised by use case:

### ⚡ Fast & Light (≤4 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `llama3.2:1b` | ~0.7 GB | Ultra-fast answers, low-power devices |
| `llama3.2:3b` | ~2 GB | ★ Fast everyday assistant |
| `gemma3:1b` | ~0.8 GB | Google's smallest capable model |
| `phi3.5:mini` | ~2.3 GB | Microsoft — efficient & capable |

### ⚖️ Balanced (8 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `llama3.1:8b` | ~5 GB | ★ Best everyday balance |
| `mistral:7b` | ~4 GB | Reasoning, writing, summarisation |
| `gemma3:4b` | ~3 GB | Great on Apple Silicon |
| `gemma3:12b` | ~8 GB | Excellent general-purpose quality |
| `qwen2.5:7b` | ~5 GB | Multilingual (29 languages) |

### 🧠 Reasoning (12 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `deepseek-r1:8b` | ~5 GB | Chain-of-thought analysis |
| `deepseek-r1:14b` | ~9 GB | Multi-step reasoning |
| `phi4:14b` | ~8 GB | Microsoft's best compact model |
| `qwq:32b` | ~20 GB | Frontier reasoning (32 GB+) |

### 💻 Coding (8–14 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `codellama:7b` | ~4 GB | All-language code specialist |
| `codellama:13b` | ~8 GB | Better generation & explanations |
| `codegemma:7b` | ~5 GB | Google — strong Python & JS |
| `deepseek-coder-v2:16b` | ~10 GB | Top-tier debugging & generation |
| `starcoder2:15b` | ~9 GB | 600+ programming languages |

### 🌍 Multilingual (8–12 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `qwen2.5:14b` | ~9 GB | 29 languages, high quality |
| `aya:8b` | ~5 GB | Cohere — 23 languages |
| `aya-expanse:8b` | ~5 GB | Improved multilingual instructions |

### 🔋 High Power (24–48 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `mixtral:8x7b` | ~26 GB | Mixture-of-experts architecture |
| `qwen2.5:32b` | ~20 GB | Large multilingual model |
| `llama3.1:70b` | ~40 GB | Near GPT-4 quality |
| `deepseek-r1:70b` | ~40 GB | Frontier-class reasoning |

---

## 💬 Chat Commands

| Command | What it does |
|---|---|
| `/help` | Show all available commands |
| `/models` | Browse all models and switch |
| `/new` | Start a fresh conversation |
| `/history` | Print conversation so far |
| `/export [path]` | Save conversation to Markdown |
| `/system` | Show current system prompt |
| `/system reset` | Reset to default system prompt |
| `/system <text>` | Set a custom system prompt |
| `/clear` | Clear the screen |
| `/about` | Privacy & licence information |
| `/quit` | Exit Worksafe AI |

### CLI flags
```bash
# Skip model selection and start immediately
./setup.sh --model llama3.1:8b

# Set a custom persona from the command line
./setup.sh --system "You are a concise technical writer."

# Skip GPU detection (faster startup)
./setup.sh --no-gpu-check
```

---

## 📄 Export to Markdown

Save any conversation with `/export` — a clean `.md` file is created in the current directory:

```markdown
# Worksafe AI — Conversation Export

| Field    | Value              |
|----------|--------------------|
| Date     | 2024-11-15 14:32:01|
| Model    | `llama3.1:8b`      |
| Turns    | 6                  |

---

### 🧑 You
How do I reverse a string in Python?

### 🤖 Llama3
The simplest way is: `s[::-1]`
...
```

You can also specify a path: `/export ~/Desktop/my-chat.md`

---

## ✏️ Custom System Prompts

Change the AI's behaviour mid-session:

```
/system You are a senior DevOps engineer. Give short, opinionated answers.
/system You are a friendly tutor. Explain things step-by-step for beginners.
/system reset
```

---

## 🛡️ Privacy & Compliance

```
┌─────────────────────────────────────────────────────────────┐
│                     Data Flow Diagram                       │
│                                                             │
│  You type prompt  →  worksafe_ai.py (local script)         │
│                           ↓                                 │
│                    Ollama  (localhost:11434)                 │
│                           ↓                                 │
│              Open-weight model on your CPU / GPU            │
│                           ↓                                 │
│                  Response printed to screen                 │
│                                                             │
│       ✗ No internet requests     ✗ No cloud logging         │
│       ✗ No telemetry             ✗ No third parties         │
└─────────────────────────────────────────────────────────────┘
```

Worksafe AI is designed for people who need to:
- Use AI for personal tasks without violating workplace data-handling policies
- Keep sensitive personal information (financial, medical, legal) off third-party servers
- Work in air-gapped or restricted-network environments
- Maintain full data sovereignty

---

## 📋 Requirements

| Requirement | Minimum |
|---|---|
| OS | macOS 12+, Ubuntu 20.04+, Windows 10 (PowerShell 5.1+) |
| Python | 3.9 or newer |
| RAM | 4 GB (8 GB+ recommended) |
| Disk | 1–40 GB per model |
| CPU | Any modern x86-64 or Apple Silicon |
| GPU | Optional — CPU works, GPU gives faster responses |

---

## 🛠️ Manual Setup

```bash
# 1. Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh   # macOS / Linux
brew install ollama                             # macOS Homebrew

# 2. Install Python dependencies
pip install rich requests

# 3. Run directly
python3 worksafe_ai.py

# 4. Or with flags
python3 worksafe_ai.py --model mistral:7b --system "Be concise."
```

---

## 🤝 Contributing

Contributions are welcome! Open an issue or pull request for:
- New model presets or categories
- Additional export formats (HTML, PDF)
- Shell completions
- Bug fixes

---

## 📄 Licence

**Worksafe AI** is free software: you can redistribute it and/or modify it under the terms of the [GNU General Public Licence v3.0](LICENSE) as published by the Free Software Foundation.

This means you are free to use, study, share, and improve it — for any purpose — as long as you keep the same freedoms intact for others.

---

<p align="center">
  <em>Built for people who want AI without compromise.<br>
  Your machine. Your data. Your rules.</em>
</p>
