{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    libnotify
    nomacs
    obsidian
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

    # ELECTRON_OZONE_PLATFORM_HINT can be overridden per host
    # mainly due to some kde issues
    ELECTRON_OZONE_PLATFORM_HINT = lib.mkDefault "wayland";
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

  services.xserver.xkb.layout = "us";
}
