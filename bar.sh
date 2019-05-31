#!/bin/bash

time=$(date +'📅%F(%a) 🕓%T')
bat="$(cat /sys/class/power_supply/BAT0/capacity)"
if grep -q Charging /sys/class/power_supply/BAT0/status; then
    bat="⚡${bat}"
else
    bat="🔋${bat}"
fi
bright="💡$(light -G)"
temp="🔥$(sensors | grep 'Package id 0' | cut -d' ' -f5)"
if [[ $(pactl list sinks | grep Stumm) == *"ja" ]]; then
    vol="🔇"
else
    vol="🔈$(pactl list sinks | grep Lautstärke | grep -o '[0-9]*%' | head -n1)"
fi

music="$(playerctl metadata artist) - $(playerctl metadata title)"
if [[ $(playerctl status) == "Playing" ]]; then
    music="⏸${music}"
elif [[ $(playerctl status) == "Paused" ]]; then
    music="▶${music}"
else
    music=
fi

ip="($(hostname -i | sed 's/\s$//'))"
if [ "$ip" = "(127.0.0.2)" ]; then
	ip=""
fi

wifi="$(iw wlp59s0 link | grep -o '^\sSSID: .*$' | sed 's/^\sSSID: //')"
if ! [ "$wifi" ]; then
	wifi="⛔"
else
	wifi="📶${wifi}"
fi

echo "$updates $music $vol $wifi${ip} $temp $bright $bat $time"
