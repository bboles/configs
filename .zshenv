# Environment variables and paths (needed everywhere)
if [[ "${OSTYPE}" == 'linux-gnu' ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  # We are on macos.
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export FZF_PATH="$HOMEBREW_PREFIX/opt/fzf"
export MANPAGER='nvim +Man!'
export EDITOR="$HOMEBREW_PREFIX/bin/nvim"

# FZF settings (must be available for scripts)
fzf_default_opts=(
  "--info=default"
  "--multi"
  "--preview='${FZF_PREVIEW}'"
  "--preview-window='${FZF_PREVIEW_WINDOW}'"
  "$FZF_COLOR_SCHEME"
  "--prompt='∼ '"
  "--pointer='▶'"
  "--marker='✓'"
  "--bind 'ctrl-p:toggle-preview'"
  "--bind 'ctrl-a:select-all'"
  "--bind 'ctrl-e:execute(nvim {+} >/dev/tty)'"
  "--height=${FZF_TMUX_HEIGHT:-50%}"
  "--min-height=50"
  "--tabstop=3"
  "--border=double"
)
export FZF_DEFAULT_OPTS="$(printf '%s ' "${fzf_default_opts[@]}")"

# Path modifications (needed for all sessions)
export cdpath=(. ~ ~/src/)
fpath=(~/.zsh/functions "${fpath[@]}")
fpath=("$HOMEBREW_PREFIX/share/zsh-completions" "${fpath[@]}")
path=(~/bin "${path[@]}")

# OrbStack (if needed for non-interactive sessions)
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
