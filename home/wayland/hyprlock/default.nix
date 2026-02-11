{...}: {
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
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
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
          text = "cmd[update:1000] date +'%H:%M:%S'";
          font_size = 96;
          font_family = "IBM Plex Sans Light";

          color = "rgba(200, 205, 210, 1)";

          position = "0, 100";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.5)";
          shadow_size = 8;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}
