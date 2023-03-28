#!/bin/sh

chk=$( printf "Yes\nNo" | rofi -dmenu -i -p "Close current session" )

case $chk in 
	Yes)
      i3-msg exit
      ;;
	No)
      ;;
esac

