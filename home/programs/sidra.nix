{inputs, pkgs, ...}: {
  home.packages = [
    inputs.sidra.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
