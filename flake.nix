{
  description = "NixOS configuration";

  inputs = {
    dustpan.url = "github:matthew-hre/dustpan";

    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stash.url = "github:NotAShelf/stash";

    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = inputs @ {
    ghostty,
    home-manager,
    nixpkgs,
    self,
    ...
  }: let
    system = "x86_64-linux";

    mkHost = hostname: modules:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs hostname;};

        modules =
          modules
          ++ [
            home-manager.nixosModules.home-manager
            ./home
            {
              environment.systemPackages = [
                ghostty.packages.${system}.default
              ];

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs hostname;};
              };
            }
          ];
      };
  in {
    nixosConfigurations = {
      toad = mkHost "toad" [
        ./hosts/toad/configuration.nix
        {nixpkgs.overlays = [inputs.niri.overlays.niri];}
      ];
      thwomp = mkHost "thwomp" [./hosts/thwomp/configuration.nix];
    };

    checks.${system} = {
      pre-commit-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
        };
      };
    };

    devShells.${system}.default = let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
      };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
