#!/bin/bash
# This script swtches cpu governor. Allow run cpufreq-set without password to use it.

get_current_governor() {
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

switch_governor() {
    # Change governor for each cpu
    for (( i = 0; i < $(nproc); i++ )); do
        if [[ "$1" == "powersave" ]]; then
              sudo cpufreq-set -c $i -g performance
        elif [[ "$1" == "performance" ]]; then
              sudo cpufreq-set -c $i -g powersave
        fi
    done
    awesome-client "awesome.emit_signal(\"cpu::governor\", \"$(get_current_governor)\", false)"
}

current_governor="$(get_current_governor)"

if [[ "$1" = "--emit" ]]; then
    awesome-client "awesome.emit_signal(\"cpu::governor\", \"${current_governor}\", true)"
elif [[ "$1" = "--switch" ]]; then
    switch_governor $current_governor
fi
