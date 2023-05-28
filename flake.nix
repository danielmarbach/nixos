{
  description = "Daniel's system configuration.";

  # Where do we get our packages:
  inputs = {
    # Main NixOS monorepo. We follow the rolling release.
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-master.url = "nixpkgs/master";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };
  };

  outputs = { self
  , nixpkgs
  , nixpkgs-master
  , nur
  , home-manager
  , ... } @ inputs:
  let
    inherit (lib.my) mapModules mapModulesRec mapHosts;
    inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

    system = "x86_64-linux";

    mkPkgs = pkgs: extraOverlays:
    import pkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = extraOverlays;
    };

    pkgs = mkPkgs nixpkgs [ ];
    master = mkPkgs nixpkgs-master [ ];

    lib = nixpkgs.lib.extend (self: super: {
      my = import ./lib {
        inherit pkgs inputs;
        lib = self;
      };
    });

    # Home manager setup. See `home.nix` for more.
    home = [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.danielmarbach = lib.mkMerge [ ./dotfiles ];
        };
      }
    ];

      defaultModules = [ ] ++ home;
  in {
    nixosConfigurations = {

      # ThinkPad X1 Carbon
      x1carbon = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./hosts/x1carbon.nix ] ++ defaultModules;
        specialArgs = {
          inherit inputs;
          inherit home-manager;
        };
      };
    };
  };
}
