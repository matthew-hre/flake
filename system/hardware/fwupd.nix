{
  config,
  lib,
  ...
}: {
  options.modules.hardware.fwupd.enable = lib.mkEnableOption "fwupd support";

  config = lib.mkIf config.modules.hardware.fwupd.enable {
    services.fwupd.enable = true;
  };
}
