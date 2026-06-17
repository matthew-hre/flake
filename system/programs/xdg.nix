{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.xdg.enable = lib.mkEnableOption "XDG support";

  config = lib.mkIf config.modules.programs.xdg.enable {
    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    };
  };
}
