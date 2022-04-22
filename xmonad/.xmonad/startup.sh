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
           --height 24 \
           --alpha 0 \
           --transparent false\
           --width 8 \
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

# Network Applet
if [ -z "$(pgrep nm-applet)" ] ; then
    nm-applet &
fi

# Dropbox
if [ -z "$(pgrep dropbox)" ] ; then
   dropbox start -i &
fi

# Bluetooth
if [ -z "$(pgrep blueman-applet)" ] ; then
   blueman-applet &
fi

# slock (after 15 min inactivity)
xautolock -time 15 -locker slock &

# volume-control
$HOME/.xmonad/volume-control.sh

# SSH agent
eval $(gnome-keyring-daemon -s)
export SSH_AUTH_SOCK
