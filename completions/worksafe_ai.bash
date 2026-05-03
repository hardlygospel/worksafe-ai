# Bash completion for Worksafe AI
# Install:
#   echo 'source /path/to/completions/worksafe_ai.bash' >> ~/.bashrc
#   # or copy to /etc/bash_completion.d/worksafe_ai

_worksafe_ai_models() {
    # Try to fetch installed models from a running Ollama instance
    if command -v curl &>/dev/null && curl -s http://localhost:11434/api/tags &>/dev/null; then
        curl -s http://localhost:11434/api/tags 2>/dev/null \
            | python3 -c "import sys,json; [print(m['name']) for m in json.load(sys.stdin).get('models',[])]" 2>/dev/null
    fi
    # Always include the curated list as fallback
    cat <<'MODELS'
llama3.2:1b
llama3.2:3b
llama3.2:11b
llama3.1:8b
gemma3:1b
gemma3:4b
gemma3:12b
gemma3:27b
phi3.5:mini
phi4:14b
mistral:7b
mistral-nemo:12b
qwen2.5:7b
qwen2.5:14b
deepseek-r1:8b
deepseek-r1:14b
deepseek-r1:70b
phi4:14b
qwq:32b
codellama:7b
codellama:13b
codegemma:7b
deepseek-coder-v2:16b
starcoder2:15b
qwen2.5-coder:7b
qwen2.5-coder:14b
aya:8b
aya-expanse:8b
mixtral:8x7b
qwen2.5:32b
llama3.1:70b
command-r:35b
llava:7b
llava:13b
moondream:1.8b
llava-llama3:8b
MODELS
}

_worksafe_ai() {
    local cur prev words cword
    _init_completion 2>/dev/null || {
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
    }

    local opts="--model -m --system -s --no-gpu-check --version --help"

    case "${prev}" in
        --model|-m)
            local models
            mapfile -t models < <(_worksafe_ai_models | sort -u)
            COMPREPLY=($(compgen -W "${models[*]}" -- "${cur}"))
            return 0
            ;;
        --system|-s)
            # Free-text argument — no completions
            return 0
            ;;
    esac

    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
        return 0
    fi

    # Complete script name itself
    COMPREPLY=($(compgen -f -- "${cur}"))
}

complete -F _worksafe_ai worksafe_ai.py
complete -F _worksafe_ai worksafe_ai
