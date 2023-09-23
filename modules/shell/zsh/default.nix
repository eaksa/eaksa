{ pkgs, ... }: let
  neofetchConfig = ./neofetch;
  p10k = pkgs.fetchFromGitHub {
    name = "powerlevel10k";
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "f851f41fc14d5bd66266b4b4af917d50c1c8b7fe";
    sha256 = "OmNseLGFGVGtKM9TZdfLJY6PbAFXWyxL14Xet63g9vA=";
  };
  p10kScript = ./powerlevel10k.zsh;
  zshrc = ./login.zsh;
in {
  environment.systemPackages = [ pkgs.neofetch ];
  environment.etc = {
    neofetch.source = neofetchConfig;
    powerlevel10k.source = p10k;
    "powerlevel10k.zsh".source = p10kScript;
  };
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    loginShellInit = "neofetch --config /etc/neofetch/config.conf";
    interactiveShellInit = builtins.readFile zshrc;
  };
}
