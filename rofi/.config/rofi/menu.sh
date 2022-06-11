#!/bin/bash

rofi_command="rofi -format i"

clip="Clipboard\0icon\x1fnotes"
sink="Select audio out\0icon\x1fspeaker"
source="Select audio in\0icon\x1fspeaker"
mount="Mount/umount device\0icon\x1fdrive-harddisk-usb"
monitor="Monitor layout\0icon\x1fmonitor"
kit="Set keyboard it\0icon\x1fkeyboard"
kus="Set keyboard us\0icon\x1fkeyboard"
browse="Browse home directory\0icon\x1ffolder"
sshot="Take a screenshot\0icon\x1fcamera"
cal="Calendar\0icon\x1fdate"
perf="Change CPU governor\0icon\x1fcomputer"

options="$clip\n$sink\n$source\n$mount\n$monitor\n$kit\n$kus\n$browse\n$sshot\n$cal\n$perf\n"

chosen="$(echo -e "$options" | $rofi_command -p "Run: " -dmenu -selected-row 0)"
case $chosen in
    0)
        rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'
        ;;
    1)
      /home/tortone/.config/rofi/rofi-pulse.sh sink &
        ;;
    2)
      /home/tortone/.config/rofi/rofi-pulse.sh source &
        ;;
    3)
      /home/tortone/.config/rofi/mountusb.sh &
        ;;
    4) /home/tortone/.config/rofi/monitor-layout.sh &
        ;;
    5)
      /usr/bin/setxkbmap -synch it &
        ;;
    6) 
      /usr/bin/setxkbmap -synch us &
        ;;   
    7)
      pcmanfm $HOME &
        ;;
    8)
      maim -s | xclip -selection clipboard -target image/png 
        ;;
    9)
      gsimplecal &
        ;;
    10)
      cpupower-gui &
        ;;
esac
