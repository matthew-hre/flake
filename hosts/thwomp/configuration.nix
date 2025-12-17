# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system

    inputs.solaar.nixosModules.default
  ];

  modules = {
    hardware.amd.enable = true;
    hardware.bluetooth.enable = true;

    programs.discord.enable = true;
    programs.fonts.enable = true;
    programs.libre.enable = true;
    programs.plasma.enable = true;
    programs.steam.enable = true;

    services.boot.enable = true;
    services.docker.enable = true;
    services.greetd.enable = true;
    services.network.enable = true;
    services.openssh.enable = true;
    services.vpn.enable = true;
    services.pipewire.enable = true;
    services.security.enable = true;
  };

  networking.hostName = "thwomp";

  services.xserver.enable = true;

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
  '';

  systemd.services."disable-xhc2-wakeup" = {
    description = "disable wakeup from usb controller XHC2";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''/bin/sh -c 'echo XHC2 > /proc/acpi/wakeup' '';
    };
  };

  hardware.enableAllFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPatches = [
    {
      name = "btusb-patch";
      patch = ./btusb.patch;
    }
  ];

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    OZONE_PLATFORM = "wayland";
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    tidal-hifi
    rocmPackages.rocm-smi
    satisfactorymodmanager
  ];

  services.solaar.enable = true;

  hardware.logitech.wireless.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
