{
  config,
  lib,
  ...
}: {
  options.modules.services.boot.enable = lib.mkEnableOption "boot (grub) support";

  config = lib.mkIf config.modules.services.boot.enable {
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
  };
}
