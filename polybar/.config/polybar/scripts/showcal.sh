#!/bin/bash

pid=`pgrep gcal`
if [[ -z "$pid" ]]; then
   export PAGER=most
   exec ~/.local/bin/alacritty -e gcal -p -s1 -H '\e[97;42m:\e[0m:\e[97;41m:\e[0m' -q IT `date +%Y`
fi

