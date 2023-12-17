{ pkgs, ... }: let
  fonts = [
    "CascadiaCode"
    "GeistMono"
    "MartianMono"
    "IBMPlexMono"
  ];
in {
  fonts.fonts = [ (pkgs.nerdfonts.override { inherit fonts; }) ];
}
