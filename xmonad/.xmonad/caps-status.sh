#!/bin/sh

ON_ICON="<fc=#FF0000><fn=1></fn></fc>"
OFF_ICON="<fn=1></fn>" 
PIPE=$XDG_RUNTIME_DIR/caps-display
[ -p "$PIPE" ] || mkfifo "$PIPE"

sleep 0.2 
current="$(xset q | grep Caps | tr -s ' ' | cut -d ' ' -f 5)"

if [ "$current" = "off" ]; then
   icon=$OFF_ICON
elif [ "$current" = "on" ]; then
   icon=$ON_ICON
fi

echo "$icon" > "$PIPE"
