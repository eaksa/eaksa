{ platform, ... }: {
  imports = if platform.isDarwin
    then [
      ./skhd.nix
      ./yabai.nix
    ]
    else [
      ./audio.nix
      ./ios.nix
      ./wayland.nix
    ];
}
