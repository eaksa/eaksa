{ pkgs, ... }: {
  programs.git.enable = true;
  environment.systemPackages = [ pkgs.gh ];
}
