#!/bin/sh

SCRIPT_PATH="`readlink  "$0"`"
BASE_DIR="$HOME/dotvim"

move() {
    if [ -e "$1" ]; then
        echo "Moving '$1' to '$1.old'";
        mv "$1" "$1.old";
    fi
}

move "$HOME/.vim"
move "$HOME/.vimrc"

ln -sv "$BASE_DIR/vim" "$HOME/.vim"
ln -sv "$BASE_DIR/vimrc" "$HOME/.vimrc"

