{ pkgs, ... }: let
  fonts = [
    "CascadiaCode"
    "IBMPlexMono"
  ];
in {
  fonts.fonts = [ (pkgs.nerdfonts.override { inherit fonts; }) ];
}
