#!/bin/bash

setbg() {
   feh --no-fehbg --bg-scale "$1"
}

BGDIR="${HOME}/.wallpapers"

rofi_command="rofi -format i"

random="Random wallpaper"
select="Select wallpaper with sxiv (m)ark and (q)uit"

options="$random\n$select"

src="$(echo -e "$options" | $rofi_command -p "Select" -dmenu -selected-row 0)"

case $src in
	0)
      valid_paper="No"
      until [ "$valid_paper" = "Yes" ]; do
         wallpaper="$(find "${BGDIR}" -type f | shuf -n 1)"
         setbg "$wallpaper" &
         cp "$wallpaper" "$HOME/.cache/wall"
         confirm="Yes\nNo"
         valid_paper="$(echo -e "$confirm" | dmenu -i -l 20 -p "Confirm wallpaper")"
      done
		;;
	1)
      wallpaper="$(sxiv -t -o "${BGDIR}")"
      cp "$wallpaper" "$HOME"/.cache/wall
      setbg "$wallpaper"
		;;
	*)
		exit
		;;
esac
