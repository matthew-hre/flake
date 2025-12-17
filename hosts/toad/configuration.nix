{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];

  modules = {
    hardware.amd.enable = true;
    hardware.bluetooth.enable = true;
    hardware.fprintd.enable = true;
    hardware.fwupd.enable = true;

    programs.discord.enable = true;
    programs.fonts.enable = true;
    programs.libre.enable = true;
    programs.niri.enable = true;
    programs.steam.enable = true;
    programs.xdg.enable = true;

    services.boot.enable = true;
    services.docker.enable = true;
    services.greetd.enable = true;
    services.network.enable = true;
    services.openssh.enable = true;
    services.vpn.enable = true;
    services.pipewire.enable = true;
    services.power.enable = true;
    services.security.enable = true;
    services.security.fingerprintPam.enable = true;
  };

  networking.hostName = "toad";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
