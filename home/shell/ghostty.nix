{
  inputs,
  pkgs,
  ...
}: let
  ghostty = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
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
      # background = "#1a1b23";
      window-decoration = true;
      window-theme = "ghostty";
      window-padding-x = 16;
      window-padding-y = 16;
      window-padding-balance = true;
      keybind = ["ctrl+shift+l=new_split:right" "ctrl+shift+d=new_split:down"];
    };
  };
}
