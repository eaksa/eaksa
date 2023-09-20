{ pkgs, ... }: let
  ranger_devicons = pkgs.fetchFromGitHub {
    owner = "alexanderjeurissen";
    repo = "ranger_devicons";
    rev = "de64ab26fb581c00a803381d522c6b3e48b79415";
    sha256 = "6JEhyU08QEkGdRW2L00ynRaoaaR5PaiVUccEUbtTQuU=";
  };
in {
  home.packages = [ pkgs.ranger ];

  # Config files
  home.file.".config/ranger/rc.conf".source = ./rc.conf;
  home.file.".config/ranger/rifle.conf".source = ./rifle.conf;

  # Colour scheme
  home.file.".config/ranger/colorschemes" = {
      source = ./colorschemes;
      recursive = true;
  };

  # Devicons
  home.file.".config/ranger/plugins/ranger_devicons".source = ranger_devicons;

  # Alias for `ls`
  programs.zsh.shellAliases.ls = "ranger";
}
