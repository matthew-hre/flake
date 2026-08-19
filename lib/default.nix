{
  inputs,
  nixpkgs,
}: let
  system = "x86_64-linux";
in {
  mkHost = hostname: modules:
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {inherit inputs hostname;};

      modules =
        modules
        ++ [
          inputs.home-manager.nixosModules.home-manager
          ../users/matthew_hre/default.nix
          ../users/matthew_hre/${hostname}.nix
          ../users/vik
          {
            # niri-flake's overlay is broken on current nixos-unstable — its
            # make-niri calls callPackage which auto-fills libdisplay-info_0_2
            # (removed from nixpkgs). Build niri-unstable ourselves from the
            # niri-custom source using nixpkgs' niri package as a base, which
            # correctly links against libdisplay-info 0.3+.
            # See https://github.com/sodiboo/niri-flake/issues/1851
            nixpkgs.overlays = [
              (final: prev: {
                niri-unstable = prev.niri.overrideAttrs (finalAttrs: previousAttrs: {
                  version = "unstable";
                  src = inputs.niri-custom;
                  # overrideAttrs runs after buildRustPackage has already
                  # processed cargoHash into cargoDeps, so we must replace
                  # cargoDeps directly rather than setting cargoLock/cargoHash.
                  cargoDeps = prev.rustPlatform.importCargoLock {
                    lockFile = "${inputs.niri-custom}/Cargo.lock";
                    allowBuiltinFetchGit = true;
                  };
                  doInstallCheck = false;
                  meta = previousAttrs.meta // {
                    changelog = "https://github.com/niri-wm/niri/commits/main";
                  };
                });
              })
            ];
            environment.systemPackages = [
              inputs.ghostty.packages.${system}.default
            ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs hostname;};
            };
          }
        ];
    };

  mkHome = hostname: modules:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {inherit inputs hostname;};
      modules = modules;
    };
}
