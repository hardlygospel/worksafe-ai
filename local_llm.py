#!/usr/bin/env python3
"""
Local LLM — Private AI for Home Use
Powered by Ollama | 100% Offline | No API Keys Required
"""

import sys
import os
import json
import subprocess
import platform
import shutil
import textwrap
import time
from pathlib import Path

try:
    import requests
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests", "-q"])
    import requests

try:
    from rich.console import Console
    from rich.panel import Panel
    from rich.prompt import Prompt, Confirm
    from rich.text import Text
    from rich.markdown import Markdown
    from rich.table import Table
    from rich.live import Live
    from rich.spinner import Spinner
    from rich.columns import Columns
    from rich.align import Align
    from rich import box
    from rich.rule import Rule
    from rich.padding import Padding
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "rich", "-q"])
    from rich.console import Console
    from rich.panel import Panel
    from rich.prompt import Prompt, Confirm
    from rich.text import Text
    from rich.markdown import Markdown
    from rich.table import Table
    from rich.live import Live
    from rich.spinner import Spinner
    from rich.columns import Columns
    from rich.align import Align
    from rich import box
    from rich.rule import Rule
    from rich.padding import Padding

# ── Constants ────────────────────────────────────────────────────────────────
OLLAMA_API   = "http://localhost:11434"
OLLAMA_TAGS  = f"{OLLAMA_API}/api/tags"
OLLAMA_CHAT  = f"{OLLAMA_API}/api/chat"
OLLAMA_PULL  = f"{OLLAMA_API}/api/pull"
HISTORY_FILE = Path.home() / ".local_llm_history.json"

console = Console()

# ── Curated model catalogue ───────────────────────────────────────────────────
MODELS = {
    "llama3.2:3b": {
        "desc": "Meta Llama 3.2 · Fast & lightweight",
        "size": "~2 GB",
        "ram":  "4 GB",
        "tag":  "Recommended for most machines",
        "color": "bright_green",
    },
    "llama3.1:8b": {
        "desc": "Meta Llama 3.1 · Great balance of speed & quality",
        "size": "~5 GB",
        "ram":  "8 GB",
        "tag":  "Best everyday model",
        "color": "cyan",
    },
    "mistral:7b": {
        "desc": "Mistral 7B · Excellent reasoning & code",
        "size": "~4 GB",
        "ram":  "8 GB",
        "tag":  "Strong all-rounder",
        "color": "blue",
    },
    "gemma3:4b": {
        "desc": "Google Gemma 3 · Compact & capable",
        "size": "~3 GB",
        "ram":  "6 GB",
        "tag":  "Great on Apple Silicon",
        "color": "magenta",
    },
    "phi4:14b": {
        "desc": "Microsoft Phi-4 · Surprisingly smart for its size",
        "size": "~8 GB",
        "ram":  "12 GB",
        "tag":  "Best small reasoning model",
        "color": "yellow",
    },
    "qwen2.5:7b": {
        "desc": "Alibaba Qwen 2.5 · Great multilingual support",
        "size": "~5 GB",
        "ram":  "8 GB",
        "tag":  "Top multilingual choice",
        "color": "bright_cyan",
    },
    "codellama:7b": {
        "desc": "Meta CodeLlama · Specialised for coding tasks",
        "size": "~4 GB",
        "ram":  "8 GB",
        "tag":  "Best for developers",
        "color": "bright_blue",
    },
    "deepseek-r1:8b": {
        "desc": "DeepSeek R1 · Chain-of-thought reasoning",
        "size": "~5 GB",
        "ram":  "8 GB",
        "tag":  "Best for complex reasoning",
        "color": "bright_magenta",
    },
}

SYSTEM_PROMPT = (
    "You are a helpful, private AI assistant running entirely on the user's local machine. "
    "No data is transmitted to any external server. Be concise, clear, and genuinely useful. "
    "If asked about privacy or data handling, reassure the user that everything stays local."
)


# ── Visual helpers ────────────────────────────────────────────────────────────

