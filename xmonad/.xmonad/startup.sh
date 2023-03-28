#!/bin/sh

# Detect active display
autorandr --force --change

# Disable touchpad tap
xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" "Synaptics Tap Action" 0
xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" "Synaptics Tap Time" 0

# System tray
if [ -z "$(pgrep trayer)" ] ; then
    trayer --edge top \
           --align right \
           --widthtype percent \
           --height 26 \
           --transparent false\
           --alpha 0\
           --width 10 \
           --tint 0x282c34 \
           --monitor primary &
fi

# notification daemon
dunst &

# Wallpaper
feh --no-fehbg --bg-fill .cache/wall

# xbindkeys
if [ -z "$(pgrep xbindkeys)" ] ; then
   xbindkeys &
fi

# greenclip
if [ -z "$(pgrep greenclip)" ] ; then
   greenclip daemon &
fi

# autocutsel
#if [ -z "$(pgrep autocutsel)" ] ; then
#   autocutsel -fork &
#   autocutsel -selection PRIMARY -fork &
#fi

# Network Applet
if [ -z "$(pgrep nm-applet)" ] ; then
    nm-applet &
fi

# Dropbox
#if [ -z "$(pgrep dropbox)" ] ; then
#   dropbox start -i &
#fi

# Bluetooth
if [ -z "$(pgrep blueman-applet)" ] ; then
   blueman-applet &
fi

# udiskie
if [ -z "$(pgrep udiskie)" ] ; then
   /usr/bin/udiskie -A -s &
fi

# slock (after 15 min inactivity)
xautolock -time 15 -locker slock &

# caffeine (suspend management)
caffeine start &

# volume-control
$HOME/.xmonad/volume-control.sh

# caps display
$HOME/.xmonad/caps-status.sh

# SSH agent
eval $(gnome-keyring-daemon -s)
export SSH_AUTH_SOCK
