{
  description = "Elang's cross-device NixOS configuration.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }:
    let
      user = {
        name = "elang";
        timeZone = "Asia/Jakarta";
        locale = "en_GB.UTF-8";
      };
      configuration = rec {
        nix = {
          nix.settings = { experimental-features = "nix-command flakes"; };
          nixpkgs.config = { allowUnfree = true; };
        };
        system = { system, hostName }:
          let
            modules = [
              configuration.nix
              ./platforms/linux/configuration.nix
              ./hosts/${hostName}/hardware-configuration.nix
              ./modules
            ];
          in
            nixpkgs.lib.nixosSystem {
              inherit modules system;
              specialArgs = { inherit hostName inputs user; };
            };
      };

    in {
      nixosConfigurations = {
        marco-2021 = configuration.system {
          system = "aarch64-linux";
          hostName = "marco-2021";
        };
      };
    };
}
