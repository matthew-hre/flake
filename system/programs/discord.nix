{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.discord.enable = lib.mkEnableOption "discord support";

  config = lib.mkIf config.modules.programs.discord.enable {
    environment.systemPackages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
      })
    ];
  };
}
