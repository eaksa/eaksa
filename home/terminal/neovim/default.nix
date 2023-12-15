{ pkgs, ... }: let
  aviaksa = pkgs.fetchFromGitHub {
    name = "aviaksa";
    owner = "eaksa";
    repo = "aviaksa";
    rev = "abb997ffe9cc7583761feb47f678edaebade9bf1";
    sha256 = "OR5q9xIsn1lZSIq1Te7DhSaEcLUUlIlGNCKqc5+c+20=";
  };
in {
  # Aviaksa dependencies
  home.packages = with pkgs; [
    cargo
    gcc
    go
    nodejs_20
    ripgrep
  ];
  programs.neovim = {
    enable = true;
  };
  home.file.".config/nvim" = {
    source = aviaksa;
    recursive = true;
  };
}
