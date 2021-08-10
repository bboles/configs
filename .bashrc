# .bashrc

# Source global definitions
if [[ -f /etc/bashrc ]]; then
        . /etc/bashrc
fi

# do this because of it being set in /etc/bashrc
unset PROMPT_COMMAND

# User specific aliases and functions
#PATH=~/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/opt/curl/bin:$PATH:/sbin:/usr/sbin:/usr/local/opt/go/libexec/bin
PATH=~/bin:/usr/local/bin:$PATH:/sbin:/usr/sbin:/usr/local/opt/mysql-client/bin

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . /usr/local/etc/profile.d/bash_completion.sh

export FZF_DEFAULT_COMMAND='find .'
export FZF_HISTORY_FZF_OPTS='--pointer=-> --tiebreak=begin'

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

if [[ -f ~/.inputrc.fzf && -r ~/.inputrc.fzf ]]; then

  # Make _Fzf_ available through _Readline_ key bindings.
  #
  bind -f ~/.inputrc.fzf
  source ~/bin/fzfhistory
fi

# append each command to our shell history
export HISTTIMEFORMAT='%F %T '          # timestamp each entry
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=10000                   # big big history
export HISTFILESIZE=10000               # big big history
shopt -s histappend                     # append to history, don't overwrite it

# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# stolen from
# https://github.com/eliben/code-for-blog/blob/master/2016/persistent-history/add-persistent-history.sh
log_bash_persistent_history() {
  local rc=$?
  [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [[ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]]; then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command() {
  log_bash_persistent_history
  #prompt_command
}

PROMPT_COMMAND="run_on_prompt_command"

# ignore minor spelling mistakes
# doesn't seem to be available in bash on centos < 6 so chuck any error displayed
shopt -s cdspell 2>/dev/null
shopt -s dirspell 2>/dev/null

# Entering a directory name as a bare word will change into that directory
shopt -s autocd 2>/dev/null

# Enable fancy globbing functions
shopt -s extglob

set -o vi
export EDITOR=/usr/bin/vim

export BAT_THEME="DarkNeon"

function prompt_command() {
  # EXIT="$?"             # This needs to be first
  PS1=""

  ### Colors to Vars ### {{{
  ## Inspired by http://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
  ## Terminal Control Escape Sequences: http://www.termsys.demon.co.uk/vtansi.htm
  ## Consider using some of: https://gist.github.com/bcap/5682077#file-terminal-control-sh
  ## Can unset with `unset -v {,B,U,I,BI,On_,On_I}{Bla,Red,Gre,Yel,Blu,Pur,Cya,Whi} RCol`
  local RCol='\[\e[0m\]'	# Text Reset
  
  # Regular                  Bold                        Underline                   High Intensity              BoldHigh Intensity           Background              High Intensity Backgrounds
  local Bla='\[\e[0;30m\]';  local BBla='\[\e[1;30m\]';  local UBla='\[\e[4;30m\]';  local IBla='\[\e[0;90m\]';  local BIBla='\[\e[1;90m\]';  local On_Bla='\e[40m';  local On_IBla='\[\e[0;100m\]';
  local Red='\[\e[0;31m\]';  local BRed='\[\e[1;31m\]';  local URed='\[\e[4;31m\]';  local IRed='\[\e[0;91m\]';  local BIRed='\[\e[1;91m\]';  local On_Red='\e[41m';  local On_IRed='\[\e[0;101m\]';
  local Gre='\[\e[0;32m\]';  local BGre='\[\e[1;32m\]';  local UGre='\[\e[4;32m\]';  local IGre='\[\e[0;92m\]';  local BIGre='\[\e[1;92m\]';  local On_Gre='\e[42m';  local On_IGre='\[\e[0;102m\]';
  local Yel='\[\e[0;33m\]';  local BYel='\[\e[1;33m\]';  local UYel='\[\e[4;33m\]';  local IYel='\[\e[0;93m\]';  local BIYel='\[\e[1;93m\]';  local On_Yel='\e[43m';  local On_IYel='\[\e[0;103m\]';
  local Blu='\[\e[0;34m\]';  local BBlu='\[\e[1;34m\]';  local UBlu='\[\e[4;34m\]';  local IBlu='\[\e[0;94m\]';  local BIBlu='\[\e[1;94m\]';  local On_Blu='\e[44m';  local On_IBlu='\[\e[0;104m\]';
  local Pur='\[\e[0;35m\]';  local BPur='\[\e[1;35m\]';  local UPur='\[\e[4;35m\]';  local IPur='\[\e[0;95m\]';  local BIPur='\[\e[1;95m\]';  local On_Pur='\e[45m';  local On_IPur='\[\e[0;105m\]';
  local Cya='\[\e[0;36m\]';  local BCya='\[\e[1;36m\]';  local UCya='\[\e[4;36m\]';  local ICya='\[\e[0;96m\]';  local BICya='\[\e[1;96m\]';  local On_Cya='\e[46m';  local On_ICya='\[\e[0;106m\]';
  local Whi='\[\e[0;37m\]';  local BWhi='\[\e[1;37m\]';  local UWhi='\[\e[4;37m\]';  local IWhi='\[\e[0;97m\]';  local BIWhi='\[\e[1;97m\]';  local On_Whi='\e[47m';  local On_IWhi='\[\e[0;107m\]';
  ### End Color Vars ### }}}

export PS1='$(EXIT="$?";if [[ $EXIT -ne 0 ]]; then echo "'${Gre}''${On_Red}'['${Bla}''${On_Red}'\u'${Gre}''${On_Red}'@\h:\w '${BIYel}''${On_Bla}'($EXIT)'${Gre}''${On_Red}']'${RCol}'\n'${RCol}'\$ "; else echo "'${Gre}''${On_Red}'['${Bla}''${On_Red}'\u'${Gre}''${On_Red}'@\h:\w]'${ICya}'\n'${RCol}'\$ "; fi)'

}

# export PROMPT_COMMAND=prompt_command  # Func to gen PS1 after CMDs

gos () {
  SSHSCRIPTDIR=~/src/gitlab/cb/dotfiles
  # OLDTERM=$TERM
  
  # trap "echo -e "\[\ekbash\e\\]"" SIGINT SIGTERM SIGSTOP SIGHUP EXIT

  # if [[ "$TERM" = 'screen' ]]; then
  #  TERM=xterm
  #  echo -e "\[\ek${1%%.*}\e\\]"  # only get the short name
  # fi
  if [[ $1 != *nsmgmt* ]]; then     # skip netscalers
    # ssh $1 "rm ~/.bashrc 2>/dev/null; [[ ! -d ~/tmp ]] && mkdir ~/tmp; [[ ! -d ~/bin ]] && mkdir ~/bin"
    # ssh -t $1 "ls -al 2>&1 >/dev/null; history -w"
    ssh $1 "[[ ! -d ~/tmp ]] && mkdir ~/tmp; [[ ! -d ~/bin ]] && mkdir ~/bin"
    # scp -q ~/src/pssgit/configs/space $1:~/bin/
    scp -q $SSHSCRIPTDIR/.server.bash_profile $1:~/.bash_profile
    scp -q $SSHSCRIPTDIR/.server.bashrc $1:~/.bashrc
    scp -q $SSHSCRIPTDIR/.server.vimrc $1:~/.vimrc
    scp -q $SSHSCRIPTDIR/.inputrc $1:~/.inputrc
  fi
  ssh $1
  # TERM=$OLDTERM
  # echo -e "\[\ekbash\e\\]"
}

updatehostsandaliases () {
  # rotate='|/-\'

  for host in `sed -e 's/[, ].*//' ~/.ssh/known_hosts`; do
    # check if it already exists and skip
    type ${host} > /dev/null 2>&1 && continue
    alias ${host}="gos ${host}"
  
    # Remove domainnames
    domain=${host%%.*}
    if [[ "${domain}" != "${host}" ]]; then
      if ! type ${domain} > /dev/null 2>&1; then
        alias ${domain}="gos ${host}"
      fi
      if ! type scp${domain} > /dev/null 2>&1; then
        eval "function scp${host}() { scp \${1} ${host}:\${2:-/tmp}; }"
      fi
    fi
    # rotate="${rotate#?}${rotate%???}"
    # printf '\b%.1s' "$rotate"
    # sleep 0.01
    type scp${host} > /dev/null 2>&1 && continue
    eval "function scp${host}() { scp \${1} ${host}:~/tmp/; }"
  done # && echo aliases rebuilt
}

updatehostsandaliases

# if [[ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]]; then
#   GIT_PROMPT_ONLY_IN_REPO=1
#   source "$HOME/.bash-git-prompt/gitprompt.sh"
# fi

export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgrep.txt

export WORKON_HOME=~/src/python/.virtualenvs
export PROJECT_HOME=~/src/python/dev
export VIRTUALENV_PYTHON=/usr/local/opt/python/libexec/bin/python
[[ -e /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh

# used by bak function further down and recognized by a number of gnu utils
export VERSION_CONTROL=numbered

# use our own LS_COLORS
export LS_COLORS='rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

# this will make nested tmux session panes display properly on a remote host
# export LANG='en_US'

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
# allows sudo to recognize our aliases
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
alias gcloud='docker run --rm -ti -v $(pwd):/mnt -v $HOME/.config/gcloud:/root/.config/gcloud -v $HOME/.ssh/google_compute_engine:/root/.ssh/google_compute_engine -v $HOME/.ssh/google_compute_known_hosts:/root/.ssh/google_compute_known_hosts -v $HOME/.ssh/google_compute_engine.pub:/root/.ssh/google_compute_engine.pub google/cloud-sdk gcloud'

alias rpmqi='rpm -qi'
alias rpmqa='rpm -qa | grep '
alias rpmql='rpm -ql'
alias rpmqf='rpm -qf'

alias pat='sudo puppet agent -t'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

if [[ -f ~/src/github/complete-alias/complete_alias ]]; then
  source ~/src/github/complete-alias/complete_alias
  complete -F _complete_alias k
fi
complete -cf sudo
complete -o default -o nospace -F _ssh gos
complete -F _man vman
# complete -C /home/linuxbrew/.linuxbrew/bin/aws_completer aws
# [[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
#complete -C ~/bin/gcloud-docker-completion.sh gcloud
# source ~/scratch/gcloud-completion/completion.bash.inc

current-branch () {
  git rev-parse --symbolic-full-name --abbrev-ref HEAD
}

gco () {
  git checkout -b $1 && git push --set-upstream origin $1
}

rpmcl () {
  rpm --changelog -q $1 | more
}

rpmq () {
  rpm -qf $(which $1)
}

c () {
  awk "BEGIN{ print $* }"
}

bak () {
  DATESTAMP=$(date "+%Y%m%d.%H%M%S")
  # cp --force --backup $1 $1
  cp $1 $1.$DATESTAMP
}

mkcd () {
    mkdir -p "$*"
    cd "$*"
}

rgrep () {
    grep --color=auto -r "$*" *
}

# only if we are interactive...
if [[ $- =~ "i" ]]; then
  ( [[ -x /usr/bin/fortune ]] || [[ -x /usr/local/bin/fortune ]] ) && fortune 

    # put some color in our man pages
    export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
    export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
    export LESS_TERMCAP_me=$(tput sgr0)
    export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
    export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
    export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
    export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)
    export LESS_TERMCAP_ZN=$(tput ssubm)
    export LESS_TERMCAP_ZV=$(tput rsubm)
    export LESS_TERMCAP_ZO=$(tput ssupm)
    export LESS_TERMCAP_ZW=$(tput rsupm)
    export GROFF_NO_SGR=1                           # needed for Konsole
fi

# Turn on shell completion for gcloud commands.
# export CLOUDSDK_PYTHON="$(brew --prefix)/opt/python@3.8/libexec/bin/python"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# This is so git knows about our gpg key.
export GPG_TTY=$(tty)

if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
# 
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# . /home/linuxbrew/.linuxbrew/opt/asdf/asdf.sh
# . /home/linuxbrew/.linuxbrew/opt/asdf/etc/bash_completion.d/asdf.bash
# . ~/tools/stern_completion.sh

# ruby things:
#
# This keeps openssl updated with brew vs. not being updated otherwise
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

eval "$(/usr/local/bin/starship init bash)"

# source /home/bboles/.config/broot/launcher/bash/br

# begin appcenter completion
[[ -f "$HOME/tools/appcenter/completion.sh" ]] && source "$HOME/tools/appcenter/completion.sh"

# completion for gh command
eval "$(gh completion -s bash)"

# completion for kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k
