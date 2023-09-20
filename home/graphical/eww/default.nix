{ lib, pkgs, ... }: lib.mkIf pkgs.stdenv.isLinux {
  programs.jq.enable = true;
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
