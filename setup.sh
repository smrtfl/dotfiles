#!/usr/bin/env bash

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"#
brew install bottom btop htop cmatrix colima docker docker-compose podman podman-compose ctop awscli coursier/formulas/coursier helm htop jq kubectl k9s krew ktop kubectx kubecolor lazygit neovim node ripgrep saml2aws skhd terraform tmux tree yabai yq zoxide font-hack-nerd-font homerow mactex notion raycast skim

# npm
npm i -g @google/gemini-cli @obi-dbs/k8s-login-cli @tailwindcss/language-server @vue/cli @vue/language-server @vue/typescript-plugin tslib vtop

# symlinks
ln -s .config ~/.config
ln -s .ideavimrc ~/.ideavimrc
ln -s .tmux.conf ~/.tmux.conf
ln -s .npmrc ~/.npmrc
ln -s .testcontainers.properties ~/.testcontainers.properties
ln -s .markdownlint.json ~/.markdownlint.json

# coursier
cs setup
