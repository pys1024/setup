#!/usr/bin/env bash
set -e

cdir=$(cd $(dirname $(realpath $0)); pwd)
bakdir=$cdir/bak_$(date +%Y%m%d%H%M%S)

bakup_if_exists() {
    mkdir -p $bakdir
    if [ -L $1 ] || [ -e $1 ]; then
        mv $1 $bakdir
    fi
}

setup() {
    local src=""
    local dst=""

    if [ $# -eq 1 ]; then
        src=$cdir/$1
        dst=$HOME/$1
    elif [ $# -eq 2 ]; then
        src=$2
        dst=$HOME/$1
    else
        return
    fi

    bakup_if_exists $dst
    ln -s $src $dst
}

setup .setup $cdir 

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

setup .cargo/config.toml

# install nerdfont/source code pro
$cdir/nerdfont/install.sh

# -------------------- RUST TOOLS --------------------
#cargo install --locked bat
#cargo install --locked eza
#cargo install --locked ripgrep
#cargo install --locked fd-find
#cargo install --locked du-dust
#cargo install --locked bottom
#cargo install --locked git-delta
#cargo install --locked watchexec-cli
#cargo install --locked hyperfine
#cargo install --locked starship
#cargo install --locked tealdeer
#cargo install --locked hexyl
#cargo install --locked zoxide

#cargo install --locked procs
#cargo install --locked just
#cargo install --locked cargo-edit cargo-watch
# ---------------------------------------------------

# install Z
# git clone https://github.com/rupa/z.git

# install fzf (written in Golang)
# git clone https://github.com/junegunn/fzf.git

# install rustup & cargo
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh

# lazygit: https://github.com/jesseduffield/lazygit (written in Golang)
