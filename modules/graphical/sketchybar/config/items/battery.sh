#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
  padding_right=8
  update_freq=30
  updates=on
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke

# sketchybar --add bracket status brew github.bell volume_icon \
#            --set status "${status_bracket[@]}"
