{
  imports = [./default.nix];

  home-manager.users.matthew_hre = {
    btop.amdGpuSupport = true;
  };
}
