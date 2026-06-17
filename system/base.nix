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

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    extra-substituters = [
      "https://zed.cachix.org"
      "https://cache.garnix.io"
      "https://niri.cachix.org"
      "https://ghostty.cachix.org"
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["matthew_hre"];
  };

  services.printing.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
