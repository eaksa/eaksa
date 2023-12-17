{ pkgs, ... }: let
  aviaksa = pkgs.fetchFromGitHub {
    name = "aviaksa";
    owner = "eaksa";
    repo = "aviaksa";
    rev = "f21172096ea91c7538a23b13d7a16095083e8cab";
    sha256 = "KzkBwRWKt+M4V2ysl1rFNarpyajtqWGjzhfaqSTtBB0=";
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
