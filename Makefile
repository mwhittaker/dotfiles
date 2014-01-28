.PHONY: all help install vimrc vundle

LINK       = ln -s -i
PM         = apt-get
PM_INSTALL = $(PM) install

all: help

help:
	@echo "make [install]"

install: gitconfig vimrc vundle

vimrc: .vimrc
	$(LINK) "$$(pwd)/$<" ~/$<

gitconfig: .gitconfig
	$(LINK) "$$(pwd)/$<" ~/$<
	$(PM_INSTALL) gitg

vundle:
	-git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle && vim +BundleInstall +qall
