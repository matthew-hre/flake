{
  config,
  lib,
  ...
}: {
  options.modules.programs.steam.enable = lib.mkEnableOption "steam support";

  config = lib.mkIf config.modules.programs.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
