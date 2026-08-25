{
  boot.loader = {
    systemd-boot.enable = false;
    efi.efiSysMountPoint = "/boot";
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      configurationLimit = 8;
    };
  };
}
