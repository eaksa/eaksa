{ pkgs, ... }: let
  aviaksa = pkgs.fetchFromGitHub {
    name = "aviaksa";
    owner = "eaksa";
    repo = "aviaksa";
    rev = "479e1a94a48ae135b98f817fe084f72b388490cb";
    sha256 = "QEM/wQl+Y5aPFNMZ6vRihlD76ly2bWmVBMhTlyxRDDo=";
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
