{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.neofetch ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    syntaxHighlighting.enable = true;
    loginShellInit = "neofetch";
  };
}
