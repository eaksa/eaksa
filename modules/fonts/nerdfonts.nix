{ pkgs, ... }: let
  fonts = [
    "CascadiaCode"
    "IBMPlexMono"
  ];
in {
  fonts.packages = [ (pkgs.nerdfonts.override { inherit fonts; }) ];
}
