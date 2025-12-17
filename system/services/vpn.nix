{
  config,
  lib,
  ...
}: {
  options.modules.services.vpn.enable = lib.mkEnableOption "vpn support";

  config = lib.mkIf config.modules.services.vpn.enable {
    services.openvpn.servers = {
      mruVPN = {
        config = ''config /home/matthew_hre/.config/openvpn/mruVPN.conf '';
        autoStart = false;
      };
    };

    services.tailscale.enable = true;
  };
}
