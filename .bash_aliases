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

# tla. See [1] for more information.
#
# [1]: https://medium.com/@bellmar/introduction-to-tla-model-checking-in-the-command-line-c6871700a6a2
alias sany='java -cp "$TLA_PATH" tla2sany.SANY'
alias tlc='java -cp "$TLA_PATH" tlc2.TLC'
alias tla2tex='java -cp "$TLA_PATH" tla2tex.TLA'

# misc
alias chrome="google-chrome"
