#!/bin/bash
if [ -e ~/.zshrc ]; then rm ~/.zshrc;fi;
if [ -e ~/.zshenv ]; then rm ~/.zshenv;fi;
if [ -e ~/.screenrc ]; then rm ~/.screenrc;fi;
if [ -e ~/.vim ]; then rm -rf ~/.vim;fi;
if [ -e ~/.vimrc ]; then rm ~/.vimrc;fi;

WD=`dirname $0`
ln -s $WD/.zshrc ~/.zshrc
ln -s $WD/.zshenv ~/.zshenv
ln -s $WD/.screenrc ~/.screenrc
ln -s $WD/.vim ~/.vim
ln -s $WD/.vimrc ~/.vimrc

echo "launch vim and tipe :BundleInstall"
