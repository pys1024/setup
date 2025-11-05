#!/usr/bin/env bash
set -e 

cdir=$(cd $(dirname $(realpath $0)); pwd)
info=$(uname -a)

if [[ $info =~ "Linux" ]]; then
    if [ x"-a" = x"$1" ]; then
        # install for all users
        sudo cp $cdir/OTF/ /usr/share/fonts/Source-code-pro -rf
        sudo fc-cache
    else
        # install for yourself
        mkdir -p ~/.fonts
        cp $cdir/OTF/* ~/.fonts
        fc-cache -f -v
    fi
else
    cp $cdir/TTF/* /c/Windows/Fonts -rf
fi
