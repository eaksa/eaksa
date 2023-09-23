#!/usr/bin/env sh

CONFIG_DIR="/etc/sketchybar"
sketchybar --add item di_helper_listener center \
		   --add event di_helper_listener_event \
		   --subscribe di_helper_listener di_helper_listener_event \
		   --set di_helper_listener script="$CONFIG_DIR/plugins/Dynamic-Island-Sketchybar/process.sh" \
			   								width=0
