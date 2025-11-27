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
          ../users/matthew_hre/${hostname}.nix
          {
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
