{
  programs.niri.settings = {
    window-rules = [
      (let
        allCorners = r: {
          bottom-left = r;
          bottom-right = r;
          top-left = r;
          top-right = r;
        };
      in {
        geometry-corner-radius = allCorners 10.0;
        clip-to-geometry = true;
        draw-border-with-background = false;
      })

      {
        matches = [
          {
            app-id = "steam";
          }
          {
            title = "^notificationtoasts_\d+_desktop$";
          }
        ];
        default-floating-position = {
          x = 10;
          y = 10;
          relative-to = "bottom-right";
        };
      }
      {
        matches = [
          {
            app-id = "com.network.manager";
          }
          {
            title = "^Network Manager$";
          }
        ];
        open-floating = true;
        default-window-height.fixed = 400;
        default-column-width.proportion = 0.25;
        default-floating-position = {
          x = 10;
          y = 10;
          relative-to = "top-right";
        };
      }
      {
        matches = [
          {is-floating = true;}
        ];
        shadow.enable = true;
      }
      {
        matches = [
          {
            app-id = "1password";
          }
        ];
        block-out-from = "screencast";
      }
    ];
    layer-rules = [
      {
        matches = [
          {
            namespace = "^swww-daemon$";
          }
        ];
        place-within-backdrop = true;
      }
    ];
  };
}
