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
    services.openvpn.enable = true;
    services.pipewire.enable = true;
    services.power.enable = true;
  };

  home-manager.users.matthew_hre.home = {
    bat.enable = true;
    btop.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    fuzzel.enable = true;
    garbage.enable = true;
    git.enable = true;
    ssh.enable = true;
    vicinae.enable = true;

    editors.helix.enable = true;
    editors.nvf.enable = true;
    editors.vscode.enable = true;

    shell.fish.enable = true;
    shell.ghostty.enable = true;

    wayland.enable = true;
    wayland.waybar.enable = false;
    wayland.quickshell.enable = true;
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
