{
  config,
  inputs,
  ...
}: {
  imports = [inputs.quickshell-config.homeManagerModules.default];

  # programs.quickshellConfig.devPath = "/home/matthew_hre/.config/quickshell";
  programs.quickshellConfig = {
    settings.showBattery = builtins.getEnv "HOSTNAME" != "thwomp";
  };
}
