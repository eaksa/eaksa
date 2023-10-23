{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.neovim ];
  environment.sessionVariables.EDITOR = "nvim";
}
