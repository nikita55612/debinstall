#!/bin/bash

set -e

[[ $EUID -eq 0 ]] || exec sudo "$0" "$@"

chmod +x ./*.sh

"./base.sh"
"./system.sh"
"./vim.sh"
"./yazi.sh"
"./golang.sh"
"./3proxy.sh"
"./xraycore.sh"

source "./newuser.sh"

newuserhome="/home/$NEW_USERNAME"

mkdir -p "$newuserhome"/tmpscripts
cp ./*.sh "$newuserhome"/tmpscripts/
chown -R "$NEW_USERNAME:$NEW_USERNAME" "$newuserhome"/tmpscripts
chmod +x "$newuserhome"/tmpscripts/*.sh

su - "$NEW_USERNAME" -c "
    cd '$newuserhome/tmpscripts'
    ./ssh.sh
    ./vim.sh
    ./yazi.sh
    ./golang.sh
"

rm -rf "$newuserhome"/tmpscripts
