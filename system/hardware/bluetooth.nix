{
  config,
  lib,
  ...
}: {
  options.modules.hardware.bluetooth.enableControllerSupport = lib.mkEnableOption "controller support";

  config = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.Policy.AutoEnable = true;

      settings.General = lib.mkIf config.modules.hardware.bluetooth.enableControllerSupport {
        Privacy = "device";
        JustWorksRepairing = "true";
        Class = "0x000100";
        FastConnectable = "true";
      };
    };

    hardware.xpadneo.enable = config.modules.hardware.bluetooth.enableControllerSupport;
  };
}