def print_banner():
    banner = Text(justify="center")
    banner.append("\n")
    banner.append("  ██╗      ██████╗  ██████╗ █████╗ ██╗      ██╗     ██╗     ███╗   ███╗\n", style="bold bright_cyan")
    banner.append("  ██║     ██╔═══██╗██╔════╝██╔══██╗██║      ██║     ██║     ████╗ ████║\n", style="bold cyan")
    banner.append("  ██║     ██║   ██║██║     ███████║██║      ██║     ██║     ██╔████╔██║\n", style="bold blue")
    banner.append("  ██║     ██║   ██║██║     ██╔══██║██║      ██║     ██║     ██║╚██╔╝██║\n", style="bold bright_blue")
    banner.append("  ███████╗╚██████╔╝╚██████╗██║  ██║███████╗ ███████╗███████╗██║ ╚═╝ ██║\n", style="bold magenta")
    banner.append("  ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚══════╝╚══════╝╚═╝     ╚═╝\n", style="bold bright_magenta")
    console.print(banner)

    subtitle = Table.grid(expand=True)
    subtitle.add_column(justify="center")
    subtitle.add_row(
        Text("🔒  Private AI · 100% Offline · Your Data Never Leaves This Machine", style="bold white")
    )
    subtitle.add_row(
        Text("Powered by Ollama  ·  No API Keys  ·  No Subscriptions  ·  No Tracking", style="dim white")
    )
    console.print(Panel(subtitle, border_style="bright_cyan", padding=(0, 2)))
    console.print()


def print_help():
    t = Table(title="Available Commands", box=box.ROUNDED, border_style="cyan", title_style="bold cyan")
    t.add_column("Command",     style="bold yellow", no_wrap=True)
    t.add_column("Description", style="white")
    rows = [
        ("/help",       "Show this help message"),
        ("/models",     "List and switch to a different model"),
        ("/new",        "Start a fresh conversation (clears history)"),
        ("/history",    "Show conversation history"),
        ("/clear",      "Clear the screen"),
        ("/about",      "Privacy & about information"),
        ("/quit  /exit","Exit the application"),
    ]
    for cmd, desc in rows:
        t.add_row(cmd, desc)
    console.print(Padding(t, (1, 0)))


def print_about():
    text = (
        "## 🔒 About Local LLM\n\n"
        "This tool lets you run a fully **private AI assistant** on your own hardware.\n\n"
        "### Why Local?\n"
        "- **Company policy safe** — no confidential data is ever sent to a third-party server\n"
        "- **No API keys** or subscriptions required\n"
        "- **Works offline** — no internet connection needed after model download\n"
        "- **GDPR / compliance friendly** — data sovereignty guaranteed\n\n"
        "### How it works\n"
        "[Ollama](https://ollama.ai) downloads and runs open-weight language models locally, "
        "exposing them through a simple REST API on `localhost:11434`.\n\n"
        "### Privacy guarantee\n"
        "Everything you type stays on **this machine**. No telemetry. No logging to any cloud."
    )
    console.print(Panel(Markdown(text), title="[bold cyan]About[/bold cyan]", border_style="cyan", padding=(1, 2)))


# ── Ollama helpers ─────────────────────────────────────────────────────────────

def ollama_running() -> bool:
    try:
        r = requests.get(f"{OLLAMA_API}/api/tags", timeout=3)
        return r.status_code == 200
    except requests.exceptions.ConnectionError:
        return False


