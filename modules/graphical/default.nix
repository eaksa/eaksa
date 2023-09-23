{ platform, ... }: {
  imports = if platform.isDarwin
    then [ ./sketchybar ]
    else [ ./hyprland.nix ];
}
