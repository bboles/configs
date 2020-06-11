# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# do this because of it being set in /etc/bashrc
unset PROMPT_COMMAND

# User specific aliases and functions
PATH=~/bin:$PATH:/sbin:/usr/sbin

# append each command to our shell history
export HISTTIMEFORMAT='%F %T '          # timestamp each entry
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=10000                   # big big history
export HISTFILESIZE=10000               # big big history
shopt -s histappend                     # append to history, don't overwrite it

# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# stolen from
# https://github.com/eliben/code-for-blog/blob/master/2016/persistent-history/add-persistent-history.sh
log_bash_persistent_history() {
  local rc=$?
  [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]; then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command() {
  log_bash_persistent_history
  prompt_command
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

export PS1='$(EXIT="$?";if [[ $EXIT -ne 0 ]]; then echo "'${Blu}''${On_Yel}'['${Bla}''${On_Yel}'\u'${Blu}''${On_Yel}'@\h:\w '${BIYel}''${On_Bla}'($EXIT)'${Blu}''${On_Yel}']'${RCol}'\n'${RCol}'\$ "; else echo "'${Blu}''${On_Yel}'['${Bla}''${On_Yel}'\u'${Blu}''${On_Yel}'@\h:\w]'${ICya}'\n'${RCol}'\$ "; fi)'

}

# export PROMPT_COMMAND=prompt_command  # Func to gen PS1 after CMDs

# used by bak function further down and recognized by a number of gnu utils
export VERSION_CONTROL=numbered

# this will make nested tmux session panes display properly on a remote host
# export LANG='en_US'

alias l='ls --color=auto -al'
alias lh='ls --color=auto -alh'
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias lt='ls --color=auto -altr'
alias grep='grep --color=auto'
alias igrep='grep --color=auto -i'
alias ifind='find . -iname'
alias findit='find . -name'
alias df='df -Ph | column -t'
alias mt='mount | column -t'
alias more='/usr/bin/less -R'
alias bc='bc ~/.bc'
alias psef='ps -ef | grep'
alias tn='telnet'
alias rup='. ~/.bashrc'
alias r='fc -s'
alias rsyncp='rsync -ahvP'
alias cal='cal -3'
alias wh='history -w'
alias tf='tail -f'
alias stf='sudo tail -f'
alias sd='sudo docker'
alias phgrep='cat ~/.persistent_history|grep --color'
# allows sudo to recognize our aliases
alias sudo='sudo '
alias svi='sudoedit'

alias rpmqi='rpm -qi'
alias rpmqa='rpm -qa | grep '
alias rpmql='rpm -ql'
alias rpmqf='rpm -qf'

alias pat='sudo puppet agent -t'

complete -cf sudo
complete -o default -o nospace -F _ssh gos

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
    [[ -x /usr/local/bin/fortune ]] && fortune 

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
fi
