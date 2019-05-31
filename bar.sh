#!/bin/bash

time=$(date +'📆%F(%a) ⏰%T')
bat="$(cat /sys/class/power_supply/BAT0/capacity)"
if grep -q Charging /sys/class/power_supply/BAT0/status; then
    bat="⚡${bat}"
else
    bat="🔋${bat}"
fi
bright="☀$(echo "$(cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness) $(cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/max_brightness)" | awk '{print $1 / $2}')"
temp="🌡$(sed 's/000$/°C/' /sys/class/thermal/thermal_zone10/temp)"
if [[ $(pactl list sinks | grep Stumm) == *"ja" ]]; then
    vol="🔇"
else
    vol="🔊$(pactl list sinks | grep Lautstärke | grep -o '[0-9]*%' | head -n1)"
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
