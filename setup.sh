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
setup .fzfrc

setup .gitconfig
setup .gitprompt

setup .tmux.conf
setup tmux.sh

# install source code pro
$cdir/source-code-pro/install.sh

# -------------------- RUST TOOLS --------------------
# install bat
#cargo install --locked bat
# install eza
#cargo install --locked eza
# install ripgrep
#cargo install --locked ripgrep
# install fd-find
#cargo install --locked fd-find
# ---------------------------------------------------

# install Z
# git clone https://github.com/rupa/z.git

# install fzf (written in Golang)
# git clone https://github.com/junegunn/fzf.git

# install rustup & cargo
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
