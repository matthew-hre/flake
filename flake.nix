{
  description = "NixOS configuration";

  inputs = {
    dustpan.url = "github:matthew-hre/dustpan";

    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";

    helium.url = "github:FKouhai/helium2nix/main";

    ink.url = "github:theMackabu/ink";

    llm-agents.url = "github:numtide/llm-agents.nix";

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

    stash.url = "github:NotAShelf/stash/f6818c9e6f2e4da4f8e7966ba4a96a317e1ad530";

    vicinae.url = "github:vicinaehq/vicinae";
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
        {nixpkgs.overlays = [inputs.niri.overlays.niri];}
      ];
      thwomp = lib.mkHost "thwomp" [./hosts/thwomp/configuration.nix];
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
