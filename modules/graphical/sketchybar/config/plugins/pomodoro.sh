#!/bin/bash

CONFIG_DIR="etc/sketchybar"
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

COUNTDOWN=$(pmdr status | jq -r .time_remaining)
SESSION=$(pmdr status | jq -r .session)
IS_FINAL=$(pmdr status | jq -r .is_final)

case $SESSION in
  "Work")
    DRAWING=on;
    ICON=$POMODORO_STOPWATCH;
    COLOR=$WHITE;
    if [[ $IS_FINAL == "true" ]]; then
      ICON=$POMODORO_STOP;
      COLOR=$YELLOW
    fi ;;
  "Break")
    DRAWING=on;
    ICON=$POMODORO_BREAK;
    COLOR=$BLUE;
    if [[ $IS_FINAL == "true" ]]; then
      DRAWING=off
    fi ;;
  *)
    DRAWING=off;;
esac

sketchybar --set $NAME drawing=$DRAWING     \
                       icon="$ICON"         \
                       icon.color="$COLOR"  \
                       label=$COUNTDOWN     \
                       label.color="$COLOR"
