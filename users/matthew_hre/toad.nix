{inputs, ...}: {
  imports = [./default.nix];

  home-manager.users.matthew_hre = {
    imports = [
      # niri needs to be specified here, since
      # it builds from source regardless of whether
      # it's enabled or not, and i don't want it
      # on thwomp
      inputs.niri.homeModules.niri
      ../../home/wayland
    ];
  };
}
