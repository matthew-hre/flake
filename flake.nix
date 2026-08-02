{
  description = "NixOS configuration";

  inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dustpan = {
      url = "git+https://tangled.org/matthew-hre.com/dustpan";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:FKouhai/helium2nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hunk = {
      url = "github:modem-dev/hunk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ink = {
      url = "github:theMackabu/ink";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jj = {
      url = "github:jj-vcs/jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.follows = "niri-custom";
    };

    niri-custom = {
      url = "github:niri-wm/niri/main";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sidra = {
      url = "github:wimpysworld/sidra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Don't follow nixpkgs — Zed's livekit build breaks with mismatched nixpkgs
    zed = {
      url = "github:zed-industries/zed";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    self,
    ...
  }: let
    system = "x86_64-linux";
    lib = import ./lib {inherit inputs nixpkgs;};
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      toad = lib.mkHost "toad" [
        ./hosts/toad/configuration.nix
      ];
      donkeykong = lib.mkHost "donkeykong" [
        ./hosts/donkeykong/configuration.nix
      ];
    };

    homeConfigurations = {
      purelend = lib.mkHome "purelend" [
        ./users/matthew_hre/purelend.nix
      ];
    };

    checks.${system} = {
      pre-commit-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
        };
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      inherit (self.checks.${system}.pre-commit-check) shellHook;
      buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
    };

    formatter.${system} = pkgs.alejandra;
  };
}
