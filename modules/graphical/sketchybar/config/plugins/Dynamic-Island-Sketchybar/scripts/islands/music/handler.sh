#!/usr/bin/env sh

# $1: MUSIC_SOURCE

# check if music app is running
RUNNING=$(pgrep -x "$1")
if [[ ! $RUNNING ]]; then
	exit 0
fi

if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Stopped" ]; then
	exit 0
fi

cache="$CONFIG_DIR/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/data/cache"
PLAYER_STATE=$(osascript -e "tell application \"$1\" to return (get player state)")

if [[ $(cat $cache) == 0 ]]; then
	# resume
	printf 1 > "$cache"
	sketchybar --trigger dynamic_island_queue INFO="pause" ISLAND_ARGS="1"
	exit 0
fi

if [[ $PLAYER_STATE == "paused" ]]; then
	# paused
	printf 0 > "$cache"
	sketchybar --trigger dynamic_island_queue INFO="pause" ISLAND_ARGS="0"
	exit 0
fi

# music display
sketchybar --trigger dynamic_island_queue INFO="music" ISLAND_ARGS=" "
