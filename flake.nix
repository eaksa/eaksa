{
  description = "Elang's cross-device NixOS and nix-darwin configuration.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    nur.url = "github:nix-community/NUR";

    # Package management in Darwin through Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    # Other sources
    firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
  };

  outputs = inputs @ {
    self,
    nixpkgs,

    darwin,
    home-manager,
    nur,

    firefox-darwin,
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
          overlays = [
            firefox-darwin.overlay
            nur.overlay
          ];
        };
      };
      homeManager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs user; };
        users.${user.name} = { imports = [ ./home ]; };
      };
      system = { system, hostName }: let
        inherit (nixpkgs.lib.strings) hasInfix;
        platform = {
          isDarwin = hasInfix "darwin" system;
          isLinux = hasInfix "linux" system;
          isx86_64 = hasInfix "x86_64" system;
          isArm = hasInfix "aarch64" system;
        };
        modules = if platform.isDarwin
          then [
            configuration.nix
            ./platforms/darwin/configuration.nix
            ./modules
            home-manager.darwinModules.home-manager {
              users.users.${user.name}.home = "/Users/${user.name}";
              home-manager = configuration.homeManager;
            }
          ]
          else [
            configuration.nix
            ./platforms/linux/configuration.nix
            ./hosts/${hostName}/hardware-configuration.nix
            ./modules
            home-manager.nixosModules.home-manager {
              home-manager = configuration.homeManager;
            }
          ];
        specialArgs = { inherit inputs hostName platform system user; };
      in if platform.isDarwin
        then darwin.lib.darwinSystem {
          inherit system modules specialArgs;
        }
        else nixpkgs.lib.nixosSystem {
          inherit system modules specialArgs;
        };
    };

  in {
    darwinConfigurations = {
      mbpro-2021 = configuration.system {
        system = "aarch64-darwin";
        hostName = "mbpro-2021";
      };
    };
    nixosConfigurations = {
      marco-2021 = configuration.system {
        system = "aarch64-linux";
        hostName = "marco-2021";
      };
      titan-2014 = configuration.system {
        system = "x86_64-linux";
        hostName = "titan-2014";
      };
    };
  };
}
