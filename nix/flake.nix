{
  description = "My NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs home-manager; };
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = { inherit inputs; };
        users.mo = {
            imports = [
                ./home.nix
            ];
        };
      };
    };
}
