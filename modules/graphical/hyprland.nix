{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland.overrideAttrs (_: {
      mesonFlags = [ "-DLEGACY_RENDERER:STRING=true" ];
    });
  };
}
