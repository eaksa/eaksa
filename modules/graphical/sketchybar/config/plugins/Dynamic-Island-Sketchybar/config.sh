#!/usr/bin/env sh

CONFIG_DIR="/etc/sketchybar"
USER_CONFIG="$CONFIG_DIR/userconfig.sh"
test -f $USER_CONFIG && source $USER_CONFIG

PADDINGS=3

# Setting up the general bar appearance and default values
sketchybar --bar     height=32                                         \
                     color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT         \
                     shadow=off                                        \
                     position=top                                      \
                     sticky=on                                         \
                     padding_right=$((10 - $PADDINGS))                 \
					 topmost=${P_DYNAMIC_ISLAND_TOPMOST:=off}		   \
                     padding_left=18                                   \
                     corner_radius=9                                   \
                     y_offset=0                                        \
                     margin=10                                         \
                     blur_radius=30                                    \
                     notch_width=0                                     \
           --default updates=when_shown                                \
                     icon.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"      \
                     icon.color=$P_DYNAMIC_ISLAND_COLOR_WHITE          \
                     icon.padding_left=$PADDINGS                       \
                     icon.padding_right=$PADDINGS                      \
                     label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:13.0" \
                     label.color=$P_DYNAMIC_ISLAND_COLOR_WHITE         \
                     label.padding_left=$PADDINGS                      \
                     label.padding_right=$PADDINGS                     \
                     background.padding_right=$PADDINGS                \
                     background.padding_left=$PADDINGS                 \
                     popup.background.corner_radius=11                 \
                     popup.background.shadow.drawing=off	       	   \
                     popup.background.border_width=2                   \
					 popup.horizontal=on
