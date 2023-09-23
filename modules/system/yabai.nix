_: let
  config = {
    layout = "bsp";

    top_padding = 16;
    bottom_padding = 12;
    left_padding = 12;
    right_padding = 12;
    window_gap = 12;

    window_topmost = "off";
    window_shadow = "float";
    window_opacity = "on";
    active_window_opacity = 0.97;
    normal_window_opacity = 0.88;

    window_border = "on";
    window_border_blur = "on";
    window_border_radius = 11;
    window_border_width = 2;
    active_window_border_color = "0xee939ab7";
    normal_window_border_color = "0xe01b1d2b";
  };
  extraConfig = ''
    # Load scripting addition
    yabai -m signal --add event=dock_did_restart action="sudo/opt/homebrew/bin/yabai --load-sa";

    # Ignore opacity rules
    yabai -m rule --add app="^Figma.*$" opacity=1.0
    yabai -m rule --add app="^GIMP.*$" opacity=1.0
    yabai -m rule --add app="^[wW]ezterm(-gui)?.*$" opacity=1.0

    # Ignore windows
    yabai -m rule --add app="System Settings" manage=off border=off

    # Update Sketchybar
    yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
    yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
    yabai -m signal --add event=space_changed action="sketchybar --trigger windows_on_spaces"
  '';
in {
  services.yabai = {
    enable = true;
    enableScriptingAddition = true; # Requires disabling SIP
    inherit config extraConfig;
  };
}
