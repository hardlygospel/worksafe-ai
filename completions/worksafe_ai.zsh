#compdef worksafe_ai worksafe_ai.py
# Zsh completion for Worksafe AI
# Install:
#   mkdir -p ~/.zsh/completions
#   cp completions/worksafe_ai.zsh ~/.zsh/completions/_worksafe_ai
#   echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
#   echo 'autoload -Uz compinit && compinit' >> ~/.zshrc

_worksafe_ai_installed_models() {
    local models=()
    if command -v curl &>/dev/null; then
        local json
        json=$(curl -s http://localhost:11434/api/tags 2>/dev/null)
        if [[ -n "$json" ]]; then
            while IFS= read -r line; do
                models+=("$line")
            done < <(python3 -c "import sys,json; [print(m['name']) for m in json.loads('$json').get('models',[])]" 2>/dev/null)
        fi
    fi
    print -l "${models[@]}"
}

_worksafe_ai_models() {
    local -a catalogue=(
        'llama3.2:1b:Ultra-fast, basic tasks'
        'llama3.2:3b:Fast everyday assistant (recommended)'
        'llama3.2:11b:Vision-capable text + image model'
        'llama3.1:8b:Best balance of speed and quality (recommended)'
        'gemma3:1b:Google'\''s smallest capable model'
        'gemma3:4b:Compact, great on Apple Silicon'
        'gemma3:12b:Excellent general-purpose quality'
        'gemma3:27b:Google'\''s largest Gemma'
        'phi3.5:mini:Microsoft — efficient and capable'
        'phi4:14b:Microsoft'\''s best compact reasoning model'
        'mistral:7b:Excellent reasoning and writing'
        'mistral-nemo:12b:Mistral'\''s newer efficient 12B'
        'qwen2.5:7b:Strong multilingual — 29 languages'
        'qwen2.5:14b:High-quality multilingual'
        'deepseek-r1:8b:Chain-of-thought reasoning'
        'deepseek-r1:14b:Strong multi-step reasoning'
        'deepseek-r1:70b:Frontier-class reasoning'
        'qwq:32b:Frontier reasoning (32GB+ RAM)'
        'codellama:7b:Meta'\''s code specialist'
        'codellama:13b:Better code generation'
        'codegemma:7b:Google'\''s coding model'
        'deepseek-coder-v2:16b:Top-tier code generation'
        'starcoder2:15b:600+ programming languages'
        'qwen2.5-coder:7b:Alibaba'\''s code-specific model'
        'qwen2.5-coder:14b:Larger Qwen coder'
        'aya:8b:Cohere — 23 languages'
        'aya-expanse:8b:Improved multilingual instructions'
        'mixtral:8x7b:Mixture-of-experts architecture'
        'qwen2.5:32b:Excellent large multilingual model'
        'llama3.1:70b:Near GPT-4 quality'
        'command-r:35b:Cohere — optimised for RAG and tool use'
        'llava:7b:Vision-language model'
        'llava:13b:Better image understanding'
        'moondream:1.8b:Tiny vision model'
        'llava-llama3:8b:LLaVA on Llama 3 backbone'
    )
    _describe 'model' catalogue
}

_worksafe_ai() {
    local -a args=(
        '(-m --model)'{-m,--model}'[Model to use (skip selection menu)]:model:_worksafe_ai_models'
        '(-s --system)'{-s,--system}'[Custom system prompt]:prompt:'
        '--no-gpu-check[Skip hardware and GPU detection]'
        '--version[Print version and exit]'
        '(- *)'{-h,--help}'[Show help and exit]'
    )
    _arguments -s -S $args
}

_worksafe_ai "$@"
