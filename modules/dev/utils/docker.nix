{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker ];
}
