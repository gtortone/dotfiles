#!/bin/sh

# run mons as daemon to fallback display on lcd
#if [ -z "$(pgrep mons)" ] ; then
#   mons -a &
#fi

# disable touchpad tap
xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" "libinput Tapping Enabled" 0

# notification daemon
dunst &

# picom compositor
if [ -z "$(pgrep picom)" ] ; then
   picom &
fi

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

# SSH agent
eval $(gnome-keyring-daemon -s)
export SSH_AUTH_SOCK

# wallpaper
feh --no-fehbg --bg-fill .cache/wall

# wait polybar tray is ready before start onedrive_tray...
sleep 2

# onedrive
if [ -z "$(pgrep onedrive_tray)" ] ; then
   onedrive_tray --onedrive-args "--verbose --monitor --disable-notifications" &
fi
