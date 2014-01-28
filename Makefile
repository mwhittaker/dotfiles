.PHONY: all help install vimrc vundle

all: help

help:
	@echo "make [install]"

install: gitconfig vimrc vundle

vimrc: .vimrc
	ln -s "$$(pwd)/$<" ~/$<

gitconfig: .gitconfig
	ln -s "$$(pwd)/$<" ~/$<
	apt-get install gitg

vundle:
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim +BundleInstall +qall
