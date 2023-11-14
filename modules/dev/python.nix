{ pkgs, ... }: let
  pythonPackages = ps: with ps; [
    build
    jupyter
  ];
in {
  environment.systemPackages = with pkgs; [
    (python3.withPackages pythonPackages)
    pipenv
  ];
}
