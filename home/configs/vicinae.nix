{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  options.home.vicinae = {
    enable = lib.mkEnableOption "vicinae configuration";
  };

  config = lib.mkIf config.home.vicinae.enable {
    services.vicinae = {
      enable = true;
      settings = {
        popToRootOnClose = true;
        theme.name = "dracula";
      };
    };
  };
}
