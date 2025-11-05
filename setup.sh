#!/usr/bin/env bash
set -e

cdir=$(cd $(dirname $(realpath $0)); pwd)
bakdir=$cdir/bak_$(date +%Y%m%d%H%M%S)

bakup_if_exists() {
    mkdir -p $bakdir
    if [ -e $1 ]; then
        mv $1 $bakdir
    fi
}

setup() {
    local src=$cdir/$1
    local dst=$HOME/$1
    bakup_if_exists $dst
    ln -s $src $dst
}

setup .bashrc
setup .bash_alias
setup .bash_func
setup .bash_path

setup .inputrc
setup .vimrc
setup .gitconfig
setup .gitprompt

setup .tmux.conf
setup tmux.sh

# install source code pro
$cdir/source-code-pro/install.sh
# install bat
# install eza
# install ripgrep
# install fd-find
# install fzf
# install rustup & cargo
