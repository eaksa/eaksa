{ pkgs, ... }: let
  pythonPackages = ps: with ps; [
    flask
    jupyter
    pillow
    pymongo
    matplotlib
    numpy
    replicate
  ];
in {
  environment.systemPackages = [ (pkgs.python3.withPackages pythonPackages) ];
}
