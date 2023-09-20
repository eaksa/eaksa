{ pkgs, ... }: let
  gtkExtraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };
in {
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
