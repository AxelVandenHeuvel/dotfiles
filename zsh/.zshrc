# --- PATH ---
typeset -U path fpath  # drop duplicate entries when shells nest (tmux, subshells)
eval "$(/opt/homebrew/bin/brew shellenv)"
# after brew shellenv so self-updating installs (claude, codex) win over Homebrew/npm copies
path=("$HOME/.local/bin" $path)

# --- Completions ---
FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- History ---
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# --- Tools ---
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# --- Aliases ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git'
alias cat='bat'

# --- Plugins (autosuggestions before highlighting) ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# syntax highlighting MUST be last
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
