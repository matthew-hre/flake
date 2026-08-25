{
  services.openvpn.servers = {
    mruVPN = {
      config = ''config /home/matthew_hre/.config/openvpn/mruVPN.conf '';
      autoStart = false;
    };
  };

  services.tailscale.enable = true;
}
