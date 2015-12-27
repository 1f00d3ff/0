# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=""
HISTFILESIZE="null"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
#######################
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='550 \t \d : Jobs {\j} $ '
else
    PS1='550 \t \d : Jobs {\j} $ '
fi
unset color_prompt force_color_prompt
###########################

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


########################
set -o vi
export EDITOR=vim

#synaptic
if [ $(grep -ic synaptics /proc/bus/input/devices) == 1 ]
then
  synclient TapButton2=2 TapButton3=3
fi

LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

alias btc="curl -s https://api.coindesk.com/v1/bpi/historical/close.json | grep -oP '[:]{1}[0-9.]{6,8}[,]{1}' | sed 's/://g' | tr '\n' ' ' | spark"
alias nn='clear; cd ~/Dropbox/Apps/plain.txt/;ls -lar'
alias s='/home/archimedes/.speedread/speedread -w'

#todo
alias d='~/.dropbox-dist/dropboxd'
alias h="openssl rand -hex 3 | tr '\n' ' ' | xclip"
alias t='clear; ~/.todo/todo.sh -t'
alias tt='vim ~/Dropbox/todo/todo.txt'
alias dd='vim ~/Dropbox/todo/done.txt'
alias motivation='~/nixToolbox/weeklyStatusReport/motivation.sh'
alias weeklyStatus='~/nixToolbox/weeklyStatusReport/weeklyStatus.sh'

alias zero='ssh -D 8081 continuumZero'
alias one='sudo ssh -D 80 continuumZero'

alias boot0='sudo cgpt add -i 6 -P 0 -S 1 /dev/sda'
alias boot1='sudo cgpt add -i 6 -P 5 -S 1 /dev/sda'

PUSHOVER_USER=$(awk '{print $1}' ~/.creds/pushover)
PUSHOVER_TOKEN=$(awk '{print $2}' ~/.creds/pushover)

function pushover {
curl -s -F "token=$PUSHOVER_TOKEN" -F "user=$PUSHOVER_USER" -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json; echo ''
}

TWILIO_ACCOUNT_SID=$(awk '{print $1}' ~/.creds/twilio)
TWILIO_AUTH_TOKEN=$(awk '{print $2}' ~/.creds/twilio)

GIT_USER=$(awk '{print $1}' ~/.creds/git)
GIT_PASS=$(awk '{print $2}' ~/.creds/git)
function createRepo {
  curl -u "$GIT_USER:$GIT_PASS" https://api.github.com/user/repos -d '{"name":"'${1}'"}'
}

AKA_KEY=$(grep Akamai ~/.totp | awk '{print $2}')
function totpAkamai {
  oathtool --base32 --totp "$AKA_KEY"
}

dgs() {
	grep -i "$*" ~/Dropbox/todo/done.txt
}

n() {
	$EDITOR ~/Dropbox/Apps/plain.txt/"$(date '+%Y-%m-%d')_$(openssl rand -hex 3)_$*".txt
}

ngs() {
	grep -i "$*" ~/Dropbox/Apps/plain.txt/*.txt
}

nls() {
	ls -lar ~/Dropbox/Apps/plain.txt/ | grep -i "$*"
}

