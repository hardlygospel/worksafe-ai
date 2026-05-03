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
| 🤖 **35+ Curated Models** | 7 categories — Fast, Balanced, Reasoning, Coding, Multilingual, High Power, Vision |
| 🖥️ **GPU Detection** | Auto-detects Apple Silicon, NVIDIA, AMD and recommends models |
| 💬 **Streaming Chat** | Responses appear token-by-token in real time |
| 📄 **Export: MD / HTML / PDF / DOCX / JSON** | Five export formats with `/export` |
| 🖼️ **Image Input** | Attach images for vision models (llava, moondream) with `/image` |
| 💾 **Named Sessions** | Save, restore, and manage named conversations with `/session` |
| 🔍 **Conversation Search** | Find any keyword in the current chat with `/search <term>` |
| 🖥️ **Shell Completions** | Tab-complete models & flags in Bash, Zsh, and Fish |
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

### ⚖️ Balanced (8–12 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `llama3.1:8b` | ~5 GB | ★ Best everyday balance |
| `mistral:7b` | ~4 GB | Reasoning, writing, summarisation |
| `mistral-nemo:12b` | ~7 GB | Mistral's newer efficient 12B — very strong |
| `gemma3:4b` | ~3 GB | Great on Apple Silicon |
| `gemma3:12b` | ~8 GB | Excellent general-purpose quality |
| `llama3.2:11b` | ~8 GB | Vision-capable text + image model |
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
| `qwen2.5-coder:7b` | ~5 GB | Alibaba's code-specific model |
| `qwen2.5-coder:14b` | ~9 GB | Larger Qwen coder — complex tasks |
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
| `gemma3:27b` | ~17 GB | Google's largest Gemma — near GPT-4 quality |
| `command-r:35b` | ~20 GB | Cohere — optimised for RAG & tool use |
| `mixtral:8x7b` | ~26 GB | Mixture-of-experts architecture |
| `qwen2.5:32b` | ~20 GB | Large multilingual model |
| `llama3.1:70b` | ~40 GB | Near GPT-4 quality |
| `deepseek-r1:70b` | ~40 GB | Frontier-class reasoning |

### 👁️ Vision & Multimodal (8–12 GB RAM)
| Model | Size | Best For |
|---|---|---|
| `moondream:1.8b` | ~1.7 GB | Tiny vision model — fast image Q&A |
| `llava:7b` | ~5 GB | Describe & reason about images |
| `llava-llama3:8b` | ~5 GB | LLaVA on Llama 3 — strong visual reasoning |
| `llava:13b` | ~8 GB | Better image understanding & analysis |

---

## 💬 Chat Commands

| Command | What it does |
|---|---|
| `/help` | Show all available commands |
| `/models` | Browse all models and switch |
| `/new` | Start a fresh conversation |
| `/history` | Print conversation history |
| `/search <term>` | Search conversation for a keyword (highlighted) |
| `/export` | Export as Markdown (default) |
| `/export html\|pdf\|docx\|json` | Export in a specific format |
| `/export <path>` | Export to path — format inferred from extension |
| `/image <path>` | Attach image for next message (vision models only) |
| `/session` | List all saved sessions |
| `/session save [name]` | Save current conversation |
| `/session load <name>` | Restore a saved conversation |
| `/session delete <name>` | Delete a saved session |
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

## 📄 Export Formats

Save any conversation in three formats using the `/export` command:

| Command | Output | Use case |
|---|---|---|
| `/export` | `.md` Markdown | Notes, documentation, plain text |
| `/export html` | `.html` styled page | Sharing, archiving, printing |
| `/export pdf` | `.pdf` document | Reports, records, offline reading |
| `/export docx` | `.docx` Word document | Office sharing, editing |
| `/export json` | `.json` transcript | Structured data, automation, archiving |
| `/export ~/chat.html` | Specific path + format from extension | Custom location |

