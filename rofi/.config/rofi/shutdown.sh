#!/bin/sh

confirm() {
   choice=$( printf "Yes\nNo" | rofi -dmenu -i -p "Confirm" )
   case $choice in
      Yes)
         true
         ;;
      No)
         false
         ;;
      *)
         exit
         ;;
   esac
}

op=$( printf "Reboot\nShutdown" | rofi -dmenu -i -p "Close current session" )

case $op in 
	Reboot)
      confirm && systemctl reboot
      ;;
	Shutdown)
      confirm && systemctl poweroff
      ;;
   *)
      exit
      ;;
esac

