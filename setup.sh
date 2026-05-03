#!/usr/bin/env bash
# ==============================================================================
#  Worksafe AI — One-Command Setup & Launcher (macOS / Linux)
#  Private AI for home use · 100% Offline · GPL-3.0
# ==============================================================================
set -euo pipefail

# ── Colours ───────────────────────────────────────────────────────────────────
R='\033[0;31m'   BRED='\033[1;31m'
G='\033[0;32m'   BGRN='\033[1;32m'
Y='\033[0;33m'   BYEL='\033[1;33m'
B='\033[0;34m'   BBLU='\033[1;34m'
M='\033[0;35m'   BMAG='\033[1;35m'
C='\033[0;36m'   BCYN='\033[1;36m'
W='\033[0;37m'   BWHT='\033[1;37m'
DIM='\033[2m'    BOLD='\033[1m'    RST='\033[0m'

# ── Banner ────────────────────────────────────────────────────────────────────
clear
echo -e "${BCYN}  ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗ █████╗ ███████╗███████╗   █████╗ ██╗${RST}"
echo -e "${CYAN}  ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗██╔════╝██╔════╝  ██╔══██╗██║${RST}"
echo -e "${BBLU}  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗███████║█████╗  █████╗    ███████║██║${RST}"
echo -e "${BBLU}  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║██╔══██║██╔══╝  ██╔══╝    ██╔══██║██║${RST}"
echo -e "${BMAG}  ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║██║  ██║██║     ███████╗  ██║  ██║██║${RST}"
echo -e "${BMAG}   ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝  ╚═╝  ╚═╝╚═╝${RST}"
echo ""
echo -e "${BWHT}  ╔══════════════════════════════════════════════════════════════╗${RST}"
echo -e "${BWHT}  ║${BYEL}      🔒 Private AI · 100%% Offline · No API Keys            ${BWHT}║${RST}"
echo -e "${BWHT}  ║${DIM}${W}   No data leaves your machine · GPL-3.0 Free Software    ${BWHT}║${RST}"
echo -e "${BWHT}  ╚══════════════════════════════════════════════════════════════╝${RST}"
echo ""

# ── Helpers ───────────────────────────────────────────────────────────────────
info()    { echo -e "  ${BCYN}ℹ${RST}  $*"; }
success() { echo -e "  ${BGRN}✓${RST}  $*"; }
warn()    { echo -e "  ${BYEL}⚠${RST}  $*"; }
error()   { echo -e "  ${BRED}✗${RST}  $*"; exit 1; }
step()    { echo -e "\n${BBLU}━━━ ${BOLD}$*${RST}${BBLU} ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RST}"; }

OS="$(uname -s)"

# ── Step 1 · Python ───────────────────────────────────────────────────────────
step "Step 1 · Checking Python"
if command -v python3 &>/dev/null; then
    PY=$(command -v python3)
    PY_VER=$("$PY" --version 2>&1 | awk '{print $2}')
    success "Python $PY_VER found at $PY"
else
    error "Python 3 is required. Install it from https://python.org then re-run this script."
fi

# ── Step 2 · Ollama ───────────────────────────────────────────────────────────
step "Step 2 · Checking Ollama"
if command -v ollama &>/dev/null; then
    OLLAMA_VER=$(ollama --version 2>&1 | head -1)
    success "Ollama found: $OLLAMA_VER"
else
    warn "Ollama not found — installing now…"
    if [[ "$OS" == "Darwin" ]]; then
        if command -v brew &>/dev/null; then
            info "Installing via Homebrew…"
            brew install ollama
        else
            info "Downloading Ollama installer…"
            curl -fsSL https://ollama.ai/install.sh | sh
        fi
    elif [[ "$OS" == "Linux" ]]; then
        info "Downloading Ollama for Linux…"
        curl -fsSL https://ollama.ai/install.sh | sh
    else
        error "Unsupported OS: $OS. Install Ollama manually from https://ollama.ai/download"
    fi

    if command -v ollama &>/dev/null; then
        success "Ollama installed successfully!"
    else
        error "Ollama installation failed. Please install manually from https://ollama.ai/download"
    fi
fi

# ── Step 3 · Python dependencies ─────────────────────────────────────────────
step "Step 3 · Installing Python dependencies"
info "Installing: rich requests"
"$PY" -m pip install --quiet --upgrade rich requests
success "Python dependencies ready"

# ── Step 4 · Launch ───────────────────────────────────────────────────────────
step "Step 4 · Launching Worksafe AI"
echo ""
info "Everything is set. Starting the chat interface…"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$PY" "$SCRIPT_DIR/worksafe_ai.py" "$@"
