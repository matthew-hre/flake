{
  home-manager.users.matthew_hre = {
    btop.amdGpuSupport = true;

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
