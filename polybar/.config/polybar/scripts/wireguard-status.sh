#!/bin/sh

wgint="$(/usr/bin/ip addr show dev wg0 2>/dev/null)"

if [[ $wgint == *UP* ]] ;then
	echo "on"
else
	echo "off"
fi
