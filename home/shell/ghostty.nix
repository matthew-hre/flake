{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  ghostty = inputs.ghostty.packages.${pkgs.system}.default;
in {
  options.home.shell.ghostty = {
    enable = lib.mkEnableOption "ghostty configuration";
  };

  config = lib.mkIf config.home.shell.ghostty.enable {
    home.sessionVariables = {
      GHOSTTY_RESOURCES_DIR = "${ghostty}/share/ghostty";
    };

    programs.ghostty = {
      enable = true;
      package = ghostty;
      enableFishIntegration = true;

      settings = {
        confirm-close-surface = false;
        font-family = "FiraCode Nerd Font";
        font-size = 11;
        font-style = "Medium";
        gtk-wide-tabs = false;

        window-inherit-working-directory = true;
        theme = "Dracula";
        window-decoration = true;
        window-theme = "ghostty";
        window-padding-x = 16;
        window-padding-y = 16;
        window-padding-balance = true;
        keybind = ["ctrl+shift+l=new_split:right" "ctrl+shift+d=new_split:down"];
      };
    };
  };
}
