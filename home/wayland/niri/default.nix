{pkgs, ...}: let
  makeCommand = command: {
    command = [command];
  };
in {
  imports = [
    ./binds.nix
    ./rules.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };

      spawn-at-startup = [
        (makeCommand "swww-daemon")
        (makeCommand "NetworkManager")
        (makeCommand "qs")
        {command = ["stash" "watch"];}
      ];

      cursor = {
        theme = "BreezeX-Dark";
        size = 24;
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };

      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };

      gestures.hot-corners.enable = false;

      switch-events = {
        lid-close.action.spawn = ["hyprlock"];
      };

      prefer-no-csd = true;

      outputs."eDP-1".mode = {
        width = 2880;
        height = 1920;
        refresh = 60.001;
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";

        default-column-width.proportion = 1.0;

        background-color = "transparent";

        insert-hint.display = {
          color = "#BD93F9AA";
        };

        focus-ring = {
          enable = false;
          width = 1;
          active.color = "#44475A";
          inactive.color = "#282A36";
        };

        border = {
          enable = true;
          width = 1;
          active.color = "#44475A";
          inactive.color = "#282A36";
        };
      };

      animations.window-resize.custom-shader = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
        }
      '';
    };
  };
}