def start_ollama() -> bool:
    """Attempt to start the Ollama daemon."""
    if shutil.which("ollama") is None:
        return False
    console.print("[yellow]Starting Ollama daemon…[/yellow]")
    subprocess.Popen(
        ["ollama", "serve"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
    )
    for _ in range(15):
        time.sleep(1)
        if ollama_running():
            console.print("[green]✓ Ollama is running[/green]")
            return True
    return False


def installed_models() -> list[str]:
    try:
        r = requests.get(OLLAMA_TAGS, timeout=5)
        data = r.json()
        return [m["name"] for m in data.get("models", [])]
    except Exception:
        return []


def pull_model(model: str):
    """Stream pull progress for a model."""
    console.print(f"\n[bold cyan]Downloading [yellow]{model}[/yellow] — this may take a while…[/bold cyan]\n")
    with requests.post(f"{OLLAMA_API}/api/pull", json={"name": model}, stream=True, timeout=None) as resp:
        last_pct = -1
        for line in resp.iter_lines():
            if not line:
                continue
            try:
                d = json.loads(line)
            except json.JSONDecodeError:
                continue
            status = d.get("status", "")
            total  = d.get("total", 0)
            comp   = d.get("completed", 0)
            if total and comp:
                pct = int(comp / total * 100)
                if pct != last_pct and pct % 5 == 0:
                    bar = "█" * (pct // 5) + "░" * (20 - pct // 5)
                    console.print(
                        f"  [cyan][{bar}][/cyan] [bold]{pct:3d}%[/bold]  [dim]{status}[/dim]",
                        end="\r"
                    )
                    last_pct = pct
            elif status:
                console.print(f"  [dim]{status}[/dim]", end="\r")
    console.print(f"\n[bold green]✓ {model} downloaded successfully![/bold green]\n")


def choose_model(preselected: str | None = None) -> str:
    local = installed_models()
    console.print()
    console.print(Rule("[bold cyan]Model Selection[/bold cyan]", style="cyan"))
    console.print()

    t = Table(box=box.ROUNDED, border_style="blue", show_header=True, header_style="bold white")
    t.add_column("#",        style="bold white",  width=4,  justify="right")
    t.add_column("Model",    style="bold yellow",  min_width=22)
    t.add_column("Description", style="white",    min_width=40)
    t.add_column("Size",     style="dim cyan",     width=8,  justify="center")
    t.add_column("RAM",      style="dim magenta",  width=8,  justify="center")
    t.add_column("Status",   width=14,             justify="center")

    model_keys = list(MODELS.keys())
    for i, key in enumerate(model_keys, 1):
        info  = MODELS[key]
        badge = (
            "[bold green]● Installed[/bold green]"
            if any(key in m for m in local)
            else "[dim]○ Not downloaded[/dim]"
        )
        t.add_row(
            str(i),
            f"[{info['color']}]{key}[/{info['color']}]",
            f"{info['desc']}\n[dim]{info['tag']}[/dim]",
            info["size"],
            info["ram"],
            badge,
        )

    console.print(t)
    console.print()

    if preselected and any(preselected in m for m in local):
        return preselected

    while True:
        choice = Prompt.ask(
            "[bold cyan]Select a model[/bold cyan] [dim](enter number or full name)[/dim]"
        )
        if choice.isdigit():
            idx = int(choice) - 1
            if 0 <= idx < len(model_keys):
                model = model_keys[idx]
                break
        elif choice in model_keys or any(choice in m for m in local):
            model = choice
            break
        console.print("[red]Invalid selection — try again[/red]")

    if not any(model.split(":")[0] in m for m in local):
        if Confirm.ask(
            f"\n[yellow]{model}[/yellow] is not downloaded. Download it now?",
            default=True,
        ):
            pull_model(model)
        else:
            console.print("[red]Cannot use a model that isn't downloaded. Please pick an installed one.[/red]")
            return choose_model()

    return model


# ── Chat engine ───────────────────────────────────────────────────────────────

def stream_chat(model: str, messages: list[dict]) -> str:
    payload = {
        "model":    model,
        "messages": messages,
        "stream":   True,
    }
    full_response = ""
    try:
        with requests.post(OLLAMA_CHAT, json=payload, stream=True, timeout=120) as resp:
            resp.raise_for_status()
            for raw_line in resp.iter_lines():
                if not raw_line:
                    continue
                try:
                    data = json.loads(raw_line)
                except json.JSONDecodeError:
                    continue
                token = data.get("message", {}).get("content", "")
                if token:
                    full_response += token
                    console.print(token, end="", markup=False, highlight=False)
                if data.get("done"):
                    break
    except requests.exceptions.RequestException as e:
        console.print(f"\n[red]Connection error: {e}[/red]")
    return full_response


def chat_loop(model: str):
    messages: list[dict] = [{"role": "system", "content": SYSTEM_PROMPT}]
    model_short = model.split(":")[0]

    console.print()
    console.print(
        Panel(
            f"[bold green]✓ Connected to [yellow]{model}[/yellow][/bold green]\n"
            "[dim]Type your message and press Enter. Type [bold]/help[/bold] for commands.[/dim]",
            border_style="green",
            padding=(0, 2),
        )
    )
    console.print()

    while True:
        try:
            user_input = Prompt.ask(
                f"[bold bright_green]You[/bold bright_green]",
                console=console,
            ).strip()
        except (KeyboardInterrupt, EOFError):
            console.print("\n[dim]Bye! 👋[/dim]")
            break

        if not user_input:
            continue

        # ── Commands ──────────────────────────────────────────────────────────
        cmd = user_input.lower()
        if cmd in ("/quit", "/exit"):
            console.print("[dim]Goodbye! Your conversation was completely private.[/dim]")
            break
        if cmd == "/help":
            print_help()
            continue
        if cmd == "/about":
            print_about()
            continue
        if cmd == "/clear":
            console.clear()
            print_banner()
            continue
        if cmd == "/new":
            messages = [{"role": "system", "content": SYSTEM_PROMPT}]
            console.print("[yellow]Conversation cleared.[/yellow]")
            continue
        if cmd == "/history":
            if len(messages) <= 1:
                console.print("[dim]No conversation history yet.[/dim]")
            else:
                for m in messages[1:]:
                    role_style = "bright_green" if m["role"] == "user" else "bright_cyan"
                    console.print(f"[{role_style}]{m['role'].capitalize()}:[/{role_style}] {m['content']}\n")
            continue
        if cmd == "/models":
            model = choose_model(model)
            messages = [{"role": "system", "content": SYSTEM_PROMPT}]
            console.print(f"[green]Switched to [yellow]{model}[/yellow]. Conversation reset.[/green]")
            continue

        # ── Send to model ─────────────────────────────────────────────────────
        messages.append({"role": "user", "content": user_input})
        console.print()
        console.print(
            f"[bold bright_cyan]{model_short.capitalize()}[/bold bright_cyan] ",
            end="",
        )
        response = stream_chat(model, messages)
        console.print("\n")
        console.print(Rule(style="dim blue"))
        console.print()

        if response:
            messages.append({"role": "assistant", "content": response})


# ── Entry point ───────────────────────────────────────────────────────────────

def main():
    print_banner()

    # 1. Check Ollama binary
    if shutil.which("ollama") is None:
        console.print(
            Panel(
                "[bold red]Ollama is not installed.[/bold red]\n\n"
                "Install it with:\n"
                "  [bold yellow]macOS / Linux:[/bold yellow]  [cyan]curl -fsSL https://ollama.ai/install.sh | sh[/cyan]\n"
                "  [bold yellow]macOS (Homebrew):[/bold yellow] [cyan]brew install ollama[/cyan]\n"
                "  [bold yellow]Windows:[/bold yellow]         [cyan]https://ollama.ai/download[/cyan]\n\n"
                "Then re-run this script.",
                title="[red]Installation Required[/red]",
                border_style="red",
                padding=(1, 2),
            )
        )
        sys.exit(1)

    # 2. Ensure daemon is up
    if not ollama_running():
        if not start_ollama():
            console.print("[bold red]Could not start Ollama. Please run `ollama serve` manually then retry.[/bold red]")
            sys.exit(1)
    else:
        console.print("[green]✓ Ollama is running[/green]")

    # 3. Model selection
    model = choose_model()

    # 4. Chat
    chat_loop(model)


if __name__ == "__main__":
    main()
