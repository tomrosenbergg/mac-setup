# --- 1. Environment Variables ---
export LANG=en_US.UTF-8
export EDITOR='nvim'
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

# --- 2. History Configuration ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Add to history, don't overwrite
setopt SHARE_HISTORY           # Share history across all sessions
setopt HIST_IGNORE_DUPS        # Don't record duplicates
setopt HIST_IGNORE_SPACE       # Don't record commands starting with space

# --- 3. Completion System ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive completion
zstyle ':completion:*' menu select                 # Visual menu for completions

# --- 4. Aliases (Your Power Tools) ---
alias ls="eza --icons --git --group-directories-first"
alias ll="eza -lh --icons --git"
alias la="eza -a --icons --git"
alias cat="bat"
alias grep="rg"                # Use ripgrep instead of grep
alias vim="nvim"
alias brewup="brew update && brew upgrade && brew cleanup"
alias cleanup="sudo /usr/local/bin/cleanup" # Calls your safe-cleanup script

# --- 5. Power Functions ---

# Find the 15 largest items in any directory
topsize() {
    local target=${1:-.}
    du -sh "${target}"/* 2>/dev/null | sort -rh | head -n 15
}

# Quick directory jump (zoxide)
eval "$(zoxide init zsh)"

# --- 6. Prompt Customization ---
# Simple, clean prompt: [directory] %
PROMPT='%F{cyan}%1~%f %F{yellow}%% %f'

# --- 7. Syntax Highlighting & Autosuggestions ---
# (Requires 'brew install zsh-syntax-highlighting zsh-autosuggestions')
# Source these if they exist
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh