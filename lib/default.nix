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
            nixpkgs.overlays = [inputs.niri.overlays.niri];
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
}
