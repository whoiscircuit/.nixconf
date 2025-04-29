{
  description = "circuit's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs,... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {inherit system; allowUnfree = true;};
    unstable = import inputs.nixpkgs-unstable {inherit system; allowUnfree = true; };
  in {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    homeConfigurations.user = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
    };
  };
}
