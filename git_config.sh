#!/usr/bin/env bash
set -e

git config --global alias.lgg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset %n%f%n' --abbrev-commit -5"
git config --global alias.lgga "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset %n%f%n' --abbrev-commit -5 --all"
git config --global alias.lg "log --graph --decorate --color -5"
git config --global alias.st "status"
git config --global alias.b "branch"
git config --global alias.chk "checkout"

git config --global color.status always
git config --global color.diff always
git config --global color.branch always
git config --global color.interactive always

git config --global core.autocrlf input
git config --global core.editor vim

git config --global user.name pengyongsheng
# git config --global user.email pys1024@sina.com
git config --global user.email pengyongsheng@goodix.com

#git config --global http.proxy 127.0.0.1:8118
#git config --global https.proxy 127.0.0.1:8118
