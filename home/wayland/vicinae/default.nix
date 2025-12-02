{inputs, ...}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    settings = {
      popToRootOnClose = true;
      theme.name = "dracula";
    };
  };
}
