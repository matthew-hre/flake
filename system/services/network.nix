{
  config,
  lib,
  ...
}: {
  options.modules.services.network.enable = lib.mkEnableOption "network support";

  config = lib.mkIf config.modules.services.network.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.powersave = false;
        wifi.scanRandMacAddress = false;
      };
      firewall.enable = true;
    };
  };
}
