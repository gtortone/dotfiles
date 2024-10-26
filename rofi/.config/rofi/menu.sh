#!/bin/bash

rofi_command="rofi -format i"

sink="Select audio out\0icon\x1fspeaker"
source="Select audio in\0icon\x1faudio-input-microphone-symbolic"
sshot="Screenshot\0icon\x1fcamera"
calc="Calculator\0icon\x1faccessories-calculator"
clip="Clipboard\0icon\x1fnotes"
monitor="Monitor layout\0icon\x1fmonitor"
browse="Browse home directory\0icon\x1ffolder"
shut="Reboot or shutdown\0icon\x1fsystem-shutdown"
radio="Radio player\0icon\x1fradio"
wall="Set wallpaper\0icon\x1fimage"

options="  $sink\n  $source\n  $sshot\n  $calc\n  $clip\n  $monitor\n  $browse\n  $shut\n  $radio\n  $wall"

chosen="$(echo -e "$options" | $rofi_command -p "Run" -dmenu -selected-row 0)"
case $chosen in
    0)
        /home/tortone/.config/rofi/rofi-pulse.sh sink &
        ;;
    1)
        /home/tortone/.config/rofi/rofi-pulse.sh source &
        ;;
    2)
        /home/tortone/.config/rofi/sshot.sh &
        ;;
    3)
        /usr/bin/mate-calculator &
        ;;
    4)
        rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'
        ;;
    5) 
        /home/tortone/.config/rofi/monitor-switcher.py
        sleep 3
        i3-msg -t run_command restart
        ;;
    6)
        pcmanfm $HOME &
        ;;
    7)
        /home/tortone/.config/rofi/shutdown.sh &
        ;;
    8)
        /home/tortone/.config/rofi/radio.sh &
        ;;
    9)
        /home/tortone/.config/rofi/setbg.sh &
        ;;

esac
