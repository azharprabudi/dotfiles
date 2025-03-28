{
  description = "Nix configuration";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
 
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
 
  outputs = inputs @ { self, nix-darwin, home-manager, nixpkgs }: let
    nixpkgsConfig = {
      config.allowUnfree = true;
    };
  in {
    darwinConfigurations = let
      inherit (inputs.nix-darwin.lib) darwinSystem;
    in {
      AP00149-MP = darwinSystem {
        system = "aarch64-darwin";
 
        specialArgs = { inherit inputs; };
 
        modules = [
          ./nix/configuration.nix
          home-manager.darwinModules.home-manager
          {

            nixpkgs = nixpkgsConfig;

            home-manager.useGlobalPkgs = true;
            home-manager.users.azharprabudi = import ./nix/home.nix;
            users.users.azharprabudi.home = "/Users/azharprabudi";
          }
        ];
      };
    };
  };
}
