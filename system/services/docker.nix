{
  config,
  lib,
  ...
}: {
  options.modules.services.docker.enable = lib.mkEnableOption "docker support";

  config = lib.mkIf config.modules.services.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };

    systemd.services."docker.socket".wantedBy = ["sockets.target"];
  };
}
