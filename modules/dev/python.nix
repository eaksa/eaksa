{ pkgs, ... }: let
  pythonPackages = ps: with ps; [
    juypter
  ];
in {
  environment.systemPackages = [ (pkgs.python3.withPackages pythonPackages) ];
}
