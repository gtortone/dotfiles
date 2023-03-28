#!/bin/sh

# detect active display
autorandr --force --change

# disable touchpad tap
xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" "Synaptics Tap Action" 0
xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" "Synaptics Tap Time" 0

# notification daemon
dunst &

# picom compositor
if [ -z "$(pgrep picom)" ] ; then
   picom &
fi

# wallpaper
feh --no-fehbg --bg-fill .cache/wall

# xbindkeys
if [ -z "$(pgrep xbindkeys)" ] ; then
   xbindkeys &
fi

# greenclip
if [ -z "$(pgrep greenclip)" ] ; then
   greenclip daemon &
fi

# onedrive
killall onedrive
killall onedrive_tray
onedrive_tray -s -a "--disable-notifications --monitor" &

# autocutsel
#if [ -z "$(pgrep autocutsel)" ] ; then
#   autocutsel -fork &
#   autocutsel -selection PRIMARY -fork &
#fi

# network applet
if [ -z "$(pgrep nm-applet)" ] ; then
    nm-applet &
fi

# bluetooth
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

# SSH agent
eval $(gnome-keyring-daemon -s)
export SSH_AUTH_SOCK
