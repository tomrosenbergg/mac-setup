# --- 1. Homebrew & Environment ---
# Initialize Homebrew first so its tools (eza, bat, zoxide) are available
eval "$(/opt/homebrew/bin/brew shellenv)"

export LANG=en_US.UTF-8
export EDITOR='nvim'

# --- 2. History Configuration ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# --- 3. Completion System ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 
zstyle ':completion:*' menu select

# --- 4. Aliases (Modern Unix Tools) ---
# Note: Ensure these are installed via brew: brew install eza bat ripgrep nvim zoxide
alias ls="eza --icons --git --group-directories-first"
alias ll="eza -lh --icons --git"
alias la="eza -a --icons --git"
alias cat="bat"
alias grep="rg"
alias vim="nvim"
alias brewup="brew update && brew upgrade && brew cleanup"
alias refresh="source ~/.zshrc"
alias rc="subl ~/.zshrc"

# --- 5. Power Functions ---
topsize() {
    local target=${1:-.}
    du -sh "${target}" 2>/dev/null | sort -rh | head -n 15
}

# Initializing zoxide (Modern 'cd')
eval "$(zoxide init zsh)"

# --- 6. Prompt Customization ---
PROMPT='%F{cyan}%1~%f %F{yellow}%% %f'

# --- 7. Syntax Highlighting & Autosuggestions ---
# These paths are standard for Apple Silicon Homebrew
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# Extra

source <(fzf --zsh)