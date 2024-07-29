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
# 20/06/2023 disabled to check i3/Xorg hangs...
#if [ -z "$(pgrep picom)" ] ; then
#   picom &
#fi

# xbindkeys
if [ -z "$(pgrep xbindkeys)" ] ; then
   xbindkeys &
fi

# parcellite
if [ -z "$(pgrep parcellite)" ] ; then
   /usr/bin/parcellite &
fi

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
# 20/06/2023 disabled to check i3/Xorg hangs...
# xautolock -time 15 -locker slock &

# solaar
if [ -z "$(pgrep solaar)" ] ; then
   /usr/bin/solaar -b symbolic -w hide &
fi

# caffeine (suspend management)
caffeine start &

# SSH agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# wallpaper
feh --no-fehbg --bg-fill .cache/wall

# wait polybar tray is ready before start onedrive_tray...
sleep 2

# onedrive
if [ -z "$(pgrep onedrive_tray)" ] ; then
   onedrive_tray --onedrive-args "--verbose --monitor --disable-notifications" &
fi

# disable DPMS and prevent screen from blanking
/usr/bin/xset s off -dpms
