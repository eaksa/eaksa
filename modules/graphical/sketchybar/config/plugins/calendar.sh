#!/bin/bash

BIRTHDAY=0530

if [ $(date +%m%d) == $BIRTHDAY ]; then
  AGE=$(($(date +%Y) - 1999))
  DATE="Happy ${AGE} 🎉  "
else
  DATE=$(date '+%a %d %b')
fi

sketchybar --set $NAME icon="$DATE" label="$(date '+%H:%M')"
