{inputs, ...}: {
  imports = [
    inputs.dustpan.homeManagerModules.dustpan
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
  };

  services.dustpan = {
    enable = true;
    roots = ["$HOME/Projects" "$HOME/repos"];
    targets = ["node_modules" ".next" ".zig-cache"];
    olderThanDays = 14;
    frequency = "weekly";
  };
}
