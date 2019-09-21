#!/usr/bin/env bash
# This script executes each time restarting awesome. Function 'run' checks is program already running
# to avoid starting few instances of one program

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run compton
run redshift
sleep 0.5 && night-mode.sh --emit

if xrandr --listmonitors | grep -q HDMI; then
  arandr-layout-two.sh
else
  arandr-layout-single.sh
fi

# Keyboard layout
setxkbmap -layout "us,ru" -option "grp:caps_toggle"
