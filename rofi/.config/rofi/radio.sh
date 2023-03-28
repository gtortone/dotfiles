#!/bin/bash

declare -A radio_stations
# list of radio stations
radio_stations[Lofi radio]="https://zeno.fm/radio/lofi-radio70w6zac9hfhvv"
radio_stations[Lofi Hip Hop radio]="https://zeno.fm/radio/lofi-radio70w6zac9hfhvv"
#

menu() {
   printf '%s\n' "${!radio_stations[@]}" | sort
   printf '%s\n' "Quit"
}

start_radio() {
  notify-send "Starting radio" "Playing station: $1. 🎶"
}

end_radio() {
  notify-send "Stopping radio" "You have quit radio. 🎶"
}

rofi_command="rofi"

choice="$(menu | $rofi_command -p "Select radio" -dmenu -selected-row 0)"

case $choice in
   '')
      exit
      ;;
	Quit)
      end_radio ;
      kill -9 `pgrep mpv`
      exit
		;;
	*)
      kill -9 `pgrep mpv`
      start_radio "$choice" ;
      mpv "${radio_stations["${choice}"]}"
		;;
esac
