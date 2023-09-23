#!/bin/bash

calendar=(
  icon=cal
  icon.padding_right=18
  label.width=45
  label.align=right
  label.font="$FONT:SemiBold:14.0"
  padding_right=10
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
