#!/bin/bash

pid=`pgrep pulsemixer`
if [[ -z "$pid" ]]; then
   exec ~/.local/bin/alacritty -e /usr/bin/pulsemixer --color 1 --no-mouse
fi

