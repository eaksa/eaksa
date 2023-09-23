#!/bin/bash

CONFIG_DIR="etc/sketchybar"
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$WHITE
FULL=no
case ${PERCENTAGE} in
  [8-9][0-9]|100) ICON=$BATTERY_100; FULL=yes
  ;;
  6[5-9]|7[0-9]) ICON=$BATTERY_75
  ;;
  5[0-9]|6[0-4]) ICON=$BATTERY_50
  ;;
  [2-4][0-9]) ICON=$BATTERY_25
  ;;
  *) ICON=$BATTERY_0; COLOR=$RED
esac

if [[ $CHARGING != "" ]]; then
  ICON=$BATTERY_CHARGING
  if [[ $FULL = "yes" ]]; then
    COLOR=$GREEN
  else
    COLOR=$WHITE
  fi
fi

sketchybar --set $NAME drawing=$DRAWING icon="$ICON" icon.color=$COLOR label="$PERCENTAGE%" label.color=$COLOR
