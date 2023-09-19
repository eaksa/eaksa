#!/bin/zsh

HYPR_SPACES=$(hyprctl workspaces -j)
HYPR_WINDOWS=$(hyprctl clients -j)

get_icon () {
    local INITIAL_TITLE=$1
    local TITLE=$2

    local DEFAULT_ICON=""
    local ICON=$DEFAULT_ICON

    local DEFAULT_TERMINAL_ICON=""
    local TERMINALS=("Alacritty" "Hyper" "iTerm2" "kitty" "Terminal" "wezterm" "wezterm-gui")

    if [[ ${TERMINALS[@]} =~ "\<${INITIAL_TITLE}\>" ]]; then
        case $TITLE in
            "bluetoothctl")
                ICON="" ;;
            "htop")
                ICON="󰝪" ;;
            "nmtui")
                ICON="󰀂" ;;
            "python" | "python3")
                ICON="" ;;
            "ranger")
                ICON="" ;;
            "vim" | "nvim")
                ICON="" ;;
            *)
                ICON=$DEFAULT_TERMINAL_ICON ;;
        esac
    else
        case $INITIAL_TITLE in
            "Firefox" | "Mozilla-Firefox")
                ICON="󰈹" ;;
            "Spotify")
                ICON="" ;;
            *) 
                ICON=$DEFAULT_ICON ;;
        esac
    fi
    echo $ICON
}

get_space_windows () {
    local SPACE_ID=$1
    local SPACE_WINDOWS=$(echo $HYPR_WINDOWS | jq -r "map(select(.workspace.id == $SPACE_ID))")
    echo $HYPR_SPACES | jq -r "map(select(.id == $SPACE_ID)) | map(.clients |= $SPACE_WINDOWS) | .[0]"
}

get_space () {
    local SPACE_ICONS=()
    local SPACE_ID=$1
    local SPACE=$(get_space_windows $SPACE_ID)

    local CLIENTS_INITIAL_TITLES=( $(echo $SPACE | jq -r '.clients | [.[].initialTitle] | map(gsub("\\s";"-")) | .[]') )
    local CLIENTS_TITLES=( $(echo $SPACE | jq -r '.clients | [.[].title] | map(gsub("\\s";"-")) | .[]') )
    for i in $(seq ${#CLIENTS_INITIAL_TITLES[@]}); do
        local WINDOW_ICON=$(get_icon ${CLIENTS_INITIAL_TITLES[i]} ${CLIENTS_TITLES[i]})
        SPACE_ICONS+=($WINDOW_ICON)
        # if [[ ! ${SPACE_ICONS[@]} =~ "\<${WINDOW_ICON}\>" ]]; then
        #     SPACE_ICONS+=($WINDOW_ICON)
        # fi
    done

    echo $SPACE | jq ". | .icons |= \"${SPACE_ICONS}\""
}

get_spaces () {
    local SPACES=""
    local SPACES_LIST=( $(echo $HYPR_SPACES | jq -r ".[].id") )
    for space_id in ${SPACES_LIST[@]}; do
        if [ ! -z "$SPACES" ]; then
            SPACES+=", "
        fi
        SPACES+=$(get_space $space_id)
    done
    echo "[$SPACES]"
}

get_spaces
