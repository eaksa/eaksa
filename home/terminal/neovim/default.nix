{ pkgs, ... }: let
  aviaksa = pkgs.fetchFromGitHub {
    name = "aviaksa";
    owner = "eaksa";
    repo = "aviaksa";
    rev = "8fa04842ef8ba7e59e7144456c9e43b07514683c";
    sha256 = "mFieuEQuwAjEnK8C+zY2USxBdYCgvoYuQqOYunqAFrk=";
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
