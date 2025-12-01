{
  config,
  lib,
  ...
}: {
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
          hide_cursor = false;
          no_fade_in = true;
        };

        auth = {
          "fingerprint:enabled" = true;
        };

        background = [
          {
            monitor = "";
            path = "~/Pictures/outer-wilds-4k.png";
            blur_passes = 2;
            blur_size = 7;
            noise = 1.17e-2; # what the fuck???
          }
        ];

        input-field = [
          {
            monitor = "eDP-1";

            size = "300, 50";
            valign = "bottom";
            position = "0%, 10%";

            outline_thickness = 1;

            font_color = "rgb(248, 248, 242)";

            outer_color = "rgba(139, 233, 253, 0.5)";
            inner_color = "rgba(80, 250, 123, 0.1)";
            check_color = "rgba(241, 250, 140, 0.5)";
            fail_color = "rgba(255, 85, 85, 0.5)";

            fade_on_empty = false;
            placeholder_text = "Enter Password";

            dots_spacing = 0.2;
            dots_center = true;
            dots_fade_time = 100;

            shadow_color = "rgba(0, 0, 0, 0.1)";
            shadow_size = 7;
            shadow_passes = 2;
          }
        ];

        label = [
          {
            monitor = "";
            text = ''
              cmd[update:1000] echo "<span>$(date +'%H:%M:%S')</span>"
            '';
            font_size = 60;
            font_family = "FiraCode Nerd Font";

            color = "rgb(248, 248, 242)";

            position = "0%, -30%";

            valign = "center";
            halign = "center";

            shadow_color = "rgba(0, 0, 0, 0.1)";
            shadow_size = 20;
            shadow_passes = 2;
            shadow_boost = 0.3;
          }
        ];
      };
    };
  };
}
