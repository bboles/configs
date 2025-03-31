# Enable vi mode.
bindkey -v

# Use bash-like tab completion.
setopt GLOB_COMPLETE
setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL

# Colors for completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:prefix:*' add-space true
zstyle ':completion:*' menu select

zmodload zsh/complist

## History setup.
setopt EXTENDED_HISTORY
# Share history across multiple zsh sessions.
setopt SHARE_HISTORY
# Append to history.
setopt APPEND_HISTORY
# Adds commands as they are typed, not at shell exit.
setopt INC_APPEND_HISTORY
# Expire duplicates first.
setopt HIST_EXPIRE_DUPS_FIRST
# Do not store duplicates.
setopt HIST_IGNORE_DUPS
# Ignore duplicates when searching.
setopt HIST_FIND_NO_DUPS
# Removes blank lines from history.
setopt HIST_REDUCE_BLANKS

alias ls='lsd'
alias l='ls -al'
alias lh='ls -alh'
alias ll='ls -l'
alias lt='ls -altr'
alias brewup='brew upgrade; brew upgrade --cask'
alias psef='ps -ef | grep'

eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

# Autoload all functions from specific contexts
# nonomatch prevents errors if the path is not a valid function.
setopt nonomatch
autoload -Uz $^fpath/*(.:t)

source ~/.zsh/functions/atuin-setup
atuin-setup
# The -u (unsafe) is to ignore permissions issues.
compinit -u

zle -N edit-command-line-exec
bindkey -M vicmd 'v' edit-command-line-exec

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

source ~/src/github.com/unixorn/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
source ~/src/github.com/z-shell/zui/zui.plugin.zsh
source ~/src/github.com/z-shell/zbrowse/zbrowse.plugin.zsh

# Added by OrbStack: command-line tools and integration.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

source "$HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
function zvm_after_init() {
  # Define your widget.
  zle -N fzf-atuin-history-widget

  # Bind in both insert and normal mode using zvm_bindkey.
  zvm_bindkey viins '^R' fzf-atuin-history-widget
  zvm_bindkey vicmd '^R' fzf-atuin-history-widget
}

# These need to be at the end.
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh"

([[ -x /usr/bin/fortune ]] || [[ -x "$HOMEBREW_PREFIX/bin/fortune" ]]) && fortune
