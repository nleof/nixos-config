{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, agenix, nixos-hardware, ... }@inputs:
    let
      mkSystem = extraModules:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          modules = [
            agenix.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.alx = { pkgs, lib, ... }: {
                home.username = "alx";
                programs.home-manager.enable = true;

                imports = [
                  agenix.homeManagerModules.default
                  ./modules/home/default.nix
                ];

                home.packages = with pkgs; [
                  age
                  agenix.packages.${system}.default
                ];

                home.stateVersion = "23.11";
              };
            }
          ] ++ extraModules;
        };
    in {
      nixosConfigurations = {

        thinkpad = mkSystem [
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          ./hosts/thinkpad/configuration.nix
          ./modules/system/desktop.nix
        ];

        desktop = mkSystem [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          ./hosts/desktop/configuration.nix
          ./modules/system/desktop.nix
        ];

        vps = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules =
            [ ./hosts/vps/configuration.nix ./modules/system/server.nix ];
        };
      };
    };
}