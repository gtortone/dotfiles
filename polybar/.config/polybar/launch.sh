#!/usr/bin/env bash

#  eDP1        HDMI1       DP2-1       bars
#  
#  y           -           -           mainbar(eDP1)
#  -           y           -           mainbar(HDMI1)
#  -           -           y           mainbar(DP2-1)
#  
#  y           y           -           mainbar(eDP1)  lightbar(HDMI1)
#  y           -           y           mainbar(eDP1)  lightbar(DP2-1)
#  -           y           y           mainbar(HDMI1) lightbar(DP2-1)
# 
# note: for mirror, duplicate, primary modes hide secondary bar

nmons=$(polybar -m | wc -l)
mode=$(mons | grep -i "mode" | awk -F ':' '{print $2}' | xargs)
edp1_monitor=$(xrandr --listmonitors | grep -i 'edp1' | awk '{print $4}')
hdmi1_monitor=$(xrandr --listmonitors | grep -i 'hdmi1' | awk '{print $4}')
dp21_monitor=$(xrandr --listmonitors | grep -i 'dp2-1' | awk '{print $4}')

echo $edp1_monitor
echo $hdmi1_monitor
echo $dp21_monitor

PRI=$(xrandr --listmonitors | grep '*' | awk '{print $4}')

if [[ $PRI ]]; then
   # primary monitor defined
   if [ $edp1_monitor ] && [ $edp1_monitor != "${PRI}" ]; then
      SEC=$edp1_monitor
   elif [ $hdmi1_monitor ] && [ $hdmi1_monitor != "${PRI}" ]; then
      SEC=$hdmi1_monitor
   elif [ $dp21_monitor ] && [ $dp21_monitor != "${PRI}" ]; then
      SEC=$dp21_monitor
   fi
else
   # primary monitor not defined
   if [[ $edp1_monitor ]]; then
      PRI=$edp1_monitor
      if [[ $hdmi1_monitor ]]; then
         SEC=$hdmi1_monitor
      elif [[ $dp21_monitor ]]; then
         SEC=$dp21_monitor
      fi
   elif [[ $hdmi1_monitor ]]; then
      PRI=$hdmi1_monitor
      if [[ $dp21_monitor ]]; then
         SEC=$dp21_monitor
      fi
   elif [[ $dp21_monitor ]]; then
      PRI=$dp21_monitor
   fi
fi

rm -f ~/.config/i3/workspace-to-monitor.conf

# launch polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do killall -q polybar; done

if [[ $PRI ]]; then
   i3-msg '[workspace=1]' move workspace to output $PRI
   i3-msg '[workspace=2]' move workspace to output $PRI
   i3-msg '[workspace=3]' move workspace to output $PRI
   i3-msg '[workspace=4]' move workspace to output $PRI
   i3-msg '[workspace=5]' move workspace to output $PRI
   echo "workspace 1 output $PRI" >> ~/.config/i3/workspace-to-monitor.conf
   echo "workspace 2 output $PRI" >> ~/.config/i3/workspace-to-monitor.conf
   echo "workspace 3 output $PRI" >> ~/.config/i3/workspace-to-monitor.conf
   echo "workspace 4 output $PRI" >> ~/.config/i3/workspace-to-monitor.conf
   echo "workspace 5 output $PRI" >> ~/.config/i3/workspace-to-monitor.conf
   echo "starting bar mainbar on $PRI"
   PRI_MONITOR=$PRI polybar mainbar 2>~/.config/polybar/mainbar.log & disown
fi

# for mirror, duplicate, primary modes, number of monitors < 2 : hide secondary bar
if [ $mode != "mirror" ] && [ $mode != "duplicate" ] && [ $mode != "primary" ] && [ "$nmons" -gt "1" ]; then
   if [[ $SEC ]]; then
      i3-msg '[workspace=6]' move workspace to output $SEC
      i3-msg '[workspace=7]' move workspace to output $SEC
      i3-msg '[workspace=8]' move workspace to output $SEC
      i3-msg '[workspace=9]' move workspace to output $SEC
      i3-msg '[workspace=10]' move workspace to output $SEC
      echo "workspace 6 output $SEC" >> ~/.config/i3/workspace-to-monitor.conf
      echo "workspace 7 output $SEC" >> ~/.config/i3/workspace-to-monitor.conf
      echo "workspace 8 output $SEC" >> ~/.config/i3/workspace-to-monitor.conf
      echo "workspace 9 output $SEC" >> ~/.config/i3/workspace-to-monitor.conf
      echo "workspace 10 output $SEC" >> ~/.config/i3/workspace-to-monitor.conf
      echo "starting bar lightbar on $SEC"
      SEC_MONITOR=$SEC polybar lightbar 2>~/.config/polybar/lightbar.log & disown
   fi
fi

# reload i3 config
i3 reload

