{
  description = "Elang's cross-device NixOS configuration.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ {
    self,
    home-manager,
    nixpkgs,
    nur,
    ...
  }: let
    user = {
      name = "elang";
      timeZone = "Asia/Jakarta";
      locale = "en_GB.UTF-8";
    };
    configuration = {
      nix = {
        nix.settings = { experimental-features = "nix-command flakes"; };
        nixpkgs = {
          config = { allowUnfree = true; };
          overlays = [ nur.overlay ];
        };
      };
      homeManager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs user; };
        users.${user.name} = { imports = [ ./home ]; };
      };
      system = { system, hostName }: let
        modules = [
          configuration.nix
          ./platforms/linux/configuration.nix
          ./hosts/${hostName}/hardware-configuration.nix
          ./modules
          home-manager.nixosModules.home-manager {
            home-manager = configuration.homeManager;
          }
        ];
      in nixpkgs.lib.nixosSystem {
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
