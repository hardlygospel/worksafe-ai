<p align="center">
  <img src="https://img.shields.io/badge/100%25_Offline-No_Cloud-brightgreen?style=for-the-badge&logo=lock" />
  <img src="https://img.shields.io/badge/Powered_by-Ollama-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/No_API_Key-Required-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/macOS_%7C_Linux_%7C_Windows-Supported-purple?style=for-the-badge&logo=apple" />
</p>

<h1 align="center">🔒 Local LLM — Private AI for Home Use</h1>

<p align="center">
  <strong>Run a powerful AI assistant entirely on your own machine.<br>
  No internet. No API keys. No subscriptions. No data ever leaves your device.</strong>
</p>

---

## 🏢 Why This Exists — The Company Policy Problem

Many workplaces have strict policies prohibiting employees from entering confidential information into AI tools like ChatGPT, Copilot, Gemini, or Claude. This is entirely reasonable — those services send your prompts to third-party servers, where data could be:

- Logged and stored for model training
- Subject to data breaches
- Accessible to foreign jurisdictions
- In violation of NDAs, HIPAA, GDPR, or other compliance requirements

**This project solves that problem at home.**

When you're off the clock, you deserve full access to AI assistance without:
- Worrying about accidentally leaking work-adjacent information
- Breaking your employer's acceptable-use policy
- Paying for subscriptions just to chat with an AI

> **Local LLM runs 100% on your own hardware.** Your prompts never touch the internet after the model is downloaded. There are no logs, no telemetry, no third-party servers involved. You can use it for personal projects, learning, creative writing, coding, and more — completely privately.

---

## ✨ Features

| Feature | Details |
|---|---|
| 🔒 **Fully Offline** | Runs locally — zero internet required after setup |
| 🚀 **One-Command Setup** | `setup.sh` installs everything automatically |
| 🎨 **Beautiful UI** | Rich terminal interface with colors, progress bars, and streaming |
| 🤖 **Multiple Models** | Choose from 8 curated open-weight models |
| 💬 **Streaming Chat** | Responses stream token-by-token in real time |
| 🔄 **Model Switching** | Change models mid-session with `/models` |
| 📝 **Conversation History** | Full context retained per session |
| 🖥️ **Cross-Platform** | macOS, Linux, and Windows (WSL) |

---

## 🚀 Quick Start

### 1 · Clone the repo
```bash
git clone https://github.com/hardlygospel/local-llm.git
cd local-llm
```

### 2 · Run the setup script
```bash
chmod +x setup.sh
./setup.sh
```

That's it. The script will:
1. Detect your OS and install **Ollama** if it's not already present
2. Install the required Python packages (`rich`, `requests`)
3. Launch the interactive model-selection and chat interface

> **Windows users:** Use [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/) and follow the Linux instructions, or install Ollama from [ollama.ai/download](https://ollama.ai/download) then run `python local_llm.py` directly.

---

## 🤖 Available Models

All models are free, open-weight, and run entirely on your hardware.

| Model | Size | RAM | Best For |
|---|---|---|---|
| `llama3.2:3b` | ~2 GB | 4 GB | Fast everyday use on any machine |
| `llama3.1:8b` | ~5 GB | 8 GB | Best balance of speed & quality |
| `mistral:7b` | ~4 GB | 8 GB | Reasoning, writing, and code |
| `gemma3:4b` | ~3 GB | 6 GB | Great on Apple Silicon Macs |
| `phi4:14b` | ~8 GB | 12 GB | Best compact reasoning model |
| `qwen2.5:7b` | ~5 GB | 8 GB | Multilingual tasks |
| `codellama:7b` | ~4 GB | 8 GB | Software development & coding |
| `deepseek-r1:8b` | ~5 GB | 8 GB | Complex reasoning & analysis |

**Not sure which to pick?** Start with `llama3.2:3b` — it's fast, capable, and works on almost any modern computer.

---

## 💬 Chat Commands

Once inside the chat interface:

| Command | What it does |
|---|---|
| `/help` | Show all available commands |
| `/models` | Browse and switch to a different model |
| `/new` | Start a fresh conversation |
| `/history` | View the current conversation |
| `/clear` | Clear the screen |
| `/about` | Privacy and project information |
| `/quit` | Exit the application |

---

## 🛡️ Privacy & Compliance

```
┌─────────────────────────────────────────────────────────────┐
│                     Data Flow Diagram                       │
│                                                             │
│  You type prompt  →  Local Python script                    │
│                           ↓                                 │
│                    Ollama (localhost)                        │
│                           ↓                                 │
│               Open-weight model on your CPU/GPU             │
│                           ↓                                 │
│                  Response printed to screen                 │
│                                                             │
│            ✗  No internet requests  ✗  No logs              │
│            ✗  No telemetry          ✗  No cloud             │
└─────────────────────────────────────────────────────────────┘
```

This tool is designed for people who want to:
- Use AI for personal tasks without violating workplace data-handling policies
- Keep sensitive personal data (financial, medical, legal) off third-party servers
- Experiment with AI in air-gapped or restricted-network environments
- Maintain full sovereignty over their data

---

## 📋 Requirements

| Requirement | Minimum |
|---|---|
| OS | macOS 12+, Ubuntu 20.04+, or Windows 11 (via WSL 2) |
| Python | 3.9 or newer |
| RAM | 4 GB (8+ GB recommended) |
| Disk | 3–10 GB per model |
| CPU | Any modern x86-64 or Apple Silicon chip |
| GPU | Optional — CPU works fine, GPU makes it faster |

---

## 🛠️ Manual Installation

If you prefer to install components yourself:

**Install Ollama:**
```bash
# macOS / Linux
curl -fsSL https://ollama.ai/install.sh | sh

# macOS via Homebrew
brew install ollama
```

**Install Python dependencies:**
```bash
pip install rich requests
```

**Run directly:**
```bash
python3 local_llm.py
```

---

## 🤝 Contributing

Contributions welcome! Ideas:
- Add more model presets
- Windows PowerShell setup script
- Export conversation to Markdown
- System prompt customisation
- GPU detection and recommendations

---

## 📄 Licence

MIT — free to use, modify, and distribute.

---

<p align="center">
  <em>Built for people who want AI without compromise.<br>
  Your machine. Your data. Your rules.</em>
</p>
