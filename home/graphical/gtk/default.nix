{ lib, pkgs, ... }: let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
  gtkExtraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };
in mkIf stdenv.isLinux {
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyo-night-gtk;
    };
    cursorTheme = {
      name = "macOS-Monterey";
      package = pkgs.apple-cursor;
    };
    font = {
      name = "IBM Plex Sans";
      package = pkgs.ibm-plex;
    };
    gtk3.extraConfig = gtkExtraConfig;
    gtk4.extraConfig = gtkExtraConfig;
  };
}
