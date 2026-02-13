{
  config,
  lib,
  ...
}: {
  options.modules.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth support";
  options.modules.hardware.bluetooth.enableControllerSupport = lib.mkEnableOption "controller support";

  config = lib.mkIf config.modules.hardware.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.Policy.AutoEnable = true;

      settings.General = lib.mkIf config.modules.hardware.bluetooth.enableControllerSupport {
        experimental = true;

        Privacy = "device";
        JustWorksRepairing = "true";
        Class = "0x000100";
        FastConnectable = "true";
      };
    };
  };
}
