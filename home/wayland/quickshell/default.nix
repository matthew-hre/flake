{
  hostname,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.quickshell-config.homeManagerModules.default];

  programs.quickshellConfig = {
    settings.showBattery = hostname == "toad";
    devPath = lib.mkIf (hostname == "toad") "/home/matthew_hre/.config/quickshell";
  };
}
