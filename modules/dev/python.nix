{ pkgs, ... }: let
  pythonPackages = ps: with ps; [
    jupyter
  ];
in {
  environment.systemPackages = [ (pkgs.python3.withPackages pythonPackages) ];
}
