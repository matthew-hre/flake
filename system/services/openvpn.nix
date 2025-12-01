{
  config,
  lib,
  ...
}: {
  options.modules.services.openvpn.enable = lib.mkEnableOption "openvpn support";

  config = lib.mkIf config.modules.services.openvpn.enable {
    services.openvpn.servers = {
      mruVPN = {
        config = ''config /home/matthew_hre/.config/openvpn/mruVPN.conf '';
        autoStart = false;
      };
    };
  };
}
