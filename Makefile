.PHONY: all help install vimrc vundle

all: help

help:
	@echo "make [install]"

install: vimrc vundle

vimrc: .vimrc
	ln -s "$$(pwd)/.vimrc" ~/.vimrc

vundle:
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
