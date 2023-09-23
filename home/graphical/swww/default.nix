{ lib, pkgs, ... }: let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
in mkIf stdenv.isLinux {
  home.packages = [ pkgs.swww ];
}
