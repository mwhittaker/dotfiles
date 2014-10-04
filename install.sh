#! /bin/sh

link() {
    ln -s -i "$(pwd)/$1" $2
}

install_bash_aliases() {
    link .bash_aliases ~/.bash_aliases 
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
    else
        link .tmux.conf-1.9 ~/.tmux.conf
    fi
}

install_vimrc() {
    if test ! -d ~/.vim/bundle/Vundle.vim; then
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    link .vimrc ~/.vimrc
}

install_xmonad_hs() {
    mkdir -p ~/.xmonad
    link xmonad.hs ~/.xmonad/xmonad.hs
}

main() {
    install_bash_aliases
    install_bashrc
    install_gitconfig
    install_tmux_conf
    install_vimrc
    install_xmonad_hs
}

main