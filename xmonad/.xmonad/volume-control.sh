#!/bin/sh

ICON="<fn=1></fn>"
MUTE_ICON="<fn=1></fn>"
PIPE=$XDG_RUNTIME_DIR/volume-display
# pipe for Xmonad
#[ -p "$PIPE" ] || mkfifo "$PIPE"

step=5

if [ $# -eq 1 ]; then
    case $1 in
        "up")
            ponymix increase $step;;
        "down")
            ponymix decrease $step;;
        "toggle")
            ponymix toggle;;
    esac
fi

muted="$(ponymix is-muted ; echo $?)"
current="$(ponymix get-volume)"

if [ "$muted" = 0 ] || [ "$current" = "0" ]; then
   volicon="audio-volume-muted"
   icon=$MUTE_ICON
elif [ $current -ge 5 ] && [ $current -lt 35 ]; then
   volicon="audio-volume-low"
   icon=$ICON
elif [ $current -ge 35 ] && [ $current -lt 75 ]; then
   volicon="audio-volume-medium"
   icon=$ICON
elif [ $current -ge 75 ]; then
   volicon="audio-volume-high"
   icon=$ICON
fi

# if launched without parameter only refresh status bar
if [ $# -ne 0 ]; then
   notify-send -h string:x-canonical-private-synchronous:volume_percentage -h int:value:$current -t 1000 --app-name volume --icon $volicon "[ $current% ]"
fi

# pipe for Xmonad
#echo "$icon $current%" > "$PIPE"
