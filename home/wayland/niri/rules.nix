{hostname, ...}: let
  displayHeight =
    if hostname == "thwomp"
    then 1440
    else 1920;
  onePasswordHeight = 600;
  centeredY = (displayHeight - onePasswordHeight) / 2 - 100;
in {
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
        open-floating = true;
        default-window-height.fixed = onePasswordHeight;
        default-floating-position = {
          relative-to = "top";
          x = 0;
          y = centeredY;
        };
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
