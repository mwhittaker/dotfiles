# basics
if [[ $(uname) = "Darwin" ]]; then
    alias ls="ls -G"
    alias grep="grep --color=auto"
fi

# vim
alias v="vim"
alias v-="vim -"

# git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gl="git lg"
alias gs="git status"
alias gca="git commit -a"

# tmux
alias tmux="tmux -2"
alias t="tmux"
alias tnew="tmux new -s"
alias tsync="tmux setw synchronize-panes on"
alias tunsync="tmux setw synchronize-panes off"

# misc
alias ack="ack-grep"
alias weechat="weechat-curses"
alias copy="xclip -selection clipboard"
alias chrome="google-chrome"
