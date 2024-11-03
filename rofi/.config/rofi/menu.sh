#!/bin/bash

rofi_command="rofi -format i"

bookmark="Web bookmarks\0icon\x1fbookmarks"
sink="Select audio out\0icon\x1fspeaker"
source="Select audio in\0icon\x1faudio-input-microphone-symbolic"
sshot="Screenshot\0icon\x1fcamera"
calc="Calculator\0icon\x1faccessories-calculator"
monitor="Monitor layout\0icon\x1fmonitor"
browse="Browse home directory\0icon\x1ffolder"
shut="Reboot or shutdown\0icon\x1fsystem-shutdown"
wall="Set wallpaper\0icon\x1fimage"

options="  $bookmark\n  $sink\n  $source\n  $sshot\n  $calc\n  $monitor\n  $browse\n  $shut\n  $wall"

chosen="$(echo -e "$options" | $rofi_command -p "Run" -dmenu -selected-row 0)"
case $chosen in
    0)
        /home/tortone/.config/rofi/bookmarks.sh &
        ;;
    1)
        /home/tortone/.config/rofi/rofi-pulse.sh sink &
        ;;
    2)
        /home/tortone/.config/rofi/rofi-pulse.sh source &
        ;;
    3)
        /home/tortone/.config/rofi/sshot.sh &
        ;;
    4)
        /usr/bin/mate-calculator &
        ;;
    5) 
        out=`/home/tortone/.config/rofi/monitor-switcher.py 2>&1`
        echo $out
        if [[ $out != *Cancel* ]]; then
           sleep 3
           i3-msg -t run_command restart
        fi
        ;;
    6)
        pcmanfm $HOME &
        ;;
    7)
        /home/tortone/.config/rofi/shutdown.sh &
        ;;
    8)
        /home/tortone/.config/rofi/setbg.sh &
        ;;

esac
