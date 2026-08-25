# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];

  hardware.bluetooth.settings.General = {
    Privacy = "device";
    JustWorksRepairing = "true";
    Class = "0x000100";
    FastConnectable = "true";
  };
  hardware.xpadneo.enable = true;

  networking.hostName = "donkeykong";
  networking.interfaces.eno1.wakeOnLan.enable = true;

  services.logind.settings.Login = {
    HandleSuspendKey = "suspend";
    HandleSuspendKeyLongPress = "suspend";
    HandleHibernateKey = "ignore";
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.settings.Sleep = {
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };

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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=0
    options rtw89_pci disable_clkreq=Y disable_aspm_l1=Y disable_aspm_l1ss=Y
  '';

  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    filezilla
    rocmPackages.rocm-smi
    satisfactorymodmanager
  ];

  programs.kdeconnect.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
