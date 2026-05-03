# Fish shell completions for Worksafe AI
# Install:
#   cp completions/worksafe_ai.fish ~/.config/fish/completions/worksafe_ai.fish
#   # Completions load automatically on next shell start

# Disable file completions for this command
complete -c worksafe_ai    -f
complete -c worksafe_ai.py -f

# ── Flags ─────────────────────────────────────────────────────────────────────
complete -c worksafe_ai    -s m -l model       -d "Model to use (skip selection)" -r
complete -c worksafe_ai    -s s -l system      -d "Custom system prompt"          -r
complete -c worksafe_ai         -l no-gpu-check -d "Skip hardware detection"
complete -c worksafe_ai         -l version      -d "Print version and exit"
complete -c worksafe_ai    -s h -l help         -d "Show help and exit"

complete -c worksafe_ai.py -s m -l model       -d "Model to use (skip selection)" -r
complete -c worksafe_ai.py -s s -l system      -d "Custom system prompt"          -r
complete -c worksafe_ai.py      -l no-gpu-check -d "Skip hardware detection"
complete -c worksafe_ai.py      -l version      -d "Print version and exit"
complete -c worksafe_ai.py -s h -l help         -d "Show help and exit"

# ── Dynamic model list from running Ollama ────────────────────────────────────
function __worksafe_ollama_models
    if command -sq curl
        set -l json (curl -s http://localhost:11434/api/tags 2>/dev/null)
        if test -n "$json"
            echo $json | python3 -c "
import sys, json
try:
    data = json.loads(sys.stdin.read())
    for m in data.get('models', []):
        print(m['name'])
except Exception:
    pass
" 2>/dev/null
            and return
        end
    end
    # Fallback catalogue when Ollama isn't running
    printf '%s\n' \
        llama3.2:1b llama3.2:3b llama3.2:11b \
        llama3.1:8b \
        gemma3:1b gemma3:4b gemma3:12b gemma3:27b \
        phi3.5:mini phi4:14b \
        mistral:7b mistral-nemo:12b \
        qwen2.5:7b qwen2.5:14b \
        deepseek-r1:8b deepseek-r1:14b deepseek-r1:70b \
        qwq:32b \
        codellama:7b codellama:13b codegemma:7b \
        deepseek-coder-v2:16b starcoder2:15b \
        qwen2.5-coder:7b qwen2.5-coder:14b \
        aya:8b aya-expanse:8b \
        mixtral:8x7b qwen2.5:32b llama3.1:70b \
        command-r:35b \
        llava:7b llava:13b moondream:1.8b llava-llama3:8b
end

# Apply model completions to -m / --model
complete -c worksafe_ai    -s m -l model -a "(__worksafe_ollama_models)"
complete -c worksafe_ai.py -s m -l model -a "(__worksafe_ollama_models)"