### Markdown export
Clean, readable `.md` dropped in the current directory:
```
# Worksafe AI — Conversation Export
| Date  | 2024-11-15 14:32 |
| Model | llama3.1:8b      |

### 🧑 You
How do I reverse a string in Python?

### 🤖 Llama3
The simplest way is: `s[::-1]`
```

### HTML export
A self-contained styled page with dark/light mode, chat bubbles, and metadata — no external dependencies, opens in any browser.

### PDF export
A clean A4 document via [`fpdf2`](https://pyfpdf.github.io/fpdf2/) — installed automatically on first use, no system binaries needed.

---

## 🔧 Shell Completions

Tab-complete model names and flags in your shell.

### Bash
```bash
echo 'source /path/to/worksafe-ai/completions/worksafe_ai.bash' >> ~/.bashrc
source ~/.bashrc
```

### Zsh
```zsh
mkdir -p ~/.zsh/completions
cp completions/worksafe_ai.zsh ~/.zsh/completions/_worksafe_ai

# Add to ~/.zshrc if not already present:
echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
source ~/.zshrc
```

### Fish
```fish
cp completions/worksafe_ai.fish ~/.config/fish/completions/
# Reopen your terminal — completions load automatically
```

Once installed, tab-completion works like this:
```
worksafe_ai --model ll<TAB>
# → llama3.2:1b   llama3.2:3b   llama3.1:8b   llava:7b   ...
```
When Ollama is running, completions are pulled live from your installed models. When it isn't, the full catalogue is used as a fallback.

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
| `fpdf2` | Optional — auto-installed on first `/export pdf` |

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

## 🖼️ Image Input (Vision Models)

Send images to vision-capable models with `/image <path>`:

```
/image ~/screenshots/error.png
Now describe what you see in this error screen.
```

The image is attached to your next message and sent alongside the text. Supported formats: `jpg`, `png`, `gif`, `webp`, `bmp`.

**Compatible models:** `llava:7b`, `llava:13b`, `llava-llama3:8b`, `moondream:1.8b`

If you try `/image` with a non-vision model, Worksafe AI will explain which models to switch to instead.

---

## 💾 Named Sessions

Save and restore conversations across app restarts:

```
/session save work-ideas
/session                     # list all sessions
/session load work-ideas     # restore model, system prompt, and history
/session delete work-ideas
```

Sessions are stored locally at `~/.worksafe_ai/sessions/` as plain JSON files — no database, no lock-in. Each session saves the model name, system prompt, and full message history.

---

## 🔍 Conversation Search

Find any word or phrase in the current conversation, with the match highlighted in context:

```
/search database
/search how to reverse
/search Python
```

Results show the speaker, message index, and ±80 characters of surrounding context with the term highlighted in yellow.

---

## 🤝 Contributing

Contributions are welcome! Open an issue or pull request for:
- ✅ ~~New model presets or categories~~ — 35+ models across 7 categories
- ✅ ~~Additional export formats (HTML, PDF, DOCX, JSON)~~ — five formats supported
- ✅ ~~Shell completions~~ — Bash, Zsh, and Fish included
- ✅ ~~Bug fixes~~ — model install detection fixed, PEP 668 pip handled
- ✅ ~~Image input for vision models~~ — `/image <path>` for llava, moondream
- ✅ ~~Conversation search~~ — `/search <term>` with highlighted results
- ✅ ~~Named sessions & session restore~~ — `/session save/load/delete`
- DOCX table-of-contents / heading styles
- Export to PDF with image thumbnails
- Ollama model update checker (`/update`)

---

## 📄 Licence

**Worksafe AI** is free software: you can redistribute it and/or modify it under the terms of the [GNU General Public Licence v3.0](LICENSE) as published by the Free Software Foundation.

This means you are free to use, study, share, and improve it — for any purpose — as long as you keep the same freedoms intact for others.

---

<p align="center">
  <em>Built for people who want AI without compromise.<br>
  Your machine. Your data. Your rules.</em>
</p>
