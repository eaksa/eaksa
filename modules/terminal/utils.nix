{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cmatrix
    fzf
    htop
    ripgrep
    unzip
    wget
  ];
}
