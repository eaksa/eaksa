_: let
  colours = {
    black = "rgb(1b1d2b)";
    red = "rgb(ff757f)";
    green = "rgb(c3e88d)";
    yellow = "rgb(ffc777)";
    blue = "rgb(b2aaff)";
    magenta = "rgb(c099ff)";
    cyan = "rgb(86e1fc)";
    white = "rgb(828bb8)";
  };

  settings = {
    # General
    monitor = [ ", preferred, auto, auto" ];
    env = [ "XCURSOR_SIZE, 24" ];
    general = {
      border_size = 3;
      no_border_on_floating = false;
      gaps_in = 4;
      gaps_out = 8;
      "col.inactive_border" = colours.black;
      "col.active_border" =
        "${colours.magenta} ${colours.blue} ${colours.cyan} ${colours.blue} 45deg";
      cursor_inactive_timeout = 5;
      layout = "dwindle";
    };
    decoration = {
      rounding = 8;
      multisample_edges = true;
      active_opacity = 0.95;
      inactive_opacity = 0.85;
      fullscreen_opacity = 1.0;
      blur = {
        size = 5;
        passes = 2;
        ignore_opacity = true;
        new_optimizations = true;
      };
      drop_shadow = false;
      dim_inactive = false;
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
    master = {
      new_is_master = true;
    };
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = false;
      always_follow_on_dnd = true;
      layers_hog_keyboard_focus = true;
      animate_manual_resizes = true;
      disable_autoreload = false;
    };
    windowrulev2 = [
      "opacity 1.0 override 1.0,class:(.*)(wezterm)$"
    ];

    # Animations
    bezier = [
      "linear, 0.0, 0.0, 1.0, 1.0"
      "easeOutQuint, 0.22, 1, 0.36, 1"
    ];
    animation = [
      "windowsIn, 1, 3, easeOutQuint, popin"
      "windowsOut, 1, 3, easeOutQuint, slide"
      "windowsMove, 1, 3, easeOutQuint"
      "border, 1, 6, easeOutQuint"
      "borderangle, 1, 100, linear, loop"
      "fade, 1, 3, easeOutQuint"
      "fadeIn, 1, 3, easeOutQuint"
      "fadeOut, 1, 8, easeOutQuint"
      "workspaces, 1, 3, easeOutQuint"
    ];

    # Inputs
    input = {
      kb_layout = "us";
      kb_options = "caps:escape";
      follow_mouse = 1;
      float_switch_override_focus = 2;
      natural_scroll = true;
      force_no_accel = false;
      numlock_by_default = false;
      sensitivity = 0.2;
      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 0.1;
        clickfinger_behavior = true;
        tap-to-click = true;
        drag_lock = false;
      };
    };
    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 4;
      workspace_swipe_distance = 700;
      workspace_swipe_invert = true;
      workspace_swipe_min_speed_to_force = 20;
      workspace_swipe_cancel_ratio = 0.3;
    };

    # Keybinds
    bind = [
      # Close active application
      "SUPER SHIFT, Q, killactive, "
      # Open terminal
      "SUPER, RETURN, exec, wezterm"
      # Open browser
      "SUPER, F, exec, firefox"
      # Open editor
      "SUPER, d, exec, wezterm start -- $EDITOR"
      # Open file manager
      "SUPER, g, exec, wezterm start -- ranger ~"
      "SUPER, c, exec, wezterm start -- ranger ~/.nixos"
      # Toggle floating window
      "SUPER, V, togglefloating, "
      # Move window focus
      "SUPER, h, movefocus, l"
      "SUPER, l, movefocus, r"
      "SUPER, k, movefocus, u"
      "SUPER, j, movefocus, d"
      # Move monitor focus
      "SUPER, bracketleft, focusmonitor, -1"
      "SUPER, bracketright, focusmonitor, +1"
      # Switch workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      # Move active window
      "SUPER SHIFT, h, movewindow, l"
      "SUPER SHIFT, l, movewindow, r"
      "SUPER SHIFT, j, movewindow, d"
      "SUPER SHIFT, k, movewindow, u"
      # Move active window to workspace
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"
      # Move monitor focus
      "SUPER, bracketleft, focusmonitor, -1"
      "SUPER, bracketright, focusmonitor, +1"
    ];
    bindr = [
      # Open program launcher
      "SUPER, SPACE, exec, pkill rofi || rofi -show drun"
    ];
    bindm = [
      # Move/resize windows
      "SUPER, mouse:271, movewindow"
      "SUPER, mouse:272, resizewindow"
    ];

    # Startup
    exec-once = [ ''
      eww kill
      eww daemon
    '' ];
    exec = [
      "swww init &"
      "swww img /etc/wallpapers/wall_morning.png"
      "eww close-all"
      "eww open bar"
    ];
  };

in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
    inherit settings;
  };
}
