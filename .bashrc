# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# The code below checks whether the shell that is running this .bashrc is
# running interactively. If it is, then the .bashrc returns and the rest of
# this file is not executed. See [1] for an explanation of this. Normally, this
# is not a problem. When you open up a terminal or ssh in to another machine,
# the shell you interact with is, well, interactive. However, if you try to run
# a command via ssh, like this:
#
#     ssh <address> <command>
#
# then the command is _not_ run in an interactive shell. Thus, the shell in
# which the command is run does not execute this .bashrc. It returns on the
# next bit of code. This is fine for most things. For example, we don't need to
# set PS1 if we're not running interatively. However, we still would like our
# PATH to be updated when running shell commands. So, we source ~/.bash_path
# here instead of down below.
#
# [1]: https://unix.stackexchange.com/a/257613
if [ -f ~/.bash_path ]; then
    . ~/.bash_path
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# See https://stackoverflow.com/a/19533853/3187068 for details.
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%m/%d/%y %T "
export HISTFILE=~/.bash_eternal_history

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# http://misc.flogisoft.com/bash/tip_colors_and_formatting
reset_code() {
    status=$?
    printf "\e[0m"
    return $status
}
bold_code() {
    status=$?
    printf "\e[1m"
    return $status
}
color_code() {
    status=$?
    printf "\e[38;5;$1m"
    return $status
}
git_on() {
    status=$?
    in_git_repo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
    if [[ "$in_git_repo" = "true" ]]; then
        echo " on ";
    fi
    return $status
}
git_branch() {
    status=$?
    in_git_repo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
    if [[ "$in_git_repo" = "true" ]]; then
        if [[ -n "$(git branch)" ]]; then
            echo "$(git rev-parse --abbrev-ref HEAD)";
        else
            echo "(empty)";
        fi
    fi
    return $status
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
    # PS1=$PS1"\`if [ \$? = 0 ]; then echo \[\e[1\;32m\]λ\[\e[0m\]; else echo \[\e[1\;31m\]!\[\e[0m\]; fi\` "
    PS1='${debian_chroot:+($debian_chroot) }'

    PS1="$PS1"'\[$(color_code 160)\]\u'
    PS1="$PS1"'\[$(reset_code)\] at '
    PS1="$PS1"'\[$(color_code 214)\]\h'
    PS1="$PS1"'\[$(reset_code)\]$(git_on)\[$(color_code 27)\]$(git_branch)'
    PS1="$PS1"'\[$(reset_code)\] in '
    PS1="$PS1"'\[$(color_code 141)\]\w'
    PS1="$PS1"'\[$(reset_code)\] '
    PS1="$PS1"'$(if [ $? = 0 ]; then echo \["$(color_code 10)\]\[$(bold_code)\]λ"; else echo "\[$(color_code 9)\]\[$(bold_code)\]!"; fi)'
    PS1="$PS1"'\[$(reset_code)\] '
fi
unset color_prompt force_color_prompt

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Environment variables
if [ -f ~/.bash_variables ]; then
    . ~/.bash_variables
fi

# Functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Enable <ctrl-p> and <ctrl-n> shortcuts
bind 'C-p':history-search-backward
bind 'C-n':history-search-forward

# Add SSH key.
if [[ $(uname) = "Darwin" ]]; then
    ssh-add -K ~/.ssh/id_rsa &> /dev/null
fi

# fzf
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi
if [ -f /usr/share/bash-completion/completions/fzf ]; then
    source /usr/share/bash-completion/completions/fzf
fi
