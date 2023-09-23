{ inputs, lib, user, ... }: let
  inherit (inputs)
    homebrew-cask
    homebrew-core
    nix-homebrew;
in nix-homebrew.darwinModules.nix-homebrew {
  inherit lib;
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = user.name;

    # Declarative package management
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
    mutableTaps = false;
  };
}

