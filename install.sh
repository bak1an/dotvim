#!/bin/sh

SCRIPT_PATH="`readlink -f "$0"`"
BASE_DIR="`dirname "$SCRIPT_PATH"`"

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

