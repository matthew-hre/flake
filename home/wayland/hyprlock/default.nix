{
  config,
  lib,
  pkgs,
  ...
}: let
  time = import ./time.nix {inherit pkgs;};
in {
  options.home.wayland.hyprlock = {
    enable = lib.mkEnableOption "hyprlock configuration";
  };

  config = lib.mkIf config.home.wayland.hyprlock.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          immediate_render = true;
          hide_cursor = true;
          no_fade_in = true;
        };

        auth = {
          "fingerprint:enabled" = true;
        };

        background = [
          {
            monitor = "";
            path = "color(0x000000)";
          }
        ];

        input-field = [
          {
            monitor = "eDP-1";
            size = "0, 0";
            opacity = 0;
          }
        ];

        label = [
          {
            monitor = "";
            text = ''
              cmd[update:10] ${time}/bin/lock-time
            '';
            font_size = 60;
            font_family = "Departure Mono";

            color = "rgb(240, 245, 250)";

            position = "0%, 0%";

            valign = "center";
            halign = "center";

            shadow_color = "rgba(100, 200, 220, 0.3)";
            shadow_size = 12;
            shadow_passes = 2;
            shadow_boost = 0.4;
          }
        ];
      };
    };
  };
}
