{
  inputs,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git

    inputs.helium.defaultPackage.x86_64-linux

    inputs.ink.packages.x86_64-linux.default

    libnotify
    nomacs
    obsidian
    playerctl
    vim

    (pkgs.writeShellScriptBin "rebuild" ''
      nh os switch ~/nix-config -H $HOSTNAME
    '')
    (pkgs.writeShellScriptBin "rebuild-test" ''
      nh os test ~/nix-config -H $HOSTNAME
    '')
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  i18n.defaultLocale = "en_CA.UTF-8";
  time.timeZone = "America/Edmonton";

  services.journald.extraConfig = "SystemMaxUse=1G";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["matthew_hre"];
  };
  programs.wireshark.enable = true;

  services.printing.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
