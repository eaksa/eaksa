{ lib, user, ... }: let
  inherit (lib) mkDefault;
in {
  programs.home-manager.enable = true;
  home = {
    username = "${user.name}";
    homeDirectory = mkDefault "/home/${user.name}";
    stateVersion = "23.11";
  };
  imports = [
    ./graphical
    ./programs
    ./shell
    ./terminal
  ];
}
