#!/usr/bin/env bash

# btop
brew install coreutils make gcc@12 lowdown
cd btop
gmake
sudo gmake install
cd -

# Symlinks
ln -s .config ~/.config
ln -s .ideavimrc ~/.ideavimrc
ln -s .tmux.conf ~/.tmux.conf
ln -s .npmrc ~/.npmrc
ln -s .testcontainers.properties ~/.testcontainers.properties
