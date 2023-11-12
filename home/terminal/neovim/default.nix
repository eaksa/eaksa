{ pkgs, ... }: let
  aviaksa = pkgs.fetchFromGitHub {
    name = "aviaksa";
    owner = "eaksa";
    repo = "aviaksa";
    rev = "82d8f08073e3f0a36c6498828b9629a1e34a9717";
    sha256 = "/CyeYiwVVO1Uk/gLRG9ugs/4YKTP5V+oEK4Jvwd8eT8=";
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
