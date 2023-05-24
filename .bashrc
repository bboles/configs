# Source global definitions.
[[ -f /etc/bashrc ]] && . /etc/bashrc

# Do this in case it is set globally.  We set it later on and it may interfere otherwise.
unset PROMPT_COMMAND

# PATH=~/bin:/usr/local/bin:$PATH:/sbin:/usr/sbin:/usr/local/opt/mysql-client/bin

[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . $(brew --prefix)/etc/profile.d/bash_completion.sh

source ~/bin/fzfhistory
bind -m vi-insert -x '"\C-r": "__fzf_history"'
bind -m vi-command -x '"\C-r": "__fzf_history"'

# Append each command to our shell history.
export HISTTIMEFORMAT='%F %T '          # timestamp each entry
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=10000                   # big big history
export HISTFILESIZE=10000               # big big history
shopt -s histappend                     # append to history, don't overwrite it

# Stolen from:
# https://github.com/eliben/code-for-blog/blob/master/2016/persistent-history/add-persistent-history.sh
log_bash_persistent_history() {
  local rc=$?
  [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [[ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]]; then
    printf "%s\t%s\n" "$date_part" "$command_part" >>~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND.
run_on_prompt_command() {
  log_bash_persistent_history
}

# Ignore minor spelling mistakes.
# Doesn't seem to be available in bash on centos < 6 so chuck any error displayed.
shopt -s cdspell 2>/dev/null
shopt -s dirspell 2>/dev/null

# Entering a directory name as a bare word will change into that directory.
shopt -s autocd 2>/dev/null

# Enable fancy globbing functions.
shopt -s extglob

set -o vi

export PROMPT_COMMAND="run_on_prompt_command"
export EDITOR=/usr/bin/vim
export BAT_THEME="DarkNeon"
export FZF_DEFAULT_COMMAND='find .'
export FZF_HISTORY_FZF_OPTS='--pointer=-> --tiebreak=begin'
# Set FZF key bindings for Vim
export FZF_DEFAULT_OPTS="--bind='ctrl-n:down,ctrl-p:up,ctrl-f:page-down,ctrl-b:page-up,ctrl-a:toggle-all'"
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgrep.txt
export VERSION_CONTROL=numbered
# This is so git knows about our gpg key.
export GPG_TTY=$(tty)
export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
# Use our own LS_COLORS.
export LS_COLORS='rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export MANPAGER='nvim +Man!'

export WORKON_HOME=~/src/python/.virtualenvs
export PROJECT_HOME=~/src/python/dev
export VIRTUALENV_PYTHON=/usr/local/opt/python/libexec/bin/python
[[ -e /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

gos() {
  SSHSCRIPTDIR=~/src/gitlab/cb/dotfiles
  if [[ $1 != *nsmgmt* ]]; then # Skip netscalers.
    ssh $1 "[[ ! -d ~/tmp ]] && mkdir ~/tmp; [[ ! -d ~/bin ]] && mkdir ~/bin"
    scp -q $SSHSCRIPTDIR/.server.bash_profile $1:~/.bash_profile
    scp -q $SSHSCRIPTDIR/.server.bashrc $1:~/.bashrc
    scp -q $SSHSCRIPTDIR/.server.vimrc $1:~/.vimrc
    scp -q $SSHSCRIPTDIR/.inputrc $1:~/.inputrc
  fi
  ssh $1
}

updatehostsandaliases() {
  for host in $(sed -e 's/[, ].*//' ~/.ssh/known_hosts); do
    # Check if it already exists and skip.
    type ${host} >/dev/null 2>&1 && continue
    alias ${host}="gos ${host}"

    # Remove domainnames
    domain=${host%%.*}
    if [[ "${domain}" != "${host}" ]]; then
      if ! type ${domain} >/dev/null 2>&1; then
        alias ${domain}="gos ${host}"
      fi
      if ! type scp${domain} >/dev/null 2>&1; then
        eval "function scp${host}() { scp \${1} ${host}:\${2:-/tmp}; }"
      fi
    fi
    type scp${host} >/dev/null 2>&1 && continue
    eval "function scp${host}() { scp \${1} ${host}:~/tmp/; }"
  done
}

current-branch() {
  git rev-parse --symbolic-full-name --abbrev-ref HEAD
}

gco() {
  git checkout -b $1 && git push --set-upstream origin $1
}

gclone() {
  local firsthalf="${1%:*}"
  local secondhalf="${1#*:}"
  local site="$(echo ${firsthalf#*@} | sed 's/.com//')"
  local org="${secondhalf%/*}"
  local newdir="$(echo "${secondhalf%.git}" | awk -F'/' '{print $2}')"

  cd ~/src
  mkdir -p "$site/$org"
  cd "$site/$org"

  git clone "$1"
  cd "$newdir"
}

rstats() {
  gh api orgs/RedemptionGames/actions/runners --jq '.runners[] | "\(.name) \(.status) \(.busy)"'
}

rpmcl() {
  rpm --changelog -q $1 | more
}

rpmq() {
  rpm -qf $(which $1)
}

c() {
  awk "BEGIN{ print $* }"
}

bak() {
  DATESTAMP=$(date "+%Y%m%d.%H%M%S")
  cp $1 $1.$DATESTAMP
}

mkcd() {
  mkdir -p "$*"
  cd "$*"
}

rgrep() {
  grep --color=auto -r "$*" *
}

f() {
  local _dir=$(
    cd ~
    fd -H -t d | fzf
  )

  # Only cd if the dir exists.
  if [[ -d "$HOME/$_dir" ]]; then
    cd "$HOME/$_dir"
  fi
}

fzfman() {
  apropos '.' | fzf --height=100% --preview-window=down:wrap \
    --preview='man "$(echo {1} | awk -F"-" "{print $1}" | sed "s/,/\n/g" | sed "s/([123456789])//g")"' \
    --bind='enter:execute(man "$(echo {1} | awk -F"-" "{print $1}" | sed "s/,/\n/g" | sed "s/([123456789])//g")")'
}

chenv() {
  if [[ -f ".envrc.$1" ]]; then
    ln -fs .envrc.$1 .envrc
  else
    echo "File .envrc.$1 does not exist."
  fi
}

alias l='ls -G -al'
alias lh='ls -G -alh'
alias ls='ls -G'
alias ll='ls -G -l'
alias lt='ls -G -altr'
alias grep='grep --color=auto'
alias igrep='grep --color=auto -i'
alias ifind='find . -iname'
alias findit='find . -name'
alias df='df -Ph | column -t'
alias mt='mount | column -t'
alias more='/usr/bin/less -FRX'
alias bc='bc ~/.bc'
alias psef='ps -ef | grep'
alias tn='telnet'
alias rup='. ~/.bashrc'
alias r='fc -s'
alias rsyncp='rsync -ahvP'
alias cal='gcal -s 1 .'
alias wh='history -w'
alias tf='tail -f'
alias stf='sudo tail -f'
alias sd='sudo docker'
alias phgrep='cat ~/.persistent_history|grep --color'
# Allows sudo to recognize our aliases.
alias sudo='sudo '
alias svi='sudoedit'
alias sshcopyid='ssh-copy-id -i ~/.ssh/id_rsa.pub'
alias svn='colorsvn'
alias ave='ansible-vault edit'
alias vi='/usr/bin/vim'
alias brewup='brew upgrade; brew upgrade --cask'
alias k='kubectl'
alias con='k config use-context $(k config get-contexts -o name | fzf)'
alias nam='k config set-context --current --namespace=$(k get namespaces -o name | sed 's%^namespace/%%' | fzf)'
# alias gcloud='docker run --rm -ti -v $(pwd):/mnt -v $HOME/.config/gcloud:/root/.config/gcloud -v $HOME/.ssh/google_compute_engine:/root/.ssh/google_compute_engine -v $HOME/.ssh/google_compute_known_hosts:/root/.ssh/google_compute_known_hosts -v $HOME/.ssh/google_compute_engine.pub:/root/.ssh/google_compute_engine.pub google/cloud-sdk gcloud'

alias rpmqi='rpm -qi'
alias rpmqa='rpm -qa | grep '
alias rpmql='rpm -ql'
alias rpmqf='rpm -qf'

alias pat='sudo puppet agent -t'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# alias git='git-branchless wrap'

if [[ -f ~/src/github/complete-alias/complete_alias ]]; then
  source ~/src/github/complete-alias/complete_alias
  complete -F _complete_alias k
fi
complete -cf sudo
complete -o default -o nospace -F _ssh gos
complete -F _man vman

# Only if we are interactive.
if [[ $- =~ "i" ]]; then
  ([[ -x /usr/bin/fortune ]] || [[ -x $(brew --prefix)/bin/fortune ]]) && fortune

  # Put some color in our man pages.
  export LESS_TERMCAP_mb=$(
    tput bold
    tput setaf 2
  ) # green
  export LESS_TERMCAP_md=$(
    tput bold
    tput setaf 6
  ) # cyan
  export LESS_TERMCAP_me=$(tput sgr0)
  export LESS_TERMCAP_so=$(
    tput bold
    tput setaf 3
    tput setab 4
  ) # yellow on blue
  export LESS_TERMCAP_se=$(
    tput rmso
    tput sgr0
  )
  export LESS_TERMCAP_us=$(
    tput smul
    tput bold
    tput setaf 7
  ) # white
  export LESS_TERMCAP_ue=$(
    tput rmul
    tput sgr0
  )
  export LESS_TERMCAP_mr=$(tput rev)
  export LESS_TERMCAP_mh=$(tput dim)
  export LESS_TERMCAP_ZN=$(tput ssubm)
  export LESS_TERMCAP_ZV=$(tput rsubm)
  export LESS_TERMCAP_ZO=$(tput ssupm)
  export LESS_TERMCAP_ZW=$(tput rsupm)
  export GROFF_NO_SGR=1 # Needed for Konsole.
fi

if [[ -f $(brew --prefix)/bin/gcloud  ]]; then
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Ruby things:
#
# This keeps openssl updated with brew vs. not being updated otherwise
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

if [[ -f $(brew --prefix)/bin/chruby  ]]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

eval "$($(brew --prefix)/bin/starship init bash)"

[[ -f "$HOME/tools/appcenter/completion.sh" ]] && source "$HOME/tools/appcenter/completion.sh"

# Completion for gh command
eval "$(gh completion -s bash)"

# Completion for kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k

# nvm things.
export NVM_DIR="$HOME/.nvm"
[[ -s "/usr/local/opt/nvm/nvm.sh" ]] && \. "/usr/local/opt/nvm/nvm.sh"
[[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ]] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# direnv things
eval "$(direnv hook bash)"
