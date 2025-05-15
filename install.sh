#!/bin/sh

set -uxo pipefail

# Instsall zgenom
git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install fzf shortcuts
$(brew --prefix)/opt/fzf/install

# Install scm_breeze
git clone https://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze

# Add asdf plugins
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add python https://github.com/danhper/asdf-python.git
