{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.dustpan.homeManagerModules.dustpan
  ];

  options.home.garbage = {
    enable = lib.mkEnableOption "garbage configuration";
  };

  config = lib.mkIf config.home.garbage.enable {
    nix.gc = {
      automatic = true;
      dates = "monthly";
    };

    services.dustpan = {
      enable = true;
      roots = ["$HOME/Projects"];
      targets = ["node_modules" ".next" ".zig-cache"];
      olderThanDays = 14;
      frequency = "weekly";
    };
  };
}
