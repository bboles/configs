# Enable vi mode.
bindkey -v

setopt AUTO_CD            # Change directories without typing 'cd'
setopt CORRECT            # Command spelling correction
setopt GLOB_COMPLETE      # Completion of globs
setopt COMPLETE_IN_WORD   # Complete from both ends of a word
setopt NO_MENU_COMPLETE   # Don't automatically select first match
setopt AUTO_MENU          # Show menu on second tab
# setopt bash_auto_list     # Show completions like Bash after tab
setopt NO_LIST_BEEP       # Don't beep when completion is shown
setopt LIST_TYPES         # Show file types in completions
setopt HIST_VERIFY        # Show history expansion for editing
setopt AUTO_PARAM_SLASH   # Add a / when a dir is completed
setopt COMPLETE_IN_WORD   # Cursor stays in the word instead of moving to the end
setopt NO_LIST_ROWS_FIRST # Nav by column instead of row

# Ensure fpath includes our custom functions directory
if [[ ${fpath[(i)~/.zsh/functions]} -gt ${#fpath} ]]; then
  fpath=(~/.zsh/functions "${fpath[@]}")
fi

# First, ensure fpath is set correctly
fpath+=("$HOMEBREW_PREFIX/share/zsh-completions")

# Load completion system
autoload -Uz compinit
compinit -u

zstyle ':completion:*' completer _extensions _complete _approximate _ignored

# Colors for completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:prefix:*' add-space true
zstyle ':completion:*' menu select
# Enable make target completion
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets' 
# zstyle ':completion:*' file-list all

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/zsh/.zcompcache"

# Match partial words.
zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Turn '//' into '/'.
zstyle ':completion:*' squeeze-slashes true

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

alias ls='lsd --group-directories-first'
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

# source ~/.zsh/functions/atuin-setup
# atuin-setup

zle -N edit-command-line-exec
bindkey -M vicmd 'v' edit-command-line-exec

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey '^[[Z' reverse-menu-complete  # Shift+Tab for backward navigation

# bindkey -M vicmd "k" up-line-or-history
# bindkey -M vicmd "j" down-line-or-history
# bindkey -M viins "^[[A" up-line-or-history
# bindkey -M viins "^[[B" down-line-or-history

# Make up-arrow consistent on both linux and macos.
# bindkey '^[[A' up-line-or-history

source ~/src/github.com/unixorn/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
source ~/src/github.com/z-shell/zui/zui.plugin.zsh
source ~/src/github.com/z-shell/zbrowse/zbrowse.plugin.zsh

# Added by OrbStack: command-line tools and integration.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

source "$HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

# This function will run after zsh-vi-mode initializes.  We can use this to
# overwrite with our own settings.
function zvm_after_init() {
  zvm_bindkey viins '^r' atuin-search
  zvm_bindkey vicmd '^r' atuin-search

  # bindkey -M vicmd 'k' history-search-backward
  bindkey -M vicmd 'k' up-line-or-history

  # This will ensure our latest completions are available.
  rehash
}

# These need to be at the end.
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh"

([[ -x /usr/bin/fortune ]] || [[ -x "$HOMEBREW_PREFIX/bin/fortune" ]]) && fortune

if [[ "${OSTYPE}" == 'linux-gnu' ]]; then
    keychain id_ed25519
      . ~/.keychain/`uname -n`-sh
fi

if ([[ "${TERM}" == *tmux* ]] && [[ "${OSTYPE}" == 'linux-gnu' ]]); then
  echo "Nested tmux detected. Setting options."
  # Make sure tmux is started.
  tmux start-server
  tmux set -g prefix C-h 2>/dev/null
  tmux bind h send-prefix 2>/dev/null
  tmux bind C-h last-window 2>/dev/null
  tmux set -as terminal-features ",screen*:clipboard" 2>/dev/null
  # The `terminal-features` setting above is so nested tmux will pass the
  # clipboard to the outer tmux/system clipboard via osc52. 'screen' here
  # references the terminal type.
fi
