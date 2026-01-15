#!/usr/bin/env bash
set -e

cdir=$(cd $(dirname $(realpath $0)); pwd)
info=$(uname -a)

if [[ $info =~ "Linux" ]]; then
    if [ x"-a" = x"$1" ]; then
        # install for all users
        sudo mkdir -p /usr/share/fonts/nerdfont
        installed=false
        for font in $cdir/*.{otf,ttf}; do
            if [ -f "$font" ] && [ ! -f "/usr/share/fonts/nerdfont/$(basename $font)" ]; then
                echo "Installing font: $(basename $font)"
                sudo cp "$font" /usr/share/fonts/nerdfont
                installed=true
            fi
        done
        if [ "$installed" = true ]; then
            sudo fc-cache
        fi
    else
        # install for yourself
        mkdir -p ~/.fonts
        installed=false
        for font in $cdir/*.{otf,ttf}; do
            if [ -f "$font" ] && [ ! -f ~/.fonts/$(basename $font) ]; then
                echo "Installing font: $(basename $font)"
                cp "$font" ~/.fonts
                installed=true
            fi
        done
        if [ "$installed" = true ]; then
            fc-cache -f -v
        fi
    fi
else
    for font in $cdir/*.{otf,ttf}; do
        if [ -f "$font" ] && [ ! -f "/c/Windows/Fonts/$(basename $font)" ]; then
            echo "Installing font: $(basename $font)"
            cp "$font" /c/Windows/Fonts
        fi
    done
fi
