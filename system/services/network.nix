{
  config,
  lib,
  ...
}: {
  options.modules.services.network.enable = lib.mkEnableOption "networking support";

  config = lib.mkIf config.modules.services.network.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.powersave = false;
        wifi.scanRandMacAddress = false;
      };
      firewall.enable = true;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
