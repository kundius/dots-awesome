#!/bin/bash

emit() {
  awesome-client "awesome.emit_signal(\"system::nightmode\", \"$1\")"
}

if [[ "$1" = "--emit" ]]; then
  if pgrep redshift; then
    emit "On"
  else
    emit "Off"
  fi
  exit 0
fi

if pgrep redshift; then
  pkill redshift
  notify-send "Redshift" "Night mode off." -i ".config/awesome/icons/redshift.png"
  emit "Off"
else
  redshift &
  emit "On"
fi
