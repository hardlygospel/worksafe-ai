#Requires -Version 5.1
# ==============================================================================
#  Worksafe AI — Windows PowerShell Setup & Launcher
#  Private AI for home use · 100% Offline · No API Keys Required
#  SPDX-License-Identifier: GPL-3.0-or-later
# ==============================================================================
[CmdletBinding()]
param(
    [string]$Model  = "",
    [string]$System = "",
    [switch]$SkipOllamaInstall,
    [switch]$SkipPythonCheck
)

$ErrorActionPreference = "Stop"

# ── ANSI colours (works in Windows Terminal, PS7+, VS Code terminal) ──────────
$ESC     = [char]27
$RST     = "$ESC[0m"
$BOLD    = "$ESC[1m"
$DIM     = "$ESC[2m"
$RED     = "$ESC[31m"
$GREEN   = "$ESC[32m"
$YELLOW  = "$ESC[33m"
$BLUE    = "$ESC[34m"
$MAGENTA = "$ESC[35m"
$CYAN    = "$ESC[36m"
$BCYAN   = "$ESC[96m"
$BYELLOW = "$ESC[93m"
$BGREEN  = "$ESC[92m"
$BRED    = "$ESC[91m"
$BWHITE  = "$ESC[97m"

# ── Helpers ───────────────────────────────────────────────────────────────────
function Write-Banner {
    Clear-Host
    Write-Host ""
    Write-Host "  $BCYAN██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗ █████╗ ███████╗███████╗   █████╗ ██╗$RST"
    Write-Host "  $CYAN██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗██╔════╝██╔════╝  ██╔══██╗██║$RST"
    Write-Host "  $BLUE██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗███████║█████╗  █████╗    ███████║██║$RST"
    Write-Host "  $BLUE██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║██╔══██║██╔══╝  ██╔══╝    ██╔══██║██║$RST"
    Write-Host "  $MAGENTA╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║██║  ██║██║     ███████╗  ██║  ██║██║$RST"
    Write-Host "  $MAGENTA ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝  ╚═╝  ╚═╝╚═╝$RST"
    Write-Host ""
    Write-Host "  $BWHITE╔══════════════════════════════════════════════════════════════╗$RST"
    Write-Host "  $BWHITE║$BYELLOW      🔒 Private AI · 100% Offline · No API Keys             $BWHITE║$RST"
    Write-Host "  $BWHITE║$DIM   No data leaves your machine · GPL-3.0 Free Software    $BWHITE║$RST"
    Write-Host "  $BWHITE╚══════════════════════════════════════════════════════════════╝$RST"
    Write-Host ""
}

function Write-Step    { param($n, $msg) Write-Host "`n$BLUE━━━ $BOLD$n · $msg$RST$BLUE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$RST" }
function Write-Success { param($msg)     Write-Host "  $BGREEN✓$RST  $msg" }
function Write-Info    { param($msg)     Write-Host "  $BCYAN ℹ$RST  $msg" }
function Write-Warn    { param($msg)     Write-Host "  $BYELLOW⚠$RST  $msg" }
function Write-Fail    { param($msg)     Write-Host "  $BRED✗$RST  $msg"; exit 1 }

function Test-Command  { param($cmd)     return $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue) }

function Refresh-Path {
    $machine = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $user    = [System.Environment]::GetEnvironmentVariable("PATH", "User")
    $env:PATH = "$machine;$user"
}

# ── Step 1 · Python ───────────────────────────────────────────────────────────
Write-Banner
Write-Step 1 "Checking Python"

if ($SkipPythonCheck) {
    Write-Info "Python check skipped."
} elseif (Test-Command "python") {
    $pyVer = python --version 2>&1
    Write-Success "Python found: $pyVer"
} elseif (Test-Command "python3") {
    $pyVer = python3 --version 2>&1
    Write-Success "Python found: $pyVer"
} else {
    Write-Warn "Python not found. Attempting install via winget…"
    try {
        winget install --id Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
        Refresh-Path
        if (Test-Command "python") {
            Write-Success "Python installed successfully!"
        } else {
            Write-Fail "Python install failed. Download from https://python.org and re-run this script."
        }
    } catch {
        Write-Fail "Could not install Python automatically. Download from https://python.org"
    }
}

# Resolve python command
$PythonCmd = if (Test-Command "python") { "python" } elseif (Test-Command "python3") { "python3" } else { $null }
if (-not $PythonCmd) {
    Write-Fail "Python not available. Please install from https://python.org"
}

# ── Step 2 · Ollama ───────────────────────────────────────────────────────────
Write-Step 2 "Checking Ollama"

if ($SkipOllamaInstall) {
    Write-Info "Ollama install check skipped."
} elseif (Test-Command "ollama") {
    $ollamaVer = ollama --version 2>&1 | Select-Object -First 1
    Write-Success "Ollama found: $ollamaVer"
} else {
    Write-Warn "Ollama not found. Downloading installer…"

    # Try winget first (Windows 10+)
    $wingetOk = $false
    try {
        winget install --id Ollama.Ollama --silent --accept-package-agreements --accept-source-agreements
        Refresh-Path
        if (Test-Command "ollama") {
            $wingetOk = $true
            Write-Success "Ollama installed via winget!"
        }
    } catch { }

    if (-not $wingetOk) {
        # Manual download fallback
        $installer = "$env:TEMP\OllamaSetup.exe"
        Write-Info "Downloading from ollama.ai…"
        try {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri "https://ollama.ai/download/OllamaSetup.exe" `
                -OutFile $installer -UseBasicParsing
            Write-Info "Running installer (silent)…"
            Start-Process -FilePath $installer -ArgumentList "/S" -Wait
            Refresh-Path

            if (Test-Command "ollama") {
                Write-Success "Ollama installed successfully!"
            } else {
                Write-Fail ("Ollama installation failed. " +
                    "Please install manually from https://ollama.ai/download then re-run this script.")
            }
        } catch {
            Write-Fail ("Download failed: $_`nPlease install Ollama manually from https://ollama.ai/download")
        }
    }
}

if (-not (Test-Command "ollama")) {
    Write-Fail "Ollama is not available. Please install from https://ollama.ai/download"
}

# ── Step 3 · Python dependencies ─────────────────────────────────────────────
Write-Step 3 "Installing Python dependencies"
Write-Info "Installing: rich, requests"

try {
    & $PythonCmd -m pip install --quiet --upgrade rich requests
    Write-Success "Python dependencies ready"
} catch {
    Write-Fail "pip install failed: $_"
}

# ── Step 4 · Launch ───────────────────────────────────────────────────────────
Write-Step 4 "Launching Worksafe AI"
Write-Host ""
Write-Info "Setup complete. Starting the chat interface…"
Write-Host ""

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$MainScript = Join-Path $ScriptDir "worksafe_ai.py"

if (-not (Test-Path $MainScript)) {
    Write-Fail "worksafe_ai.py not found in $ScriptDir. Please re-clone the repository."
}

# Build argument list
$pyArgs = @($MainScript)
if ($Model)  { $pyArgs += "--model";  $pyArgs += $Model  }
if ($System) { $pyArgs += "--system"; $pyArgs += $System }

& $PythonCmd @pyArgs
