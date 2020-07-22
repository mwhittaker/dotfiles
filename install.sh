#! /usr/bin/env bash

set -euo pipefail

link() {
    ln -s -i "$(pwd)/$1" $2 || true
}

install_bash_aliases() {
    link .bash_aliases ~/.bash_aliases
}

install_bash_functions() {
    link .bash_functions ~/.bash_functions
}

install_bash_path() {
    link .bash_path ~/.bash_path
}

install_bashrc() {
    link .bashrc ~/.bashrc
}

install_gitconfig() {
    link .gitconfig ~/.gitconfig
}

install_tmux_conf() {
    local tmux_version=$(tmux -V | awk '{print $2}')
    if echo "$tmux_version" | grep '3.' > /dev/null; then
        link .tmux.conf-3.0 ~/.tmux.conf
    elif test $(echo "$tmux_version <= 1.8" | bc) -eq 1; then
        link .tmux.conf-1.8 ~/.tmux.conf
    elif test $(echo "$tmux_version < 2.0" | bc) -eq 1; then
        cat .tmux.conf-1.8 > .tmux.conf
        cat .tmux.conf-1.9 >> .tmux.conf
        link .tmux.conf ~/.tmux.conf
    else
        link .tmux.conf-2.0 ~/.tmux.conf
    fi

    if [[ $(uname) = "Darwin" ]]; then
        link .tmux.conf-macos ~/.tmux.conf-macos
    fi
}

install_vimrc() {
    if test ! -d ~/.vim/bundle/Vundle.vim; then
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    link .vimrc ~/.vimrc
    vim +PluginInstall +qa
}


install_xmonad_hs() {
    if [[ $(uname) = Linux ]]; then
        mkdir -p ~/.xmonad
        link xmonad.hs ~/.xmonad/xmonad.hs
    fi
}

install_latexmkrc() {
    link .latexmkrc ~/.latexmkrc
}

main() {
    if ! [[ "$(basename $PWD)" = "dotfiles" ]]; then
        echo "You must run install.sh script from within dotfiles/."
        return 1
    fi
    install_bash_aliases
    install_bash_functions
    install_bash_path
    install_bashrc
    install_gitconfig
    install_tmux_conf
    install_vimrc
    install_xmonad_hs
    install_latexmkrc
}

main
