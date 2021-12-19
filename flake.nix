{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let 
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

  in {
    homeManagerConfigurations = {
      atlas = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;

        username = "atlas";
        homeDirectory = "/home/atlas";
        stateVersion = "21.11";
        configuration = {
          imports = [
            ./home.nix
          ];
        };
      };
    };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        
        modules = [
         ./configuration.nix
        ];
      };
    };
  };
}
