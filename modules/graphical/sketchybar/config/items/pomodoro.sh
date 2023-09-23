#!/bin/bash

pomodoro=(
  script="$PLUGIN_DIR/pomodoro.sh"
  icon.padding_right=5
  padding_right=8
  update_freq=1
  updates=on
)

sketchybar --add event pomodoro_update      \
           --add item pomodoro right        \
           --set pomodoro "${pomodoro[@]}"  \
           --subscribe pomodoro pomodoro_update
