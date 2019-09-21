#!/bin/bash
SONG="$(mpc current)"
awesome-client "awesome.emit_signal(\"player::song\", \"$SONG\")"
