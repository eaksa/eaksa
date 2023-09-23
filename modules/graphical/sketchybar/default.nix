{ pkgs, ... }: let
  sketchybarrc = builtins.readFile ./sketchybarrc;
in {
  environment.systemPackages = [ pkgs.jq ];
  services.sketchybar = {
    enable = true;
    config = sketchybarrc;
  };
  environment.etc.sketchybar.source = ./config;
  environment.variables.SKETCHYBAR_CONFIG_DIR = "/etc/sketchybar";
}
