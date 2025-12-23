#!/usr/bin/env bash

set -e

[[ $EUID -eq 0 ]] || exec sudo "$0" "$@"

if ! systemctl list-unit-files --type=service | grep -q proxyhub.service; then
    git clone --depth 1 https://github.com/nlkli/ProxyHub
	chmod +x ./ProxyHub/install.sh
	./ProxyHub/install.sh
else
	systemctl restart proxyhub.service || systemctl start proxyhub.service
fi
