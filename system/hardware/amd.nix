{
  config,
  lib,
  ...
}: {
  options.modules.hardware.amd.enable = lib.mkEnableOption "AMD support";

  config = lib.mkIf config.modules.hardware.amd.enable {
    boot.initrd.kernelModules = ["amdgpu"];
  };
}
