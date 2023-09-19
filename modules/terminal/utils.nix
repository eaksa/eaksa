{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cmatrix
    fzf
    htop
    ripgrep
    wget
  ];
}
