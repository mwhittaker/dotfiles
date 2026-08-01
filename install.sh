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
    # tmux -V prints things like "tmux 3.0a" or "tmux next-3.4"; grab the
    # leading digits of the version number.
    local tmux_version=$(tmux -V | awk '{print $2}')
    local tmux_major=$(echo "$tmux_version" | grep -o '[0-9]\+' | head -n 1)
    if [[ -z "$tmux_major" ]] || (( tmux_major < 3 )); then
        echo "tmux 3 or later is required, but found version '$tmux_version'."
        return 1
    fi
    link .tmux.conf ~/.tmux.conf

    if [[ $(uname) = "Darwin" ]]; then
        link .tmux.conf-macos ~/.tmux.conf-macos
    fi
}

install_vimrc() {
    link .vimrc ~/.vimrc
    vim +PlugInstall +qa
}

install_xmonad_hs() {
    if [[ $(uname) = Linux ]]; then
        mkdir -p ~/.xmonad
        link xmonad.hs ~/.xmonad/xmonad.hs
    fi
}

main() {
    if ! [[ "$(basename $PWD)" = "dotfiles" ]]; then
        echo "You must run install.sh script from within dotfiles/."
        return 1
    fi

    sudo apt update
    sudo apt upgrade
    sudo apt install bat fd-find fzf ripgrep
    mkdir -p ~/.local/bin
    ln -s $(which batcat) ~/.local/bin/bat
    ln -s $(which fdfind) ~/.local/bin/fd

    install_bash_aliases
    install_bash_functions
    install_bash_path
    install_bashrc
    install_gitconfig
    install_tmux_conf
    install_vimrc
    # install_xmonad_hs
}

main
