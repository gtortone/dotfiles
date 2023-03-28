#!/bin/bash

cp2cb-maim() {
   case "$XDG_SESSION_TYPE" in
      'x11') xclip -selection clipboard -t image/png;;
      'wayland') wl-copy -t image/png;;
      *) err "Unknown display server";;
   esac
}

OUTDIR=~/Downloads
MAIM=maim

rofi_command="rofi -format i"

whole="Fullscreen"
select="Selected region"
window="Active window"

file="File"
clip="Clipboard"
both="File and clipboard"

srcopt="$whole\n$select\n$window"
destopt="$file\n$clip\n$both"

maimopts=""
SCREENSHOT=$OUTDIR/maim-`date +%F-%T`.png

src="$(echo -e "$srcopt" | $rofi_command -p "Select" -dmenu -selected-row 0)"

case $src in
	0)
		# fullscreen capture
		;;
	1)
		# select region to capture
		maimopts+=" -s "
		;;
	2)
		# capture active window
		maimopts+=" -i $(xdotool getactivewindow) "
		;;
	*)
		exit
		;;
esac

dest="$(echo -e "$destopt" | $rofi_command -p "Write to" -dmenu -selected-row 0)"

case $dest in
   0)
      $MAIM $maimopts $SCREENSHOT
      msg="Screenshot saved to $SCREENSHOT"
      ;;
   1)
      $MAIM $maimopts | cp2cb-maim
      msg="Screenshot saved to clipboard"
      ;;
   2)
      $MAIM $maimopts | tee $SCREENSHOT | cp2cb-maim
      msg="Screenshot saved to clipboard and $SCREENSHOT"
      ;;
   *)
      exit
      ;;
esac

notify-send  --app-name sshot --icon camera "$msg"

