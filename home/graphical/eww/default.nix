{ lib, pkgs, ... }: let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
in mkIf stdenv.isLinux {
  # Dependencies for polling widgets
  home.packages = with pkgs; [ jq python311 socat ];
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
