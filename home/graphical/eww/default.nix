{ lib, pkgs, ... }: lib.mkIf pkgs.stdenv.isLinux {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
