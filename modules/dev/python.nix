{ pkgs, ... }: let
  pythonPackages = ps: with ps; [
    flask
    jupyter
    pillow
    pymongo
    matplotlib
    numpy
  ];
in {
  environment.systemPackages = [ (pkgs.python3.withPackages pythonPackages) ];
}
