#!/usr/bin/env bash
set -euo pipefail

RED_C='\033[1;31m'
GREEN_C='\033[1;32m'
YELLOW_C='\033[1;33m'
BLUE_C='\033[1;34m'
MAGENTA_C='\033[1;35m'
CYAN_C='\033[1;36m'
WHITE_C='\033[1;37m'
BLACK_C='\033[1;38m'
NC='\033[0m'

cdir=$(
    cd $(dirname $(realpath $0))
    pwd
)
bakdir=$cdir/bak_$(date +%Y%m%d%H%M%S)

bakup_if_exists() {
    if [ -L $1 ] || [ -e $1 ]; then
        mkdir -p $bakdir
        mv $1 $bakdir
    fi
}

# dst <- src
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

    if [ -L $dst ] && [ $(readlink $dst) = $src ]; then
        echo -e "${GREEN_C}[SETUP]${WHITE_C}Symbolic file is ready: $dst$NC"
    else
        bakup_if_exists $dst
        mkdir -p $(dirname $dst)
        echo -e "${GREEN_C}[SETUP]${CYAN_C}Create symbolic link: $dst -> $src$NC"
        ln -s $src $dst
    fi
}

setup .setup $cdir

setup .bashrc
setup .bash_alias
setup .bash_func

setup .inputrc
setup .vimrc
setup .fzfrc

setup .gitconfig
setup .gitprompt

setup .tmux.conf
setup tmux.sh

setup .cargo/config.toml

setup .config/opencode
setup .config/lazygit
setup .config/zsh
setup .config/fish
setup .config/ranger
setup .config/neofetch
setup .config/yazi
setup .config/starship.toml
setup .config/starship-tmux.toml

# -------------------- NERDFONT ---------------------
# install nerdfont/source code pro
# ---------------------------------------------------
echo -e "${GREEN_C}[SETUP]${CYAN_C}Install nerdfont...$NC"
$cdir/nerdfont/install.sh

# -------------------- HOMEBREW ---------------------
# install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ---------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
    echo -e "${GREEN_C}[SETUP]${CYAN_C}Install homebrew...$NC"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# -------------------- RUST TOOLS -------------------
# install rustup & cargo
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
# ---------------------------------------------------
install_rust_tools() {
    rust_tools="bat eza ripgrep fd-find du-dust bottom git-delta watchexec-cli \
    hyperfine starship tealdeer hexyl zoxide tree-sitter-cli \
    jaq procs just cargo-edit cargo-watch"

    echo -e "${GREEN_C}[SETUP]${CYAN_C}Install RUST tools...$NC"
    for tool in $rust_tools; do
        if cargo install --list | grep -q "^$tool v"; then
            echo -e "${GREEN_C}[SETUP]${WHITE_C}RUST tool is ready: $tool$NC"
        else
            echo -e "${GREEN_C}[SETUP]${CYAN_C}Install $tool...$NC"
            cargo install --locked $tool
        fi
    done
}

if command -v cargo >/dev/null 2>&1; then
    install_rust_tools
else
    echo -e "${GREEN_C}[SETUP]${CYAN_C}Install RUST environment...$NC"
    curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh

    install_rust_tools
fi

# -------------------- LAZYGIT ----------------------
# install fzf (written in Golang)
# git clone https://github.com/junegunn/fzf.git
# ---------------------------------------------------
if command -v fzf >/dev/null 2>&1; then
    echo -e "${GREEN_C}[SETUP]${WHITE_C}Tool is ready: fzf$NC"
else
    if command -v brew >/dev/null 2>&1; then
        echo -e "${GREEN_C}[SETUP]${CYAN_C}Install fzf...$NC"
        brew install fzf
    else
        echo -e "${GREEN_C}[SETUP]${YELLOW_C}FZF is NOT installed!$NC"
    fi
fi

# -------------------- LAZYGIT ----------------------
# install nerdfont/source code pro
# Lazygit: https://github.com/jesseduffield/lazygit (written in Golang)
# ---------------------------------------------------
if command -v lazygit >/dev/null 2>&1; then
    echo -e "${GREEN_C}[SETUP]${WHITE_C}Tool is ready: lazygit$NC"
else
    if command -v brew >/dev/null 2>&1; then
        echo -e "${GREEN_C}[SETUP]${CYAN_C}Install lazygit...$NC"
        brew install lazygit
    else
        echo -e "${GREEN_C}[SETUP]${YELLOW_C}Lazygit is NOT installed!$NC"
    fi
fi

# Ghostty: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# install Z: deprecated, replaced by zoxide
# git clone https://github.com/rupa/z.git

