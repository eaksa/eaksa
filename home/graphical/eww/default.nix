{ lib, pkgs, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Dependencies for polling widgets
  home.packages = with pkgs; [ jq python311 socat ];
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
