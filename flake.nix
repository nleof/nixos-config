{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    yawp.url = "git+https://github.com/nleof/yawp?submodules=1";
    yawp.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, home-manager, agenix, nixos-hardware, yawp, ... }@attrs:
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
              home-manager.extraSpecialArgs = { inherit agenix; };

              home-manager.users.alx = ./modules/home/alx.nix;
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

        vps = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = { inherit yawp; };
          modules =
            [ ./hosts/vps/configuration.nix ./modules/system/server.nix ];
        };
      };
    };
}
