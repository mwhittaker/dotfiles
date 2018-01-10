#! /usr/bin/env bash

set -euo pipefail

link() {
    ln -s -i "$(pwd)/$1" $2
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
    if test $(echo "$tmux_version <= 1.8" | bc) -eq 1; then
        link .tmux.conf-1.8 ~/.tmux.conf
    elif test $(echo "$tmux_version < 2.0" | bc) -eq 1; then
        cat .tmux.conf-1.8 > .tmux.conf
        cat .tmux.conf-1.9 >> .tmux.conf
        link .tmux.conf ~/.tmux.conf
    else
        link .tmux.conf-2.0 ~/.tmux.conf
    fi

    command -v nm-tool >/dev/null 2>&1 || echo "PLEASE INSTALL NM-TOOL"
    command -v amixer  >/dev/null 2>&1 || echo "PLEASE INSTALL AMIXER"
    command -v acpi    >/dev/null 2>&1 || echo "PLEASE INSTALL ACPI"
}

install_vimrc() {
    if test ! -d ~/.vim/bundle/Vundle.vim; then
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    link .vimrc ~/.vimrc
    vim +PluginInstall +qa

    echo 'In ~/.vim/bundle/coquille/autoload/coquille.vim, change'
    echo '  hi CheckedByCoq ctermbg=17 guibg=LightGreen'
    echo '  hi SentToCoq ctermbg=60 guibg=LimeGreen'
    echo 'to'
    echo '  hi link CheckedByCoq ColorColumn'
    echo '  hi link SentToCoq Visual'
}

install_xmonad_hs() {
    mkdir -p ~/.xmonad
    link xmonad.hs ~/.xmonad/xmonad.hs
}

install_latexmkrc() {
    link .latexmkrc ~/.latexmkrc
}

main() {
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
