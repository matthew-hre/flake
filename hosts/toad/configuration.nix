{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
    ../../system/hardware/fprintd.nix
    ../../system/hardware/fwupd.nix
    ../../system/services/power.nix
  ];

  security.pam.services."polkit-1".fprintAuth = true;

  networking.hostName = "toad";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
