{ user, ... }: {
  programs.home-manager.enable = true;
  home = {
    username = "${user.name}";
    homeDirectory = "/home/${user.name}";
    stateVersion = "23.05";
  };
  imports = [
    ./graphical
    ./programs
  ];
}
