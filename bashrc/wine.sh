#! /bin/bash

# [[ "$-" != *i* ]] && return

for k in $HOME/dotfiles/wine/*; do
    export PATH="$PATH:$k/bin"
done
