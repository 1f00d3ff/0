# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export MACHINE=XIAOH
export CROWD_USER=blah
export CROWD_PASS=blahblah

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

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

export PS1=$IBlack$Time12h$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo $(git status) | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    ## nothing to commit
    echo "\t \d :'$Green'"$(__git_ps1 " (%s)"); \
  else \
    ## Changes to working tree
    echo "\t \d :'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$BYellow$PathShort$Color_Off'\$ "; \
else \
  ## Not in git repo
  echo "'$Yellow$PathShort$Color_Off'\t \d {\j}\$ "; \
fi)'

#if [ "$color_prompt" = yes ]; then
#    PS1='abc \t \d : Jobs {\j} $ '
#else
#    PS1='abc \t \d : Jobs {\j} $ '
#fi
#unset color_prompt force_color_prompt
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
CDPATH=:~/nixToolbox/

#synaptic dection and middle click support
if [ $(grep -ic synaptics /proc/bus/input/devices) == 1 ] || [ $(type -p synclient) ]; then
  synclient TapButton2=2 TapButton3=3
fi

LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

alias btc="curl -s https://api.coindesk.com/v1/bpi/historical/close.json | grep -oP '[:]{1}[0-9.]{6,8}[,]{1}' | sed 's/://g' | tr '\n' ' ' | tee <(spark) | sort -rn"
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

alias make="make -j $(($(cat /proc/cpuinfo | grep processor | wc -l)+1))"


export PUSHOVER_USER=$(awk '{print $1}' ~/.creds/pushover)
export PUSHOVER_TOKEN=$(awk '{print $2}' ~/.creds/pushover)
function push {
curl -s -F "token=$PUSHOVER_TOKEN" -F "user=$PUSHOVER_USER" -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json; echo ''
}


export MAKER_KEY=$(awk '{print $1}' ~/.creds/maker)
function ifttt {
curl https://maker.ifttt.com/trigger/$1/with/key/$MAKER_KEY -H "Content-Type: application/json" -d '{"value1":"'$2'"}'
}


export TWILIO_ACCOUNT_SID=$(awk '{print $1}' ~/.creds/twilio)
export TWILIO_AUTH_TOKEN=$(awk '{print $2}' ~/.creds/twilio)
export TWILIO_CALLER_ID=$(awk '{print $3}' ~/.creds/twilio)
function sms {
curl -s -u "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN" -d "From=$TWILIO_CALLER_ID" -d "To=$1" -d "Body=$2" "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/SMS/Messages"; echo ''
}


export GIT_USER=$(awk '{print $1}' ~/.creds/git)
export GIT_PASS=$(awk '{print $2}' ~/.creds/git)
function createRepo {
  curl -u "$GIT_USER:$GIT_PASS" https://api.github.com/user/repos -d '{"name":"'${1}'"}'
}


export AKA_KEY=$(awk '{print $1}' ~/.creds/aka)
function totpAka {
  timeVar=30
  seconds=$(date '+%S')
  if [[ $seconds -ge 30 ]]; then
    timeVar=60
  fi
  remaining=$(($timeVar-$seconds))
  echo $(($timeVar-$seconds)) seconds remaining
  oathtool --base32 --totp "$AKA_KEY" | tee >(xclip)
}



function dgs {
	grep -i "$*" ~/Dropbox/todo/done.txt
}

function n {
	$EDITOR ~/Dropbox/Apps/plain.txt/"$(date '+%Y-%m-%d')_$(openssl rand -hex 3)_$*".txt
}

function ngs {
	grep -i "$*" ~/Dropbox/Apps/plain.txt/*.txt
}

function nls {
	ls -lar ~/Dropbox/Apps/plain.txt/ | grep -i "$*"
}

function quad {
  tmux new -s quad \; split-window \; split-window \; split-window \; select-layout tiled
}

export CROWD_USER=$(awk '{print $1}' ~/.creds/crowd)
export CROWD_PASS=$(awk '{print $2}' ~/.creds/crowd)
