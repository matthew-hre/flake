{
  config,
  lib,
  pkgs,
  ...
}: {
  options.home.fuzzel = {
    enable = lib.mkEnableOption "fuzzel configuration";
  };

  config = lib.mkIf config.home.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          width = 40;
          lines = 8;
          line-height = 30;
          icon-theme = "Papirus";
          prompt = ''"  "'';
          font = "FiraCode Nerd Font:size=14";
        };
        colors = {
          background = "282A36FF";
          text = "f8f8f2ff";
          match = "8be9fdff";
          selection-match = "8be9fdff";
          selection = "BD93F9FF";
          selection-text = "282A36ff";
          border = "44475Aff";
        };
        border = {
          width = 2;
          radius = 20;
        };
      };
    };
  };
}
