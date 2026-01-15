#!/usr/bin/env bash
set -e

cdir=$(cd $(dirname $(realpath $0)); pwd)
info=$(uname -a)

if [[ $info =~ "Linux" ]]; then
    if [ x"-a" = x"$1" ]; then
        # install for all users
        sudo mkdir -p /usr/share/fonts/nerdfont
        for font in $cdir/*.{otf,ttf}; do
            if [ -f "$font" ] && [ ! -f "/usr/share/fonts/nerdfont/$(basename $font)" ]; then
                sudo cp "$font" /usr/share/fonts/nerdfont
            fi
        done
        sudo fc-cache
    else
        # install for yourself
        mkdir -p ~/.fonts
        for font in $cdir/*.{otf,ttf}; do
            if [ -f "$font" ] && [ ! -f "~/.fonts/$(basename $font)" ]; then
                cp "$font" ~/.fonts
            fi
        done
        fc-cache -f -v
    fi
else
    for font in $cdir/*.{otf,ttf}; do
        if [ -f "$font" ] && [ ! -f "/c/Windows/Fonts/$(basename $font)" ]; then
            cp "$font" /c/Windows/Fonts
        fi
    done
fi
