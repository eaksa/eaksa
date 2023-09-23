_: let
  skhdConfig = ''
    # Open terminal
    alt - return : wezterm; sketchybar --trigger windows_on_spaces

    # Navigation
    alt - h : yabai -m window --focus west
    alt - j : yabai -m window --focus south
    alt - k : yabai -m window --focus north
    alt - l : yabai -m window --focus east

    # Open directory
    alt - g : wezterm start -- ranger ~; sketchybar --trigger windows_on_spaces
    alt - c : wezterm start -- ranger ~/.config; sketchybar --trigger windows_on_spaces
    alt - d : wezterm start -- nvim; sketchybar --trigger windows_on_spaces

    # Programs
    alt - f : open "$HOME/Applications/Home Manager Apps/Firefox.app"; sketchybar --trigger windows_on_spaces

    # Move focus to workspace
    alt - 1 : yabai -m space --focus 1
    alt - 2 : yabai -m space --focus 2
    alt - 3 : yabai -m space --focus 3
    alt - 4 : yabai -m space --focus 4
    alt - 5 : yabai -m space --focus 5
    alt - 6 : yabai -m space --focus 6
    alt - 7 : yabai -m space --focus 7
    alt - 8 : yabai -m space --focus 8
    alt - 9 : yabai -m space --focus 9

    # Moving windows
    shift + alt - h : yabai -m window --warp west
    shift + alt - j : yabai -m window --warp south
    shift + alt - k : yabai -m window --warp north
    shift + alt - l : yabai -m window --warp east

    # Move focus container to workspace
    shift + alt - 1 : yabai -m window --space 1; yabai -m space --focus 1
    shift + alt - 2 : yabai -m window --space 2; yabai -m space --focus 2
    shift + alt - 3 : yabai -m window --space 3; yabai -m space --focus 3
    shift + alt - 4 : yabai -m window --space 4; yabai -m space --focus 4
    shift + alt - 5 : yabai -m window --space 5; yabai -m space --focus 5
    shift + alt - 6 : yabai -m window --space 6; yabai -m space --focus 6
    shift + alt - 7 : yabai -m window --space 7; yabai -m space --focus 7
    shift + alt - 8 : yabai -m window --space 8; yabai -m space --focus 8
    shift + alt - 9 : yabai -m window --space 9; yabai -m space --focus 9

    # Close window
    alt + shift - q : yabai -m window --close; sketchybar --trigger windows_on_spaces
  '';
in {
  services.skhd = {
    enable = true;
    inherit skhdConfig;
  };
}
