{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  systemd.services."docker.socket".wantedBy = ["sockets.target"];
}
