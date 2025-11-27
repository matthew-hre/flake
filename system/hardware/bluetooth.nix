{
  config,
  lib,
  ...
}: {
  options.modules.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth support";

  config = lib.mkIf config.modules.hardware.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.Policy.AutoEnable = true;
    };
  };
}
